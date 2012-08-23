Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v18 01/16] doc: Add telephony interface design document
Date: Thu, 23 Aug 2012 16:38:50 +0200
Message-Id: <1345732745-28706-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
References: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am                    |    2 +-
 doc/audio-telephony-design.txt |  318 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 doc/audio-telephony-design.txt

diff --git a/Makefile.am b/Makefile.am
index 4977a05..aae19f9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -385,7 +385,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/network-api.txt doc/input-api.txt doc/audio-api.txt \
 		doc/control-api.txt doc/hfp-api.txt doc/health-api.txt \
 		doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt \
-		doc/supported-features.txt
+		doc/supported-features.txt doc/audio-telephony-design.txt
 
 AM_YFLAGS = -d
 
diff --git a/doc/audio-telephony-design.txt b/doc/audio-telephony-design.txt
new file mode 100644
index 0000000..45e79ca
--- /dev/null
+++ b/doc/audio-telephony-design.txt
@@ -0,0 +1,318 @@
+Telephony Interface Design
+**************************
+
+Introduction
+============
+
+The aim of this document is to briefly describe the telephony interface which
+will allow external application to implement telephony related profiles
+(headset, handsfree, dial-up networking and sim access).
+
+
+The goal
+========
+
+Previous version of headset code in BlueZ needs the implementation of an AT
+parser for each modem target or external telephony application (Maemo, oFono)
+which is not the aim of Bluez.
+
+The telephony interface allows BlueZ to focus on Bluetooth communication part
+(connection, disconnection, authentication, authorization) and let external
+application (i.e. oFono) take charge of the Telephony tasks (AT parsing and
+modem specific code).
+This will allow code to be simpler, easier to maintain and debug in both BlueZ
+and telephony application.
+
+
+Design
+======
+
+External applications, which should implement AT parsing and telephony part
+will have to register an org.bluez.TelephonyAgent using this new interface.
+This will setup a SDP record for the profile and a RFCOMM server listening for
+incoming connection.
+
+When a new device is connected, NewConnection method of TelephonyAgent is
+called. The telephony agent must reply with a TelephonyConnection object after
+proper communication establishment (after SLC setup completes for HFP, or
+directly for other profiles).
+
+For Headset and Handsfree profiles, the interaction with the audio component
+(i.e. PulseAudio) will be done by listening to TelephonyConnection properties
+changes.
+
+
+Flow charts
+===========
+
+Here is some flowcharts of interactions between BlueZ, telephony agent (oFono)
+and audio component (PulseAudio):
+
+        .....>  Bluetooth communication between headset and phone
+        ----->  Dbus messages and signals
+
+Outgoing SCO connection - HFP <= 1.5
+------------------------------------
+
+When PulseAudio needs to setup the audio connection it will call media
+transport acquire method. This will perform a SCO connection and return the SCO
+socket file descriptor to PulseAUdio.
+
+	PulseAudio              BlueZ           HF/AG
+	|                         |               |
+	|    transport acquire    |               |
+	|------------------------>|               |
+	|                         |  connect SCO  |
+	|                         |..............>|
+	|      return SCO fd      |               |
+	|<------------------------|               |
+	|                         |               |
+
+Incoming SCO connection - HFP <= 1.5
+------------------------------------
+
+On an incoming SCO connection the profile will change to playing state.
+On reception of this state change, PulseAudio will call media transport acquire
+method to retrieve the SCO socket file descriptor.
+
+	PulseAudio              BlueZ           HF/AG
+	|                         |               |
+	|                         |  connect SCO  |
+	|                         |<..............|
+	|  state changed signal   |               |
+	|<------------------------|               |
+	|                         |               |
+	|    transport acquire    |               |
+	|------------------------>|               |
+	|                         |               |
+	|      return SCO fd      |               |
+	|<------------------------|               |
+	|                         |               |
+
+Codec negotiation - HFP AG - HFP v1.6
+-------------------------------------------
+
+On reception of HF available codecs command (AT+BAC), the gateway may start a
+codec selection procedure which will end up by codec property update and setup
+of the correct media transport.
+When a media transport already exists and it uses a different codec, it should
+be closed before correct one is setup.
+
+	PulseAudio          BlueZ            oFono           HF
+	|                     |                |              |
+	|                     |                | AT+BAC=u1,u2 |
+	|                     |                |<.............|
+	|                     |                |              |
+	|                     |                |      OK      |
+	|                     |                |.............>|
+	|                     |                |              |
+	|                     |                |   +BCS:id    |
+	|                     |                |.............>|
+	|                     |                |              |
+	|                     |                |  AT+BCS=id   |
+	|                     |                |<.............|
+	|                     |                |              |
+	|                     |                |      OK      |
+	|                     |                |.............>|
+	|                     | codec property |              |
+	|                     | changed signal |              |
+	|                     |<---------------|              |
+	| configure Transport |                |              |
+	|<--------------------|                |              |
+	|                     |                |              |
+
+It may also be possible to force a codec selection procedure by calling "get
+audio codec" method of TelephonyConnection.
+
+	PulseAudio          BlueZ             oFono          HF
+	|                     |                 |             |
+	|                     |    get codec    |             |
+	|                     |---------------->|             |
+	|                     |                 |   +BCS:id   |
+	|                     |                 |............>|
+	|                     |                 |             |
+	|                     |                 |  AT+BCS=id  |
+	|                     |                 |<............|
+	|                     |                 |             |
+	|                     |                 |      OK     |
+	|                     |                 |............>|
+	|                     | codec property  |             |
+	|                     | changed signal  |             |
+	|                     |<----------------|             |
+	| configure Transport |                 |             |
+	|<--------------------|                 |             |
+	|                     |                 |             |
+
+Outgoing SCO connection - HFP AG - HFP v1.6
+-------------------------------------------
+
+Idem than for HFP v1.5
+
+Incoming SCO connection - HFP AG - HFP v1.6
+-------------------------------------------
+
+It is pretty the same here as for outgoing SCO connection, except that it is
+started upon reception of AT+BCC from the headset.
+
+	PulseAudio           BlueZ              oFono         HF
+	|                      |                  |            |
+	|                      |                  |   AT+BCC   |
+	|                      |                  |<...........|
+	|                      |                  |            |
+	|                      |                  |     OK     |
+	|                      |                  |...........>|
+	|                      |    connection    |            |
+	|                      | requested signal |            |
+	|                      |<-----------------|            |
+	|                      |                  |            |
+	|                      |          connect SCO          |
+	|                      |..............................>|
+	| state changed signal |                  |            |
+	|<---------------------|                  |            |
+	|                      |                  |            |
+	|  transport acquire   |                  |            |
+	|--------------------->|                  |            |
+	|                      |                  |            |
+	|    return SCO fd     |                  |            |
+	|<---------------------|                  |            |
+
+
+Codec negotiation - HFP HF - HFP v1.6
+-------------------------------------------
+
+Codec selection procedure started by gateway will end up by codec property
+update and setup of the correct media transport.
+When a media transport already exists and it uses a different codec, it should
+be closed before correct one is setup.
+
+	PulseAudio          BlueZ            oFono           HF
+	|                     |                |              |
+	|                     |                |   +BCS:id    |
+	|                     |                |<.............|
+	|                     |                |              |
+	|                     |                |  AT+BCS=id   |
+	|                     |                |.............>|
+	|                     |                |              |
+	|                     |                |      OK      |
+	|                     |                |<.............|
+	|                     | codec property |              |
+	|                     | changed signal |              |
+	|                     |<---------------|              |
+	| configure Transport |                |              |
+	|<--------------------|                |              |
+	|                     |                |              |
+
+Outgoing SCO connection - HFP HF - HFP v1.6
+-------------------------------------------
+
+On media transport acquire, the TelephonyConnection interface is called to
+request connection from the gateway.
+Then incoming SCO socket file descriptor will be returned to PulseAudio.
+
+	PulseAudio             BlueZ             oFono        AG
+	|                        |                 |           |
+	|   transport acquire    |                 |           |
+	|----------------------->|                 |           |
+	|                        |    request      |           |
+	|                        |   connection    |           |
+	|                        |---------------->|           |
+	|                        |                 |  AT+BCC   |
+	|                        |                 |..........>|
+	|                        |                 |           |
+	|                        |                 |     OK    |
+	|                        |                 |<..........|
+	|                        |                 |           |
+	|                        |          connect SCO        |
+	|                        |<............................|
+	|      return SCO fd     |                 |           |
+	|<-----------------------|                 |           |
+	|                        |                 |           |
+
+Incoming SCO connection - HFP HF - HFP v1.6
+-------------------------------------------
+
+Idem than for HFP v1.5
+
+AT+NREC - HFP AG
+----------------
+
+Reception of AT+NREC will be signaled to Bluez by TelephonyConnection.
+This will update the NREC property of media transport interface (listened by
+PulseAudio).
+
+	HF          oFono            BlueZ         PulseAudio
+	|   AT+NREC   |                |                |
+	|............>|                |                |
+	|             |    property    |                |
+	|             | changed signal |                |
+	|             |--------------->|                |
+	|     OK      |                |    property    |
+	|<............|                | changed signal |
+	|             |                |--------------->|
+	|             |                |                |
+
++BSIR - HFP AG
+--------------
+
+PulseAudio can change in-band ring tone by calling SetProperty method of media
+transport interface.
+This will call SetProperty of TelephonyConnection interface, which will send the
+proper +BSIR unsolicited event.
+
+	HF          oFono            BlueZ         PulseAudio        app
+	|             |                |                |             |
+	|             |                |                |<------------|
+	|             |                |  SetProperty   |             |
+	|             |                |<---------------|             |
+	|             |  SetProperty   |                |             |
+	|             |<---------------|                |             |
+	|   +BSIR:x   |                |                |             |
+	|<............|                |                |             |
+	|             |    property    |                |             |
+	|             | changed signal |                |             |
+	|             |--------------->|                |             |
+	|             |                |                |             |
+
+AT+VGS,AT+VGM - HFP AG
+----------------------
+
+Reception of volume management command will be signaled to Bluez by
+TelephonyConnection.
+This will update the corresponding volume property of media transport interface
+(listened by PulseAudio).
+
+	HF          oFono            BlueZ         PulseAudio        app
+	|             |                |                |             |
+	|  AT+VGS=xx  |                |                |             |
+	|............>|                |                |             |
+	|             |    property    |                |             |
+	|             | changed signal |                |             |
+	|             |--------------->|                |             |
+	|     OK      |                |                |             |
+	|<............|                |    property    |             |
+	|             |                | changed signal |             |
+	|             |                |--------------->|             |
+	|             |                |                |------------>|
+	|             |                |                |             |
+
++VGS,+VGM - HFP AG
+------------------
+
+PulseAudio can change volume by calling SetProperty method of media transport
+interface.
+This will call SetProperty of TelephonyConnection interface, which will send the
+proper +VGx unsolicited event.
+
+	HF          oFono            BlueZ         PulseAudio        app
+	|             |                |                |             |
+	|             |                |                |<------------|
+	|             |                |  SetProperty   |             |
+	|             |                |<---------------|             |
+	|             |  SetProperty   |                |             |
+	|             |<---------------|                |             |
+	|   +VGS:xx   |                |                |             |
+	|<............|    property    |                |             |
+	|             | changed signal |    property    |             |
+	|             |--------------->| changed signal |             |
+	|             |                |--------------->|             |
+	|             |                |                |------------>|
-- 
1.7.9.5


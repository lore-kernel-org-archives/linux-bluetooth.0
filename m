Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add HFP design document
Date: Thu, 15 Nov 2012 18:35:39 +0100
Message-Id: <1353000939-16880-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am                    |    2 +-
 doc/audio-telephony-design.txt |  320 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 doc/audio-telephony-design.txt

diff --git a/Makefile.am b/Makefile.am
index e8a247a..a167a24 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -342,7 +342,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/media-api.txt doc/assigned-numbers.txt \
 		doc/supported-features.txt doc/alert-api.txt doc/mgmt-api.txt \
 		doc/oob-api.txt doc/proximity-api.txt doc/heartrate-api.txt \
-		doc/thermometer-api.txt
+		doc/thermometer-api.txt doc/audio-telephony-design.txt
 
 AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
diff --git a/doc/audio-telephony-design.txt b/doc/audio-telephony-design.txt
new file mode 100644
index 0000000..7604f9f
--- /dev/null
+++ b/doc/audio-telephony-design.txt
@@ -0,0 +1,320 @@
+Telephony Interface Design
+**************************
+
+Introduction
+============
+
+The aim of this document is to briefly describe usage of profile interface which
+will allow external application to implement telephony related profiles
+(headset, handsfree).
+
+
+The goal
+========
+
+Previous version of headset code in BlueZ needs the implementation of an AT
+parser for each modem target or external telephony application (Maemo, oFono)
+which is not the aim of Bluez.
+
+The profile interface allows BlueZ to focus on Bluetooth communication part
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
+will have to register an org.bluez.Profile1 agent using RegisterProfile of
+org.bluez.ProfileManager1 interface.
+This will setup a SDP record for the profile and a RFCOMM server listening for
+incoming connection.
+
+When a new device is connected, NewConnection method of Profile1 agent is
+called with informations related to connecting profile (like RFCOMM client file
+descriptor, version, features, media end point path, ...).
+
+The telephony application is in charge to implement a MediaTransport for its
+audio connection with remote device and interact with the MediaTransport of the
+audio component (i.e. PulseAudio).
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
+Start up
+--------
+
+When PulseAudio starts it registers media endpoints to BlueZ.
+When oFono starts it registers profile agent for HFP.
+
+	PulseAudio              BlueZ                    oFono
+	|                         |                        |
+	| register media endpoint |                        |
+	|------------------------>|                        |
+	|                         | register profile agent |
+	|                         |<-----------------------|
+	|                         |                        |
+
+HFP Connection
+--------------
+
+On incoming connection, BlueZ performs (if needed) authentication and
+authorization then passes RFCOMM file descriptor and media end point path to
+oFono.
+oFono should create a media transport and register it to PulseAudio using the
+media end point path.
+
+	PulseAudio          oFono            BlueZ           HF
+	|                     |                |              |
+	|                     |                |  connection  |
+	|                     |                |    set-up    |
+	|                     |                |<............>|
+	|                     | NewConnection  |              |
+	|                     |<---------------|              |
+	| SelectConfiguration |                |              |
+	|<--------------------|                |              |
+	|                     |                |              |
+	|   SetConfiguration  |                |              |
+	|<--------------------|                |              |
+	|                     |                |              |
+
+Outgoing SCO connection - HFP <= 1.5
+------------------------------------
+
+When PulseAudio needs to setup the audio connection it will call media
+transport acquire method. This will perform a SCO connection and return the SCO
+socket file descriptor to PulseAudio.
+
+	PulseAudio              oFono           HF/AG
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
+On an incoming SCO connection oFono will change to playing state.
+On reception of this state change, PulseAudio will call media transport acquire
+method to retrieve the SCO socket file descriptor.
+
+	PulseAudio              oFono           HF/AG
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
+codec selection procedure which will setup the correct media transport.
+When a media transport already exists and it uses a different codec, it should
+be closed before correct one is setup.
+
+	PulseAudio          oFono           HF
+	|                     |              |
+	|                     | AT+BAC=u1,u2 |
+	|                     |<.............|
+	|                     |              |
+	|                     |      OK      |
+	|                     |.............>|
+	|                     |              |
+	|                     |   +BCS:id    |
+	|                     |.............>|
+	|                     |              |
+	|                     |  AT+BCS=id   |
+	|                     |<.............|
+	|                     |              |
+	|                     |      OK      |
+	|                     |.............>|
+	| configure Transport |              |
+	|<--------------------|              |
+	|                     |              |
+
+It may also be possible to force a codec selection from oFono.
+
+	PulseAudio          oFono          HF
+	|                     |             |
+	|                     |   +BCS:id   |
+	|                     |............>|
+	|                     |             |
+	|                     |  AT+BCS=id  |
+	|                     |<............|
+	|                     |             |
+	|                     |      OK     |
+	|                     |............>|
+	| configure Transport |             |
+	|<--------------------|             |
+	|                     |             |
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
+	PulseAudio           oFono          HF
+	|                      |             |
+	|                      |    AT+BCC   |
+	|                      |<............|
+	|                      |             |
+	|                      |     OK      |
+	|                      |............>|
+	|                      |             |
+	|                      | connect SCO |
+	|                      |............>|
+	| state changed signal |             |
+	|<---------------------|             |
+	|                      |             |
+	|  transport acquire   |             |
+	|--------------------->|             |
+	|                      |             |
+	|    return SCO fd     |             |
+	|<---------------------|             |
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
+	PulseAudio          oFono           AG
+	|                     |              |
+	|                     |   +BCS:id    |
+	|                     |<.............|
+	|                     |              |
+	|                     |  AT+BCS=id   |
+	|                     |.............>|
+	|                     |              |
+	|                     |      OK      |
+	|                     |<.............|
+	| configure Transport |              |
+	|<--------------------|              |
+	|                     |              |
+
+Outgoing SCO connection - HFP HF - HFP v1.6
+-------------------------------------------
+
+On media transport acquire, oFono requests connection from the gateway.
+Then incoming SCO socket file descriptor will be returned to PulseAudio.
+
+	PulseAudio             oFono          AG
+	|                        |             |
+	|   transport acquire    |             |
+	|----------------------->|             |
+	|                        |   AT+BCC    |
+	|                        |............>|
+	|                        |             |
+	|                        |      OK     |
+	|                        |<............|
+	|                        |             |
+	|                        | connect SCO |
+	|                        |<............|
+	|      return SCO fd     |             |
+	|<-----------------------|             |
+	|                        |             |
+
+Incoming SCO connection - HFP HF - HFP v1.6
+-------------------------------------------
+
+Idem than for HFP v1.5
+
+AT+NREC - HFP AG
+----------------
+
+Reception of AT+NREC will update the NREC property of media transport interface
+(listened by PulseAudio).
+
+	HF          oFono         PulseAudio
+	|   AT+NREC   |                |
+	|............>|                |
+	|             |    property    |
+	|             | changed signal |
+	|             |--------------->|
+	|     OK      |                |
+	|<............|                |
+	|             |                |
+
++BSIR - HFP AG
+--------------
+
+PulseAudio can change in-band ring tone by calling SetProperty method of media
+transport interface, which will send the proper +BSIR unsolicited event.
+
+	HF          oFono         PulseAudio        app
+	|             |                |             |
+	|             |                |<------------|
+	|             |  SetProperty   |             |
+	|             |<---------------|             |
+	|   +BSIR:x   |                |             |
+	|<............|                |             |
+	|             |    property    |             |
+	|             | changed signal |             |
+	|             |--------------->|             |
+	|             |                |             |
+
+AT+VGS,AT+VGM - HFP AG
+----------------------
+
+Reception of volume management command will update the corresponding volume
+property of media transport interface (listened by PulseAudio).
+
+	HF          oFono         PulseAudio        app
+	|             |                |             |
+	|  AT+VGS=xx  |                |             |
+	|............>|                |             |
+	|             |    property    |             |
+	|             | changed signal |             |
+	|             |--------------->|             |
+	|     OK      |                |             |
+	|<............|                |------------>|
+	|             |                |             |
+
++VGS,+VGM - HFP AG
+------------------
+
+PulseAudio can change volume by calling SetProperty method of media transport
+interface. This which will send the proper +VGx unsolicited event.
+
+	HF          oFono         PulseAudio        app
+	|             |                |             |
+	|             |                |<------------|
+	|             |  SetProperty   |             |
+	|             |<---------------|             |
+	|   +VGS:xx   |                |             |
+	|<............|    property    |             |
+	|             | changed signal |             |
+	|             |--------------->|             |
+	|             |                |------------>|
+	|             |                |             |
-- 
1.7.9.5


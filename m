Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] audio: Fix headset NULL pointer dereference during
 AT+BLDN response
Date: Tue, 23 Oct 2012 19:27:05 +0530
Message-id: <1351000626-22632-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While waiting for the AT+BLDN asynchronous response, if RFCOMM got
disconnected, then respose will cause NULL pointer dereference.

During headset disconnection, the headset state changes from
HEADSET_STATE_CONNECTED to HEADSET_STATE_DISCONNECTED along with
freeing the dev->headset. During the response, in telephony_generic_rsp
its dereferencing.

Log:
bluetoothd[5573]: audio/headset.c:handle_event() Received AT+BLDN
bluetoothd[5573]: audio/telephony.c:telephony_last_dialed_number_req()
 telephony-tizen: last dialed number request
bluetoothd[5573]: audio/telephony.c:dbus_method_call_send() +
bluetoothd[5573]: audio/telephony.c:dbus_method_call_send() -
bluetoothd[5573]: Endpoint replied with an error: org.freedesktop.DBus\
 .Error.NoReply
bluetoothd[5573]: audio/telephony.c:telephony_device_disconnected()
 telephony-tizen: device 0x40439b60 disconnected
bluetoothd[5573]: audio/headset.c:headset_set_state() State changed
 /org/bluez/5573/hci0/dev_BC_47_60_F5_88_89:
 HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[5573]: audio/media.c:headset_state_changed()
bluetoothd[5573]: audio/media.c:headset_state_changed() Clear endpoint
 0x40430620
bluetoothd[5573]: audio/telephony.c:telephony_dial_number_reply()
 redial_reply
bluetoothd[5573]: audio/telephony.c:telephony_dial_number_reply()
 dial_reply reply: No Call log
---
 audio/headset.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index bd83a65..30d24cf 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -689,6 +689,9 @@ static int telephony_generic_rsp(struct audio_device *device, cme_error_t err)
 	struct headset *hs = device->headset;
 	struct headset_slc *slc = hs->slc;
 
+	if (!slc)
+		return -EIO;
+
 	if ((err != CME_ERROR_NONE) && slc->cme_enabled)
 		return headset_send(hs, "\r\n+CME ERROR: %d\r\n", err);
 
-- 
1.7.4.1


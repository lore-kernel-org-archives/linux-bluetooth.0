Return-Path: <cyrus@holtmann.org>
Message-ID: <4E1D2146.2050508@bluewatersys.com>
Date: Wed, 13 Jul 2011 16:38:30 +1200
From: Andre Renaud <andre@bluewatersys.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Headset+Alsa problems (without Pulse Audio)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I'm trying to get a bluetooth headset working on an embedded Linux 
environment. I don't have the available resources to drag in all of
Pulse Audio, so this is being done with essentially just bluez 
and the alsa-libs.

It all seems to connect & pair properly, but when I go to play audio 
no sound comes out. There are no complaints, and the 'aplay' command 
runs for approximately the correct amount of time before exiting 
cleanly. Using hcidump, I can see that the audio data is being 
transmitted.

In the process of investigating this, I found that the amixer command 
was unable to talk to the bluetooth controls. I eventually tracked 
this down to a bug in audio/ctl_bluetooth.c. Having fixed it,
I am now able to list the controls, but unable to change their values
(I have also made it so that it errors out if it goes to change
an integer, and the change doesn't take, rather than looping forever).

Does anyone know what I might be missing, or where I should start
looking next?

Regards,
Andre

--- a/audio/ctl_bluetooth.c	2011-07-13 15:53:11.000000000 +1200
+++ b/audio/ctl_bluetooth.c	2011-07-13 16:27:04.000000000 +1200
@@ -156,7 +156,7 @@
 	req->mode = mode;
 	req->key = key;
 
-	ret = send(data->sock, req, BT_SUGGESTED_BUFFER_SIZE, MSG_NOSIGNAL);
+	ret = send(data->sock, req, sizeof(*req), MSG_NOSIGNAL);
 	if (ret <= 0) {
 		SYSERR("Unable to request new volume value to server");
 		return  -errno;
@@ -225,7 +225,7 @@
 	struct bluetooth_data *data = ext->private_data;
 	char buf[BT_SUGGESTED_BUFFER_SIZE];
 	struct bt_control_rsp *rsp = (void *) buf;
-	long current;
+	long current, new;
 	int ret, keyvalue;
 
 	DBG("ext %p key %ld", ext, key);
@@ -245,7 +245,16 @@
 		if (ret < 0)
 			break;
 
-		current = keyvalue;
+                ret = bluetooth_read_integer(ext, key, &new);
+                if (ret < 0)
+                    return ret;
+
+                if (new == current) {
+                    SNDERR("Unable to move volume %s",
+                            keyvalue == BT_CONTROL_KEY_VOL_UP ? "up" : "down");
+                    return  -EAGAIN;
+                }
+                current = new;
 	}
 
 	return ret;


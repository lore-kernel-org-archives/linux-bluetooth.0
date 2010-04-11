Return-Path: <cyrus@holtmann.org>
Date: Sun, 11 Apr 2010 13:36:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Rogers <brian@xyzw.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Mouse authentication regression after 4.63
Message-ID: <20100411103618.GA7676@jh-x301>
References: <4BC19B11.1090409@xyzw.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
In-Reply-To: <4BC19B11.1090409@xyzw.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brian,

On Sun, Apr 11, 2010, Brian Rogers wrote:
> Upon trying out a newer version of BlueZ, I found a regression in
> support for my mouse caused by the following commit:
> 
> commit aee26b30bbc24cde464ba1a557c2b258ddec6432
> Author: Johan Hedberg <johan.hedberg@nokia.com>
> Date:   Tue Mar 30 13:36:46 2010 +0300
> 
>     Make BtIO default security level MEDIUM
> 
>     MEDIUM makes more sense than the kernel default LOW which maps to "no
>     bonding" with SSP (something that's useful only for very special cases
>     such as OPP).
> 
> 
> After this commit, when I turn on or move my mouse, I get prompted
> for a PIN to use for the connection. "0000" won't work, and blank
> isn't accepted, so the mouse can't connect. Deleting and re-pairing
> my mouse doesn't work either. I suspect my mouse just does not
> support encryption. I've never seen AUTH or ENCRYPT on my mouse in
> the output of "hcitool con" and I can't enable encryption on a
> working bluez using "hcitool auth". It just prompts for a PIN, and
> disconnects the mouse when I enter one. And there's no documentation
> on what PIN should be used with this mouse.
> 
> With the above commit reverted, it works fine again. The mouse
> information is below. Could this be a device-specific quirk? What
> information is needed to resolve this?

I don't think this needs anything device specific. Authentication is
optional for mice so we can't really have the HID sockets requiring
higher security than LOW. The attached patch should fix the issue.

Johan

--Kj7319i9nmIyA2yE
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="input-sec-level.patch"

diff --git a/input/device.c b/input/device.c
index 922dc98..e047009 100644
--- a/input/device.c
+++ b/input/device.c
@@ -886,6 +886,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 				BT_IO_OPT_SOURCE_BDADDR, &idev->src,
 				BT_IO_OPT_DEST_BDADDR, &idev->dst,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("%s", err->message);
@@ -964,6 +965,7 @@ static DBusMessage *input_device_connect(DBusConnection *conn,
 					BT_IO_OPT_SOURCE_BDADDR, &idev->src,
 					BT_IO_OPT_DEST_BDADDR, &idev->dst,
 					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
 		iconn->ctrl_io = io;
 	}
diff --git a/input/server.c b/input/server.c
index 93ceea6..7eddf93 100644
--- a/input/server.c
+++ b/input/server.c
@@ -187,6 +187,7 @@ int server_start(const bdaddr_t *src)
 				server, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
 	if (!server->ctrl) {
 		error("Failed to listen on control channel");
@@ -199,6 +200,7 @@ int server_start(const bdaddr_t *src)
 				server, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
 	if (!server->intr) {
 		error("Failed to listen on interrupt channel");

--Kj7319i9nmIyA2yE--

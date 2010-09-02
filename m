Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Fix Connected status when PS3 BD remote connects
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-E3WP1yYSzFqgqYZrVdDZ"
Date: Thu, 02 Sep 2010 16:59:32 +0100
Message-ID: <1283443172.2361.63.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-E3WP1yYSzFqgqYZrVdDZ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hey,

This fixes a problem where the BD remote didn't appear as connected even
though it was.

Cheers

--=-E3WP1yYSzFqgqYZrVdDZ
Content-Disposition: attachment; filename="0001-Fix-Connected-status-when-PS3-BD-remote-connects.patch"
Content-Type: text/x-patch; name="0001-Fix-Connected-status-when-PS3-BD-remote-connects.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 5e636f5633c1af92880a249b50bf60f78a4350bb Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 2 Sep 2010 16:55:30 +0100
Subject: [PATCH] Fix Connected status when PS3 BD remote connects

The PS3 BD remote isn't connectable from the outside,
so the only way to use it with BlueZ is to make it connect. But
the code to create a new connection was never setting the
connected flags on the fake connection, so the remote wrongly
appeared as disconnected even though it was present.
---
 input/device.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/input/device.c b/input/device.c
index 5187f41..0bcbbdb 100644
--- a/input/device.c
+++ b/input/device.c
@@ -640,6 +640,8 @@ static int hidp_add_connection(const struct input_device *idev,
 		fake->disconnect = fake_hid_disconnect;
 		fake->priv = fake_hid;
 		err = fake_hid_connadd(fake, iconn->intr_io, fake_hid);
+		if (err == 0)
+			fake->flags |= FI_FLAG_CONNECTED;
 		goto cleanup;
 	}
 
-- 
1.7.0.1


--=-E3WP1yYSzFqgqYZrVdDZ--


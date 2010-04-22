Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Add sysfs speed attribute for wacom bluetooth
 tablet
From: Przemo Firszt <przemo@firszt.eu>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel <marcel@holtmann.org>, Peter Hutterer <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>
In-Reply-To: <alpine.LNX.2.00.1003220947310.18642@pobox.suse.cz>
References: <1268925902.12672.25.camel@pldmachine>
	 <1268926015.12672.27.camel@pldmachine>
	 <1268926624.21548.1478.camel@localhost.localdomain>
	 <1268939541.3639.13.camel@pldmachine>
	 <alpine.LNX.2.00.1003220947310.18642@pobox.suse.cz>
Content-Type: multipart/mixed; boundary="=-8Lbt0DXeVNZDa4zQVKU9"
Date: Thu, 22 Apr 2010 20:51:20 +0100
Message-ID: <1271965880.3540.16.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-8Lbt0DXeVNZDa4zQVKU9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Dnia 2010-03-22, pon o godzinie 09:48 +0100, Jiri Kosina pisze:
[..]
> The patch looks fine to me, so I have applied it to my tree.
> 
> Could you also please send a followup patch which would add 
> Documentation/ABI entry for the speed attribute?
Hi Jiri,
Sorry for the delayed reply. See attached patch for ABI entry.
Is Kernel Version: 2.6.35 OK?

Thanks,
Przemo

--=-8Lbt0DXeVNZDa4zQVKU9
Content-Disposition: attachment; filename*0=0001-Add-Documentation-ABI-entry-for-wacom-reporting-spee.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-Add-Documentation-ABI-entry-for-wacom-reporting-spee.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From f118300739d2592646ddb5d58b47df59db002873 Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Wed, 21 Apr 2010 22:16:25 +0100
Subject: [PATCH] Add Documentation/ABI entry for wacom reporting speed attribute.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 Documentation/ABI/testing/sysfs-wacom |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-wacom

diff --git a/Documentation/ABI/testing/sysfs-wacom b/Documentation/ABI/testing/sysfs-wacom
new file mode 100644
index 0000000..1517976
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-wacom
@@ -0,0 +1,10 @@
+What:		/sys/class/hidraw/hidraw*/device/speed
+Date:		April 2010
+Kernel Version:	2.6.35
+Contact:	linux-bluetooth@vger.kernel.org
+Description:
+		The /sys/class/hidraw/hidraw*/device/speed file controls
+		reporting speed of wacom bluetooth tablet. Reading from
+		this file returns 1 if tablet reports in high speed mode
+		or 0 otherwise. Writing to this file one of these values
+		switches reporting speed.
-- 
1.7.0.2


--=-8Lbt0DXeVNZDa4zQVKU9--

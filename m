Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix pad button definition in hid-wacom.c
From: =?UTF-8?Q?Przemys=C5=82aw?= Firszt <przemo@firszt.eu>
To: Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Ping <pinglinux@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
In-Reply-To: <1262619546.19140.1.camel@localhost.localdomain>
References: <1262544397.10071.60.camel@pldmachine>
	 <alpine.LNX.2.00.1001041224010.2277@pobox.suse.cz>
	 <1262619546.19140.1.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-FKzj1qBMvnNtT8IOPMHV"
Date: Sat, 09 Jan 2010 14:11:09 +0000
Message-ID: <1263046269.2938.6.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-FKzj1qBMvnNtT8IOPMHV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dnia 2010-01-04, pon o godzinie 16:39 +0100, Bastien Nocera pisze:
> On Mon, 2010-01-04 at 12:24 +0100, Jiri Kosina wrote:
> > On Sun, 3 Jan 2010, Przemys=C5=82aw Firszt wrote:
> >=20
> > > Please check attached patch and apply if it's possible.
> > > The patch was also discussed here:
> > > http://www.mail-archive.com/linuxwacom-devel@lists.sourceforge.net/ms=
g00128.htm
> >=20
> > Adding Bastien (the author of hid-wacom.c) to CC.
[..]
There is one more change required to get the pad buttons on wacom
bluetooth tablet fully working - see attached patch.
My main goal was to map pad buttons to Ctrl-Z and Ctrl-Y - (gimp
undo/redo) and now it works.=20
After this:
xsetwacom --set "WACOM Pen Tablet pad" Button1 "core key ctrl z"
xsetwacom --set "WACOM Pen Tablet pad" Button2 "core key ctrl y"
I've got nicely working undo/redo in gimp.
--
Przemo




--=-FKzj1qBMvnNtT8IOPMHV
Content-Disposition: attachment; filename*0=0002-Add-BTN_TOOL_FINGER-input-report-when-reporting-a-pa.pat; filename*1=ch
Content-Type: text/x-patch; name="0002-Add-BTN_TOOL_FINGER-input-report-when-reporting-a-pa.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 28feba89f364fc7ce0733ca9736b970bcdde7fd3 Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Sat, 9 Jan 2010 13:58:51 +0000
Subject: [PATCH 2/2] Add BTN_TOOL_FINGER input report when reporting a pad button

Without this patch xf86-input-wacom driver wasn't able to properly recognise
pad button events. It was also causing some problems with button mapping.
Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/hid-wacom.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 75ea66a..12dcda5 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -142,6 +142,7 @@ static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 		wdata->butstate = rw;
 		input_report_key(input, BTN_0, rw & 0x02);
 		input_report_key(input, BTN_1, rw & 0x01);
+		input_report_key(input, BTN_TOOL_FINGER, 0xf0);
 		input_event(input, EV_MSC, MSC_SERIAL, 0xf0);
 		input_sync(input);
 	}
-- 
1.6.5.7


--=-FKzj1qBMvnNtT8IOPMHV--

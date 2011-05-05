Return-Path: <cyrus@holtmann.org>
Sender: Bastien Nocera <hadessuk@googlemail.com>
Subject: Re: [PATCH] Re: Work-around for broken MS device
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Thu, 05 May 2011 19:02:09 +0100
In-Reply-To: <7B1632C9-FE1A-43EA-A0B6-F26A46F9929F@holtmann.org>
References: <1236278908.3602.1896.camel@cookie.hadess.net>
	 <1237397279.15346.1157.camel@cookie.hadess.net>
	 <1237011673.24751.10.camel@localhost.localdomain>
	 <1237816742.19118.1234.camel@cookie.hadess.net>
	 <7B1632C9-FE1A-43EA-A0B6-F26A46F9929F@holtmann.org>
Content-Type: multipart/mixed; boundary="=-N++cpaLUuNevao+K+Qnp"
Message-ID: <1304618532.16101.14.camel@novo.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-N++cpaLUuNevao+K+Qnp
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit

On Mon, 2009-03-23 at 16:45 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> >>>> As seen in https://bugzilla.redhat.com/show_bug.cgi?id=450081
> >>>> The Microsoft Wireless Notebook Presenter Mouse 8000 has its name  
> >>>> in
> >>>> ISO-8859-1 instead of UTF-8, as required by the BT spec.
> >>>>
> >>>> I've implemented a small work-around. This isn't very invasive,  
> >>>> IMO, as
> >>>> we already do UTF-8 checks.
> >>>>
> >>>> In my tests, this makes the mouse show up as:
> >>>> Microsoft® Wireless Notebook Presenter Mouse 8000
> >>>
> >>> Attached is patch in the proper format.
> >>
> >> I see the need for this one, but just a failing UTF-8 check to  
> >> assume we
> >> are using ISO-8859-1 is not good enough. Since the mouse has a DID
> >> record, can we tie this together with the VID and PID?
> >
> > In those kind of cases, we can only guess what the encoding would  
> > be, we
> > can't detect those encodings reliably. Given that we fallback to the  
> > old
> > behaviour when the device, and that ISO-8859-X corresponds 1-1 with
> > UTF-8 for the ASCII characters, I don't think it's such a stretch to
> > think that American companies (who'd be using ISO-8859-1) would be the
> > worst offenders for this sort of mistake.
> >
> > I don't think special casing only this device would be a good idea.  
> > As I
> > mentioned, I reproduced the bug by making my computer, running BlueZ,
> > adopt that name.
> 
> can we just fallback to ASCII only? Looks better to me than assuming  
> Latin-1. We replace invalid characters with spaces in that case.

Patch to do that attached.

Cheers

--=-N++cpaLUuNevao+K+Qnp
Content-Disposition: attachment; filename="0001-Handle-non-UTF-8-device-names.patch"
Content-Type: text/x-patch; name="0001-Handle-non-UTF-8-device-names.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 02180fd9a53d3e544a218b3040ce63dcb58b4560 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Mon, 8 Nov 2010 16:43:42 +0000
Subject: [PATCH] Handle non-UTF-8 device names

http://thread.gmane.org/gmane.linux.bluez.kernel/1687
https://bugzilla.redhat.com/show_bug.cgi?id=450081
---
 src/event.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/event.c b/src/event.c
index d5bf967..0a2fb0c 100644
--- a/src/event.c
+++ b/src/event.c
@@ -562,13 +562,15 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status,
 	struct remote_dev_info match, *dev_info;
 
 	if (status == 0) {
-		char *end;
-
-		/* It's ok to cast end between const and non-const since
-		 * we know it points to inside of name which is non-const */
-		if (!g_utf8_validate(name, -1, (const char **) &end))
-			*end = '\0';
-
+		if (!g_utf8_validate(name, -1, NULL)) {
+			/* Assume ASCII, and replace all non-ASCII with spaces */
+			for (i = 0; name[i] != '\0'; i++) {
+				if (!isascii (name[i]))
+					name[i] = ' ';
+			}
+			/* Remove leading and trailing whitespace characters */
+			g_strstrip (name);
+		}
 		write_device_name(local, peer, name);
 	}
 
-- 
1.7.5


--=-N++cpaLUuNevao+K+Qnp--

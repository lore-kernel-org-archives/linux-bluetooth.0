Return-Path: <jt@bougret.hpl.hp.com>
Date: Tue, 16 Sep 2003 17:06:37 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
Message-ID: <20030917000637.GA26969@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030915221624.GA17085@bougret.hpl.hp.com> <1063712005.22723.27.camel@pegasus> <20030916195333.GA25068@bougret.hpl.hp.com> <1063755753.29942.9.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1063755753.29942.9.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Sep 17, 2003 at 01:42:27AM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> > 	While you are at it, would you mid to do the following :
> > 	o rename sdp_uuid_cmp() to sdp_uuid128_cmp(). The current name
> > totally confused me.
> 
> who are the current users of sdp_uuid_cmp() ?

	As far as I can see, it's only used internally, like this :

record.c:       if (sdp_list_find(rec->pattern, uuid128, sdp_uuid_cmp) == NULL)
record.c:               rec->pattern = sdp_list_insert_sorted(rec->pattern, uuid128, sdp_uuid_cmp);

	I believe that it can only work with the server records,
because it require all UUIDs to be 128, whereas the UUID you get as a
client are UUID16. That's why I needed the other function :

	  if(sdp_list_find(services, &service_nap, sdp_uuid16_cmp) != NULL)


> > 	I hope you will keep the --tree browsing option in sdptool,
> > because the default browsing is useless for advanced stuff. The
> > display might be ugly, but at least it display everything and the
> > basic infrastructure is sound.
> 
> Of course, because that is the only output that matters to me and I
> don't find the tree output so ugly. This is an example output of my
> Bluespoon headset from my code:
> 
> Sequence
>         Attribute 0x0000 - Service record handle
>                 UINT32 0x00010000
>         Attribute 0x0001 - Service class ID list
>                 Sequence
>                         UUID16 0x1108 - Headset
>                         UUID16 0x1203 - Generic Audio
>         Attribute 0x0004 - Protocol descriptor list
>                 Sequence
>                         Sequence
>                                 UUID16 0x0100 - L2CAP
>                         Sequence
>                                 UUID16 0x0003 - RFCOMM

	This looks much better than what I have with sdp-1.2, it seems
that you have done some nice cleanup. Wonderful ;-)

>                                 UINT8 0x01

	Why is this one broken ? In version 1.2, it should display
"Channel/Port".

>         Attribute 0x0009 - Bluetooth profile descriptor list
>                 Sequence
>                         Sequence
>                                 UUID16 0x1108 - Headset
>                                 UINT16 0x0100

	I can't help on this one, but that would be easy to add.

>         Attribute 0x0302
>                 Bool True

	Totally untested patch :
---------------------------------------------
--- listattr.s2.c       Tue Sep 16 16:53:01 2003
+++ listattr.c  Tue Sep 16 17:00:33 2003
@@ -145,6 +145,12 @@ static struct attrib_def pan_attrib_name
   { 0x30E, "IPv6Subnet", NULL, 0 },
 };
 
+/* Name of the various Generic-Audio attributes. See BT assigned numbers */
+/* Note : totally untested - Jean II */
+static struct attrib_def audio_attrib_names[] = {
+  { 0x302, "Remote audio volume control", NULL, 0 },
+};
+
 /* Same for the UUIDs. See BT assigned numbers */
 static struct uuid_def uuid16_names[] = {
   /* -- Protocols -- */
@@ -184,7 +190,8 @@ static struct uuid_def uuid16_names[] = 
   { 0x1105, "OBEXObjectPush", NULL, 0 },
   { 0x1106, "OBEXFileTransfer", NULL, 0 },
   { 0x1107, "IrMCSyncCommand", NULL, 0 },
-  { 0x1108, "Headset", NULL, 0 },
+  { 0x1108, "Headset",
+    audio_attrib_names, sizeof(audio_attrib_names)/sizeof(struct attrib_def) },
   { 0x1109, "CordlessTelephony", NULL, 0 },
   /* ... */
   { 0x110F, "VideoConferencing", NULL, 0 },
@@ -216,7 +223,8 @@ static struct uuid_def uuid16_names[] = 
   { 0x1200, "PnPInformation", NULL, 0 },
   { 0x1201, "GenericNetworking", NULL, 0 },
   { 0x1202, "GenericFileTransfer", NULL, 0 },
-  { 0x1203, "GenericAudio", NULL, 0 },
+  { 0x1203, "GenericAudio",
+    audio_attrib_names, sizeof(audio_attrib_names)/sizeof(struct attrib_def) },
   { 0x1204, "GenericTelephony", NULL, 0 },
 };
 
---------------------------------------------

> Regards
> 
> Marcel

	Have fun...

	Jean

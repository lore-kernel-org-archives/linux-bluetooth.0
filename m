Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Adam Bliss <abliss@google.com>
Date: Sun, 14 Feb 2010 22:29:31 -0800
Message-ID: <ee007d8e1002142229m22bec4fdweb8150bdb8e8706d@mail.gmail.com>
Subject: SolidTek ASK-3962 keyboard works but mouse doesn't [patch]
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,

I bought a SolidTek ASK-3962 Keyboard/Mouse for use with my Home
Theatre PC.  The keyboard connects and works great with bluez 4.60 --
hooray!

However, the mouse does not work.  I traced this down to the subclass
the device reports when it connects.  It reports 0x40, while bluez
expects it to include 0x80 to be treated as a mouse.  I found this
patch to work great:


--- bluez-4.60/input/device.c   2010-01-09 12:52:17.000000000 -0800
+++ bluez-4.60-new/input/device.c       2010-02-14 22:16:22.000000000 -0800
@@ -647,6 +647,12 @@
        if (idev->name)
                strncpy(req->name, idev->name, sizeof(req->name) - 1);

+       if (req->vendor == 0x0dc6 && req->product == 0x3752) {
+               // The SolidTek ask-3962 has a keyboard and a mouse, but
+               // incorrectly reports its subclass.
+               req->subclass |= 0x80;
+       }
+
        /* Encryption is mandatory for keyboards */
        if (req->subclass & 0x40) {
                err = bt_acl_encrypt(&idev->src, &idev->dst,
encrypt_completed, req);


(You can also do this with the old hidd program by passing "-b 192" to
force the subclass.)

I don't know if one-off hacks in device.c are the right way to solve
this problem -- I was "inspired" by the one-off patch in there already
for 054c:0268.  Let me know if there's a more appropriate way to fix
this, and I'll be happy to send in another patch.

Cheers,
--Adam Bliss

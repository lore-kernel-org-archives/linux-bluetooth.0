Return-Path: <cyrus@holtmann.org>
Message-ID: <682855.82528.qm@web52605.mail.re2.yahoo.com>
Date: Tue, 11 May 2010 13:48:55 -0700 (PDT)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: Fail to store link key for Blackberry
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,  
I was having trouble pairing with Blackberry (bluez-4.60). It was paired, but the next connection require pair again.
 hcidump: "Link Key Request Negative Reply"
  check  /var/lib/bluetooth/xxx/linkkeys   not there.
  Delete the device from BB side, went through pairing again
   hcidump: > Link key Notification .. type 6 (Changed Combination key)
   but  ../linkkeys still not there.
  Trace down to dbus-hci.c   hcid_dbus_link_key_notify()
/*  Only store the link key if one of the following is true:   
     2. this is a changed combination key and there was a previously
     stored one */
...
   if (key_type < 0x03 || (key_type == 0x06 && old_key_type != 0xff) ||
...
if I change it to the following, then the ../linkkeys is stored and paring with the Blackberry only need to do once   
   if (key_type < 0x03 || (key_type == 0x06) ||

Look to me " hcidump: Link key Notification .. type 6 (Changed Combination key) " the "6" is coming from Blackberry. 
I tried deleted the device from the Blackberry, delete the device and remove the battery from the Blackberry....
 hcidump > link key notification still type 6.

/*     * 2. this is a changed combination key and there was a previously
     *    stored one */ 
in general make sense until we encounter device like this or for whatever reason, we lost the local link
key for the device, then we might be stuck in "pairing everytime connect".

Any comment?

Ed



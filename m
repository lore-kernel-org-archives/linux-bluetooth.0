Return-Path: <huggie@earth.li>
Date: Sat, 15 May 2004 00:40:45 +0100
From: Simon Huggins <huggie@earth.li>
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: More progress with 2.6.6-mh1
Message-ID: <20040514234045.GH21076@paranoidfreak.co.uk>
References: <20040513202052.GJ14471@paranoidfreak.co.uk> <1084485054.25099.153.camel@pegasus> <20040513220010.GD19473@paranoidfreak.co.uk> <1084486715.25099.164.camel@pegasus> <20040513222606.GE19473@paranoidfreak.co.uk> <20040514085951.GL19473@paranoidfreak.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040514085951.GL19473@paranoidfreak.co.uk>
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, May 14, 2004 at 09:59:51AM +0100, Simon Huggins wrote:
> In 2.4.26-mh1 I can see the phone I get:
[..]
> And the scan does see the device with the name I gave it.

And if I apply bk-usb.patch from -mm2:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm2/broken-out/

then it will find the phone and work from gnokii and minicom over rfcomm.

So that's vanilla 2.6.6 + -mh1 + the -mm2 usb patch.

I'm not sure which bit broke it but there is a patch there which has
been posted to one of the bluez lists which is this snippet (whitespace may be
borked):

diff -Nru a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
--- a/drivers/bluetooth/hci_usb.c       Wed May 12 20:33:40 2004
+++ b/drivers/bluetooth/hci_usb.c       Wed May 12 20:33:40 2004
@@ -342,7 +342,7 @@
 
 static inline void hci_usb_wait_for_urb(struct urb *urb)
 {
-       while (atomic_read(&urb->count) > 1) {
+       while (atomic_read(&urb->kref.refcount) > 1) {
                current->state = TASK_UNINTERRUPTIBLE;
                schedule_timeout((5 * HZ + 999) / 1000);
        }

I haven't tested 2.6.6-mh1 + that snippet though I can if you like.

Does 2.6.6-mh1 work for other people?

The comment that goes with it is a bit disturbing:

#   2004/04/29 10:47:50-07:00 greg@kroah.com 
#   USB: fix build error in hci_usb driver due to urb reference count
#   change.
#   
#   This really needs to get fixed the proper way, by making the urb
#   allocation dynamic in the driver, instead of the hack it is
#   currently doing...

Is that broken then?

Simon.

-- 
 -+//                      - Oh no.  It's closed.                      \\+-
-+<<          - We're not pre-school toys Slinky; we can read.          >>+-
 -+\\                                                                  //+-
        Colocate your server with http://www.blackcatnetworks.co.uk

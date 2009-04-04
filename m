Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: linux-bluetooth@vger.kernel.org
Subject: The link I had working quit.  Help
Date: Sat, 04 Apr 2009 16:36:25 -0400
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Message-id: <200904041636.25409.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings all;

I had minicom working fine till I reset the passkey on both devices, and now 
minicom says there is no /dev/rfcomm0 when there really is.

The init script I use here now reads:
----------------------------------
#!/bin/bash
echo attempting to get bt link to the coco3
hcitool -i hci0 11:11:11:11:11:11 key 4391
rfcomm release hci0
rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8
echo this should show the cocos address
rfcomm -i 11:11:11:11:11:11 show hci0
------------------------------------
and returns:
[root@coyote sysconfig]# connect2coco3

attempting to get bt link to the coco3
this should show the cocos address
rfcomm0: 11:11:11:11:11:11 -> 00:0C:84:00:86:F8 channel 1 clean

But minicom now says /dev/rfcomm0 doesn't exist, or after a couple of minutes:
-------------------------------
[root@coyote system.d]# minicom
minicom: cannot open /dev/rfcomm0: Host is down
-----------------------------

but it does exist:
[root@coyote sysconfig]# ls -l /dev/rfc*
crw------- 1 root root 216, 0 2009-04-04 16:20 /dev/rfcomm0

I am assuming that 'key' here is equal to 'passkey' on the other device.
Is that assumption wrong?

I'm also assuming that a short powerdown for the eb101 device at the other end 
will restore it to link mode after I quit the comm proggy on that machine, 
which probably puts the eb101 into the command mode with a +++ pause ATH.  I 
can train that program not to do that I think.

So, which end do I beat on here?, I'm getting lost in the forest, too many 
trees.

Thank you all.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Please state the nature of the technical emergency


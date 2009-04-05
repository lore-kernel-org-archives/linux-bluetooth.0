Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Date: Sun, 05 Apr 2009 17:59:31 -0400
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904051659.47368.gene.heskett@verizon.net>
In-reply-to: <200904051659.47368.gene.heskett@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Message-id: <200904051759.31968.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sunday 05 April 2009, Gene Heskett wrote:
[...]
Been playing with a script, step by step.  It gets to the line
hciconfig -a hci0 putkey 0000 (which is the default key at the other end of 
this link I'm trying to reliably establish)

The script:
----------------------------------
#!/bin/bash
echo attempting to get bt link to the coco3
echo "rfcomm release hci0"
rfcomm release hci0
sleep 5
echo "hciconfig hci0 down"
hciconfig -a hci0 down
sleep 5
echo "hciconfig -a hci0 up"
hciconfig -a hci0 up
sleep 5
hciconfig -a
sleep 5
echo "hciconfig -a hci0 noauth noencrypt nosecmgr"
hciconfig -a hci0 noauth noencrypt nosecmgr
sleep 5
echo "hciconfig -a hci0 putkey 0000"
hciconfig -a hci0 putkey 0000
--------which returns:
Can't find link key for 0000 on hci0
^C

And as you can see I killed it there.  What am I doing wrong?
-------------script continues----------------
sleep 5
echo "rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8"
rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8
sleep 5
echo "rfcomm -i 11:11:11:11:11:11 connect hci0 00:0c:84:00:86:F8"
rfcomm -i 11:11:11:11:11:11 connect hci0 00:0c:84:00:86:F8
sleep 5
echo this should show the cocos address
rfcomm -i 11:11:11:11:11:11 show hci0
-------------------------------
And it did yesterday morning before I broke it somehow trying to make a script 
that Just Worked(TM) :(

Where are the bluetooth guru's?  Or, where can I find the RFC documents that 
describe how all this is supposed to work?

What I want to  do, and was doing, is to run a system shell on the bt device 
on the other end, and minicom or picocom  to /dev/rfcomm0 as a remote terminal 
on that system.

Thanks everybody.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Learning French is trivial: the word for horse is cheval, and everything else
follows in the same way.
		-- Alan J. Perlis


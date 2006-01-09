Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43C29249.3020008@fillibach.de>
From: Kosta Welke <kosta@fillibach.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] pan link quality
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 09 Jan 2006 17:41:45 +0100

Hi all!

I am currently playing around in setting up IP ad-hoc networks using
bluez. olsr-over-bluetooth works, and `pand -Q` is a nice thing :)

The bad stuff is that inquiry & connecting can take some time, but its 
hard to really do something against that. (I have a few hacks in mind, 
but they wont scale)

What would be really nice is some link quality metric. On my mobile 
device `hcitool lq` always returns 255 (Even if the link goes bad and 
the other side sees it). But I have one metric in mind: the interface 
gets destroyed if a certain number of packets are not acknowledged by 
the receiver. Is there some way (other than writing a script that 
listens to hcidump) to measure this? `ifconfig bnep0` shows errors:0
and dropped:0 until it is detroyed. I am not a kernel hacker, i looked 
around a bit in the bluez module, the library and pand, but couldnt 
really find anything...

Do you have any hints? Is there any "unacknoledged packets" metric 
accessible from userland? Where is the code that destroys the bnep 
interface after x packets?

Thanks in advance,

Kosta

PS: Are you interesed in a "zeroconf ip" patch for pand?


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

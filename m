Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Russell Neches <russell@ccs.neu.edu>
To: bluez-users <bluez-users@lists.sourceforge.net>
Message-ID: <20040310182158.GA9279@naginata.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] crash on remove
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Mar 2004 13:21:58 -0500


Sorry if this is mildly off-topic...

Every time I remove a bluetooth USB key from my desktop machine, I get
a hard lock. I've tried this with a Belkin key and D-Link key (not the
one with the Broadcom chipset). I don't even see a kernel panic in
text mode. However, my laptop (running exactly the same kernel
version) works fine on remove. So far, this only seems to happen with
bluetooth USB keys. I've tried a number of other USB devices on my
desktop, and they all remove cleanly (even after several such cycles).  
 
The desktop (where the problems are occuring) has an A-Bit motherboard
with all Via components, and has both a USB 1.1 and 2.0 controller
(I'm pretty sure I'm plugging the key into one of the 1.1 ports). 

The laptop is a Toshiba Libretto L5 with ALI components (USB 1.1). 

I'm running kernel 2.6.3 with no patches applied on both systems. 

This is most likely a module unloading bug triggered by the hotplug
event, but I figured I'd ask here first, as it is bluetooth related.
If anyone else has a similar hardware combination, would you mind
attempting to remove the key a couple of times? (occasionally the
desktop will only freeze after the second unload)

Does anyone have any strategies for extracting some debugging
information? I've not played with SysReq or tracebacks, so I'm not
sure if they'd help in this case.

Thanks,

Russell



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

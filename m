Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Felix Homann <fexpop@onlinehome.de>
To: bluez-users@lists.sourceforge.net
Date: Fri, 28 Jul 2006 11:00:44 +0200
References: <200607271240.49400.fexpop@onlinehome.de>
	<200607272208.06047.fexpop@onlinehome.de>
	<1154049600.7650.6.camel@localhost>
In-Reply-To: <1154049600.7650.6.camel@localhost>
MIME-Version: 1.0
Message-Id: <200607281100.44745.fexpop@onlinehome.de>
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a Belkin dongle in Debian
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

On Friday 28 July 2006 03:20, Marcel Holtmann wrote:
> Hi Felix,
> now you are mixing things. 

I don't think so. In my original post I mentioned two issues. One could be 
worked around by "hciconfig hci0 inqmode 0". kdebluetoothd can find other 
devices afterwards. 

(BTW, why is this only necessary for kdebluetoothd, 'hcitool scan' works fine 
without setting the inqmode first. Why has this not been an issue with the 
2.x series of bluez?)

The other issue didn't get a reply. (Maybe I should have put both issues in 
differnet threads like I did in the Debian BTS, sorry..)

> The inquiry mode has nothing to do with the 
> scan mode.

Sure, but there's still the other issue: My system can't be found by other 
devices. Here's a more detailed report:

1. My system can only be found by other devices if I enable inquiry scan 
manually using 'hciconfig hci0 iscan' (or piscan). It's the only way I found 
so far. 'hciconfig -a' will show "UP RUNNING ISCAN". 

2. "iscan enable;" in hcid.conf will not make my system visible (in 
contradiction to what the man page says), 'hciconfig -a' will show "UP 
RUNNING PSCAN".

3. "pscan disable;" in hcid.conf  will not disable PSCAN.  'hciconfig -a' will 
show "UP RUNNING PSCAN".

4. It doesn't matter (with respect to 'hciconfig -a' output and visibility) at 
all if there is any 'iscan/pscan enable/disable' line at all: PSCAN will show 
up, ISCAN not.

5. All of this happens with every BT card/dongle I have at hand 
(SPHINX/Belkin/EPoX).

> The scan mode defines is you are visible and connectable. The D-Bus API
> sets you to connectable only unless you disable the discoverable timeout
> and set your yourself to discoverable.

How do I set the discoverable timeout? How am I supposed to set myself 
discoverable? Are there new options in hcid.conf? Where is it documented?

> This is a feature of the new 3.x 
> generation that will make you automatically unvisible after a certain
> amount of time.

Where is it documented? (Generally I've been missing such a feature. I just 
don't want to be invisble from the start.)

> These two things are not related.

Yes, read above.

> And start sending in "hcidump -X -V"  outputs instead of speculating.

I did not know of this. Here's the output of "hcidump -X -V" while my phone is 
scanning for devices:

# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff

That's really all there is. The output doesn't change after 
issueing 'hciconfig hci0 piscan', but my phone can see my PC afterwards. 
After a minute or so hcidump spits out this:

< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 2
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
< HCI Command: Read Scan Enable (0x03|0x0019) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Scan Enable (0x03|0x0019) ncmd 1
    status 0x00 enable 2

Afterwards my system is invisble again, I guess that's the timeout you've 
mentioned.

Kind regards,

Felix

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: John Morton <jwm@angrymonkey.net.nz>
To: bluez-users@lists.sourceforge.net
Date: Fri, 18 Aug 2006 01:17:01 +1200
MIME-Version: 1.0
Message-Id: <200608180117.02770.jwm@angrymonkey.net.nz>
Subject: [Bluez-users] Keyboard woe
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

I've just picked up a luggable bluetooth keyboard for use with a cellphone, 
but I'd like to get it going under linux. This is proving to be a challenge.

So far the USB bluetooth dongle seems to work fine, and I can gather 
information about the keyboard, ie:

> hcitool inq
Inquiring ...
        00:0A:3A:30:D4:40       clock offset: 0x60be    class: 0x001f00
> hcitool info 00:0A:3A:30:D4:40
Requesting information ...
        BD Address:  00:0A:3A:30:D4:40
        Device Name: KEYBOARD
        LMP Version: 1.1 (0x1) LMP Subversion: 0x2c2
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbc 0x06 0x07 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <sniff mode> <RSSI> <channel quality> <CVSD> <paging scheme>
                <power control>

After some reading I discover that I need to get going hidd to use the 
keyboard and I'd need to connect manually first to perform pairing. (This I 
find in the Debian readme, but no where else - is there documentation I'm 
missing?)

The first time I run hidd --connect 00:0A:3A:30:D4:40 it fails with an oblique 
error message about not being able to open an input device. I have to run 
strace to find out which (/dev/input/uinput) then grep the kernel source to 
work out which module needs building (CONFIG_INPUT_UNINPUT).  Again - have I 
missed some vital piece of documentation, here, because googling was rather 
unreliable...

Now, when I run it, I get a connection, but I'm a bit lost as to what ought to 
happen. What I'm getting is every key press on the bluetooth keyboard 
producing an unknown event code, ie:

> hidd --connect 00:0A:3A:30:D4:40
Connected to 00:0A:3A:30:D4:40 on channel 1
Press CTRL-C for hangup
Unknown event code 1
Unknown event code 64
Unknown event code 2
Unknown event code 3
Unknown event code 4

(String was 1234)

What _should_ be happening?

And what can I do to produce some debugging output of use to any developers on 
the list?

TIA,
John


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

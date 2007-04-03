Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 3 Apr 2007 17:37:07 -0400
From: Chris MacDonald <chris@fourthandvine.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <457639F1.3030908@fourthandvine.com>
References: <457639F1.3030908@fourthandvine.com>
Message-ID: <a4ee4469bd4883e4ad9d73414e11b833@localhost>
Subject: Re: [Bluez-users] Device 'sleeping' and Reconnecting
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

Hello...

Me again, I've finally had a moment to play with this again so I have some logs that may help. I can still connect to the Apple bluetooth keyboard but the connection only lasts 30 minutes while idle then it disconnects...

...
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0041
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
...

Then when I hit a key...

...
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
...

Which looks like it's reconnecting, but I can never type again with the keyboard, each time I type it just looks like it's trying to reconnect again. It takes an "hidd --connect ..." to connect to the keyboard and type again. This is all taken with hcidump 1.3, I have more logs available.

I'm currently running Gentoo (2.6.19-gentoo-r5 from Portage) along with bluez-utils and bluez-libs 2.25 from Portage as well. Any help would be greatly appreciated, ideally I'd just like to have the keyboard reconnect and still be usable. I'm not sure if it's a simple directive I'm missing in my hcid.conf or something else along those lines. Speaking if which, here's my hcid.conf...

options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /usr/bin/bluepin;
}
device {
        name "BlueZ (%d)";
        class 0x100;
        iscan enable; pscan enable;
        lm accept;
        lp rswitch,hold,sniff,park;
        auth enable;
        encrypt enable;
}

Again, any help would be great, thanks.

Chris

On Tue, 05 Dec 2006 22:33:05 -0500, Chris MacDonald <chris@fourthandvine.com> wrote:
> Hi all,
> 
> I just recently purchased an Apple bluetooth keyboard and I'm just
> trying to wrestle with it to get things working smoothly.
> 
> So far I've managed to connect to it and have it function properly as a
> keyboard but there seems to be some kind of power saving function to the
> keyboard that I'm having problems with. After about 20 minutes or so (I
> haven't been patient enough to figure out exactly how long it is) after
> being left alone the keyboard no longer functions. Opening hcidump with
> another keyboard and watching the output shows that the keyboard seems
> to be sending something to my bluetooth receiver, but the connection
> never reestablishes to the point where I can type with the keyboard again.
> 
> Currently to reconnect everything I just turn the power to the keyboard
> off and on again then with a second keyboard I run 'hidd -connect
> BT_ADDR' and it reconnects. It may be worth mentioning that if I happen
> to hit a key on the keyboard after restarting it and immediately try the
> aforementioned command it fails.
> 
> Ideally what I'd like to do is have the keyboard come back to life and
> 'just work'. Barring that I'm wondering if it'd be possible to throw
> something into my crontab to keep the connection alive. If anyone can
> help in this endevour that would be awesome. I'd be more than willing to
> provide the necessary output from any commands that should be run to
> shed some light on the situation, I just haven't included any here
> because I'm not sure what's needed/relevant.
> 
> Thanks in advance,
> Chris
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

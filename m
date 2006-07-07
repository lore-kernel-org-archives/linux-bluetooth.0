Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Christoph Lukas <christoph.lukas@gmx.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d23110170607070744u5cdc657cy607db2016a887908@mail.gmail.com>
References: <1150746967.5012.13.camel@localhost>
	<44970CBD.8000802@xmission.com> <1152109512.11387.24.camel@localhost>
	<d23110170607070744u5cdc657cy607db2016a887908@mail.gmail.com>
Date: Fri, 07 Jul 2006 17:48:24 +0200
Message-Id: <1152287304.5770.15.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Slow connection to Motorola H500 Headset
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

Hi Ulisses,

thanks for your reply.

> > can anybody tell me what this 'HCI Event: Mode Change (0x14) plen 6' is
> > about and probably how to prevent this?
> > A full hcidump from pairing the headset and starting btsco is attached.
> 
> First of all, hcidump produce better output when you use -X and -V switches. :-)

Ah, thanks. That would have made it easier.

> Well, this mode change event is turning the connection to sniff mode,
> probably to save some power. And according to your dump the command to
> change the connection mode was sent by your headset. Looking closer we
> can see that the interval between two sniff anchor points is 4096
> baseband slots that give us 2.56 seconds! This really seems to be
> overkill and it's probably causing the delay you're experiencing.

Ok. That sounds reasonable. 

> I don't think there's something you can do to avoid this. btsco could
> change the link policy settings to remove sniff mode, but this would
> require root privileges and I really don't think btsco shoud do that.
> Marcel, am I right or is there anything that might be done and I don't
> know?

In a first try I have used hciconfig to disable sniff mode completely on
hci0:

hciconfig hci0 lp RSWITCH,HOLD,PARK

This made my headset working perfectly!

You are my hero!

Are there any negative side effect of disabling sniff mode? Is it needed
for some devices?

Thanks a lot,
Christoph



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

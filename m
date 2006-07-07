Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d23110170607071014p5f60069fj6e6ef41d0034d049@mail.gmail.com>
Date: Fri, 7 Jul 2006 14:14:46 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1152287304.5770.15.camel@localhost>
MIME-Version: 1.0
References: <1150746967.5012.13.camel@localhost>
	<44970CBD.8000802@xmission.com> <1152109512.11387.24.camel@localhost>
	<d23110170607070744u5cdc657cy607db2016a887908@mail.gmail.com>
	<1152287304.5770.15.camel@localhost>
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

On 7/7/06, Christoph Lukas <christoph.lukas@gmx.net> wrote:

Hi Christoph,

> In a first try I have used hciconfig to disable sniff mode completely on
> hci0:
>
> hciconfig hci0 lp RSWITCH,HOLD,PARK
>
> This made my headset working perfectly!
>
> You are my hero!
>
> Are there any negative side effect of disabling sniff mode?

Yeah, I didn't say but you could have done just that. Though it
disables the sniff mode for all ACL connections using the hci0 adapter
and we usually don't want this because several devices use the sniff
mode to save battery. Thus the negative side effect you might notice
is that your devices will probably run out of battery much earlier
than before.

FWIW, I think that your headset doesn't make use of sniff mode correctly.

> Is it needed for some devices?

I really don't know if the sniff mode is mandatory for some devices,
but I do know that some keyboards/mice like to be in sniff mode all
the time.

Best regards,

-- Ulisses

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

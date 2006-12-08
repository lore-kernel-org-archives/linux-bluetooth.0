Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45798CE8.80502@xmission.com>
Date: Fri, 08 Dec 2006 09:03:52 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: jimmi@bglug.it, BlueZ users <bluez-users@lists.sourceforge.net>
References: <20060805103737.GB6035@jimmi.home>
	<44D489D5.2040509@schugy.de>	<20060805131519.GA6170@jimmi.home>	<20060817115818.GA6365@jimmi.home>	<20060828172022.GA5370@jimmi.home>
	<20061208083051.GA6178@jimmi.home>
In-Reply-To: <20061208083051.GA6178@jimmi.home>
Subject: Re: [Bluez-users] Again down with Jabra BT250V
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

Jimmi

the other fix is to install bluez-passkey-gnome.

has anyone filed a bug with ubuntu? bluetooth doesn't work out of the 
box on edgy.

brad

> On 280806 alle 19:20, Jimmi wrote:
>> After reading  some post here it  came in my mind  to try reinstalling
>> bluez-pin.  I  purged  the  Debian package  and  installed  again  and
>> magically it started working! 8)
> 
> After some  time I  switched to  Ubuntu ("edgy"  now) and  the nightmare
> started again:
> 
> $btsco 00:07:A4:14:0F:BF
> 	Error: Failed to connect to SDP server: Permission denied
> 	Assuming channel 2
> 
> 	Can't connect RFCOMM channel: Permission denied
> 
> On another  laptop I  could perfectly  pair my  headset using  the gnome
> bluetooth-applet,  existing  in Ubuntu  in  the  "feisty" repository.  I
> installed it and I was perfectly able to pair through it. Now everything
> works perfect :)
> 
> Therefore I  understood that  there is  something wrong  with bluez-pin,
> even though  I could  not realize  what. By  giving: 
> #/usr/bin/bluez-pin out  00:07:A4:14:0F:BF"  
> the window comes out, I may write the pin in it and the pin is stored in
> /etc/bluetooth/pin. (of course in /etc/bluetooth/hcid I have "pin_helper
> /usr/bin/bluez-pin;")
> 
> Hope this helps somebody ;)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

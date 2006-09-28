Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Mark Hellman <markhellman@techie.com>
Date: Thu, 28 Sep 2006 11:06:59 +0100
Message-ID: <efg6rk$5tg$1@sea.gmane.org>
References: <eeu5cm$25p$1@sea.gmane.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] btsco, udev and other issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Can'T anyone give me some hints on these questions?


Mark Hellman wrote:

> I have the following issues with btsco and Nokia HS-56W headset:
> 
> 1. I have seen several reports that indicate btsco can be run as a regular
>    user. But I have only been able to run it as root. When I run it as a
>    regular user I get:
>          btsco v0.42
>          Error: control open (hw:1): No such device
>          Error: Can't find device. Bail
> 
> 
> 2. As a consequence of running btsco as root, the newly created sound
> device
>    cannot be seen by regular users. What udev rule should I set so that
>    the BT headset is seen by other users when btsco is run by root?
> 
> 
> 3. While using btsco with Skype, a lot of message like the following
> appear
>    on syslog:
>       kernel: snd-bt-sco: Shift problem detected! Fixing to 1.
>       kernel: snd-bt-sco: Shift problem detected! Fixing to 0.
>    What do they mean? Should I be worried about them?
> 
> 
> 4. When I hang up a call on Skype, I'm not able to place another call
> again.
>    Skype says "Problem with sound device". I need then to restart Skype in
>    order to be able access the BT headset again. But when the other
>    calling party hangs up, this problem does not occur... It seems that
>    when I hang up a call, the SCO channel is not cleanly disconnected. Any
>    ideas why?
> 
> 
> I would be grateful if someone could enlighten me on at least some of
> these issues.
> 
> Mark



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

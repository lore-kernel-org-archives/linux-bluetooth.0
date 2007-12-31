Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300712310801sd57b33dt309c99a6d7d33895@mail.gmail.com>
Date: Mon, 31 Dec 2007 09:01:41 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <200712311033.44650.lists@spudulike.me.uk>
MIME-Version: 1.0
References: <200712311033.44650.lists@spudulike.me.uk>
Subject: Re: [Bluez-users] Bluetooth connection log file.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Colin

you can debug problems as they happen with

sudo hcidump -XV >/tmp/log

you'll get a lot of data but usually the problems stand out.

On Dec 31, 2007 3:33 AM, Colin Murphy <lists@spudulike.me.uk> wrote:
> I am having a problem on my Ubuntu 7.10 box in making a useful connection to
> my stereo headset adaptor.  I have been able to make a connection but it only
> lasts for a few minutes, at best.  The messages I get on screen seem to
> suggest that the bluetooth adaptor itself, hci0, keeps 'disappearing'
> and 're-appearing'.
>
> To get some more information I would like to look at the log files, but I
> can't seem to find any that make reference to bluetooth.
>
> What log files will tell me what is going on with the bluetooth adaptor dongle
> and with the connections that are made, but then dropped.
>
> Thanks in advance.
> --
> Colin@spudulike.me.uk
> Gotta' go, things to be, people to do, stuff to, err, stuff.
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

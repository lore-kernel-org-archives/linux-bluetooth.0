Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Apr 2008 22:00:35 +0300 (EEST)
From: Ari Moisio <arimo@iki.fi>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300804070735n2f107af4ge23848cc96f7ff20@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0804072148110.866@arimo.local>
References: <Pine.LNX.4.64.0804071115190.866@arimo.local>
	<200804070956.23449.aklists@mixdown.ca>
	<d89ddf300804070735n2f107af4ge23848cc96f7ff20@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Emulating a gps receiver
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

Hello

  Thanks.  Fixed class definition and added SP to service. Rfcomm appears 
to be little old in Debian (3.7), it did not recognize the watch command 
and i had to split the given command for two separate commands but this is 
not a problem.  Sending a nmea log  one line in second with simple script 
worked perfectly:-)



-- 
mr. M01510


On Mon, 7 Apr 2008, Brad Midgley wrote:

> Guys
>
> If you set up gpsd, you can do this in a straightforward way, assuming
> rfcomm0 is available:
>
> sdptool add SP
> rfcomm -r watch 0 1 sh -c "gpspipe -r >/dev/rfcomm0" &
>
> the first command advertises a serial port on channel 1, the second
> sets up a listener that will repeat the nmea stream over channel 1
> whenever someone connects on it.
>
> there may be ways to make gpsd put out a pre-recorded stream, or you
> could write your own app that runs in place of gpspipe and slowly
> sends out your nmea log in eg 1-second intervals.
>
> Andrew's device class suggestion may be required for some devices, but
> I didn't need it for a pocketpc or my n800.
>
> Brad
>
>

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

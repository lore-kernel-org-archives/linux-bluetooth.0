Return-Path: <cyrus@holtmann.org>
Message-ID: <47AB899D.7060609@wurmsdobler.org>
Date: Thu, 07 Feb 2008 22:43:41 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <47AB5665.8040101@wurmsdobler.org>
	<d89ddf300802071149x4e36a56ajac12896abda9d7cc@mail.gmail.com>
In-Reply-To: <d89ddf300802071149x4e36a56ajac12896abda9d7cc@mail.gmail.com>
Subject: Re: [Bluez-users] Headset, ALSA and other issues
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

Hello,
> 115k is probably too slow to be workable for audio. That's one reason
> it's more common to connect the adapter to the pc over  usb.
you are right in principal. One thing I neglected to mention, however, 
is that the target hardware is based on the imx27 ADS board. We are 
going to use the hardware facilities, i.e. UART to the BC4-ROM for 
control, and PCM over SSI. How this is going to work in terms of routing 
the signals through ALSA and the Linux kernel, I hope to find out soon.

peter



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

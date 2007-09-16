Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <ee63ef30709161045u6e91123fj39996e9797c8f039@mail.gmail.com>
References: <ee63ef30709161045u6e91123fj39996e9797c8f039@mail.gmail.com>
Date: Sun, 16 Sep 2007 22:48:10 +0200
Message-Id: <1189975690.7541.47.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] a2dp not working in stereo and minor patch
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

Hi Brandon,

> I have a Sony DRBT21G and I have high quality audio working.
> I am using bluez-3.18 libs and utils.
> 
> But, I am only getting mono sound. Stereo is not working. Here is an
> example running mpg123-alsa...
> 
> $ mpg123-alsa -v -a bluetooth test.mp3
> Playing MPEG stream 1 of 1: 06 Money.mp3 ...
> 
>         Title:   Money
>         Artist:  Pink Floyd
>         Album:   The Dark Side of the Moon [SACD]
>         Year:    2003
>         Genre:   Rock
>         Comment:
> 
> MPEG 1.0, Layer: III, Freq: 44100, mode: Joint-Stereo, modext: 0, BPF : 835
> Channels: 2, copyright: No, original: No, CRC: No, emphasis: 0.
> Bitrate: 256 kbits/s Extension value: 0
> Audio: 1:1 conversion, rate: 44100, encoding: signed 16 bit, channels: 1
> 
> 
> This last line seems to indicate that the audio is being converted to
> 1 channel. The missing stereo separation is particularly noticeable in
> this song since the beginning starts out with cash register sounds
> alternating from one ear to the other.

please check bluez-utils-3.19 since this bug should have been fixed
already.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

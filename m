Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300801211019h6591383asa0239dccede535d5@mail.gmail.com>
Date: Mon, 21 Jan 2008 11:19:07 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20080121135052.GB20816@juIljoat8>
MIME-Version: 1.0
References: <47928635.2030400@gmx.net>
	<d89ddf300801192041o12e98ee7ybeeb28efb2fdfa1d@mail.gmail.com>
	<479346D7.1080500@gmx.net>
	<d89ddf300801200639h393483e3y2ca35af47b93a608@mail.gmail.com>
	<20080121135052.GB20816@juIljoat8>
Subject: Re: [Bluez-users] audio bluetooth connectivity in gutsy
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

Benito

> Nevertheless I can go one step further than Gunnar: the audio player
> starts up, the headset-speaker beeps,
>
> To my uneducated eyes this looks like the audio stream somehow can't be
> transmitted while the "signalling" works.

Yes, you're correct that signaling works but not audio. The beep you
hear is the headset letting you know the connection was negotiated...
it's not a sound sent by the computer.

It's unlikely the problem is in the headset. What usually is happening
in this situation is the computer opens the sco connection and tries
to push data over it but the adapter is not picking up the data and
transmitting it.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

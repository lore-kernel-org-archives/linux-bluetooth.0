Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Wolfgang Wershofen <wolfgang@wershofen.de>
To: bluez-users@lists.sourceforge.net
Date: Thu, 22 Feb 2007 00:27:28 +0100
References: <45DAC336.1080806@wershofen.de>
In-Reply-To: <45DAC336.1080806@wershofen.de>
MIME-Version: 1.0
Message-Id: <200702220027.28783.wolfgang@wershofen.de>
Subject: Re: [Bluez-users] plugz: snd_pcm_hw_params_set_rate(8287) failed:
	Invalid argument
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Am Dienstag, 20. Februar 2007 schrieb Wolfgang Wershofen:
> Hi,
>
> I'm rather new to using bluetooth devices but I successfully managed to
> get my headset running using plugz. I use it for telephony purposes with
> twinkle (http://www.twinklephone.com).
>
> I am able to hear people and talk to them during the phone call without
> problems, but I can't hear the ringtone created by twinkle on my
> headset. In the log files, I find the following error message:
>
> snd_pcm_hw_params_set_rate(8287) failed: Invalid argument
>
(...)
> I don't know, if this is a plugz issue or a twinkle issue and I didn't
> find anything related on the net.

Meanwhile, I got an answer from the author of twinkle as follows:

---- < snip > -----------------------------------------------------------
This error shows that setting the soundcard to an exact sample
rate of 8287 fails (this sample rate comes from ringback.wav).
Twinkle uses this call to set an exact rate:

err =3D snd_pcm_hw_params_set_rate (pcm_ptr, hw_params, sample_rate, 0)

This happens on some soundcard and is not fatal, as Twinkle
next instructs the soundcard to pick a lower sampe rate
that it can suppor with this call:

err =3D snd_pcm_hw_params_set_rate (pcm_ptr, hw_params, sample_rate, -1)

The -1 argument indicates that =A0the soundcard may pick a lower
sample rate. It seems that your alsa does not accept this parameter.
---- < snap > -----------------------------------------------------------

I got around this problem by supplying twinkle with a wav audio file with =

exactly 8000 Hz sample rate and now it works.

But the question still remains: Why is the setting of a sample rate not =

possible with plugz?

cu
Wolfgang

-- =

Geek by nature - Linux by choice

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 29 May 2006 09:25:55 +0200
Message-ID: <96B7A15232D6CF42836BFD428AD6B6034E508F@deexmb01.de.icap.com>
From: "Guido Reimer" <G.Reimer@de.icap.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth-alsa: a2recv stuttering
	sound	from	WM5.0 AKU2.0
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

Brad,

> maybe wm5 reports the wrong rate to us. you could try hardcoding in
> adjustsound() the value that is used. the legal values are 16000,
32000,
> 44100, 48000.

I will try this as far as i come home today.
Will also set the channels manual to 2 (just got your secound mail)

> we print out the rate that the sender reports. what rate are you
getting
> printed out?

44100

> it sounds like wm5 is encoding at a higher rate than we expect.

Do you mean the bitrate of the streamed Data? Will check the registry of
WM5.0 to find additional infos about the crazy things it does.

Guido






_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

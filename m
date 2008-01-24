Return-Path: <cyrus@holtmann.org>
Message-ID: <479911A2.6040704@naustech.com>
Date: Thu, 24 Jan 2008 23:30:58 +0100
From: "Ing. Gabriele Oberhammer" <gabriele@naustech.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4795D6EB.2080209@naustech.com>	<1201018471.24085.4.camel@littletux>
	<47986354.2080205@naustech.com>
	<d89ddf300801240717g61e06642v28d6f0cf1b3cf2da@mail.gmail.com>
In-Reply-To: <d89ddf300801240717g61e06642v28d6f0cf1b3cf2da@mail.gmail.com>
Subject: Re: [Bluez-users] Headset half working using Bluez's ALSA plugin
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

Ok, I eventually managed to compile and install bluez-utils!
The problem was that the audio module was not built, even if I used 
--enable-all switch in configure. To have the audio module built I had 
to add --enable-audio  (so it seems that --enable-all does not.... 
enable all  ;-)
Note that to have network/serial/input services built you have to add 
--enable-{network,serial,input} too.

Here's the correct configure  line:

sudo ./configure --prefix=/usr --mandir=/usr/share/man \ 
--sysconfdir=/etc  --localstatedir=/var --libexecdir=/lib \
--enable-all --enable-audio

Unfortunately I'm stuck with the same situation of the first post, i.e. 
playback works well but capture is not working.


$ arecord -D bluetooth -f S16_LE  /tmp/test.wav

produces always files 44 bytes long without any audio  ;(

So, before giving up, is there in the list someone with a fully working 
bluetooth headset who could give me some hints?

Thanks in advance,
bye.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

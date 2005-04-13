Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f54d86405041222381e9da934@mail.gmail.com>
From: Benny <bennyvasanth@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco - headset profile activated but no sco packets transmitted ???
In-Reply-To: <200504042322.17493.pavouk@pavouk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050404194542.GA7640@lsweb.de> <42519CD7.1030606@xmission.com>
	 <200504042322.17493.pavouk@pavouk.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 13 Apr 2005 11:08:42 +0530

Dear Pavel Ruzicka,

I am also involved in testing the BT Headset functionality with the
PC. I am using a CSR based USB BT Dongle on the PC and the BT Mono
Headset is the RFMD Headset kit.

I have taken the latest CVS "btsco" files and compiled. Fedora 3(linux
kernel 2.6.9-1.667) runs on my host PC. I have taken the latest Bluez
libraries and utilities from the bluez site.

After running the "btsco" I am able to run the xmms and play songs and
test for the speaker functionality separately. But I am not able to
test the Sound recorder functionality. The SCO connection is opened
only when I press "play" for the xmms and it closes when I stop the
song. Whether I can test the mic functionality separately.

But my target application is a chat application with the usage of
Speaker and mic working simultaneosly.

Please advice of the setting I need to make.

Thanks & Regards,
Benny

On 4/5/05, Pavel Ruzicka <pavouk@pavouk.org> wrote:
> > I haven't heard success stories for using the bt110 but I can't remembe=
r
> > if we've had trouble reports on this one or not.
> >
> > > root@sigma:~/src/btsco# ./btsco -v 00:07:A4:95:41:76 2
> >
> > The only thing I would suggest is that you don't specify the channel
> > here, but I suspect btsco will autodetect channel 2 anyway.
>=20
> Hello,
>=20
> I now tried compiling snd_bt_sco for 2.6.11.6 and everything works great.
>=20
> I am using btsco 00:07:A4:0A:3F:XX or btsco 00:07:A4:0A:3F:XX 2 and both
> works.
>=20
> I have headset Jabra BT250.
> Dongle is d-link DBT-120 with 1.2 firmware.
>=20
> This sents sound from headset mic to soundcard:
> "cat </dev/dsp1 >/dev/dsp0".
> Simultaneously I start xmms, setup out to BT headset alsa device, and
> mp3 plays in my headset. Sound from headset microphone goes to my normal =
audio
> set.
>=20
> I have few questions:
>=20
> Audio is heavily delayed (about 300-400ms)
> What is the reason for this delay?
>=20
> Sound from microphone is noised. For speaking is enough, but quality is n=
ot
> much good. Is it normal?
>=20
> Best regards,
>=20
> Pavel Ruzicka


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

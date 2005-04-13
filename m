Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f54d86405041222462d20258e@mail.gmail.com>
From: Benny <bennyvasanth@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BT Headset - snd-bt-sco - Mic operation not working
In-Reply-To: <424D7BDB.1040408@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f54d864050401035565d0acd6@mail.gmail.com>
	 <424D7BDB.1040408@xmission.com>
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
Date: Wed, 13 Apr 2005 11:16:53 +0530

Dear Brad Midgley,

Thanks for your immediate response and sorry for my late reply.

My problem is I am not able to test the Sound recorder
functionality(ie) No action on pressing the record button.

I was getting the loop back(tested using Alsa Mixer unmute loopback)=20
working with the old "btsco". But with the latest "btsco" daemon I am
not able to hear the "loop back".

The SCO connection is opened only when I press "play" for the xmms and
it closes when I stop the song. Whether I can test the mic
functionality separately.

Please advice of the setting I need to make.

Thanks & Regards,
Benny


On 4/1/05, Brad Midgley <bmidgley@xmission.com> wrote:
> what kind of failure? can you use a mixer app or the headset to turn up
> the record volume and unmute the mic?
>=20
> Benny wrote:
> > Dear all,
> >
> > I am using a USB BT Dongle(CSR based) on a Linux PC(2.6.9) installed
> > with the latest snd-bt-sco driver taken from CVS.
> >
> > I have established a bluetooth connection to a BT Mono headset using
> > the btsco application. It is working fine for Audio(xmms playing a
> > .wav file) SCO connection from PC to the BT headset(speaker).
> >
> > But fails when I tried to test the headset MIC operation by carrying
> > out a recording operation using the sound recorder application on PC.
> >
> > Please advice.
> >
> > Thanks & Regards,
> > Benny


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

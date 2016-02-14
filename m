Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mkj@gotu.dk (Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?=)
To: Emanuele Cozzi <cozziemanuele@gmail.com>
Cc: "linux-bluetooth\@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bose AE2 SoundLink issues
References: <CAO0tx5h5KnfbvaOiFX1HD9Yp=K7nsidG0piah5aG5WX27HKQvg@mail.gmail.com>
	<878u2n5zmn.fsf@gotu.dk>
	<CAO0tx5jCzYybNDc7ewLUS0X+VtoKwcLtvv6fPmSzZECHjRJmLQ@mail.gmail.com>
Date: Sun, 14 Feb 2016 12:39:49 +0100
In-Reply-To: <CAO0tx5jCzYybNDc7ewLUS0X+VtoKwcLtvv6fPmSzZECHjRJmLQ@mail.gmail.com>
	(Emanuele Cozzi's message of "Sun, 14 Feb 2016 11:20:54 +0000")
Message-ID: <87ziv3tta2.fsf@gotu.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On søn, feb 14 2016, Emanuele Cozzi <cozziemanuele@gmail.com> wrote:

I should say first that I use pulseaudio as the A2DP source for
bluez, and pavucontrol to manage pulseaudio card profiles.

The profiles of Bose AE2 on my machine are "Off", "Headset Head Unit
(HSP/HFP)", "High Fidelity Playback (A2DP Sink)". I'm using A2DP by
default and selecting HSP/HFP doesnt trigger anything noticable. Audio
still gets transmittet with no clicks or pauses, and no voice in the
headset says anything.

I believe A2DP and HSP/HFP should be mutually exclusive because A2DP is
one way (from laptop to headset). HSP/HFP is two-way, so you can
listen and record audio simultaneously. I believe A2DP use different
codecs as well, but I'm not sure.

You too.

> Hi Martin,
>
> thank you for having solved this issue. My lack of full knowledge in the bluetooth stack would have never brought me so far in such a short time.
>
> One last question. I noticed that in this way, I can't select both telephony and a2dp profiles at the same moment but they are mutually exclusive. Basically I can assign only 1
> profile at time to the headset. Moreover, I noticed that the telephony profile somehow conflicts: if selected, every few secs the Bose starts announcing "Call from". Are you in the
> same situation?
>
> Have a great day! 
>
> Emanuele
>
> Il giorno dom 14 feb 2016 alle ore 11:56 Martin Kjær Jørgensen <mkj@gotu.dk> ha scritto:
>
>     On lør, feb 13 2016, Emanuele Cozzi <cozziemanuele@gmail.com> wrote:
>    
>     > Hi, 
>     >
>     > I was digging around to look for some info about the pairing issues there might be with the Bose AE2 SoundLink, and I found your email on the linux-bluetooth list (
>     > http://article.gmane.org/gmane.linux.bluez.kernel/66210/match=bose+ae2).
>     >
>     > The same situation here. My personal laptop with Ubuntu Gnome 15.10, kernel 4.2.0, bluez 5.35 and all the pulseaudio related modules shows the same symptoms and logs of
>     yours.
>     >
>     > I read that one of your guesses was the SMP security service. Few days ago I tried to disable SMP with hcitool but with no luck...
>     > At the moment I'm pretty sure there is something wrong with the GATT service because every time I connect the headphones, the bluetooth daemon logs: "Unable to register GATT
>     > service with handle 0x0001 for device ..."
>     >
>     > On the other side I have no issues with my bluetooth speakers, thus there should be some kind of incompatibility with our Bose.
>     >
>     > Concluding, I'm writing this e-mail both to share with you my experience but also to check if you made some progresses in the meanwhile.
>     >
>     > Sorry for this incursion!
>     >
>     > Cheers,
>     >
>     > Emanuele 
>     > --
>     >
>     > Emanuele Cozzi
>    
>     I've tried repost an answer to the list. Apparently it didnt get
>     posted. The answerer suggested that BLE conflicts with the pairing, so
>     enforcing BR/EDR seems to fixit. So my main.conf ends up looking like this:
>    
>     [General]
>     Name = mkjlap
>     Class = 0x000100
>     PairableTimeout = 0
>     DiscoverableTimeout = 0
>     # MKJ: bredr seems to be needed for Bose AE2 pairing
>     ControllerMode = bredr
>     MultiProfile = multiple
>     FastConnectable = true
>     AutoEnable = true
>
> --
>
> Emanuele Cozzi

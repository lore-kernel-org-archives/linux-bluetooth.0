Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sat, 10 Apr 2010 20:25:04 +0200
Subject: RE: bluez and a2dp sennheiser pcx310 headphones
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E032CD6F8EB@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E0323A72E4D@NL0105EXC01V01.eur.slb.com>
	 <2d5a2c101002072354u74cd7b77jc933d7cb61666b90@mail.gmail.com>
	 <6AC5A55546F64545AE996F8200E3AC4E0323A730D7@NL0105EXC01V01.eur.slb.com>
 <2d5a2c101002080102o71229a41ob75676b48a502919@mail.gmail.com>
In-Reply-To: <2d5a2c101002080102o71229a41ob75676b48a502919@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Monday, 08 February, 2010 11:55
> To: John Frankish
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: bluez and a2dp sennheiser pcx310 headphones
>
> Hi John,
>
> On Mon, Feb 8, 2010 at 8:19 AM, John Frankish <j-frankish@slb.com> wrote:
>> Hi,
>>
>> Using the .asoundrc below with bluez-4.53, I've been able to play music to a pair of sennheiser pcx310 headphones without problems, but although the remote volume control on the headphones works, the track skip/fastforward/repeat does not.
>>
>> According to the headphones manual, the remote controls rely on an avrcp profile - is this something supported by bluez or is it something that should be supported by the audio source (or both)?
>
> You probably need to load uinput module to make this to work, also you
> should probably try pulse audio which has a better integration with
> bluetooth headsets so you don't need to manually configure alsa it
> will do all this automatically for you.
>
OK, so I've updated the kernel to 2.6.33.2 and loaded the uinput module.

I believe things are connected as I see this in dmesg after pressing the "track skip" button:

input: 00:1B:66:00:31:88 as /devices/virtual/input/input11

mplayer -ao alsa:device=bluetooth /mnt/sda1/Music/f00/aayw.mp3

Starting playback...
[press track skip]
No bind found for key ''.                         


Could anybody point me to a resource that explains how to manually "bind" the headphone controls to xmms, mplayer, rhythmbox, etc since I don't particularly want to use pulse audio

Thanks
John

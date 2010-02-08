Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E0323A730D7@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E0323A72E4D@NL0105EXC01V01.eur.slb.com>
	 <2d5a2c101002072354u74cd7b77jc933d7cb61666b90@mail.gmail.com>
	 <6AC5A55546F64545AE996F8200E3AC4E0323A730D7@NL0105EXC01V01.eur.slb.com>
Date: Mon, 8 Feb 2010 11:02:04 +0200
Message-ID: <2d5a2c101002080102o71229a41ob75676b48a502919@mail.gmail.com>
Subject: Re: bluez and a2dp sennheiser pcx310 headphones
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 8, 2010 at 9:57 AM, John Frankish <j-frankish@slb.com> wrote:
>
>
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
> Thanks - I'm stuck with alsa for the moment, what is the uinput module and where do I find it?

uinput kernel module, you can load it manually by doing: sudo modprobe
uinput (if you don't have then you need to enable it and recompile
your kernel)

PS: Before come back with such questions you better do a search/google
for it so you don't flood the mailing list with inconvenient
questions.

-- 
Luiz Augusto von Dentz
Computer Engineer

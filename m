Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E0323A72E4D@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E0323A72E4D@NL0105EXC01V01.eur.slb.com>
Date: Mon, 8 Feb 2010 09:54:39 +0200
Message-ID: <2d5a2c101002072354u74cd7b77jc933d7cb61666b90@mail.gmail.com>
Subject: Re: bluez and a2dp sennheiser pcx310 headphones
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Mon, Feb 8, 2010 at 8:19 AM, John Frankish <j-frankish@slb.com> wrote:
> Hi,
>
> Using the .asoundrc below with bluez-4.53, I've been able to play music to a pair of sennheiser pcx310 headphones without problems, but although the remote volume control on the headphones works, the track skip/fastforward/repeat does not.
>
> According to the headphones manual, the remote controls reply on an avrcp profile - is this something supported by bluez or is it something that should be supported by the audio source (or both)?

You probably need to load uinput module to make this to work, also you
should probably try pulse audio which has a better integration with
bluetooth headsets so you don't need to manually configure alsa it
will do all this automatically for you.

> Is the .asoundrc file correct for a2dp headphones with remote control?
>
>
> Regards
> John
>
>
> pcm.!default {
>   type plug
>   slave.pcm "dmix"
> }
>
> ctl.mixer0 {
>   type hw
>   card 0
> }
>
> pcm.bluetooth {
>       type bluetooth
>       device "00:1B:66:00:31:88"
>       profile "auto"
> }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
Computer Engineer

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK8T_aUcSDWmhW18W6CrQFXe+_OKA3XyXZBrwPCpgbV4b+W6xw@mail.gmail.com>
References: <CAK8T_aUcSDWmhW18W6CrQFXe+_OKA3XyXZBrwPCpgbV4b+W6xw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 May 2017 21:07:20 +0300
Message-ID: <CABBYNZKVEmpgjEe4o6z+uDXr1bdE1CM2+pbbutUhzrybO04_Fw@mail.gmail.com>
Subject: Re: Question on switiching codecs with bluez 5
To: Sudha S <sudhas.raghavan@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, May 22, 2017 at 10:35 AM, Sudha S <sudhas.raghavan@gmail.com> wrote:
> Hello ,
>
>   I have a device that is registered as a A2DP source.
> In my code , I am registering with 2 codecs as endpoints SBC and AAC .
> I am using the bluez 5 calls for this .
>
> I am connecting this to a SONY speaker that supports AAC and SBC.
>
> The SetConfiguration and SelectConfiguration callbacks received are
> for the "AAC endpoint" .
> AAC content gets played .
> My device (source) supports other audio formats other than AAC .
>
> Question 1 :
> ------------------
> Can the non AAC content be played now  by the speaker ? Or is it
> expected that the input tot he speaker should now always be AAC.

You can only have one codec/endpoint configured, so yes if you select
AAC then everything must be encoded in AAC in order for the speaker to
decode.

> Question 2:
> ----------------
> If yes, then how can this be done with bluez?

I theory we could switch the codec in case we know the audio source
changes, that would probably mean AAC is used only when the source is
already encoded in AAC, though this might create extra delays
switching codecs back and forth.

> Question 3:
> ------------------
> In my code with 2 RegisterEndpoint calls, if the code registers for
> SBC first followed by AAC, then the Select/Set callbacks are received
> for SBC .
> If the order of calls is switched i.e Register endpoint with AAC as
> codec first followed by SBC, then the callbacks are reeceived for AAC
> .
>
> Is this the expected behavior or is this device (sink) specific ?

Yes, you shall register in order of preference, though the is not
ideal if you want to change the order depending audio source but that
is not supported yet. I guess the real problem is that A2DP did not
have in mind multiple codec setup so we could have multiple stream
simultaneously, so it probably makes little sense to use codecs where
the enconding in real-time is too costly, like AAC and MP3.

> Thanks ,
> Sudha.S
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

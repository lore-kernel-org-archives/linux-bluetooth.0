Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHymeZq774dz2nsP0Jonb_W4Oqu=O6XXV=hPuxBV0LM0_5Yf7A@mail.gmail.com>
References: <CAHymeZq774dz2nsP0Jonb_W4Oqu=O6XXV=hPuxBV0LM0_5Yf7A@mail.gmail.com>
From: Ash K <ashoksarf@gmail.com>
Date: Tue, 9 Aug 2011 15:02:56 -0500
Message-ID: <CAMhHtTz6WFcHsDrvC9P=e=HqcrgUizJ5y7NDJT_icszkijLXFA@mail.gmail.com>
Subject: Re: can BT create N independent channels?
To: james pruett <gpscruise@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

Comments bellow:

On Tue, Aug 9, 2011 at 12:14 PM, james pruett <gpscruise@gmail.com> wrote:
> I am writing an Android APP using BT for a control application.
>
> Q: If I am on a BT-headset call already, can I create a second BT-connection?
>
> Eg, will the stack allow two independent BT audio channels?

BlueZ does allow you to do it, but Android framework does not have
this facility in it (Since it was meant to handle all the normal
cases, which is to handle one call). You probably have to hack into
Android to create two audio channels.

Also remember that HF/HS audio means SCO connections and not all
controllers support multiple SCO connections (Not sure if two
controllers can provide you parallel SCO connections, though I know
controllers supporting 2 SCO connections connecting two different
controllers. Let me know if you find out if some one provides 2 SCOs
between 2 devices).

>
> I want normal calls in one channel, and I create a second signalling
> channel for an unrelated purpose. I know there is Serial protocol, but
> I want to avoid that if possible (Serial devices are more expensive
> than audio devices...) I am going to send the audio into a DTMF
> decoder to get ON/OFF control bits only.

Why can't you use same AUDIO channel for both audio data and DTMF
tone? A phone connection will not be established until you get
ring/dial tone, on ring AUDIO will be sent to DTMF encoder and switch
the AUDIO destination to speakers once the connection is established.

>
> Thanks for any leads!
> jim pruett
> wikiSPEEDia.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Ash

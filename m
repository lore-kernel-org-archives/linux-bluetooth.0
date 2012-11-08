Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK_W7q=cc4m4W2QwWdAp8+JEe7NkFGhwSjFPcyRzqN=OA@mail.gmail.com>
References: <CAMOw1v5q7eP2O4h6KtKNv0himHKA4pmg9STrxUczL_frYgECZA@mail.gmail.com>
	<CABBYNZK_W7q=cc4m4W2QwWdAp8+JEe7NkFGhwSjFPcyRzqN=OA@mail.gmail.com>
Date: Thu, 8 Nov 2012 16:04:26 +0100
Message-ID: <CANT-zCWwUkjSuJ79etrBhY6Ta+-PSX2_6_WRq4rZ5J9-Ywj=Qg@mail.gmail.com>
Subject: Re: DBus.Properties: help for remaining convertions
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 7, 2012 at 11:34 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Wed, Nov 7, 2012 at 9:20 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> Luiz, do you plan to convert to DBus.Properties after you finish the
>> pending features you are doing? I think audio/transport.c is the only
>> one still requiring a feature in gdbus:  security check for the sender
>> as discussed previously.  I can add this when we are converting audio.
>
> I can take care of converting the audio after we move it to profiles,
> and yes we need the sender check for in gdbus, but that can come
> latter.

I agree that we need to move to the new profile infrastructure first.
Some of these D-Bus interfaces might even disappear completely
(Headset, AudioSink, etc.), to be replaced by the generic
profile-handling API.

I sent some related patches in a previous RFC, which I will resend now
focusing on the audio part only.

Cheers,
Mikel

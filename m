Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMib2GZCAOHfBv=SZrVWaPEHZV6WDkoct03TPqtjyvAcHwoeqQ@mail.gmail.com>
References: <CAMib2GZCAOHfBv=SZrVWaPEHZV6WDkoct03TPqtjyvAcHwoeqQ@mail.gmail.com>
Date: Mon, 4 Jan 2016 12:14:00 -0200
Message-ID: <CABBYNZJfMFewZUgjAfNTNasoLGWgm=LYdmzvfSLOEwRWoXbrxA@mail.gmail.com>
Subject: Re: How to bind any linux media player to simple-player script?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Kyle Shneider <shneiderkyle@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kyle,

On Sat, Dec 26, 2015 at 1:18 PM, Kyle Shneider <shneiderkyle@gmail.com> wrote:
> I'm testing a2dp profile. bluetoothd gets commands from connected
> device, but there are no audio.
> As i get it, reading code of simple-player, you should either pass
> actual player's path as argument of simple-player script of change
> hardcoded /test/player to actual player's path... something like that,
> correct me if i'm wrong. Binded player should have mpris interface,
> like /org/mpris/MediaPlayer2/rhythmbox
> But all linux players use session bus, and in our case we work with
> org.bluez on system bus. So how to properly bind any linux media
> player to simple-player script.

If you have control over the player you may want to register directly
using the media interface, if you just want to bind an existing player
then you can use tools/mpris-proxy tool, it will detect MPRIS
compatible players and register them, but as the name suggests it will
proxy messages back and forth so it is not recommended for production,
it is just a testing tool.

-- 
Luiz Augusto von Dentz

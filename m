Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5q7eP2O4h6KtKNv0himHKA4pmg9STrxUczL_frYgECZA@mail.gmail.com>
References: <CAMOw1v5q7eP2O4h6KtKNv0himHKA4pmg9STrxUczL_frYgECZA@mail.gmail.com>
Date: Wed, 7 Nov 2012 20:51:22 +0100
Message-ID: <CA+6KyKbJ=V2Fw09BvDnndz+OZAACjpyh115ku-Mw+cUMrS2ZZQ@mail.gmail.com>
Subject: Re: DBus.Properties: help for remaining convertions
From: Andrzej Kaczmarek <andrzejk@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Nov 7, 2012 at 8:20 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Hey!
>
> I stopped converting profiles to DBus.Properties due to some reasons
> like 1) lack of time; 2) I don't use or can't test the conversion or
> 3) I'm seeing a lots of patches to that profile and my changes would
> conflict.
>
>
> Here is a list of missing profiles (except audio):
> └ bluez ➤ git grep -l GetProperties | grep -e " | grep -v -e "^audio"
> attrib/client.c
> profiles/cups/main.c
> profiles/network/connection.c
> profiles/proximity/monitor.c
> profiles/proximity/reporter.c
> profiles/thermometer/thermometer.c

<snip>

> Anyone to step up and help to finish the conversions? The sooner these
> are finished, the sooner other projects can adapt themselves to the
> upcoming API.

I have patches for thermometer (together with some other changes
there) - just need to test them and will send soon.

BR,
Andrzej

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5q7eP2O4h6KtKNv0himHKA4pmg9STrxUczL_frYgECZA@mail.gmail.com>
References: <CAMOw1v5q7eP2O4h6KtKNv0himHKA4pmg9STrxUczL_frYgECZA@mail.gmail.com>
Date: Thu, 8 Nov 2012 00:34:45 +0200
Message-ID: <CABBYNZK_W7q=cc4m4W2QwWdAp8+JEe7NkFGhwSjFPcyRzqN=OA@mail.gmail.com>
Subject: Re: DBus.Properties: help for remaining convertions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Nov 7, 2012 at 9:20 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Luiz, do you plan to convert to DBus.Properties after you finish the
> pending features you are doing? I think audio/transport.c is the only
> one still requiring a feature in gdbus:  security check for the sender
> as discussed previously.  I can add this when we are converting audio.

I can take care of converting the audio after we move it to profiles,
and yes we need the sender check for in gdbus, but that can come
latter.


-- 
Luiz Augusto von Dentz

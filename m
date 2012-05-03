Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 3 May 2012 19:15:09 -0300
Message-ID: <CAMOw1v4CNd39VTA9atMnYAmq+LATBc50PBPLR1tvy0Y1gM9=oA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 00/13] gdbus: Better D-Bus introspection
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, May 3, 2012 at 9:28 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>
> This is v4 of this series. The biggest difference from v3 is that we are
> not
> adding a decorated signature anymore. Instead we define the type
> GDBusArgInfo
> and add fields in_args, out_args and args into the tables.
>
> First 4 patches are the same as before and are independent from the
> others.
>
> Patches 5, 6, 7, 8 and 9 are split like this because gdbus is used in
> projects
> other than BlueZ, so the first 2 patches can be easily ported there.

And if these patches break VIM's highlight for you:
https://groups.google.com/forum/#!msg/vim_dev/_IL5jM1-t_w/D-vIwZM2RfwJ

Lucas De Marchi

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1368183727-24461-7-git-send-email-luiz.dentz@gmail.com>
References: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com> <1368183727-24461-7-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 14 May 2013 00:07:40 -0300
Message-ID: <CAMOw1v53fJ-GFWFerW1LXUtPbM+izfReu7FrvAKY2vTptvhmBw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 7/8] media: Ignore signess for D-Bus int types
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 10, 2013 at 8:02 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Some players such as Spotify implements some properties that are
> defined in MPRIS as int64 as uint64 which makes it fail to register.

If it's defined in spec as int64, wouldn't it be the case of fixing
Spotify instead?


Lucas De Marchi

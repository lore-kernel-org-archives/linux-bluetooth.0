Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334767682-27121-3-git-send-email-lucas.demarchi@profusion.mobi>
References: <1334767682-27121-1-git-send-email-lucas.demarchi@profusion.mobi> <1334767682-27121-3-git-send-email-lucas.demarchi@profusion.mobi>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 18 Apr 2012 15:57:08 -0300
Message-ID: <CAMOw1v5qVgy5yW+btczvrKxu9LbygTdJ38ywjsH+DpA7Ju1o-w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/5] gdbus: add decorated DBus signature for methods
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 18, 2012 at 1:48 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> To generate better introspection data we need to keep the name of each
> argument in GDBusMethodTable. With decorated signatures we can save
> them, while being compatible with the previous format. It is supposed to
> be used as following:
>
> s[argname1]o[argname2]
>
> We can't simply change signature to this format because we need to be
> able to rapidly check if messages have that same signature when they
> arrive: that is a much hotter path than the Introspect call, which
> this patch tries to solve.
>
> Therefore, when registering the interface we create the undecorated
> signature and save on the same structure, that is used by everybody.
> Introspect can later make use of the decorated version, exporting
> argument names.
> ---
>  gdbus/gdbus.h  |    7 +++++--
>  gdbus/object.c |   34 +++++++++++++++++++++++++++++++++-
>  2 files changed, 38 insertions(+), 3 deletions(-)

Don't bother too much with the current implementation, only with the
idea of adding the arguments using "decorated signatures". This
implementation has some bugs that I need to work out yet. Same apply
for patches 4 and 5.

Lucas De Marchi

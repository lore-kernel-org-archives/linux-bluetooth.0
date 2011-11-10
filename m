Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320415251-10350-2-git-send-email-radoslawjablonski@gmail.com>
References: <1320415251-10350-1-git-send-email-radoslawjablonski@gmail.com>
	<1320415251-10350-2-git-send-email-radoslawjablonski@gmail.com>
Date: Thu, 10 Nov 2011 13:22:07 +0200
Message-ID: <CAFy0spsO_9khjOA=-KYxhZBAwJya_bAYx4jqVf=f=fJxD+hRcA@mail.gmail.com>
Subject: Re: [PATCH obexd 1/1] Fix missing URL vCard's field with OTHER subtype
From: Mika Linnanoja <mika.linnanoja@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>,
	michalski.raf@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 4, 2011 at 4:00 PM, Radoslaw Jablonski
<radoslawjablonski@gmail.com> wrote:
> From: Rafal Michalski <michalski.raf@gmail.com>
>
> Previously URL vCard's field (imported with default OTHER subtype) was
> missing after pulling entire phonebook or single vCard (for phonebook
> and each call history as well).
> This patch fixes that issue by adjusting queries to URL field.
> ---
>  plugins/phonebook-tracker.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)

Anybody any comments to this patch? It's well tested to work (is
anything else using phonebook-tracker than N9?).

Cheers,
Mika

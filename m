Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1252950229-9629-1-git-send-email-vapier@gentoo.org>
References: <1252905504-26666-1-git-send-email-vapier@gentoo.org>
	<1252950229-9629-1-git-send-email-vapier@gentoo.org>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Tue, 19 Jan 2010 06:16:05 -0500
Message-ID: <8bd0f97a1001190316k6167ad39h20be3343aba3acb8@mail.gmail.com>
Subject: Re: [PATCH v2] [Bluetooth] redo checks in IRQ handler for shared IRQ
	support
To: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 14, 2009 at 12:43, Mike Frysinger wrote:
> Commit ac019360fe3 changed the irq handler logic to BUG_ON rather than
> returning IRQ_NONE when the incoming argument is invalid. =C2=A0While thi=
s
> works in most cases, it doesn't work when the IRQ is shared with other
> devices (or when DEBUG_SHIRQ is enabled).
>
> So revert the previous change and replace the warning message with a
> comment explaining that we want this behavior.

was this picked up ?
-mike

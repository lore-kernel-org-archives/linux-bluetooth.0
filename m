Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Nov 2013 15:42:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] sdptool: Fix memory leaks creating OPP record
Message-ID: <20131125134234.GC19445@x220.p-661hnu-f1>
References: <1385385285-30592-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385385285-30592-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Nov 25, 2013, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  tools/sdptool.c | 3 +++
>  1 file changed, 3 insertions(+)

All three patches have been applied, however don't hesitate to also send
patches to fix using 0 instead of NULL for pointers.

Johan

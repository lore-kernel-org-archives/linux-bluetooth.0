Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 14:09:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] lib: Fix invalid "whitespace" on company
 identifier string
Message-ID: <20131002110944.GA26752@x220.p-661hnu-f1>
References: <1380636683-24380-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380636683-24380-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Oct 01, 2013, Anderson Lizardo wrote:
> Somehow, the invalid multibyte sequence "\xC2\xA0" (which is displayed
> as a whitespace) was inserted on a company identifier string. Fix this
> to avoid a bogus diff when running tools/update_compids.sh.
> ---
>  lib/bluetooth.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan

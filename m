Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Oct 2011 16:29:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] Add check for empty string in
 vcard_printf_fullname
Message-ID: <20111011132909.GA19276@fusion.localdomain>
References: <1318231359-3309-1-git-send-email-radoslawjablonski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318231359-3309-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Mon, Oct 10, 2011, Radoslaw Jablonski wrote:
> If tag value is empty there is possibility to quickly create
> empty tag without entering to rest of the logic.
> Checking for empty parameter at the begining is included
> basicaly in every print tag function in code - here somehow
> was missing.
> ---
>  plugins/vcard.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Both patches have been applied. Thanks.

Johan

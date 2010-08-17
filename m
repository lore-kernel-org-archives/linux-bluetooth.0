Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 14:50:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix problem with filling ADR with unneeded semicolons
Message-ID: <20100817115039.GA10342@jh-x301>
References: <1282043444-20543-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282043444-20543-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Aug 17, 2010, Lukasz Pawlik wrote:
> Previously in a phonebook pull request ADR was filled with six
> semicolons when contact address entry was empty in phonebook. This
> patch fixes this problem. Address is send as an empty string.
> ---
>  plugins/vcard.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)

Thanks. The patch is now upstream.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 May 2012 11:34:26 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] hcidump: Correct len name
Message-ID: <20120507183426.GB7230@x220.hpllc.com>
References: <1336398567-27842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336398567-27842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, May 07, 2012, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  parser/hci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied after fixing up the commit message. There's no point in
prefixing hcidump commits with hcidump. You can (and it's recommended
that you do) put "hcidump" within the [] of the mail subject though.

Johan

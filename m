Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Aug 2010 21:12:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Solve compilation problem when SBC variable is not
 active
Message-ID: <20100831181211.GA18479@jh-x301>
References: <AANLkTinHLGYkji4Eoxu_QReDQCHndB7r319jB-2butVT@mail.gmail.com>
 <1283266211-15798-1-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283266211-15798-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 31, 2010, Jose Antonio Santos Cadenas wrote:
> The inclusion of src/attrib-server.c file by default in the daemon
> source needs also to compile by default attrib_sources, not only
> when SBC is active.
> ---
>  Makefile.am |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

Thanks. The patch has been pushed upstream.

Johan

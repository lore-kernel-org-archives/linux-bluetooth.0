Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Feb 2013 12:55:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH sbc] build: Do not use deprecated AM_CONFIG_HEADER
Message-ID: <20130227105554.GA24198@x220.ger.corp.intel.com>
References: <1360852021-2693-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360852021-2693-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Feb 14, 2013, Lucas De Marchi wrote:
> The long-obsoleted AM_CONFIG_HEADER macro was removed in automake 1.13.
> Use AC_CONFIG_HEADERS instead.
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan

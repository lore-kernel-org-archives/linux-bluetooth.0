Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Sep 2010 23:14:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, barbieri@profusion.mobi
Subject: Re: [PATCH] Simplify linker script
Message-ID: <20100921201402.GA29547@jh-x301>
References: <1285094816-1683-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285094816-1683-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Sep 21, 2010, Lucas De Marchi wrote:
> Version linker scripts support function names and globs, so there's no
> need to rely on nm tool to gather the exported symbols.
> ---
>  .gitignore           |    1 -
>  Makefile.am          |   14 +-------------
>  configure.ac         |    2 +-
>  src/bluetooth.ver.in |   10 ++++++++++
>  4 files changed, 12 insertions(+), 15 deletions(-)
>  create mode 100644 src/bluetooth.ver.in

Thanks for the patch. It has been pushed to the upstream tree. Could you
provide one for obexd too?

Johan

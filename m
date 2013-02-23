Return-Path: <cyrus@holtmann.org>
Date: Sat, 23 Feb 2013 12:53:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2 BlueZ 0/2] configure.ac fixes
Message-ID: <20130223105304.GA12612@x220.P-661HNU-F1>
References: <1359906411-12624-1-git-send-email-ospite@studenti.unina.it>
 <1360531251-18371-1-git-send-email-ospite@studenti.unina.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360531251-18371-1-git-send-email-ospite@studenti.unina.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Sun, Feb 10, 2013, Antonio Ospite wrote:
> Patch 1 fixes --with-* options, it should be OK as Marcel
> acknowledged.
> 
> Patch 2 is more for the sake of regularity with USB_CFLAGS and
> USB_LIBS, it's not strictly necessary.
> 
> Thanks,
>    Antonio
> 
> Antonio Ospite (2):
>   configure.ac: call AC_SUBST unconditionally with --with-* options
>   Call AC_SUBST(*_CFLAGS) and AC_SUBST(*_LIBS) only when needed
> 
>  configure.ac |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Both patches have been applied. Thanks.

Johan

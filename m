Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 14:03:31 -0800
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Andre Dieb Martins <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -v3 1/6] Partial dump of ATT PDUs
Message-ID: <20110209220331.GE11911@jh-x301>
References: <1297272535-14890-1-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1297272535-14890-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Wed, Feb 09, 2011, Andre Dieb Martins wrote:
> Starts implementing dumping for ATT/GATT pdus.
> ---
>  Makefile.am     |    1 +
>  parser/att.c    |  161 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  parser/l2cap.c  |    7 +++
>  parser/parser.h |    2 +
>  src/hcidump.c   |    1 +
>  5 files changed, 172 insertions(+), 0 deletions(-)
>  create mode 100644 parser/att.c

All six patches have been pushed upstream. Thanks.

Johan

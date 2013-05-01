Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 May 2013 09:10:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH BlueZ v2 01/16] attrib: Get rid of gint
Message-ID: <20130501061016.GA13611@x220.P-661HNU-F1>
References: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, May 01, 2013, Lucas De Marchi wrote:
> Use plain int instead of gint. In glib gint is always a typedef to int,
> so it's safe to use it even for callbacks with glib.
> ---
> 
> v2: Fix commit message
> 
>  attrib/gatt-service.c | 2 +-
>  attrib/gatt.c         | 2 +-
>  attrib/gattrib.c      | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

All patches in this set have been applied. Thanks.

Johan

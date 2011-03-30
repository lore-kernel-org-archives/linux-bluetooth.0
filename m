Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Mar 2011 19:35:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Move GATT example server to a standalone plugin
Message-ID: <20110330163530.GB30984@jh-x301>
References: <1301415328-14257-1-git-send-email-anderson.lizardo@openbossa.org>
 <1301415328-14257-2-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301415328-14257-2-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Mar 29, 2011, Anderson Lizardo wrote:
> The GATT example server was in the same plugin as the GATT client.
> Moving it to a separate plugin will allow to easily disable it.
> ---
>  Makefile.am            |    8 +-
>  acinclude.m4           |    6 +
>  attrib/example.c       |  341 -----------------------------------------------
>  attrib/example.h       |   26 ----
>  attrib/manager.c       |    6 -
>  bootstrap-configure    |    1 +
>  plugins/gatt-example.c |  348 ++++++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 361 insertions(+), 375 deletions(-)

This patch has been pushed upstream. Thanks.

Johan

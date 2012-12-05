Return-Path: <cyrus@holtmann.org>
Message-ID: <1354703610.1815.0.camel@aeonflux>
Subject: Re: [PATCH] hciconfig: Retrieve linkey from device info file
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 05 Dec 2012 11:33:30 +0100
In-Reply-To: <1354702812-21080-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354702812-21080-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Skip 2 first bytes of Key entry as it begins with "0x"
> ---
>  Makefile.tools    |    2 +-
>  tools/hciconfig.c |   37 ++++++++++++++++++++++++++++---------
>  2 files changed, 29 insertions(+), 10 deletions(-)

this is not worth it. I rather have the feature in hciconfig removed.

Regards

Marcel



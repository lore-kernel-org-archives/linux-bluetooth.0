Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Add secure param to Mgmt PIN Code Request Event
From: Marcel Holtmann <marcel@holtmann.org>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <1303987847-6878-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1303987847-6878-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 30 Apr 2011 11:46:06 -0700
Message-ID: <1304189166.15916.98.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> Update mgmt interface with secure param in pin code request event
> which is part of secure pin requirement implementation.
> ---
>  doc/mgmt-api.txt |    1 +
>  lib/mgmt.h       |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 925b5ad..45f6a64 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -482,6 +482,7 @@ PIN Code Request Event
>  Event Code		0x000E
>  Controller Index:	<controller id>
>  Event Parameters	Address (6 Octets)
> +			Secure (1 Octet)

we do need to document possible values and their meanings. Is this a
boolean or is this suppose to indicate the PIN code length?

Regards

Marcel



Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 2/5] advertising: Add IncludeName property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170803133252.30700-2-luiz.dentz@gmail.com>
Date: Thu, 3 Aug 2017 17:17:31 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <793B8A5D-0ED8-4F44-9D8B-DA5C1B7DB75C@holtmann.org>
References: <20170803133252.30700-1-luiz.dentz@gmail.com>
 <20170803133252.30700-2-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds support to include adapter name, or alias, in the scan
> response with use of IncludeName property.
> ---
> doc/advertising-api.txt |  5 +++++
> src/advertising.c       | 27 +++++++++++++++++++++++++++
> 2 files changed, 32 insertions(+)
> 
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index 78c1c04e3..8759c1d1c 100644
> --- a/doc/advertising-api.txt
> +++ b/doc/advertising-api.txt
> @@ -66,6 +66,11 @@ Properties	string Type
> 			Includes the Tx Power in the advertising packet.
> 			If missing, the Tx Power is not included.
> 
> +		bool IncludeName
> +
> +			Include adapter Name, or Alias if set, as scan
> +			response data.
> +

would be an array{string} SystemAdvertisingData or something a lot better. Mapping the mgmt API one to one seems a really pointless idea.

Regards

Marcel


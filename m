Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/5] doc/mgmt-api: Add appearance command specification
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1473281867-8560-1-git-send-email-szymon.janc@codecoup.pl>
Date: Thu, 8 Sep 2016 00:02:59 +0100
Cc: linux-bluetooth@vger.kernel.org,
        =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Message-Id: <825BB3CB-6594-432B-BEC2-6BF4FFEF05EA@holtmann.org>
References: <1473281867-8560-1-git-send-email-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> ---
> doc/mgmt-api.txt | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 2b8a81d..ed0cb99 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2885,6 +2885,31 @@ Read Extended Controller Information Command
> 				Invalid Index
> 
> 
> +Set Appearance Command
> +======================
> +
> +	Command Code:		0x0042
> +	Controller Index:	<controller id>
> +	Command Parameters:	Appearance (2 Octets)
> +	Return Parameters:	Appearance (2 Octets)

hmmm. While I get that Set Local Name returns the input parameters, the Set Device ID does not. For Set Device Class is that we match major and minor class into class of device.

So my thinking is that we should not return any result values. Thoughts?

Regards

Marcel


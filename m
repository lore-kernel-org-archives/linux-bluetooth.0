Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v3 5/8] obexd: Add RegisterNotifications function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1363014350-16114-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Mon, 11 Mar 2013 09:19:48 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <72B23061-16D8-4949-AAB4-9537F6726FCB@holtmann.org>
References: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1363014350-16114-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> This allows applications to register for all different types
> of MAP event reports.
> 
> In response to this call, the MSE should connect to the local MNS
> instance.
> ---
> doc/obex-api.txt   |  6 ++++
> obexd/client/map.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 92 insertions(+)

never ever intermix doc/ changes with actual code. You really need to learn on how to split patches properly. There is no reason at all that this are not two patches.


> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index 759c4d8..ef5d85e 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -651,6 +651,12 @@ Methods		void SetFolder(string name)
> 			Possible errors: org.bluez.obex.Error.InvalidArguments
> 					 org.bluez.obex.Error.Failed
> 
> +		void RegisterNotifications(boolean)
> +
> +			Register / unregister reception of notifications.
> +
> +			Possible errors: org.bluez.obex.Error.InvalidArguments
> +					 org.bluez.obex.Error.Failed

Why don't you describe the boolean variable and what it does. If this is an on/off switch, then we are not doing this stupid thing here.

Simple things like EnableNotifications and DisableNotifications would be better. Also this needs a bit detailed explanations why you thing this is the right API for handling this. I am not even convinced we should be doing it like this.

Regards

Marcel


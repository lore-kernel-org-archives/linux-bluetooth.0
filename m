Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v2 1/3] obexd: Move Message.Get parameter attachment into dictionary
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362481981-7813-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Tue, 5 Mar 2013 08:12:49 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A9F65BD5-95F0-4DA8-B6DE-A8D4C8756269@holtmann.org>
References: <1362481981-7813-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1362481981-7813-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> This is a preparation for adding additional parameters to Message.Get.
> The parsing of the args dictionary is done in parse_get_options.
> 
> The Attachment parameter has been moved into the args dictionary.
> The parameter is now optional defaulting to true.
> ---
> doc/obex-api.txt   | 11 ++++++--
> obexd/client/map.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++--------
> 2 files changed, 78 insertions(+), 14 deletions(-)
> 
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index 759c4d8..9a78284 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -714,10 +714,10 @@ Message hierarchy
> =================
> 
> Service		org.bluez.obex
> -Interface	org.bluez.obex.Message1
> +Interface	org.bluez.obex.Message2
> Object path	[variable prefix]/{session0,session1,...}/{message0,...}
> 
> -Methods		object, dict Get(string targetfile, boolean attachment)
> +Methods		object, dict Get(string targetfile, dict args)

you can not do this. We need to support both APIs in this case. ALso where is the discussion on this API change and especially why do we need it.

Regards

Marcel


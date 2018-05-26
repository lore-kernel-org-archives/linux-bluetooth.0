Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BlueZ v4 1/4] doc/gatt-api: Add authorization options for
 attributes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180525091541.4688-1-grzegorz.kolodziejczyk@codecoup.pl>
Date: Sat, 26 May 2018 18:13:55 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <487AACC5-DA1A-4CCA-B5F7-E762CBCABC90@holtmann.org>
References: <20180525091541.4688-1-grzegorz.kolodziejczyk@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

> This patch adds authorization property for attributes and prepare write
> request for authorization option for write request. This is require to
> handle correctly prepare writes, which may response with insufficient
> authorization error.
> ---
> doc/gatt-api.txt | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 0f1cc9029..6b1487254 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -85,6 +85,9 @@ Methods		array{byte} ReadValue(dict options)
> 			Possible options: "offset": Start offset
> 					  "device": Device path (Server only)
> 					  "link": Link type (Server only)
> +					  "prep-authorize": boolean Is prepare
> +							    authorization
> +							    request
> 
> 			Possible Errors: org.bluez.Error.Failed
> 					 org.bluez.Error.InProgress
> @@ -250,6 +253,7 @@ Properties	string UUID [read-only]
> 				"encrypt-authenticated-write"
> 				"secure-read" (Server only)
> 				"secure-write" (Server only)
> +				"authorize"
> 
> Characteristic Descriptors hierarchy
> ====================================
> @@ -284,6 +288,9 @@ Methods		array{byte} ReadValue(dict flags)
> 			Possible options: "offset": Start offset
> 					  "device": Device path (Server only)
> 					  "link": Link type (Server only)
> +					  "prep-authorize": boolean Is prepare
> +							    authorization
> +							    request

lets use “prepare-authorize” and not shortcut things for no good reason.

Regards

Marcel


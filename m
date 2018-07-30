Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2 1/5] doc/adapter-api: Add Discoverable option to
 SetDiscoveryFilter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180730064424.13996-1-luiz.dentz@gmail.com>
Date: Mon, 30 Jul 2018 13:09:39 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4D53D61B-794E-43C5-9D3B-79FBF1175208@holtmann.org>
References: <20180730064424.13996-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This enables the client to set its discoverable setting while
> discovering which is very typical situation as usually the setings
> application would allow incoming pairing request while scanning, so
> this would reduce the number of calls setting Discoverable and
> DiscoverableTimeout and restoring after done with discovery.
> ---
> doc/adapter-api.txt | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index d14d0ca50..4791af2c7 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -113,6 +113,12 @@ Methods		void StartDiscovery()
> 				generated for either ManufacturerData and
> 				ServiceData everytime they are discovered.
> 
> +			bool Discoverable (Default: false)
> +
> +				Make adapter discoverable while discovering,
> +				if the adapter is already discoverable this
> +				setting this filter won't do anything.
> +
> 			When discovery filter is set, Device objects will be
> 			created as new devices with matching criteria are
> 			discovered regardless of they are connectable or

I am now regretting that we didn’t add a uint32 Flags parameter to Start Service Discovery mgmt command if this is something that is often done. Letting the kernel coordinate this properly for the lifetime of the discovery would be best. Otherwise things start to get racy eventually. Meaning that when implementing this in bluetoothd, we need to be careful to handle other mgmt commands correctly that might be issued from non-bluetoothd applications.

Regards

Marcel


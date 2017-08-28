Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ 1/3] adapter-api: Rename ResetData to DuplicateData
 filter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170828134240.18840-1-luiz.dentz@gmail.com>
Date: Mon, 28 Aug 2017 16:21:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F7B892BC-8CB7-4E85-B73A-EDEC74AF5AE4@holtmann.org>
References: <20170828134240.18840-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Since essencially what this filter would be doing is disable duplicate
> for data use it instead of ResetData.
> ---
> doc/adapter-api.txt |  9 +++++----
> src/adapter.c       | 32 ++++++++++++++++----------------
> src/device.c        |  8 ++++----
> src/device.h        |  5 +++--
> 4 files changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index c2898694d..eaf96f36c 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -58,7 +58,8 @@ Methods		void StartDiscovery()
> 			int16	      RSSI	: RSSI threshold value
> 			uint16        Pathloss	: Pathloss threshold value
> 			string        Transport	: type of scan to run
> -			bool          ResetData : Reset advertisement data
> +			bool          DuplicateData : Disables duplicate
> +			detection of advertisement data.
> 
> 			When a remote device is found that advertises any UUID
> 			from UUIDs, it will be reported if:
> @@ -91,9 +92,9 @@ Methods		void StartDiscovery()
> 			the RSSI delta-threshold, that is imposed by
> 			StartDiscovery by default, will not be applied.
> 
> -			If ResetData is enabled PropertiesChanged signals will
> -			be generated for either ManufacturerData and ServiceData
> -			everytime they are discovered.
> +			If DuplicateData is enabled PropertiesChanged signals
> +			will be generated for either ManufacturerData and
> +			ServiceData everytime they are discovered.

mention that this is false by default when omitted.

We should in addition state that even if this is omitted or set to false, the duplicate filtering is best-effort and not guaranteed. Unless we actually plan to have a huge report cache in bluetoothd.

Regards

Marcel


Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] doc/adapter-api.txt: StartServiceDiscovery method.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418046439-15725-1-git-send-email-jpawlowski@google.com>
Date: Mon, 8 Dec 2014 15:07:06 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <90BAB1E8-4E68-4F87-BB1B-B89687BE5E72@holtmann.org>
References: <1418046439-15725-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> This patch proposes new method, StartServiceDiscovery to D-Bus Adapter API for
> desktop bluetoothd. It will allow for rapid discovery of nearby devices that
> advertise services.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> doc/adapter-api.txt | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 74d235a..88533ed 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -22,6 +22,26 @@ Methods		void StartDiscovery()
> 			Possible errors: org.bluez.Error.NotReady
> 					 org.bluez.Error.Failed
> 
> +		void StartServiceDiscovery(uint8 rssi, array{string} uuids)
> +
> +			This method starts the device discovery session with
> +			filtering by uuids, and rssi value. Use StopDiscovery to
> +			release the sessions acquired.
> +
> +			This method will use LE scan only.
> +
> +			Device that have RSSI bigger than rssi parameter, and
> +			advertise at least one service from uuids array, is
> +			conseidered filter match.
> +
> +			This process will start creating Device objects as new
> +			devices matching criteria are discovered. It will also
> +			emit PropertiesChanged signal for already existing
> +			Device objects, with updated RSSI value.
> +
> +			Possible errors: org.bluez.Error.NotReady
> +					 org.bluez.Error.Failed
> +

I think we want to use an dictionary of filter properties here. Clearly the D-Bus API should provide the possibilities to filter out pathloss if we choose to. Additionally you might need an option to restrict this to only LE devices.

Regards

Marcel


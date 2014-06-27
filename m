Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] [RFC] doc: Add StartDiscoveryWithOptions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403896589-6135-1-git-send-email-scott@netsplit.com>
Date: Fri, 27 Jun 2014 22:15:09 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <90AEC8D9-5894-4083-AD82-F8D9A8DC1000@holtmann.org>
References: <1403896589-6135-1-git-send-email-scott@netsplit.com>
To: Scott James Remnant <scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> This patch proposes an extension to the D-Bus Adapter API to permit
> the application to specify whether it wishes to discover BR/EDR
> or LE devices.
> 
> Rationale is to permit an application, only interested in an LE device
> with intent on using GATT to not cause the large power drain of
> performing BR/EDR Inquiry.
> ---
> doc/adapter-api.txt | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 74d235a..668644d 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -22,6 +22,29 @@ Methods		void StartDiscovery()
> 			Possible errors: org.bluez.Error.NotReady
> 					 org.bluez.Error.Failed
> 
> +		void StartDiscoveryWithOptions(dict options)
> +
> +			This method starts the device discovery session, as
> +			StartDiscovery(), but lets the client specify
> +			additional options. Use StopDiscovery to release the
> +			sessions acquired.
> +
> +			possible options:
> +
> +				boolean Classic:
> +
> +					Specifies whether discovery of BR/EDR
> +					devices should be performed.
> +
> +				boolean LowEnergy:
> +
> +					Specifies whether discovery of LE
> +					devices should be performed.

I hoped that we will be able to avoid adding an StartDiscoveryWithOptions. However the way the LE application world is going, we need to provide application the option to search for their counterpart peripheral.

We however will most likely not need this for BR/EDR since that application model there is pretty clear that we only do discovery from the settings screen and not from a specific application.

If I take one step back and look from an application point of view, then I might actually want something totally different. I think what really want is a FindDevices method that will return a list of objects that fulfill my search pattern. So each application can start their own FindDevices method and bluetoothd will take care of making sure that each application is served properly.

I do realize that you are going for the simple approach with just starting LE active scanning and then filtering out the results in a higher layer. However I get the feeling that we better do that inside the daemon and provide the application with a pre-filtered list. And if no search patterns are given, then you get the complete list and can filter by yourself later on.

The reason why I like to keep discovery separate from searching for a known device, these are separate operations. There is subtle difference between advertising non-discoverable and advertising discoverable. While many devices always advertise discoverable, they do not need it. And StartDiscovery will not report non-discoverable devices back. However a FindDevice of course can look for a specific device matching its search pattern even if it is not discoverable.

Keep also in mind that it might be neat to have a feature where you register an observer like agent that gets notified when a device with certain pattern is found. Once we have all the background scanning figured out in the kernel, this becomes a possibility. And that is a better approach than always triggering active scanning. The simplest pattern could just be the identity address of a device. With all this beacon stuff you might want to find a device, but have no need to connect since all the data is present the advertising data. Or it could be simply that the service data contains a sequence counter that allows you to tell if connection is required or not.

These are just a few thoughts that come to mind when we are talking about LE scanning. I like to get LE passive scanning enabled in the kernel and have a mgmt API that we then can map to multiple use cases over D-Bus. And I like it to be smart and as low power consumption as possible.

Regards

Marcel


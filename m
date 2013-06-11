Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [RFC v1 5/9] doc: add RequestPairingSession() and ReleasePairingSession()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1370909011-19315-5-git-send-email-gustavo@padovan.org>
Date: Tue, 11 Jun 2013 03:22:50 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Message-Id: <62325EFA-9142-4B53-AF39-2D00E36BE0C3@holtmann.org>
References: <1370909011-19315-1-git-send-email-gustavo@padovan.org> <1370909011-19315-5-git-send-email-gustavo@padovan.org>
To: Gustavo Padovan <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Those methods improve the tracking of the Discoverable and Pairable
> properties for Pairing purposes. One could call RequestPairingSession()
> to get a Pairing session.
> 
> ReleasePairingSession() releases a session. If the client exits without
> calling the ReleasePairingSession() the session is also released.
> When the last session is released both Discoverable and Pairing goes back
> the their original value.
> 
> The Pairing property tracks if the there is a ongoing Pairing session.
> ---
> doc/adapter-api.txt | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 47 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 74d235a..4d205f2 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -35,6 +35,37 @@ Methods		void StartDiscovery()
> 					 org.bluez.Error.Failed
> 					 org.bluez.Error.NotAuthorized
> 
> +		void RequestPairingSession()

my current thinking is that naming these EnablePairing and DisablePairing is a bit simple and more intuitive and fits better with StartDiscovery and StopDiscovery.

> +
> +			This method starts a Pairing session, it enables both
> +			Discoverable and Pairable properties and tracks the
> +			lifetime of the client that requested it. The client can
> +			release the session by calling ReleasePairingSession().
> +			The session is also released if the clients exits
> +			unexpectedly.
> +
> +			Many sessions can be created by different clients. When
> +			last session is released Discoverable and Pairable are
> +			set back to wherever value they had before the request
> +			of the first session.
> +
> +			The Pairing property show if there is a ongoing session
> +			or not.

Make sure to note the effect on the Pairable and Discoverable properties.

> +
> +			Possible errors: org.bluez.Error.NotReady
> +					 org.bluez.Error.Failed
> +
> +		void ReleasePairingSession()
> +
> +			This method removes a Pairing session. When called
> +			it will remove the session and if it is the last session
> +			Discoverable and Pairable will be set to the value they
> +			had before the beginning of the first session.
> +
> +			Possible errors: org.bluez.Error.NotReady
> +					 org.bluez.Error.Failed
> +					 org.bluez.Error.NotAuthorized
> +
> 		void RemoveDevice(object device)
> 
> 			This removes the remote device object at the given
> @@ -111,6 +142,9 @@ Properties	string Address [readonly]
> 
> 			For any new adapter this settings defaults to false.
> 
> +			This property will become readonly if a Pairing session
> +			is ongoing.
> +
> 		boolean Pairable [readwrite]
> 
> 			Switch an adapter to pairable or non-pairable. This is
> @@ -122,6 +156,9 @@ Properties	string Address [readonly]
> 
> 			For any new adapter this settings defaults to true.
> 
> +			This property will become readonly if a Pairing session
> +			is ongoing.
> +
> 		uint32 PairableTimeout [readwrite]
> 
> 			The pairable timeout in seconds. A value of zero
> @@ -131,6 +168,9 @@ Properties	string Address [readonly]
> 			The default value for pairable timeout should be
> 			disabled (value 0).
> 
> +			This property will become readonly if a Pairing session
> +			is ongoing.
> +
> 		uint32 DiscoverableTimeout [readwrite]
> 
> 			The discoverable timeout in seconds. A value of zero
> @@ -140,10 +180,17 @@ Properties	string Address [readonly]
> 			The default value for the discoverable timeout should
> 			be 180 seconds (3 minutes).
> 
> +			This property will become readonly if a Pairing session
> +			is ongoing.
> +
> 		boolean Discovering [readonly]
> 
> 			Indicates that a device discovery procedure is active.
> 
> +		boolean Pairing [readonly]
> +
> +			Indicates that one or more pairing session is active.
> +

Not super happy with the name, but I could live with it.

Regards

Marcel


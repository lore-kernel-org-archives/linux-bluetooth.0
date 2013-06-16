Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 5/9] doc: add EnablePairing() and DisablePairing()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1370948187-3702-5-git-send-email-gustavo@padovan.org>
Date: Sun, 16 Jun 2013 13:42:50 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Message-Id: <16C709C9-3300-4A6D-91D2-DFF6F895C082@holtmann.org>
References: <1370948187-3702-1-git-send-email-gustavo@padovan.org> <1370948187-3702-5-git-send-email-gustavo@padovan.org>
To: Gustavo Padovan <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Those methods improve the tracking of the Discoverable and Pairable
> properties for Pairing purposes. One could call EnablePairing() to get a
> Pairing session.
> 
> DisablePairing() releases a session. If the client exits without calling
> the DisablePairing() the session is also released.  When the last session
> is released both Discoverable and Pairable goes back the value they had
> before the first session started.
> 
> The Pairing property tracks if the there is a ongoing Pairing session.
> ---
> doc/adapter-api.txt | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 53 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 74d235a..dba037f 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -35,6 +35,43 @@ Methods		void StartDiscovery()
> 					 org.bluez.Error.Failed
> 					 org.bluez.Error.NotAuthorized
> 
> +		void EnablePairing()
> +
> +			This method starts a Pairing session, in other words,

Remove the in other words here.

And lower case pairing please.

> +			it enables both Discoverable and Pairable properties
> +			and tracks the lifetime of the client that requested
> +			it. The client can release the session by calling
> +			ReleasePairingSession(). The session is also released

ReleasePairing.

> +			if the clients exits unexpectedly.
> +
> +			Many sessions can be created by different clients. When
> +			last session is released Discoverable and Pairable are
> +			set back to wherever value they had before the request
> +			of the first session.
> +
> +			The Pairing property show if there is a ongoing session
> +			or not.

The Pairing property will indicate true if at least one pairing session is active and otherwise indicate false.

> +
> +			When one or more pairing session is running the

are running.

> +			following properties goes to the readonly mode:

well become read only.

> +			Discoverable, DiscoverableTimeout, Pairable and
> +			PairableTimeout. An error will be returned if a
> +			client tries to set their value.

if clients try to set their values.

Also specify the value.

> +
> +			Possible errors: org.bluez.Error.NotReady
> +					 org.bluez.Error.Failed
> +
> +		void DisablePairing()
> +
> +			This method removes a Pairing session. When called
> +			it will remove the session and if it is the last session
> +			Discoverable and Pairable will be set to the value they
> +			had before the beginning of the first session.

Mention that the properties become writable again.

> +
> +			Possible errors: org.bluez.Error.NotReady
> +					 org.bluez.Error.Failed
> +					 org.bluez.Error.NotAuthorized
> +
> 		void RemoveDevice(object device)
> 
> 			This removes the remote device object at the given
> @@ -111,6 +148,9 @@ Properties	string Address [readonly]
> 
> 			For any new adapter this settings defaults to false.
> 
> +			This property will become readonly if a Pairing session
> +			is ongoing.
> +
> 		boolean Pairable [readwrite]
> 
> 			Switch an adapter to pairable or non-pairable. This is
> @@ -122,6 +162,9 @@ Properties	string Address [readonly]
> 
> 			For any new adapter this settings defaults to true.
> 
> +			This property will become readonly if a Pairing session
> +			is ongoing.
> +
> 		uint32 PairableTimeout [readwrite]
> 
> 			The pairable timeout in seconds. A value of zero
> @@ -131,6 +174,9 @@ Properties	string Address [readonly]
> 			The default value for pairable timeout should be
> 			disabled (value 0).
> 
> +			This property will become readonly if a Pairing session
> +			is ongoing.
> +
> 		uint32 DiscoverableTimeout [readwrite]
> 
> 			The discoverable timeout in seconds. A value of zero
> @@ -140,10 +186,17 @@ Properties	string Address [readonly]
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
> 		array{string} UUIDs [readonly]
> 
> 			List of 128-bit UUIDs that represents the available

Regards

Marcel


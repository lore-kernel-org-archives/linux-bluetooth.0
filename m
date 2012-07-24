Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 11:27:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [RFC BlueZ 7/7] doc: Add Register/Unregister GATT based services
Message-ID: <20120724092702.GA8706@x220.ice.intel.com>
References: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
 <1343058920-18608-8-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343058920-18608-8-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jul 23, 2012, Anderson Lizardo wrote:
> --- a/doc/service-api.txt
> +++ b/doc/service-api.txt
> @@ -43,6 +43,39 @@ Methods		uint32 AddRecord(string record)
>  					 org.bluez.Error.DoesNotExist
>  					 org.bluez.Error.Failed
>  
> +		void Register(string uuid, dict settings,
> +					array{object} characteristics)
> +
> +			Add a GATT based service. The uuid represents the
> +			primary/secondary service UUID. The settings
> +			dictionary has the following format:
> +			{
> +				"id": string (optional)
> +			}
> +
> +			settings field is being added to allow API
> +			flexibility. The "id" field allows the core to
> +			manage handle allocation and internal GATT storage.
> +
> +			GATT included services is supported by providing the
> +			same characteristic object path (restricted to same
> +			provider/owner).
> +
> +			The characteristic objects implemented by the
> +			caller shall follow the interface defined in the
> +			attribute API.
> +
> +			Possible errors: org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.AlreadyExists
> +
> +		void Unregister(string uuid)
> +
> +			Removes a given GATT based service previously
> +			registered by the caller.
> +
> +			Possible errors: org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.NotAuthorized

I don't think the Register/Unregister names are right since this is
purely LE/GATT specific. Or do you foresee this being used for
traditional (non-GATT) BR/EDR profiles? I'd either propose having a new
interface for these or then rename them (e.g. RegisterGATT?).

FWIW I'm also not sure that the interface name org.bluez.Service is
quite right. Interface names are supposed to describe something about
the object which implements them, but the object this interface is used
for (adapter) cannot be said to "be" a service. Instead, this interface
abstracts a local database of services. What would you think of calling
it ServiceManager or ServiceDatabase?

Johan

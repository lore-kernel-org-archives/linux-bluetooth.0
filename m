Return-Path: <cyrus@holtmann.org>
From: "Zhang, Zhenhua" <zhenhua.zhang@intel.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 10 May 2010 08:41:59 +0800
Subject: RE: [PATCH] Dial-up Networking profile API
Message-ID: <33AB447FBD802F4E932063B962385B351E79EBA6@shsmsx501.ccr.corp.intel.com>
References: <1273371107-31813-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <1273371107-31813-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Padovan,

linux-bluetooth-owner@vger.kernel.org wrote:
> It is exactly the same API of Handsfree profile. The idea is
> to use the same Agent logic.
> ---
> doc/dun-api.txt |   82
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 files changed, 82 insertions(+), 0 deletions(-)  create
> mode 100644 doc/dun-api.txt
> 
> diff --git a/doc/dun-api.txt b/doc/dun-api.txt new file mode 100644
> index 0000000..af1c507 --- /dev/null
> +++ b/doc/dun-api.txt
> @@ -0,0 +1,82 @@
> +DUNGateway hierarchy
> +========================
> +
> +Service		org.bluez
> +Interface	org.bluez.DUNGateway
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX +
> +This interface is available for remote devices which can function in
> +the Gateway role of the DUN profile.  It is intended to be used with
> +external  handlers of the DUN Protocol.
> +
> +Methods		void Connect()
> +
> +			Connect to the GW service on the remote device. +
> +		void Disconnect()
> +
> +			Disconnect from the GW service on the
> remote device
> +
> +		dict GetProperties()
> +
> +			Returns all properties for the
> interface. See the
> +			properties section for available properties.
> +
> +		void RegisterAgent(object path)
> +
> +			The object path defines the path the of
> the agent
> +			that will be called when a new DUN connection
> +			is established.
> +
> +			If an application disconnects from the
> bus all of its
> +			registered agents will be removed.
> +
> +		void UnregisterAgent(object path)
> +
> +			This unregisters the agent that has
> been previously
> +			registered. The object path parameter
> must match the
> +			same value that has been used on registration.
> +
> +			Possible Errors: org.bluez.Error.Failed
> +
> org.bluez.Error.InvalidArguments
> +
> +
> +Signals		PropertyChanged(string name, variant value) +
> +			This signal indicates a changed value
> of the given
> +			property.
> +
> +Properties	string State [readonly]
> +
> +			Indicates the state of the connection.  Possible +			values are:
> +				"disconnected"
> +				"connecting"
> +				"connected"
> +
> +DUNAgent hierarchy
> +===============
> +
> +Service         unique name
> +Interface       org.bluez.DUNAgent
> +Object path     freely definable
> +
> +Methods		void NewConnection(filedescriptor fd)
> +
> +			This method gets called whenever a new DUN
> +			connection has been established.  The objectpath
> +			contains the object path of the remote
> device.  This
> +			method assumes that DBus daemon with
> file descriptor
> +			passing capability is being used.
> +
> +			The agent should only return
> successfully once the
> +			establishment of the data call has been fineshed

A typo 'fineshed' should be 'finished'.

> +			without problems.
> +
> +			Possible Errors:
> org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.Failed
> +
> +		void Release()
> +
> +			This method gets called whenever the service daemon
> +			unregisters the agent.

Compared with hfp-api.txt, I think we should also add the sentence like "or whenever the Adapter where the DUNAgent registers itself is removed".

> --
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html



Regards,
Zhenhua


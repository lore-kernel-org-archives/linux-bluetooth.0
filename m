Return-Path: <cyrus@holtmann.org>
Message-ID: <4C5FD994.40206@libresoft.es>
Date: Mon, 09 Aug 2010 12:33:56 +0200
From: Santiago Carot-Nemesio <scarot@libresoft.es>
MIME-Version: 1.0
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Changes in HDP API.
References: <201008051129.38119.santoscadenas@gmail.com> <1281016183-4547-1-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1281016183-4547-1-git-send-email-santoscadenas@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/05/10 15:49, Jose Antonio Santos Cadenas wrote:
> Now the connection is made directly to a device and bluetoothd daemon
> guess the PSM connection and the MDEPID based on the data get from the
> SDP record.
> ---
>   doc/health-api.txt |  105 ++++++++++++++++++++--------------------------------
>   1 files changed, 40 insertions(+), 65 deletions(-)
>
> diff --git a/doc/health-api.txt b/doc/health-api.txt
> index f469df3..89df8bd 100644
> --- a/doc/health-api.txt
> +++ b/doc/health-api.txt
> @@ -14,12 +14,9 @@ Object path	/org/bluez/
>
>   Methods:
>
> -	object	CreateApplication(dict config, object agent)
> +	object	CreateApplication(dict config)
>
> -		Returns the path of the new registered application. The agent
> -		parameter is the path of the object with the callbacks to
> -		notify events (see org.bluez.HealthAgent at the end
> -		of this document).
> +		Returns the path of the new registered application.
>
>   		Dict is defined as bellow:
>   		{
> @@ -39,32 +36,33 @@ Methods:
>
>   		Closes the HDP application identified by the object path. Also
>   		application will be closed if the process that started it leaves
> -		the bus.
> +		the bus. Only the creator of the application will be able to
> +		destroy it.
>
>   		Possible errors: org.bluez.Error.InvalidArguments
>   				org.bluez.Error.NotFound
> +				org.bluez.Error.NotAllowed
>
>   --------------------------------------------------------------------------------
>
>   Service		org.bluez
> -Interface	org.bluez.HealthApplication
> -Object path	[variable prefix]/health_app_ZZZZ
> +Interface	org.bluez.HealthDevice
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>
>   Methods:
>
> -	void Echo(object service)
> +	Boolean Echo()
>
>   		Sends an echo petition to the remote service. Returns True if
>   		response matches with the buffer sent. If some error is detected
> -		False value is returned and the associated MCL is closed.
> +		False value is returned.
>
>   		Possible errors: org.bluez.Error.InvalidArguments
>   				org.bluez.Error.OutOfRange
>
> -	object CreateChannel(object service, string type)
> +	object CreateChannel(object application, string configuration)
>
> -		Creates a new data channel with the indicated config to the
> -		remote Service.
> +		Creates a new data channel.
>   		The configuration should indicate the channel quality of
>   		service using one of this values "Reliable", "Streaming", "Any".
>
> @@ -76,16 +74,27 @@ Methods:
>
>   	void DestroyChannel(object channel)
>
> -		Destroys the data channel object.
> +		Destroys the data channel object. Only the creator of the
> +		channel or the creator of the HealtApplication that received the
> +		data channel will be able to destroy it
>
>   		Possible errors: org.bluez.Error.InvalidArguments
> -				orb.bluez.Error.NotFound
> +				org.bluez.Error.NotFound
> +				org.bluez.Error.NotAllowed
>
> ---------------------------------------------------------------------------------
> +Signals:
>
> -Service		org.bluez
> -Interface	org.bluez.HealthService
> -Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY
> +	void ChannelConnected(object channel)
> +
> +		This signal is launched when a new data channel is created or
> +		when a known data channel is reconnected.
> +
> +	void ChannelDeleted(object channel)
> +
> +		This signal is launched when a data channel is deleted.
> +
> +		After this signal the data channel path will not be valid and
> +		its path can be reused for future data channels.
>
>   --------------------------------------------------------------------------------
>
> @@ -94,6 +103,9 @@ Interface	org.bluez.HealthChannel
>   Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/
>   							hdp_YYYY/channel_ZZ
>
> +Only the process that created the data channel or the creator of the
> +HealthApplication that received it will be able to call this methods.
> +
>   Methods:
>
>   	dict GetProperties()
> @@ -101,17 +113,23 @@ Methods:
>   		Returns all properties for the interface. See the properties
>   		section for available properties.
>
> +		Posible errors: org.bluez.Error.NotAllowed
> +
>   	fd Acquire()
>
>   		Returns the file descriptor for this data channel. If the data
>   		channel is not connected it will also reconnect.
>
>   		Possible errors: org.bluez.Error.NotConnected
> +				org.bluez.Error.NotAllowed
>
>   	void Release()
>
>   		Releases the fd. Application should also need to close() it.
>
> +		Possible errors: org.bluez.Error.NotAcquired
> +				org.bluez.Error.NotAllowed
> +
>   Properties:
>
>   	string Type (read only)
> @@ -119,50 +137,7 @@ Properties:
>   		The quality of service of the data channel. ("Reliable" or
>   		"Streaming")

In HDP specification there is a special mention for first data channel 
opened that it shall be used for sending specific protocol data. Using 
this API it is impossible diferentiate it from another reliable data 
channels when it changes after a MCL reconnection. For applications 
using HDP is mandatory sending this kind of traffic through the first 
reliable data channel.

I suggest use an special Type for it in addition to "Reliable" and 
"Streaming" such as "Main".

Due that main data channel can change after a MCL reconnection, we need 
notify it to applications. We can expose a new signal similar to hfp-api 
to announce property changes, for example something like this:

+Signals	PropertyChanged(string new_value)
+
+		This signal indicates a property changed value.

Comments are welcome.
Regards.

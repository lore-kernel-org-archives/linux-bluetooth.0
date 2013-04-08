Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v4 2/6] Bluetooth: Add SCO socket voice_setting option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5162BADF.7010608@linux.intel.com>
Date: Mon, 8 Apr 2013 10:50:34 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <562DEF75-6DB8-4AA8-ACD5-40929964BC45@holtmann.org>
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com> <1363716255-21332-3-git-send-email-frederic.dalleau@linux.intel.com> <DE6F5576-C7C9-4EA9-B242-3489F0651FBC@holtmann.org> <5162BADF.7010608@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> I find this parameter name a bit long. What about just "setting" or "settings" or "voice". I am open for suggestions.
>> 
>> Also should this be part of options or the socket address structure.
>> 
>> Another option would be to introduce a SCO_SETTINGS or SCO_VOICE socket option. With just this one parameter.
>> 
>> Since the default value of voice setting is not 0x0000, it might make actually more sense to introduce a new socket option. Playing the memset handling would only work nicely if the default would be 0x0000, but it isn't.
>> 
>> Regards
>> 
>> Marcel
>> 
> 
> I agree that having a separate socket option is better. IMHO, having it in the
> sockaddr is not enough because you don't know in advance what stream is
> flowing for incoming connections. It could improve the API for outgoing
> connections.

fair enough. Being able to set a socket option before calling accept() allows us to pick and choose the SCO air mode we require.

> My concern is how do we handle user values.
> If the user do not set this option, hci_conn->settings contains 0x0000.
> In this case, it is possible to start the sco connection as we have it today.
> If the user set 0x0060 (cvsd 16 bits) or 0x0003 (transparent data), then it is
> possible to start S3, S2, S1 or T2, T1 sequences.
> 
> For other values, IMHO, returning an error would be the way to go.

The default value for voice settings comes from hci_dev and is normally 0x0060. So that would be the value that we have initially. Which means CVSD air encoding.

If you create a SCO socket with socket() and call getsockopt on it, then it should return the default voice setting from the controller. Actually our global default and only once you bound it with bind() it will tell you the controller specific value. And with Synchronous setup, it also does not matter much since there it is part of the HCI command anyway. It does get a bit tricky for legacy controllers that do not support eSCO. Here we would need to write default voice setting first before calling add SCO.

And yes, we can limit the possible valid values. It is more important to also return the value we are getting back from the kernel. So that systems like PA know exactly what kind of link is configured.

> If the above is fine for you, we can discuss the naming. What about the
> following ?
> 
> #define SCO_SETTINGS  0x03
> struct sco_settings {
>        __u16           settings;
> };

That is my current thinking. However we might start using SOL_BLUETOOTH and start using BT_VOICE or similar as a socket option. I do want to be able to retire SOL_SCO and SOL_L2CAP at some point.

Regards

Marcel


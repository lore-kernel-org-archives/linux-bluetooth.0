Return-Path: <cyrus@holtmann.org>
Message-ID: <4E57B011.9070201@linux.intel.com>
Date: Fri, 26 Aug 2011 16:39:13 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: HFP gateway and new incoming connection
References: <4E528879.5080103@invoxia.com>	<20110822174912.GA21949@joana>	<CABBYNZLEkc8FWmJm9hU_n-KL2mhWeWPcUfxqX1jskH8ubU-aMw@mail.gmail.com>	<4E536DFF.8050205@invoxia.com>	<CABBYNZKyb=SFcaT-MvBLCTyZiENt=8W5xdpah6jiy8JX+8=Hfg@mail.gmail.com>	<4E53949C.7050804@invoxia.com> <CABBYNZ+yPF28bewUjw8Vjs5HFqB3vUVExJfZARBqXhYLpxHkHw@mail.gmail.com>
In-Reply-To: <CABBYNZ+yPF28bewUjw8Vjs5HFqB3vUVExJfZARBqXhYLpxHkHw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Le 24/08/2011 13:03, Luiz Augusto von Dentz a écrit :
> Hi,
>
> On Tue, Aug 23, 2011 at 2:53 PM, Arnaud Mouiche
> <arnaud.mouiche@invoxia.com>  wrote:
>> On 08/23/2011 01:14 PM, Luiz Augusto von Dentz wrote:
>>>
>>> Hi Arnaud,
>>>
>>> On Tue, Aug 23, 2011 at 12:08 PM, Arnaud Mouiche
>>> <arnaud.mouiche@invoxia.com>    wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 08/22/2011 09:58 PM, Luiz Augusto von Dentz wrote:
>>>>>
>>>>> [...]
>>>>> Yep, we have some plans to move the Agent registration to adapter
>>>>> path, so it gonna be per adapter. This is necessary to set the
>>>>> features bit properly in the record and probably gonna support both
>>>>> roles (with different agents). My initial idea was to use Media API,
>>>>> but perhaps is confusing since HFP is not entirely about audio but
>>>>> call control too (mostly) so perhaps we gonna have a different
>>>>> interface for it e.g. org.bluez.Telephony, in addition to that we are
>>>>> planning to pass the endpoint bus and path together in the
>>>>> NewConnection so the telephony agent (oFono) can communicate directly
>>>>> to endpoint in use (PulseAudio).
>>>>>
>>>>> Those are my plans, but none of this is set in stone and Im pretty
>>>>> open for ideas
>>>>>
>>>> what about using the org.bluez.Adapter / RegisterAgent API, and add:
>>>> - the possibility to setup multiple agents (maintain a list of agents)
>>>> - use the "capability" field as a filter definition to find the good
>>>> agent
>>>> for the particular request
>>>> ex:
>>>>     audio/gateway.c::agent_sendfd() will look for a agent in the list,
>>>> with a
>>>> "HFP" capability to send the "NewConnection" request
>>>
>>> I guess it would be confusing since with the same method we would have
>>> different types of agents which implements different interfaces, there
>>> is also the problem that by using Adapter interface it would have to
>>> be implemented in the core daemon but my intention is to maintain this
>>> inside the audio plugin to hook with Media API.
>>>
>> You are right. I didn't see how the core was compartmentalized from plugins.
>> I need took more closely to the Media API...
>>
>
> How about the following:
>
> Telephony hierarchy [experiemental]
> ===================
>
> Service		org.bluez
> Interface	org.bluez.Telephony
> Object path	[variable prefix]/{hci0,hci1,...}
>
> Methods		void RegisterAgent(object path, dict properties)
>
> 			Register a TelephonyAgent to sender, the sender can
> 			register as many agents as it likes.
>
> 			Note: If the sender disconnects its agents are
> 			automatically unregistered.
>
> 			possible properties:
>
> 				string UUID:
>
> 					UUID of the profile which the agent is
> 					for.
>
> 				uint16 Version:
>
> 					Version of the profile which the agent
> 					implements.
>
> 				byte Features:
>
> 					Agent supported features as defined in
> 					profile spec e.g. HFP.
>
> 			Possible Errors: org.bluez.Error.InvalidArguments
>
>
> 		void UnregisterAgent(object path)
>
> 			Unregister sender agent.
>
> TelephonyAgent hierarchy
> ========================
>
> Service		unique name
> Interface	org.bluez.TelephonyAgent
> Object path	freely definable
>
> ethods		void NewConnection(filedescriptor fd, dict properties)
>
> 			This method gets called whenever a new connection
> 			has been established. This method assumes that DBus
> 			daemon with file descriptor passing capability is
> 			being used.
>
> 			The agent should only return successfully once the
> 			establishment of the service level connection (SLC)
> 			has been completed.  In the case of Handsfree this
> 			means that BRSF exchange has been performed and
> 			necessary initialization has been done.
>
> 			If Endpoint is set the agent is responsible to
> 			create an object implementing org.bluez.MediaTransport
> 			and notify the Endpoint using org.bluez.MediaEndpoint.
>
> 			possible properties:
>
> 				strict Device:
>
> 					BlueZ remote device object.
>
> 				string UUID:
>
> 					Profile UUID of the connection.
>
> 				uint16 Version:
>
> 					Remote profile version.
>
> 				byte Features:
>
> 					Remote profile features.
>
> 				string Endpoint:
>
> 					Optional. Endpoint bus id.
>
> 				string EndpointPath:
>
> 					Optional. Endpoint object path.
>
> 			Possible Errors: org.bluez.Error.InvalidArguments
> 					 org.bluez.Error.Failed
>
> 		void Release()
>
> 			This method gets called whenever the service daemon
> 			unregisters the agent or whenever the Adapter where
> 			the TelephonyAgent registers itself is removed.
>
>

This interface should be used with org.bluez.Media API, daemon 
registering with org.bluez.Telephony will take care of control channel 
while org.bluez.Media will be used to manage audio part, did I 
understand correctly ?

I understand how connection will be managed for server part (incoming 
connections), but what will be used for client part (outgoing connections) ?

It may be possible to use a per device interface similar to 
org.bluez.HandsfreeGateway with only connect/disconnect methods (with 
different interfaces for each HFP roles).

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation


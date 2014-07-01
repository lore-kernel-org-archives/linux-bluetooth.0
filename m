Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] doc: Add EIR to device properties
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+bD78j4bSfqvn7MHnsV7PKp_dGXN4dLApW2G5p4oN-Tsu+h1Q@mail.gmail.com>
Date: Tue, 1 Jul 2014 12:42:16 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F49C47A1-077C-41E2-A36B-3DE9EF1A9E19@holtmann.org>
References: <1403897492-6233-1-git-send-email-scott@netsplit.com> <B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org> <CA+bD78j4bSfqvn7MHnsV7PKp_dGXN4dLApW2G5p4oN-Tsu+h1Q@mail.gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>>> This patch proposes an extension to the D-Bus Device API to allow
>>> an application access to the last EIR data received from a device
>>> in inquiry or advertising mode.
>>> 
>> in general I have no objections in exposing the EIR and AD information. However I do not like to use EIR as property key. I know that on mgmt API we simply went with EIR_Data, but on the D-Bus API we most likely need to find a name that is a bit more generic and allows to represent EIR and AD information.
>> 
> 
> Thinking about this a little bit more, I'm not sure this should be a
> Device property either. The advertisement data isn't really a property
> of the device, but a property of the advertisement itself.
> 
> A peripheral could theoretically send different advertisements, a
> weird example might be a peripheral sending a non-connectable
> undirected advertisement generally, and a connectable directed
> advertisement to us directly, with different AD.

that is indeed possible. They can also interleave them with one time targeting a different central.

Keep in mind that there is also something called service solicitation. Meaning a peripheral start indicated that it want a device with service UUID x to find us. iOS is for example using that to filter for the Notification Center stuff.

> This seems to fold back nicely into the discussion about a "Find
> Devices" API, intended for applications and separate from the
> StartDiscovery API. If that were an "agent" mode, it could look
> something like this:
> 
>    <- Search( { Data: "FF4C000214" }, agent_object_path )
>    -> DeviceFound( device_object_path, data )
>    -> DeviceFound( device_object_path, data )
>    -> DeviceFound( device_object_path, data )
> 
> Where data in the agent method is the unparsed advertisement data, if
> the application is interested in it. The above example is looking for
> an iBeacon by presence of a specific data structure, so the app
> probably wants the unparsed data parameter and doesn't care so much
> about the object path.
> 
> But looking for heart rate monitors might be:
> 
>    <- Search( { UUID: "180D" }, agent_object_path )
>    -> DeviceFound( device_object_path, data )
>    -> DeviceFound( device_object_path, data )
>    -> DeviceFound( device_object_path, data )
> 
> In which case the application probably just wants the device object path.
> 
> 
> If this is broadly along the lines you're thinking, I'll draft a doc
> to begin discussion.

I think this looks pretty along the lines what I am looking for. However I was thinking in a bit more detail likes this:

	<- Search method call
	-> New Device object / Updated device object
	-> New Device object / Updated device object
	-> Search method return -> array of objects with properties

So you can treat the search dead simple and just display the results. However that way you can not monitor progress. If you want to monitor progress while search is running, you need to monitor changes to the device objects.

Regards

Marcel


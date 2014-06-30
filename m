Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org>
References: <1403897492-6233-1-git-send-email-scott@netsplit.com>
	<B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org>
Date: Mon, 30 Jun 2014 13:26:23 -0700
Message-ID: <CA+bD78j4bSfqvn7MHnsV7PKp_dGXN4dLApW2G5p4oN-Tsu+h1Q@mail.gmail.com>
Subject: Re: [RFC] doc: Add EIR to device properties
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 27, 2014 at 12:55 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:

>> This patch proposes an extension to the D-Bus Device API to allow
>> an application access to the last EIR data received from a device
>> in inquiry or advertising mode.
>>
> in general I have no objections in exposing the EIR and AD information. H=
owever I do not like to use EIR as property key. I know that on mgmt API we=
 simply went with EIR_Data, but on the D-Bus API we most likely need to fin=
d a name that is a bit more generic and allows to represent EIR and AD info=
rmation.
>

Thinking about this a little bit more, I'm not sure this should be a
Device property either. The advertisement data isn't really a property
of the device, but a property of the advertisement itself.

A peripheral could theoretically send different advertisements, a
weird example might be a peripheral sending a non-connectable
undirected advertisement generally, and a connectable directed
advertisement to us directly, with different AD.

This seems to fold back nicely into the discussion about a "Find
Devices" API, intended for applications and separate from the
StartDiscovery API. If that were an "agent" mode, it could look
something like this:

    <- Search( { Data: "FF4C000214" }, agent_object_path )
    -> DeviceFound( device_object_path, data )
    -> DeviceFound( device_object_path, data )
    -> DeviceFound( device_object_path, data )

Where data in the agent method is the unparsed advertisement data, if
the application is interested in it. The above example is looking for
an iBeacon by presence of a specific data structure, so the app
probably wants the unparsed data parameter and doesn't care so much
about the object path.

But looking for heart rate monitors might be:

    <- Search( { UUID: "180D" }, agent_object_path )
    -> DeviceFound( device_object_path, data )
    -> DeviceFound( device_object_path, data )
    -> DeviceFound( device_object_path, data )

In which case the application probably just wants the device object path.


If this is broadly along the lines you're thinking, I'll draft a doc
to begin discussion.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?

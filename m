Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: MAP client: Add support for receiving notifications
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <51472E9E.50807@oss.bmw-carit.de>
Date: Wed, 20 Mar 2013 10:10:58 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <F648EBCB-EE39-47D1-8040-07AC2AE0C249@holtmann.org>
References: <51472E9E.50807@oss.bmw-carit.de>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> This is a follow-up on the discussion started in my patch set
> "MAP client: notification support". The patches were implementing
> notification support only for one remote device and needed an additional
> API function for choosing that device.
> 
> It's better to implement this implicitly and support multiple devices
> from the beginning.
> 
> In this E-Mail I'd like to suggest how we could implement the
> notification connection setup in BlueZ. I'll try to explain the relevant
> part of the spec to have a base for discussion.
> 
> MAP consists of two different OBEX applications, Message Access Service
> (MAS) for browsing messages and Message Notification Service (MNS) for
> receiving event reports about changes on the server (like new messages,
> moved messages, delivery reports, ...).
> 
> The spec describes the single phone use case where the MAP client (MCE)
> consists of several MAS client instances for the different accounts and
> one common MNS server instance:
> 
>  MCE (Car Kit)       MSE (Phone)
> +---------------+   +-------------------------+
> | MAS client 1  |<->| MAS server 1 (SMS)      |
> | MAS client 2  |<->| MAS server 2 (E-Mail A) |
> |     ...       |   |     ...                 |
> | MNS server    |<->| MNS client              |
> +---------------+   +-------------------------+
> 
> Every MAS client instance, that wants to use notifications, needs to
> use the SetNotificationRegistration function to enable it.
> If the MNS connection isn't established already, the server (MSE) will
> start the SDP lookup for the MNS instance on the client and connect to
> it. The event reports that are sent on the MNS channel contain the MAS
> instance ID, that can be used to map the event to the MAS client.
> 
> Since an OBEX instance, like the MNS server, cannot be connected to
> different remote devices at the same time, it will not work to have one
> static MNS server instance. Instead we need one MNS server instance for
> every connected remote device (that we want to use with MAP). Since the
> MNS connection establishment is based on SDP, we have to make sure that
> there's only one MNS server SDP record visible. Otherwise, the MSE
> cannot know which one to connect to.

are you sure about this? In theory you could just use another OBEX connection id for the second connection. Has this actually been tested?

> If we want to hide this all from the application level, we could do the
> connection establishment for two devices (MSE 1 and MSE 2) as described
> here.
> 
>  MCE (Car Kit)       MSE 1 (Business phone)
> +---------------+   +-------------------------+
> | MAS client 1  |<->| MAS server 1 (SMS)      |
> | MAS client 2  |<->| MAS server 2 (E-Mail A) |
> |     ...       |   |     ...                 |
> | MNS server 1  |<->| MNS client              |
> |               |   +-------------------------+
> |               |
> |               |     MSE 2 (private phone)
> |               |   +-------------------------+
> | MAS client 3  |<->| MAS server 1 (SMS)      |
> |     ...       |   |     ...                 |
> | MNS server 2  |<->| MNS client              |
> +---------------+   +-------------------------+
> 
> - MCE connects MAS client 1 to MSE 1
> - MCE dynamically instantiates MNS server 1 and registers its SDP record
> - MAS client 1 sends SetNotificationRegistration(on)
> - MSE does SDP lookup and connects to the found MNS server 1
> - MCE removes SDP record for MNS server 1
> - MCE connects MAS client 2 to MSE 1
> - MAS client 2 sends SetNotificationRegistration(on)
>     (MNS channel is already up, MSE just responds OK)
> - MCE connects MAS client 3 to MSE 2
> - MCE dynamically instantiates MNS server 2 and registers its SDP record
> - MAS client 3 sends SetNotificationRegistration(on)
> - MSE does SDP lookup and connects to the found MNS server 2
> - MCE removes SDP record for MNS server 2
> ...
> 
> Does that sound reasonable for you?

This proposal is inherintly racy. I also do not understand it. When you have a different ACL link, then you can have the same RFCOMM channel established twice. So why are we bothering with this.

If you are expecting one client connection from each MSE, then there is no need to play any of these tricks. And if a MSE wants to establish more than one client connection, then it is better able to use different connection ids.

Regards

Marcel


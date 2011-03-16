Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimP_XBFy58dMDZa69RQ9UKeZmh++jeuH073doLr@mail.gmail.com>
References: <AANLkTimP_XBFy58dMDZa69RQ9UKeZmh++jeuH073doLr@mail.gmail.com>
From: jaikumar Ganesh <jaikumarg@gmail.com>
Date: Tue, 15 Mar 2011 19:57:22 -0700
Message-ID: <AANLkTimVj3PjXjYPfj_3f-8bSvYBLnxeX-n_pyh6rY8r@mail.gmail.com>
Subject: Re: [RFC] Auto Connections
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <Ville.Tervo@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Claudio:

On Fri, Mar 11, 2011 at 1:30 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi guys,
>
> It is time to get opinions from some gurus!
>
> We need to implement automatic connections to implement the Profiles.
> At the moment BlueZ supports only dual mode adapters, as consequence
> BlueZ needs to start the LE connection. IMHO, it is better to leave
> the responsibility to the controller, implementing "selective"
> connections will only introduce more code without concrete benefits.
> Configuring the controller to autonomously establish connections seems
> to be the right approach to proceed.
>
> This topic is NOT about StartDiscovery() + CreateDevice.
> StartDiscovery uses active scanning and CreateDevice uses direct
> connection establishment. We need a mechanism to automatically connect
> to "trusted" devices or devices flagged as "AutoConnect".
>
>
> My initial idea is: change the LE server socket to report
> outgoing(host initiated) connections through the server socket.
> Awkward?
> To achieve that we need to manage the LE Create Connection(using
> whitelist) in the kernel, extend the management interface to control
> devices in the whitelist, change the LE Connection Complete Event
> handling to get the Role properly.
> Pros:
> - Controller manage connections
> - Flexible to support  connections to "trusted" resolvable address and
> passive scanning
> - Only one "flow" for the connections: LE server socket
> - Maybe we could hide resolvable address from the userspace, mapping
> it directly to public or static random
> Cons:
> - Risky
> - Less control of the connection establishment process
>
>
> Another approach can be to manage the LE connections(using whitelist)
> from the userspace. BDADDR_ANY in the destination field(sockaddr_l2)
> can be used to define LE connections using white list.
> Pros:
> - It will not be necessary to extend the management interface now,
> address can be added directly to the controller's white list
> - Doesn't require changes in the LE server socket
> Cons:
> - BDADDR_ANY in the destination field has no meaning for Basic Rate
> - Needs to expose the resolvable address to the userspace
> - Different "flows" for incoming/outgoing connections
>
>
> Open issue(s):
> * How to handle timeouts when sending LE Create Connection
> * Passive scanning management
>


 In general, why do we want let the stack manage auto connections i.e
can you elaborate on "We need to implement automatic connections to
implement the Profiles". Why not let the applications (which sit above
Bluez) handle auto connections ?

Thanks

>
> Cheers,
> Claudio
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

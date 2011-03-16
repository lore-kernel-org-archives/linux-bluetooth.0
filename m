Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Mar 2011 17:40:04 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <Ville.Tervo@nokia.com>
Subject: Re: [RFC] Auto Connections
Message-ID: <20110316204004.GA2339@joana>
References: <AANLkTimP_XBFy58dMDZa69RQ9UKeZmh++jeuH073doLr@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimP_XBFy58dMDZa69RQ9UKeZmh++jeuH073doLr@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-03-11 21:30:09 +0000]:

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
> - Flexible to support  connections to "trusted" resolvable address and
> passive scanning
> - Only one "flow" for the connections: LE server socket
> - Maybe we could hide resolvable address from the userspace, mapping
> it directly to public or static random

This approach have a lot of advantages. It seems the best option to me.

> Cons:
> - Risky

Define risky here.

> - Less control of the connection establishment process

But do we need this control?

-- 
Gustavo F. Padovan
http://profusion.mobi

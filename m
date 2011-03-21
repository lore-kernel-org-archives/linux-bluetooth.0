Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTin-Tc4s76OuJ26ktQXT7n5f7yMZbYWpMiv-Dfc4@mail.gmail.com>
References: <AANLkTimP_XBFy58dMDZa69RQ9UKeZmh++jeuH073doLr@mail.gmail.com>
 <20110316204004.GA2339@joana> <AANLkTin-Tc4s76OuJ26ktQXT7n5f7yMZbYWpMiv-Dfc4@mail.gmail.com>
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Mon, 21 Mar 2011 16:30:17 +0530
Message-ID: <AANLkTimiJ19Vn9Pgs0iAMDmxaa=kXNRXQ72FOmQofy4x@mail.gmail.com>
Subject: Re: [RFC] Auto Connections
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <Ville.Tervo@nokia.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,


> to Jaikumar:
> The profiles will indirectly manage the connections providing
> informations such as connection parameters(interval, window, ...) and
> addresses, but the kernel needs to centralize/manage the connections.

As per section 9.3.8, a host can still perform direct connection
establishment procedure
by telling controller to "ignore the White List and process
connectible advertising
packets from a specific single device specified by the Host". Wouldn't
this be same
as letting the host[read profiles] directly manage connections?


> We can't allow the profiles to control the connection directly, a
> remote can implement more than one profile, maybe with different
> constraints. The host can also provide inputs, for instance power
> saving profile or maximum number of LE connections.

Why not? under direct connection establishment procedure, it should be
possible for a host
to establish connection with a remote peer device with host selected connection
configurable parameters. Why should we deprive a bluez host of
establishing such a connection...

Or did I miss something here?

Thanks,
Arun

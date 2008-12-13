Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100812121702j5db4d6b4sbdbbd2f5e0cdc0fe@mail.gmail.com>
Date: Fri, 12 Dec 2008 22:02:46 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Johan Hedberg" <johan.hedberg@nokia.com>
Subject: Re: Adapter API - Devices property not updated if connection initiated by remote device
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081212132850.GA2126@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812111357.59004.blam@trolltech.com>
	 <1229046197.22285.21.camel@violet.holtmann.net>
	 <200812121452.37564.blam@trolltech.com>
	 <1229079527.22285.38.camel@violet.holtmann.net>
	 <20081212132850.GA2126@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Fri, Dec 12, 2008 at 10:28 AM, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> There definitely needs to be a way to know that a remote device has
> connected to us even if it is not paired. I think we should just
> populate the Devices list in this case and then remove the device from
> it once it disconnects (if it didn't pair before that) and also send all
> appropriate signals while doing this. For knowing if the device is
> paired or not we already have the separate Paired property.

We could create the device object, but we should be careful to not
start a service discovery and end up with this device on the storage.
Note that this can be a security problem, since normally connections
should at least trigger authorization which requires the object
anyway, so someone is not really asking to the agent to authorize a
incoming connection.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação

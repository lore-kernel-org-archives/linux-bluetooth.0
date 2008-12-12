Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Dec 2008 15:28:50 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Adapter API - Devices property not updated if connection
	initiated by remote device
Message-ID: <20081212132850.GA2126@localhost>
References: <200812111357.59004.blam@trolltech.com> <1229046197.22285.21.camel@violet.holtmann.net> <200812121452.37564.blam@trolltech.com> <1229079527.22285.38.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1229079527.22285.38.camel@violet.holtmann.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 12, 2008, Marcel Holtmann wrote:
> I think we do create a temporary device structure for incoming
> connections in all cases since that is needed for pairing. However we
> might not add this to the Devices list.
> 
> Johan, any comments here. Should we just send out signals? I think the
> current reason for not doing so is that in most cases this is during a
> pairing event and we do wanna wait until it succeeds. However I don't
> see the big harm in adding it to the list.

There definitely needs to be a way to know that a remote device has
connected to us even if it is not paired. I think we should just
populate the Devices list in this case and then remove the device from
it once it disconnects (if it didn't pair before that) and also send all
appropriate signals while doing this. For knowing if the device is
paired or not we already have the separate Paired property.

Johna

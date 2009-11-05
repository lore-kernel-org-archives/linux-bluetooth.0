Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Nov 2009 20:52:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: RFC: New Handsfree Client Role API
Message-ID: <20091105185232.GA27336@jh-x301>
References: <200911051142.31929.denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200911051142.31929.denkenz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Denis,

On Thu, Nov 05, 2009, Denis Kenzior wrote:
> Properties	boolean Connected [readonly]
> 
> 			Indicates if there is an active connection to the
> 			AG service on the remote device.

In addition to (or instead of) this property we could also have a string
State property which would also communicate the "connecting" and "playing"
states. This is what we have for some other interfaces and it has proved
to be useful there (not sure if that'll be equally true for this new
interface but it's still worth considering).

> Methods		void NewConnection(object device, filedescriptor fd)
> 
> 			This method gets called whenever a new handsfree
> 			connection has been established.  The objectpath
> 			contains the object path of the remote device.  This
> 			method assumes that DBus daemon with file descriptor
> 			passing capability is being used.

As discussed on the #ofono channel, you might want to add here that the
assumption is that the agent responds to this method only after it has
completed the establishment of the SLC (or when it chooses to reject the
connection). 

Johan

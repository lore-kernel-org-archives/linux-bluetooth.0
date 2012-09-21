Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Sep 2012 22:07:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pacho Ramos <pacho@gentoo.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd: Refusing input device connect: Operation already in
 progress (114)
Message-ID: <20120921190732.GA9428@x220.P-661HNU-F1>
References: <1347704153.24322.11.camel@belkin4>
 <20120921124323.GA14885@x220>
 <1348254019.2085.2.camel@belkin4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348254019.2085.2.camel@belkin4>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pacho,

On Fri, Sep 21, 2012, Pacho Ramos wrote:
> > > Searching, I found this thread that pointed to the culprit, but I
> > > haven't found what finally occurred with it, if patch was reverted or a
> > > different fix was pulled in:
> > > http://www.spinics.net/lists/linux-bluetooth/msg26442.html
> > 
> > This is a different issue but the cause seems to be similar. You don't
> > need to patch bluetoothd though but just disable the mgmt part by
> > passing -P mgmtops to bluetoothd. For whatever reason the connection
> > state isn't cleaned up with mgmt (which shouldn't be dependent on mgmt
> > to begin with) and the input_device_set_channel function returns
> > -EALREADY when accepting a connection.
> 
> But it sounds like a workaround as mgmt is still broken as compared with
> bluetoothd previous above change was committed, no? Thanks for the
> info :)

Yes, it's still a workaround and the real cause needs to be figured out
and fixed (either with more detailed logs or by the developers
reproducing this themselves).

Johan

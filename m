Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 11:31:38 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] Bluetooth: mgmt: Add support for switching to LE
 peripheral mode
Message-ID: <20121025143138.GA27907@samus>
References: <1351112996-9597-6-git-send-email-johan.hedberg@gmail.com>
 <20121024221341.GA22764@samus>
 <20121024223635.GA11976@x220.P-661HNU-F1>
 <20121025005842.GB22764@samus>
 <1351130085.1785.84.camel@aeonflux>
 <20121025045605.GB12303@echo>
 <20121025075045.GA22397@x220>
 <CAJdJm_Odk8_8dLjcYw9kfr+CCD0Q0bNgu9duhRo6oKXYAo9cKA@mail.gmail.com>
 <20121025114817.GA2197@x220>
 <20121025120407.GA3274@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121025120407.GA3274@x220>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 15:04 Thu 25 Oct, Johan Hedberg wrote:
> Hi,
> 
> On Thu, Oct 25, 2012, Johan Hedberg wrote:
> > This will need some more thinking. We could add a new mgmt command for
> > that, or if you wanna go crazy why not map this to the L2CAP socket
> > interface's connect() system call. I.e. if LE GAP is in peripheral mode
> > instead of doing HCI_LE_Create_Connection or just failing with "not
> > allowed" a socket connect() would simply trigger directed advertising to
> > the device in question and deliver the successful connection in the same
> > way as a central role triggered connect would do (unless we time out
> > waiting for the remote device to connect). Now that I think of this
> > second option it actually sounds quite natural and not so crazy after
> > all :)
> 
> There's on problem with this though: we'd still be undirected
> connectable between doing mgmt_set_le(peripheral) and issuing the socket
> connect(). So maybe we might need to introduce a mgmt_set_le_connectable
> command and a "le-connectable" setting after all (that could only be set
> in peripheral mode).


Why not sending undirected connectable events when there's an active
listen()?

> 
> Johan


Cheers,
-- 
Vinicius

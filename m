Return-Path: <cyrus@holtmann.org>
From: "Malovany, Ram" <ramm@ti.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] Bluetooth: Set name_state to unknown when entry
 name is empty
Date: Mon, 23 Jul 2012 07:38:59 +0000
Message-ID: <2683478DEE33CD4DAF508ABCF391F6A40B4B3312@DNCE05.ent.ti.com>
References: <1342682771-28584-1-git-send-email-ramm@ti.com>
 <1342682771-28584-3-git-send-email-ramm@ti.com>
 <20120719141205.GB5141@joana> <20120719142736.GC5141@joana>
In-Reply-To: <20120719142736.GC5141@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Gustavo,

> -----Original Message-----
> From: Gustavo Padovan [mailto:gustavo@padovan.org]
> Sent: Thursday, July 19, 2012 5:28 PM
> To: Malovany, Ram; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v2 3/3] Bluetooth: Set name_state to unknown when entry
> name is empty
> 
> * Gustavo Padovan <gustavo@padovan.org> [2012-07-19 11:12:05 -0300]:
> 
> > Hi Ram,
> >
> > * ramm@ti.com <ramm@ti.com> [2012-07-19 10:26:11 +0300]:
> >
> > > From: Ram Malovany <ramm@ti.com>
> > >
> > > When the name of the given entry is empty , the state needs to be
> > > updated accordingly.
> > >
> > > Signed-off-by: Ram Malovany <ramm@ti.com>
> > > ---
> > >  net/bluetooth/hci_event.c |    2 ++
> > >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > All 3 patches have been applied to bluetooth.git. But please keep in mind
> that
> > we put periods at the end of the summary lines, I fixed that for you this
> 
> Sorry. We *don't* put periods at the end of summary lines.
> 
> 	Gustavo

Thanks , I will update accordingly next time.

Regards,
Ram

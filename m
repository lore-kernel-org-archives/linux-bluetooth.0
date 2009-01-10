Return-Path: <cyrus@holtmann.org>
Subject: Re: "packet types" wrong in libbluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1231603296.653256.942.nullmailer@galant.ukfsn.org>
References: <1231595402.312160.19752.nullmailer@galant.ukfsn.org>
	 <1231597284.5229.2.camel@californication>
	 <1231603296.653256.942.nullmailer@galant.ukfsn.org>
Content-Type: text/plain
Date: Sat, 10 Jan 2009 17:13:25 +0100
Message-Id: <1231604005.5229.5.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Iain,

> > > The HCI packet type functions ptypetostr() and strtoptype() in lib/hci.c
> > > don't work correctly. This is because the HCI spec is messed up wrt the 2
> > > and 3 Mbps packet types, which are indicated by inverted bit logic (see
> > > "Create Connection Command" in core spec document)
> >
> > current situation is perfectly fine. It follows the spec. closely and
> > this means for EDR the types are inverted.
> 
> since the spec is somewhat twisty I don't see how it follows it at all :)
> 
> > Trying to make them looks nice doesn't help. You should not mess with
> > packet types at all. It is the link managers' job to get this right.
> 
> I am not messing with packet types at all. I apologise because I don't use
> Linux or the BlueZ tools in general but it seems that hcidump displays
> "Create Connection" packets (at least) incorrectly because of this. For
> instance
> 
> 	hci_ptypetostr(HCI_DH1)
> 
> will return
> 
> 	"DH1 "
> 
> which seems normal. But, when this is part of a HCI packet (eg Create
> Connection command), that result should actually be:
> 
> 	"DH1 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 3-DH5 "
> 
> Should it be handled in hcidump instead, as below?

the Create Connection displays the actual bits set. And that is how it
suppose to be. The above line means EDR disabled. You set the bitmask
and that the meaning of some bits is disabled instead of enabled is a
different story.

Regards

Marcel



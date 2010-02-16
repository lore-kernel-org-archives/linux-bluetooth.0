Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluez-hcidump fix SDP universal attributes
From: Marcel Holtmann <marcel@holtmann.org>
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1266312330.230253.2026.nullmailer@galant.ukfsn.org>
References: <1259610176.010210.13279.nullmailer@galant.ukfsn.org>
	 <1263901312.199442.295.nullmailer@galant.ukfsn.org>
	 <1266312330.230253.2026.nullmailer@galant.ukfsn.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Feb 2010 07:42:42 -0800
Message-ID: <1266334962.8849.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Iain,

> > > hcidump shows SDP universal attribute 0x000d as IconURL but in fact it is
> > > defined as "Additional Protocol Descriptor Lists". IconURL is 0x000c and I
> > > don't know what Icon_10 was, perhaps an older name?
> > >
> > > Eg, from an SDP probe of a mouse:
> > >
> > >       aid 0x000d (IconURL)
> > >          < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16 0x0011 (HIDP) > > >
> >
> > Reposting because there was no response to this, patch is attached..
> >
> > See "5.1.6 AdditionalProtocolDescriptorList attribute" and "5.1.14 IconURL
> > Attribute" sections in the core specification for reference..
> >
> > (they sometimes call it AdditionalProtocolDescriptorLists and that is more
> > accurate as more than one protocol descriptor list may be included)
> 
> posting this simple (and easily verified) patch for hcidump for the third
> time..

sorry for having missed it. For some reason it got sorted away. Can you
create a proper patch with git format-patch. That makes it way easier
for me to apply them.

Regards

Marcel



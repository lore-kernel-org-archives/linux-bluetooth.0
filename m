Return-Path: <dcbw@redhat.com>
Subject: Re: SCO MTU fix needed for Kensington Bluetooth USB Adapter
From: Dan Williams <dcbw@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1152896210.25660.39.camel@localhost>
References: <1152893105.14037.21.camel@localhost.localdomain>
	 <1152894124.25660.33.camel@localhost>
	 <1152894617.14037.45.camel@localhost.localdomain>
	 <1152895158.25660.37.camel@localhost>
	 <1152895689.14037.50.camel@localhost.localdomain>
	 <1152896210.25660.39.camel@localhost>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 14:08:06 -0400
Message-Id: <1152900486.15253.0.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2006-07-14 at 18:56 +0200, Marcel Holtmann wrote:
> Hi Dan,
> 
> > > please also send "hciconfig hci0 features" (I don't like to decode that
> > 
> > [localhost ~]# /usr/sbin/hciconfig hci0 features
> > hci0:   Type: USB
> >         BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 377:10 SCO MTU: 16:0
> >         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
> >                 <3-slot packets> <5-slot packets> <encryption> <slot offset> 
> >                 <timing accuracy> <role switch> <hold mode> <sniff mode> 
> >                 <RSSI> <channel quality> <SCO link> <HV2 packets> 
> >                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power control> 
> >                 <transparent SCO> <enhanced iscan> <interlaced iscan> 
> >                 <interlaced pscan> <AFH cap. slave> <AFH cap. master> 
> > 
> > 
> > > by hand). And check if "hciconfig hci0 inqmode 1" succeeds.
> > 
> > [localhost ~]# /usr/sbin/hciconfig hci0 inqmode 1
> > [localhost ~]# 
> > 
> > (ie, nothing printed out)
> 
> if "hciconfig hci0 inqmode" return Inquiry with RSSI as mode then this
> dongle also supports it, even if it is not mentioned in the features.

It does return that, yes.

> Regards
> 
> Marcel
> 
> 

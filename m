Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jul 2012 10:36:03 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Re: [RFC] dbusoob: Update API
Message-ID: <20120726133603.GA28470@samus>
References: <1343226308-443-1-git-send-email-szymon.janc@tieto.com>
 <1343226308-443-2-git-send-email-szymon.janc@tieto.com>
 <20120725182201.GA4165@echo>
 <1842864.hGRL10RuKd@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1842864.hGRL10RuKd@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 11:24 Thu 26 Jul, Szymon Janc wrote:
> On Wednesday 25 of July 2012 21:22:01 Vinicius Costa Gomes wrote:
> > Hi Szymon,
> 
> Hi Vinicius,
> 
> > 
> > On 16:25 Wed 25 Jul, Szymon Janc wrote:
> > > ---
> > >  doc/oob-api.txt |   57 +++++++++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 51 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/doc/oob-api.txt b/doc/oob-api.txt
> > > index d838712..8b7b633 100644
> > > --- a/doc/oob-api.txt
> > > +++ b/doc/oob-api.txt
> > > @@ -7,26 +7,71 @@ Service		org.bluez
> > >  Interface	org.bluez.OutOfBand
> > >  Object path	[variable prefix]/{hci0,hci1,...}
> > >  
> > > -Methods		array{byte} hash, array{byte} randomizer ReadLocalData()
> > > +Methods		dict ReadLocalData()
> > >  
> > >  			This method reads local OOB data from adapter. Return
> > > -			value is pair of arrays 16 bytes each.
> > > +			value is a dictionary with following keys:
> > >  
> > > -			Note: This method will generate and return new local
> > > -			OOB data.
> > > +			array{byte} Hash:
> > > +
> > > +					16 bytes hash blob.
> > > +
> > > +			array{byte} Randomizer:
> > > +
> > > +					16 bytes randomizer blob.
> > 
> > I would add a TK field (with 16 bytes) for Low Energy bonding.
> 
> I must admit that I totally ignored LE case :) I'll add TK to dictionary,
> yet I'm not very familiar with LE, is TK a random number returned by 'LE Rand'
> command ? It doesn't seem to have same semantic as 'Read Local OOB Data' command.
> Hints?

The generation of the TK number is actually up to the host, it may want
to use 'LE Rand' (which generates only 8 bytes) or it may want to use
something else, which should be our case. More about TK in the page 1969
of the spec (section 2.3.5.4).

You are right that the semantics of 'LE Rand' are different from 'Read Local
OOB'. That is because the security protocol of LE is implemented in the
host side.

What I mean is that it would be up to BlueZ to guarantee that each time
ReadLocalData() is called a different TK is generated.

> 
> > 
> > > +
> > > +			Other data that can be transmitted via OOB mechanism
> > > +			can be obtained from org.bluez.Adapter interface.
> > > +
> > > +			Note: This method will generate and return new hash
> > > +			and randomizer every time it is called. Data
> > > +			received in previous calls is invalidated and cannot be
> > > +			used for pairing.
> > >  
> > >  			Possible errors: org.bluez.Error.Failed
> > >  					 org.bluez.Error.InProgress
> > >  
> > > -		void AddRemoteData(string address, array{byte} hash,
> > > -							array{byte} randomizer)
> > > +		void AddRemoteData(string address, dict data)
> > 
> > I am thinking if only the address is enough for the Low Energy case, i.e.
> > should we have an address type here?
> 
> In spec there are 'Flags' and 'Security Manager OOB Flags' EIR data types,
> is that needed/useful for LE case? Maybe pass them as blobs to bluez so that
> dbusoob user doesn't need to parse those bit fields to set address type?

Yeah, that should be enough. BlueZ already has access to all the EIR/AD
data.

> 
> -- 
> BR
> Szymon Janc
> 


Cheers,
-- 
Vinicius

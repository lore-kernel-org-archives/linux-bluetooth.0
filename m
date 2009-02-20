Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/4] add the D-Bus interface definition for HFP Audio
 gateway  -- take 2 -- resend
From: Denis Kenzior <denis.kenzior@intel.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1235161095.24255.21.camel@californication>
References: <ac8af0be0902200541p170966b6v8bbcf89ab04e129a@mail.gmail.com>
	 <1235161095.24255.21.camel@californication>
Content-Type: text/plain
Date: Fri, 20 Feb 2009 14:52:39 -0600
Message-Id: <1235163159.31774.54.camel@dkenzior-MOBL>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > +		string[] GetSubscriberNumbers()
> > +
> > +			Get all the numbers of AG
> 
> Shouldn't we use GetProperties() for this? Or does this actually end up
> in exchanging AT commands. How often does this change. Can we assume we
> only do this once and then be able to cache them?

This actually results in a +CNUM which can return multiple numbers.
However, we should only be returning the number for voice call basic
service and ignoring the rest.  I don't think HFP was meant for data /
fax calls :)

> 
> > +Signals
> > +		void Connected(uint32 ag_features)
> > +
> > +			Connection successfully esteblished. 'ag_features' are
> > +			ORed features:
> > +				0x001 Three-way calling
> > +				0x002 Echo cancelling and/or noice reduction
> > +					function
> > +				0x004 Voice recognition function
> > +				0x008 In-band ring tone capability
> > +				0x010 Attach a number to a voice tag
> > +				0x020 Ability to reject a call
> > +				0x040 Enhanced call status
> > +				0x080 Enhanced call control
> > +				0x100 Extended Error Result Cod
> 
> I really don't like having the features in hex codes. Can't we use the
> same strings the actual AT command set uses.

That is what the spec uses.  HFP AG & HFP client do a handshake of
sending +BRSF commands.  E.g. +BRSF: 224.  The decimal number is a bit
field containing the features actually supported. The numbers have
different meanings depending on whether HFP is AG role or Client role.

> > +		void CallCancelled()
> > +
> > +			Call failed to set up. It means that we tried to call
> > +			someone or someone tried to call us but call was not
> > +			accepted.
> 
> Would call that CallTerminated()
> 
> > +		void CallStart()
> > +
> > +			Call set up successfully.
> > +
> > +		void CallEnd()
> > +
> > +			Call was started and now ended. In contrast with
> > +			CallCancelled where call didn't started
> 
> That is CallStarted() and CallEnded().
> 
> Do we really need three signals to do this? Any better ideas?

This is not really complete enough.  You can have calls on hold,
multiparty calls etc.

Regards,
-Denis


Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 14:27:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot <sancane@gmail.com>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/14] thermometer: Reformat MeasurementReceived
 description
Message-ID: <20120928112757.GA18423@x220>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1348584763-22824-8-git-send-email-andrzej.kaczmarek@tieto.com>
 <20120928104318.GC25415@x220>
 <CACLukzLZGEbA-3pSqbutRrjb5WXJo7az+DydQ1Vph5bAnD0kdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACLukzLZGEbA-3pSqbutRrjb5WXJo7az+DydQ1Vph5bAnD0kdQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Fri, Sep 28, 2012, Santiago Carot wrote:
> 2012/9/28 Johan Hedberg <johan.hedberg@gmail.com>:
> > Hi Andrzej,
> >
> > On Tue, Sep 25, 2012, Andrzej Kaczmarek wrote:
> >> +                     Measurement:
> >> +
> >> +                             int16 Exponent:
> >> +                             int32 Mantissa:
> >> +
> >> +                                     Measurement value is calculated as
> >> +                                     (Mantissa) x (10^Exponent)
> >> +
> >> +                                     In case of invalid or missing data,
> >> +                                     Exponent is set to 0 and Mantissa is
> >> +                                     set to 2^23-1 (0x7FFFFF hexadecimal).
> >
> > Why aren't we using the D-Bus DOUBLE type for this? For invalid/missing
> > data just leave out these values from the dict. No need to try to
> > brute-force a 1:1 mapping from the protocol to D-Bus.
> 
> We don't use double type here because these information is valuable
> for upper profiles implementing a IEE11073-20601 protocol layer. This
> fact is scarcely commented in HTP and better explained in former
> specification where there is a need to pack both values (mantissa and
> exponent) in special kind of APDUs. Of course we could provide the
> double value here, but there will remain the need to know when an
> special case occurs: NRes, NaN,INFINITY, -INFINITY.
> 
> Furthermore, providing a double value here will force to upper
> profiles to do extra stuff to calculate the mantissa and the exponent
> values in order to create APDUs, beside they will have to deal with
> impreccisions derivated to comparate float point numbers and so it
> might make difficult to check when a special case has happened.
> 
> these are, as far as I remember, the reasons which we did it in this
> way. We were already talking about this fact in the mailing list in
> the past but I don't find the thread right now. sorry

This is good enough as a justification. I remembered we had discussed
this before but for the details I needed to get my memory refreshed.
Thanks.

Johan

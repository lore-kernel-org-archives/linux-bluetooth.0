Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
        "'Siarhei Siamashka'" <siarhei.siamashka@nokia.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <200812112227.07170.siarhei.siamashka@nokia.com>	 <1229045974.22285.18.camel@violet.holtmann.net>	 <200812121137.18041.siarhei.siamashka@nokia.com> <1229079849.22285.43.camel@violet.holtmann.net>
In-Reply-To: <1229079849.22285.43.camel@violet.holtmann.net>
Subject: RE: [PATCH] sbc: bitstream packing optimization for encoder.
Date: Fri, 12 Dec 2008 16:23:33 +0100
Message-ID: <00c801c95c6d$9953dad0$cbfb9070$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

next week I will discuss the bug fixing of SBC with Jaska Uimonen, who is
ill this week.

The sound quality of the fix point implementation still remains below of the
quality of the floating point version.

Maybe, we shall support both depending on the performance requirements?

Regards,
 
Christian


> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Marcel Holtmann
> Sent: Friday, December 12, 2008 12:04 PM
> To: Siarhei Siamashka
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] sbc: bitstream packing optimization for encoder.
> 
> Hi Siarhei,
> 
> > > > Appears that bitstream packing is also one of the most CPU hungry
> > > > operations in SBC encoder, which did not get proper attention
> yet.
> > > > Could somebody review this patch and provide feedback/comments?
> > >
> > > again thanks for working on this. I am actually willing to include
> your
> > > patches quickly in one of the next releases to get more wider
> testing
> > > audience.
> >
> > Thanks. Are the contributors of the last SBC-related modifications
> reachable
> > nowadays? They could probably help with the review of our patches.
> 
> they should be at least all subscribed to this mailing list now. Since
> I
> will actually close the other ones in two weeks.
> 
> > SBC code still can be improved in many ways from the performance
> point of
> > view. The current implementation follows SBC specification pretty
> much
> > literally. But rearranging the code a bit and getting rid of
> multidimentional
> > arrays can provide identical output, but work noticeably faster. Also
> SBC
> > can benefit from ARM assembly optimizations (for ARM11 and Cortex-
> A8),
> > so these could be applied a bit later once all the high level stuff
> is in
> > place.
> >
> > Current implementation only needs to be checked to ensure that it is
> correct
> > and fully adheres to the specification before applying large scale
> > optimizations.
> 
> I agree. So lets get a fully compliant Linux version first and then we
> go from there.
> 
> > > One comment from my side is that this should work with little-
> endian and
> > > big-endian as input streams. Please keep that in mind.
> >
> > Yes, it should work fine on both big and little endian systems,
> though I did
> > not test it on big-endian hardware myself. Actually SBC bitstream
> packer
> > favors big-endian systems, because the following part...
> >
> > +               if (bits_count >= 16) {\
> > +                       bits_count -= 8;\
> > +                       *data_ptr++ = (uint8_t)(bits_cache >>
> bits_count);\
> > +                       bits_count -= 8;\
> > +                       *data_ptr++ = (uint8_t)(bits_cache >>
> bits_count);\
> > +               }\
> >
> > ...could be implemented as something like this for big-endian systems
> > (provided that we additionally take care of alignment and convert
> 'data_ptr'
> > into a pointer to uint16_t):
> >
> > +               if (bits_count >= 16) {\
> > +                       bits_count -= 16;\
> > +                       *data_ptr++ = (uint16_t)(bits_cache >>
> bits_count);\
> > +               }\
> >
> > But for little endian-systems and also to ensure endian neutrality,
> data
> > writes are done one byte at a time.
> 
> Lets keep doing it byte by byte for now. However keep in mind that the
> input stream can also be in big endian even it is runs on a little
> machine. And vice-versa.
> 
> > And Just an additional comment about portability, there are also
> systems where
> > uint8_t data type is not supported (and CHAR_BIT is different from
> 8). For
> > example, there is a port SBC encoder from bluez to C55x DSP [1].  I'm
> in no
> > way involved in this project, but they could probably want to submit
> some
> > changes to mainline SBC code to make it usable on such systems with a
> bit
> > less tweaks.
> 
> We are doing Linux first and then worry about other systems.
> 
> Regards
> 
> Marcel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

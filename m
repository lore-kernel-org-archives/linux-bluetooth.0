Return-Path: <cyrus@holtmann.org>
Message-ID: <1348844742.13371.38.camel@aeonflux>
Subject: Re: [PATCH 0/5] mSBC tests
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Date: Fri, 28 Sep 2012 17:05:42 +0200
In-Reply-To: <20120927233420.3441f14e@i7>
References: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <20120927233420.3441f14e@i7>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > I wanted to know more about mSBC and I look into the spec and saw it
> > was just a set of settings for SBC. So I tried to exercise them using
> > sbcenc and sbcdec and found it wasn't possible, I ended modifying SBC
> > library and now it should be possible to use mSBC settings.
> > Using 15 block doesn't work using SIMD processing because of data
> > reordering so I recalled some legacy C code from an older release
> > (sbc_analyse_eight) and put in a separate primitives file.
>
> 
> I wonder why they decided to go with the odd sided blocks? Anyway,
> I guess there is no other way but to adapt to this extended spec.
> Thanks for taking a look at this stuff.
> 
> Have you tried to tweak the SIMD code to make it process one
> block at a time instead of batches of 4?
> 
> I suspect that we might only need to track the state and flip between
> "even" and "odd" constant tables for every other processed block in
> "sbc_analyze_4b_4s_simd" and "sbc_analyze_4b_8s_simd" replacement
> functions. The functions "sbc_encoder_process_input_s4_internal"
> and "sbc_encoder_process_input_s8_internal" also need to be
> updated to handle arbitrary number of blocks and not just
> multiples of 4. Though I haven't been working with sbc code lately
> and may be mistaken.
> 
> Using the old tables "_sbc_proto_fixed8" and "_sbc_proto_fixed4" has
> a disadvantage of not having the tweaks from:
>     http://git.kernel.org/?p=bluetooth/sbc.git;a=commit;h=bec3d3989ba2
> They haven't been in use for ages and just remained in the sources by.
> 
> If we just could make SIMD code work, that would be the best option in
> my opinion.
> 
> > Work done from the spec, not tested with any reference encoder.
> 
> Does a reference mSBC encoder exist somewhere? Or any ideas how to test
> the new code with something other than bluez just to be sure that it's
> correct?

I looked at the Bluetooth SIG website and couldn't find a reference
encoder or sample files. The old SBC reference encoder and decoder don't
seem to support other block sizes.

SBC Encoder LIB Version 1.5
Copyright (c) 2002  Philips Consumer Electronics, ASA Labs

Usage:
sbc_encoder [-jsv] [-lblk_len] [-nsubbands] [-p] [-rrate] [-ooutputfile] inputfile
            [-s] use the stereo mode for stereo signals
            [-v] verbose mode
            [-j] allow the use of joint coding for stereo signals
            [-lblk_len] blk_len specifies the APCM block length, out of [4,8,12,16]
            [-nsubbands] subbands specifies the number of subbands, out of [4,8]
            [-p] a simple psycho acoustic model is used
            [-rrate] specifies the bit rate in bps
            [-ooutputfile] specifies the name of the bitstream output file
            inputfile specifies the audio input file, the major audio formats are supported


SBC Decoder LIB Version 1.5
Copyright (c) 2002  Philips Consumer Electronics, ASA Labs

Usage:
sbc_decoder [-v] [-ooutputfile] [-pstartpos] inputfile
            [-v] verbose mode
            [-pstartpos] startpos specifies the byte offset to start with decoding
            [-ooutputfile] specifies the name of the audio output file
            inputfile specifies the name of the bitstream input file

And the sample files are all from 2001. We might have to create our own
ones and our own naive and stupid reference encoder/decoder.

Regards

Marcel



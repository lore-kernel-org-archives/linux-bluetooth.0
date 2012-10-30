Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Oct 2012 04:18:50 +0200
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?UTF-8?B?RnLDqWTDqXJpYw==?= Dalleau <frederic.dalleau@linux.intel.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/5] mSBC tests
Message-ID: <20121030041850.2bda32b0@i7>
In-Reply-To: <1348844742.13371.38.camel@aeonflux>
References: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
	<20120927233420.3441f14e@i7>
	<1348844742.13371.38.camel@aeonflux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 28 Sep 2012 17:05:42 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> > > Work done from the spec, not tested with any reference encoder.
> > 
> > Does a reference mSBC encoder exist somewhere? Or any ideas how to test
> > the new code with something other than bluez just to be sure that it's
> > correct?
> 
> I looked at the Bluetooth SIG website and couldn't find a reference
> encoder or sample files. The old SBC reference encoder and decoder don't
> seem to support other block sizes.
> 
> SBC Encoder LIB Version 1.5
> Copyright (c) 2002  Philips Consumer Electronics, ASA Labs
> 
> Usage:
> sbc_encoder [-jsv] [-lblk_len] [-nsubbands] [-p] [-rrate] [-ooutputfile] inputfile
>             [-s] use the stereo mode for stereo signals
>             [-v] verbose mode
>             [-j] allow the use of joint coding for stereo signals
>             [-lblk_len] blk_len specifies the APCM block length, out of [4,8,12,16]
>             [-nsubbands] subbands specifies the number of subbands, out of [4,8]
>             [-p] a simple psycho acoustic model is used
>             [-rrate] specifies the bit rate in bps
>             [-ooutputfile] specifies the name of the bitstream output file
>             inputfile specifies the audio input file, the major audio formats are supported
> 
> 
> SBC Decoder LIB Version 1.5
> Copyright (c) 2002  Philips Consumer Electronics, ASA Labs
> 
> Usage:
> sbc_decoder [-v] [-ooutputfile] [-pstartpos] inputfile
>             [-v] verbose mode
>             [-pstartpos] startpos specifies the byte offset to start with decoding
>             [-ooutputfile] specifies the name of the audio output file
>             inputfile specifies the name of the bitstream input file
> 
> And the sample files are all from 2001. We might have to create our own
> ones and our own naive and stupid reference encoder/decoder.

Hi Marcel,

As the first step, some sort of automated testing ("make check") for
verifying sbc encoding/decoding correctness might be useful.

So far I have been using the following quickly hacked script. It just
takes a directory with *.au files, encodes them using different
settings and provides a log with md5 hashes which can be compared with
the reference log:

#!/usr/bin/env ruby

testfiles = []
Dir.new("testsamples").each {|file|
    next if not file =~ /\.au$/
    testfiles.push("testsamples/" + file)
}

if File.exists?("sbc-test.ok") then
    fh = File.open("sbc-test.ok", "r")
    okdata = fh.read()
    fh.close()
end

outstring = ""

testfiles.sort!

testfiles.each {|file|

    ["-b32", "-b64", "-b128", "-b255"].each {|br|
    ["-s4", "-s8"].each {|sb|
    ["-S", ""].each {|snr|
    ["-j", ""].each {|j|
    ["-d", ""].each {|d|
    ["-B4", "-B8", "-B12", "-B16"].each {|blk|
        outstring += sprintf("%s #{file} (#{br} #{sb} #{snr} #{j} #{d} #{blk})\n",
            `./sbcenc #{br} #{sb} #{snr} #{j} #{d} #{blk} #{file} 2>/dev/null | md5sum`.strip).gsub(/[ ]+/, " ")
    }
    }
    }
    }
    }
    }
}

if not okdata then
    printf("no reference ok data\n")
end

if outstring != okdata then
    printf("test failed!\n")
else
    printf("test ok\n")
end

fh = File.open("sbc-test.results", "w")
fh.write(outstring)
fh.close()

############################

Though I see this scripts as a dead end, because my media files are a
bit too large for adding to a git repository and these files are
all copyrighted. Some of them have a permissive license (big buck
bunny soundtrack), some of them do not.

Anyway, based on the fact that we use a fixed point encoder for sbc and
its output is deterministic, we can just encode some pseudo random noise
data and compare the checksums/hashes of the encoded results with some
reference values.

-- 
Best regards,
Siarhei Siamashka

Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: Testing SBC filtering functions
Date: Mon, 29 Dec 2008 16:36:15 +0200
Cc: hoene@uni-tuebingen.de, "'ext Brad Midgley'" <bmidgley@gmail.com>,
        "'Jaska Uimonen'" <jaska.uimonen@nokia.com>,
        linux-bluetooth@vger.kernel.org
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com> <200812291306.02281.siarhei.siamashka@nokia.com> <1230552269.15666.11.camel@californication>
In-Reply-To: <1230552269.15666.11.camel@californication>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gBOWJuQRiRM9Vr9"
Message-Id: <200812291636.16207.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_gBOWJuQRiRM9Vr9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 29 December 2008 14:04:29 ext Marcel Holtmann wrote:
> Hi Siarhei,
> 
> > > I wrote this script to make some tests on the SBC decoder and encoder using
> > > the recommended testing procedure with the reference bitstreams, the
> > > reference codec and PEAQ. 
> > > http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/
> > > I got little bit confused with all the latest patches and whether they are
> > > included or not. Just send me an email on which patch you like to have
> > > tested. Running the tests just takes half an hour; me to answer my emails
> > > maybe a bit longer.
> > 
> > Please try the following patch (apply it to the latest git):
> > http://marc.info/?l=linux-bluetooth&m=123054787830678&w=2
> > 
> > You can try the patch "as is", and also with SBC_HIGH_PRECISION define
> > uncommented. High precision mode is naturally more likely to pass the
> > conformance tests.
> > 
> > I used my own script for testing with 'tiny_psnr' tool for comparing original file
> > before encoding and the final decoded result (it measures standard deviation
> > and PSNR). It would be interesting to see how our results correlate.
> 
> can you open source tiny_psnr an we merge it into the BlueZ source?

It is already open source. This very simple tool is used in ffmpeg project
regression tests (and is part of ffmpeg distribution). It does not do
anything extraordinary, but just analyzes the difference between several
audio files and gets standard deviation and PSNR statistics. I just did not
feel like reinventing the wheel and used it for estimating quality :)

I only use the following patch on top of it (it can do automatic shift detection):
http://article.gmane.org/gmane.comp.video.ffmpeg.devel/74597
I find this patch quite useful (especially as it turns out for SBC), but ffmpeg
developers do not think so...

A crude ruby script (sorry, I don't speak shell scripting language) is attached.
I have been using it for testing audio quality.

For example, here is the test of a high precision sbcenc build (bitpool=255):

./sbc_encode_test.rb BigBuckBunny-stereo.flac
[2, 48000]
["-j -S -s8 -B16 -b255", "-j -l16 -n8 -r1569000"]
--- comparing original / sbcenc + sbcdec ---
stddev:  108.67 PSNR: 55.60 bytes:114519261/114520000

--- comparing original / sbcenc + sbc_decoder.exe ---
stddev:    1.09 PSNR: 95.56 bytes:114519260/114520000

--- comparing original / sbc_encoder.exe + sbc_decoder.exe ---
stddev:    1.09 PSNR: 95.56 bytes:114519260/114520000

--- comparing sbcenc + sbc_decoder.exe / sbc_encoder.exe + sbc_decoder.exe
stddev:    0.01 PSNR:130.99 bytes:114519552/114519552

Test of a standard sbcenc build (bitpool=255):

./sbc_encode_test.rb BigBuckBunny-stereo.flac
[2, 48000]
["-j -S -s8 -B16 -b255", "-j -l16 -n8 -r1569000"]
--- comparing original / sbcenc + sbcdec ---
stddev:  108.71 PSNR: 55.59 bytes:114519261/114520000

--- comparing original / sbcenc + sbc_decoder.exe ---
stddev:    2.07 PSNR: 89.98 bytes:114519260/114520000

--- comparing original / sbc_encoder.exe + sbc_decoder.exe ---
stddev:    1.09 PSNR: 95.56 bytes:114519260/114520000

--- comparing sbcenc + sbc_decoder.exe / sbc_encoder.exe + sbc_decoder.exe
stddev:    1.77 PSNR: 91.34 bytes:114519552/114519552

Having high bitrate is useful for detecting bugs in analysis filter because
its contribution to quality loss is more visible in this configuration and
other factors play lesser role.

I tested a lot of various files and settings configurations. According to this
script, the quality of high precision sbcenc build matches the quality of
reference encoder pretty well. Standard 16-bit fixed point sbcenc build
introduces a very minor quality loss, noticeable only at extremely high
bitrates.

By the way, 'sbcdec' seems to introduce quite a noticeable distortion and
is orders of magnitude less precise than the encoder.

Of course it would be intertesting to see if the quality estimation done by
using tiny_psnr is adequate and if it can replace a 6000 EUR tool for this
particular purpose.


Best regards,
Siarhei Siamashka

--Boundary-00=_gBOWJuQRiRM9Vr9
Content-Type: application/x-ruby;
  name="sbc_encode_test.rb"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="sbc_encode_test.rb"

#!/usr/bin/env ruby

# encoding settings
$nrof_subbands = 8
$nrof_blocks = 16
$sbc_join = 1
$bitpool = 255

if not ARGV[0]
    printf("Please provide a source audio file in the command line\n")
    exit(1)
end

# FIXME: properly escape file name
def get_file_info(filename)
    x = `sox -V #{filename} -n 2>&1`
    channels = nil
    if x =~ /^Channels       : (\d+)$/ then
        channels = $1.to_i
    end
    samplerate = nil
    if x =~ /^Sample Rate    : (\d+)$/ then
        samplerate = $1.to_i
    end
    if not channels then error("sss") end
    return [channels, samplerate]
end

def get_recommended_hq_encode_cmdline(filename)
    fileinfo = get_file_info(filename)
    p fileinfo
    nrof_channels = fileinfo[0]
    fs = fileinfo[1]

    bitpool_limit = nrof_channels * 16 * $nrof_subbands
    bitpool_limit = 255 if bitpool_limit > 255
    $bitpool = bitpool_limit if $bitpool > bitpool_limit

    frame_length = 4 + (4 * $nrof_subbands * nrof_channels) / 8
    if nrof_channels == 1 then
        frame_length += $nrof_blocks * nrof_channels * $bitpool / 8
    else
        frame_length += ($sbc_join * $nrof_subbands + $nrof_blocks * $bitpool) / 8
    end
    bit_rate = 8 * frame_length * fs / $nrof_subbands / $nrof_blocks
    if nrof_channels == 1 then
        return ["-S -s#{$nrof_subbands} -B#{$nrof_blocks} -b#{$bitpool}",
                "-l#{$nrof_blocks} -n#{$nrof_subbands} -r#{bit_rate}"]
    elsif $sbc_join == 1 then
        return ["-j -S -s#{$nrof_subbands} -B#{$nrof_blocks} -b#{$bitpool}",
                "-j -l#{$nrof_blocks} -n#{$nrof_subbands} -r#{bit_rate}"]
    else
        return ["-S -s#{$nrof_subbands} -B#{$nrof_blocks} -b#{$bitpool}",
                "-l#{$nrof_blocks} -n#{$nrof_subbands} -r#{bit_rate}"]
    end
end

x = get_recommended_hq_encode_cmdline(ARGV[0])
p x
`sox #{ARGV[0]} --endian big -s -2 -t au tmp.au`
`sox #{ARGV[0]} --endian little -s -2 -t wav tmp.wav`
`./sbcenc #{x[0]} tmp.au > tmp_sbcenc.sbc`
`wine ./sbc_encoder.exe #{x[1]} -otmp_ref.sbc tmp.wav 2> /dev/null`

`./sbcdec -f tmp_sbcdec.wav tmp_sbcenc.sbc`
`wine ./sbc_decoder.exe -otmp_ref.wav tmp_ref.sbc 2> /dev/null`
`wine ./sbc_decoder.exe -otmp_sbcenc.wav tmp_sbcenc.sbc  2> /dev/null`
printf("--- comparing original / sbcenc + sbcdec ---\n%s\n", `./tiny_psnr tmp_sbcdec.wav tmp.wav 2 - 44 | grep stddev`)
printf("--- comparing original / sbcenc + sbc_decoder.exe ---\n%s\n", `./tiny_psnr tmp_sbcenc.wav tmp.wav 2 - 44 | grep stddev`)
printf("--- comparing original / sbc_encoder.exe + sbc_decoder.exe ---\n%s\n", `./tiny_psnr tmp_ref.wav tmp.wav 2 - 44 | grep stddev`)
printf("--- comparing sbcenc + sbc_decoder.exe / sbc_encoder.exe + sbc_decoder.exe\n%s\n", `./tiny_psnr tmp_sbcenc.wav tmp_ref.wav 2 - 44 | grep stddev`)

--Boundary-00=_gBOWJuQRiRM9Vr9--

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
	<CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
Date: Tue, 18 Oct 2011 12:26:42 +0300
Message-ID: <CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
Subject: Re: A2DP quality (bluetooth-alsa)
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: "qduaty@gmail.com" <qduaty@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=002215b039aa4fe2d404af8f526d
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--002215b039aa4fe2d404af8f526d
Content-Type: text/plain; charset=UTF-8

On Mon, Oct 10, 2011 at 10:10 PM, qduaty@gmail.com <qduaty@gmail.com> wrote:
> 2011/10/10 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
>> On Mon, Oct 10, 2011 at 1:40 PM, qduaty@gmail.com <qduaty@gmail.com> wrote:
>> Could you please provide a link to the Xiph Foundation's article you
>> have mentioned? Also what does "SBC is unable to encode such material
>> properly" mean?
>
> I remember it was their "About" article, but it seems either they
> shortened it (removing fragments irrelevant to their mission) or it
> has never been there and I've seen it somewhere else. Anyway, the
> whole phenomena is called "Loudness war". CD's are recorded with
> dynamics compression, so their sound has distortions introduced in
> production and high energy in all subbands at the same time. Thus, SBC
> must encode distortions as well as higher energy in all subbands.

Still I would suggest you to try the attached patch just for a test.
It reduces audio volume as part of the sbc encoding process and should
eliminate most of the possible clipping cases on the decoding side.
Some people on Hydrogenaudio forums have investigated the impact of
clipping on the perceived audio quality and found it at least audible:
    http://www.hydrogenaudio.org/forums/index.php?showtopic=82112
    http://en.wikipedia.org/wiki/Clipping_(audio)

>> The SBC decoder seems to be clamping the out-of-range values [...]
>> not doing any clamping is a lot worse and letting the samples
>> overflow results in really bad audible clicks.
>
> Maybe sin() would help, who knows? Obviously in the decoder, which
> usually cannot be reprogrammed, but future /bluez devices/ could
> benefit from this.

The headset is free to do whatever it likes with the samples falling
out of [-0x8000, 0x7FFF] range, like clipping them or adjusting the
volume or anything else. It does not have to produce files with 16-bit
audio samples but just needs to play some sound in the speakers.

>> What kind of A2DP headset are you using yourself?
>
> Nokia BT-503. Its quality is enough to notice an obvious difference
> between 'computer' bitpool (<=53) and that coming from Windows Mobile
> (128 does not cause skipping yet). In presence of dynamics
> compression, even two guitars with a vocal can be distinguished only
> with higher bitpool. Another example is a symphony - I can hear
> individual instruments from WinMo, and a "movie soundtrack" from
> Bluez. I don't know how the device deals with clicks, but I never
> heard them. Usual (and also annoying) distortion is a 'chirp' in some
> bands.

OK, thanks for the information. It looks like this is not the same
issue as I observed with Logitech FreePulse headset. In any case, I'm
glad that you are interested in A2DP audio quality and would
definitely appreciate any feedback and test results. As I see it,
there are two things to take care:
    1. make higher sbc bitpool settings usable in bluez with your headset
    2. make sure that sbc codec itself is well behaved and providing
the best results for any available bitpool
But I myself can only comment on the latter.

Using bitpool 128 is kind of weird for SBC codec, because the encoded
data stream has about the same size as the the original data and this
defeats the whole purpose of having any lossy compression at all. It
is also worth mentioning that bluez sbc encoder implementation uses a
bit lower precision analysis filter by default which allows SIMD
optimizations and this should be fine at normal encoding settings. But
uncommenting SBC_HIGH_PRECISION define may be important for getting
better audio quality at higher bitpool settings. Also trying to
enable/disable joint stereo, testing 4 vs. 8 subbands and snr vs.
loudness allocation method may probably have some impact on audio
quality for your use case. I still recommend you to try sbcenc/sbcdec
tools for the experiments with audio quality. They use a somewhat less
common big endian http://en.wikipedia.org/wiki/Au_file_format but you
can get your audio files converted to it using
http://sox.sourceforge.net/ command line tool. Also here I have some
ruby script, which can simplify sbc encoding/decoding testing:
    http://cgit.freedesktop.org/~siamashka/bluez/log/?h=sbc-tests

When doing the evaluation of encoding/decoding audio quality with
sbcenc/sbcdec, please keep in mind that the current bluez sbc
*decoder* implementation has some issues. Partially motivated by your
posts, I decided to finally attempt to bring the bluez sbc decoder
into a better shape and already sent one patch to the mailing list for
review. The rest of the fixes are available here and they improve sbc
decoder audio quality:
    http://cgit.freedesktop.org/~siamashka/bluez/log/?h=sbc-decoder-fixes
But the synthesis filter still needs to be converted to fixed point
and optimized for performance before really using it in bluez. I'll
try to do this work as time permits and will submit the patches later.
But quality-wise, it should be already possible to use my
'sbc-decoder-fixes' git branch for testing.

-- 
Best regards,
Siarhei Siamashka

--002215b039aa4fe2d404af8f526d
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-HACK-sbc-reduce-volume-in-sbc-encoder.patch"
Content-Disposition: attachment;
	filename="0001-HACK-sbc-reduce-volume-in-sbc-encoder.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gtw7pg1h0

RnJvbSAxMjNhMDIxMzc2YTRmZDY2Yzg4ZmMxZWQ2Y2EyNmE2ZThlZTVlMzY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaWFyaGVpIFNpYW1hc2hrYSA8c2lhcmhlaS5zaWFtYXNoa2FA
bm9raWEuY29tPgpEYXRlOiBUdWUsIDE4IE9jdCAyMDExIDA0OjA4OjA3ICswMzAwClN1YmplY3Q6
IFtQQVRDSF0gSEFDSzogc2JjOiByZWR1Y2Ugdm9sdW1lIGluIHNiYyBlbmNvZGVyCgpSZWR1Y2lu
ZyBhdWRpbyB2b2x1bWUgd2hlbiBlbmNvZGluZyBoZWxwcyB0byBhdm9pZCBjbGlwcGluZwppbiB0
aGUgZGVjb2RlciBmb3IgdGhlIGhlYXZpbHkgZHluYW1pY2FsbHkgY29tcHJlc3NlZCBhdWRpby4K
QWxzbyBoaWdoIHByZWNpc2lvbiBtb2RlIGlzIGVuYWJsZWQgaW4gc2JjIGVuY29kZXIgdG8gZ2V0
IHRoZQpiZXN0IHBvc3NpYmxlIGF1ZGlvIHF1YWxpdHkuCgpTb21lIHJlZmVyZW5jZXM6CiAgICBo
dHRwOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0xvdWRuZXNzX3dhcgogICAgaHR0cDovL3d3dy5o
eWRyb2dlbmF1ZGlvLm9yZy9mb3J1bXMvaW5kZXgucGhwP3Nob3d0b3BpYz04MjExMgotLS0KIHNi
Yy9zYmNfdGFibGVzLmggfCAgICA2ICsrKy0tLQogMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2JjL3NiY190YWJsZXMuaCBiL3Ni
Yy9zYmNfdGFibGVzLmgKaW5kZXggMjhjMGQ1NC4uOGQwMjVlMCAxMDA2NDQKLS0tIGEvc2JjL3Ni
Y190YWJsZXMuaAorKysgYi9zYmMvc2JjX3RhYmxlcy5oCkBAIC0xMzYsNyArMTM2LDcgQEAgc3Rh
dGljIGNvbnN0IGludDMyX3Qgc3lubWF0cml4OFsxNl1bOF0gPSB7CiAKIC8qIFVuY29tbWVudCB0
aGUgZm9sbG93aW5nIGxpbmUgdG8gZW5hYmxlIGhpZ2ggcHJlY2lzaW9uIGJ1aWxkIG9mIFNCQyBl
bmNvZGVyICovCiAKLS8qICNkZWZpbmUgU0JDX0hJR0hfUFJFQ0lTSU9OICovCisjZGVmaW5lIFNC
Q19ISUdIX1BSRUNJU0lPTgogCiAjaWZkZWYgU0JDX0hJR0hfUFJFQ0lTSU9OCiAjZGVmaW5lIEZJ
WEVEX0EgaW50NjRfdCAvKiBkYXRhIHR5cGUgZm9yIGZpeGVkIHBvaW50IGFjY3VtdWxhdG9yICov
CkBAIC0yMDgsNyArMjA4LDcgQEAgc3RhdGljIGNvbnN0IEZJWEVEX1QgX3NiY19wcm90b19maXhl
ZDRbNDBdID0gewogICovCiAjZGVmaW5lIFNCQ19DT1NfVEFCTEVfRklYRUQ0X1NDQUxFIFwKIAko
KHNpemVvZihGSVhFRF9UKSAqIENIQVJfQklUIC0gMSkgKyBTQkNfRklYRURfRVhUUkFfQklUUykK
LSNkZWZpbmUgRl9DT1M0KHgpIChGSVhFRF9BKSAoKHgpICogXAorI2RlZmluZSBGX0NPUzQoeCkg
KEZJWEVEX0EpICgoeCAqIDAuNykgKiBcCiAJKChGSVhFRF9BKSAxIDw8IChzaXplb2YoRklYRURf
VCkgKiBDSEFSX0JJVCAtIDEpKSArIDAuNSkKICNkZWZpbmUgRih4KSBGX0NPUzQoeCkKIHN0YXRp
YyBjb25zdCBGSVhFRF9UIGNvc190YWJsZV9maXhlZF80WzMyXSA9IHsKQEAgLTMwNSw3ICszMDUs
NyBAQCBzdGF0aWMgY29uc3QgRklYRURfVCBfc2JjX3Byb3RvX2ZpeGVkOFs4MF0gPSB7CiAgKi8K
ICNkZWZpbmUgU0JDX0NPU19UQUJMRV9GSVhFRDhfU0NBTEUgXAogCSgoc2l6ZW9mKEZJWEVEX1Qp
ICogQ0hBUl9CSVQgLSAxKSArIFNCQ19GSVhFRF9FWFRSQV9CSVRTKQotI2RlZmluZSBGX0NPUzgo
eCkgKEZJWEVEX0EpICgoeCkgKiBcCisjZGVmaW5lIEZfQ09TOCh4KSAoRklYRURfQSkgKCh4ICog
MC43KSAqIFwKIAkoKEZJWEVEX0EpIDEgPDwgKHNpemVvZihGSVhFRF9UKSAqIENIQVJfQklUIC0g
MSkpICsgMC41KQogI2RlZmluZSBGKHgpIEZfQ09TOCh4KQogc3RhdGljIGNvbnN0IEZJWEVEX1Qg
Y29zX3RhYmxlX2ZpeGVkXzhbMTI4XSA9IHsKLS0gCjEuNy4zLjQKCg==
--002215b039aa4fe2d404af8f526d--

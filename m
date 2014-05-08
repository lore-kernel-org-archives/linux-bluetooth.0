Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140508193609.GA13996@t440s.P-661HNU-F1>
References: <20140506004501.318D810193E@puck.mtv.corp.google.com>
	<20140508073646.GA14385@t440s.lan>
	<CAGXr9JFAcMES1c2oPUx+gtEZaowoOea5UFp0hFR2ROBsjRkRrw@mail.gmail.com>
	<20140508193609.GA13996@t440s.P-661HNU-F1>
Date: Thu, 8 May 2014 12:42:56 -0700
Message-ID: <CAGXr9JEGyXC903ghhc-hqUUT0m5BS2QucpcZUO-Ypx9fNwEiVg@mail.gmail.com>
Subject: Re: [PATCH] input: Add userspace HID support
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, May 8, 2014 at 12:36 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Petri,
>
> On Thu, May 08, 2014, Petri Gynther wrote:
>> On Thu, May 8, 2014 at 12:36 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> > Hi Petri,
>> >
>> > On Mon, May 05, 2014, Petri Gynther wrote:
>> >> Enable HID protocol handling in userspace when UserspaceHID=true in input.conf.
>> >>
>> >> Benefits of userspace HID:
>> >> 1. Persistent HID/input pipeline
>> >>    For a Bluetooth HID device, the corresponding kernel HID/input devices are
>> >>    created only once when the Bluetooth HID device is used the first time.
>> >>    The HID/input pipeline is not destroyed and recreated every time when
>> >>    the Bluetooth HID device disconnects and reconnects.
>> >>
>> >> 2. HID vs HoG parity
>> >>    Enables HID and HoG devices to operate the same way in BlueZ stack, using
>> >>    uHID kernel module (/dev/uhid) to pass HID report data between bluetoothd
>> >>    and kernel HID subsystem.
>> >>
>> >> 3. Debugging
>> >>    It is easier to debug HID protocol in userspace than in HIDP kernel module.
>> >> ---
>> >>  Makefile.plugins           |   3 +-
>> >>  profiles/input/device.c    | 674 +++++++++++++++++++++++++++++++++++++++++++--
>> >>  profiles/input/device.h    |   1 +
>> >>  profiles/input/hidp_defs.h |  79 ++++++
>> >>  profiles/input/input.conf  |   4 +
>> >>  profiles/input/manager.c   |  10 +
>> >>  6 files changed, 754 insertions(+), 17 deletions(-)
>> >>  create mode 100644 profiles/input/hidp_defs.h
>> >
>> > Considering that we're using uhid also for the Android HID solution
>> > (see android/hidhost.c) is there an opportunity here to avoid code
>> > duplication by sharing some code? I'm not saying that this must be done
>> > before we apply your patch, but if code sharing is possible it'd be good
>> > to try to refactor common parts into src/shared/hid.c or similar.
>> >
>> > Johan
>>
>> I think Marcel also mentioned this earlier. I can certainly look into
>> refactoring, but I'd prefer to do that after this patch is applied, so
>> we have a working userspace HID solution as a baseline.
>
> Fair enough. I was just about to apply your patch, but it has actually
> some compiler warnings/errors that need fixing:
>
>   CC       profiles/input/bluetoothd-device.o
> profiles/input/device.c: In function ‘hidp_send_message’:
> profiles/input/device.c:175:10: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
>   if (len < size) {
>           ^
> profiles/input/device.c: In function ‘uhid_send_feature_answer’:
> profiles/input/device.c:230:10: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
>   if (len < sizeof(ev)) {
>           ^
> profiles/input/device.c: In function ‘uhid_send_input_report’:
> profiles/input/device.c:272:10: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
>   if (len < sizeof(ev)) {
>           ^
> profiles/input/device.c: In function ‘uhid_watch_cb’:
> profiles/input/device.c:683:10: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
>   if (len < sizeof(ev.type)) {
>           ^
> cc1: all warnings being treated as errors
> make[1]: *** [profiles/input/bluetoothd-device.o] Error 1
> make: *** [all] Error 2
>
> Please always use ./bootstrap-configure && make or at least
> --enable-maintainer-mode to catch as many issues as possible. For the
> record, my gcc version is "gcc (GCC) 4.8.2 20131212 (Red Hat 4.8.2-7)"
> from Fedora 20.
>
> This particular error is a bit silly since you do have the correct type
> for the read/write return parameter, but you'll simply need to do an
> explicit type cast into size_t in the comparison.
>
> Johan

I didn't see these errors with my compiler (Ubuntu 12.04 LTS): gcc
(Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3

I will fix now and send a new patch shortly.

-- Petri

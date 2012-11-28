Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANq1E4Thu4XWHATv2BiA7m0Nppi92JdeGtLfCj35tr9g6RSw3A@mail.gmail.com>
References: <1350894680-3947-1-git-send-email-dh.herrmann@googlemail.com>
 <20121128125041.GA995@x220.ger.corp.intel.com> <CANq1E4Thu4XWHATv2BiA7m0Nppi92JdeGtLfCj35tr9g6RSw3A@mail.gmail.com>
From: Peter Olson <peter.olson@gmail.com>
Date: Wed, 28 Nov 2012 10:03:26 -0800
Message-ID: <CAEfj2kAzcnZR525A+k8Q-95BGu1Bk3CFSq4eG=j27zBvtcMENg@mail.gmail.com>
Subject: Re: [PATCH bluez] wiimote: add Wii-Remote-Plus ID and name detection
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Apologies, the testing as a whole is not yet complete as I have some
issues still. However, the bluez portion of the fixes David was making
so seem to work properly. Before the patch I would have to use blueman
to force a connection without a paring code, after the patch the
bluetooth recognizes the device automatically and prompts for
accepting the connection. My remaining issues lie with getting some
userspace tools to recognize the wiimote, not with the bluez.

Peter

On Wed, Nov 28, 2012 at 5:00 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Johan
>
> On Wed, Nov 28, 2012 at 1:50 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi David,
>>
>> On Mon, Oct 22, 2012, David Herrmann wrote:
>>> The Nintendo Wii Remote Plus uses a new product ID and name. To detect
>>> them properly, we need to add them to the wiimote-module.
>>>
>>> To avoid an overlong "if" statement, this converts the match-function to
>>> walk over an array and check all VID/PID pairs and device-names. This
>>> makes adding new devices much easier.
>>> ---
>>> Hi Johan
>>>
>>> I am actually not sure why Nintendo changed the VID/PID for the new revisions of
>>> the WiimotePlus. I have a WiimotePlus which still uses the old numbers and works
>>> here quite well. However, I have now got multiple requests from people with the
>>> new device name and IDs. Unfortunately, I cannot test these so I'd like to have
>>> a "Tested-by" by Peter (CC'ed) before this is applied.
>>>
>>> Thanks
>>> David
>>>
>>>  plugins/wiimote.c | 35 ++++++++++++++++++++++++++++-------
>>>  1 file changed, 28 insertions(+), 7 deletions(-)
>>
>> Well, the Tested-by never came, but since the patch looks ok to me I
>> went ahead and applied it anyway (with a minor fix to use G_N_ELEMENTS()
>> instead of your custom array length calculation).
>
> Sorry for the long delay. But I don't have the device so it sometimes
> takes a bit longer. Anyway, it doesn't do any harm if we apply it so
> yes, thanks for not forgetting about it.
>
> Cheers
> David

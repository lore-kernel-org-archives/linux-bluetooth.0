Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121128125041.GA995@x220.ger.corp.intel.com>
References: <1350894680-3947-1-git-send-email-dh.herrmann@googlemail.com>
	<20121128125041.GA995@x220.ger.corp.intel.com>
Date: Wed, 28 Nov 2012 14:00:24 +0100
Message-ID: <CANq1E4Thu4XWHATv2BiA7m0Nppi92JdeGtLfCj35tr9g6RSw3A@mail.gmail.com>
Subject: Re: [PATCH bluez] wiimote: add Wii-Remote-Plus ID and name detection
From: David Herrmann <dh.herrmann@googlemail.com>
To: David Herrmann <dh.herrmann@googlemail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Peter Olson <peter.olson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

On Wed, Nov 28, 2012 at 1:50 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi David,
>
> On Mon, Oct 22, 2012, David Herrmann wrote:
>> The Nintendo Wii Remote Plus uses a new product ID and name. To detect
>> them properly, we need to add them to the wiimote-module.
>>
>> To avoid an overlong "if" statement, this converts the match-function to
>> walk over an array and check all VID/PID pairs and device-names. This
>> makes adding new devices much easier.
>> ---
>> Hi Johan
>>
>> I am actually not sure why Nintendo changed the VID/PID for the new revisions of
>> the WiimotePlus. I have a WiimotePlus which still uses the old numbers and works
>> here quite well. However, I have now got multiple requests from people with the
>> new device name and IDs. Unfortunately, I cannot test these so I'd like to have
>> a "Tested-by" by Peter (CC'ed) before this is applied.
>>
>> Thanks
>> David
>>
>>  plugins/wiimote.c | 35 ++++++++++++++++++++++++++++-------
>>  1 file changed, 28 insertions(+), 7 deletions(-)
>
> Well, the Tested-by never came, but since the patch looks ok to me I
> went ahead and applied it anyway (with a minor fix to use G_N_ELEMENTS()
> instead of your custom array length calculation).

Sorry for the long delay. But I don't have the device so it sometimes
takes a bit longer. Anyway, it doesn't do any harm if we apply it so
yes, thanks for not forgetting about it.

Cheers
David

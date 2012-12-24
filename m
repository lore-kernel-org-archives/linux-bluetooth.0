Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1356194344.29264.16.camel@aeonflux>
References: <1356097469-24073-1-git-send-email-s.syam@samsung.com>
	<20121221193112.GA31432@x220.ger.corp.intel.com>
	<1356194344.29264.16.camel@aeonflux>
Date: Mon, 24 Dec 2012 17:16:15 +0530
Message-ID: <CAFBvHieL1n6ZHe2+475KLFRAVO7-nJXPz1c8tJu2MHg_+KvX6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Fix to update EIR for uuid16 properly
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Syam Sidhardhan <s.syam@samsung.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Johan,

On Sat, Dec 22, 2012 at 10:09 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
>> > If we register a uuid other than uuid16, especially custom 128 bit uuid
>> > then nothing is updated in the EIR and it was broken.
>> >
>> > After registering a 16 bit uuid. ex: "sdptool add SP", we can see the
>> > uuid in the EIR as below.
>> > < 0000: 01 52 0c f1 00 08 09 52  65 64 77 6f 6f 64 15 03  .R.....Redwood..
>> >   0010: 01 11 32 11 2f 11 06 11  05 11 0a 11 0e 11 0c 11  ..2./...........
>> >   0020: 1f 11 12 11 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00f0: 00 00 00 00 00                                    .....
>> > > 0000: 04 0e 04 01 52 0c 00                              ....R..
>> >
>> > But after register a user defined 128 bit uuid, nothing is
>> > updated in the EIR.
>> >
>> > < 0000: 01 52 0c f1 00 08 09 52  65 64 77 6f 6f 64 00 00  .R.....Redwood..
>> >   0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
>> >   00f0: 00 00 00 00 00                                    .....
>> > > 0000: 04 0e 04 01 52 0c 00                              ....R..
>> >
>> > With this fix, we can see the EIR is updated properly.
>> >
>> > Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
>> > ---
>> >  net/bluetooth/mgmt.c |    2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> > index f559b96..512a3f5 100644
>> > --- a/net/bluetooth/mgmt.c
>> > +++ b/net/bluetooth/mgmt.c
>> > @@ -514,8 +514,6 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
>> >             u16 uuid16;
>> >
>> >             uuid16 = get_uuid16(uuid->uuid);
>> > -           if (uuid16 == 0)
>> > -                   return;
>> >
>> >             if (uuid16 < 0x1100)
>> >                     continue;
>>
>> Nak. The bug is real and should be fixed but your fix is wrong. The
>> right fix it to convert this return statement into a continue statement
>> since we do still want to check for a 0 return value from get_uuid16.
>>

Since the next statements (uuid16 < 0x1100) indirectly do this logic,
I intentionally removed it in order to avoid duplication.
Probably for more clarity and readability, I can do it as per your
suggestion.

>> Along with this patch please prepare another one to increment the mgmt
>> revision. These two should go together to upstream trees so that we can
>> introduce a check in user space to know whether it's safe to pass
>> non-16bit UUIDs to the kernel or not.
>
Ok.
> I want a fix that introduces also support for 32-bit and 128-bit UUIDs
> now. No paper over the hole fixing here.
>

As per the specification, "To reduce interference, the host should try
to minimize the amount of EIR data such that the baseband can use
a 1-slot or 3-slot EIR packet. This is advantageous because it reduces
interference and maximizes the probability that the EIR packet will be
received."

Does the addition of 128-bit and 32-bit uuid decreases the probability of the
reception of EIR packet, if any application register more of these types?

Regards,
Syam

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121023212637.GA17404@x220.ger.corp.intel.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	<1351011241-32515-5-git-send-email-johan.hedberg@gmail.com>
	<CAJdJm_MhB79eQSAHUqOa7Xwf+ujrnQZtG_jqEgMfEFzuoqB9-w@mail.gmail.com>
	<20121023212637.GA17404@x220.ger.corp.intel.com>
Date: Wed, 24 Oct 2012 20:00:56 -0400
Message-ID: <CAJdJm_M8TWo9_SDW1anX8hUyTiyEL=utDr=kTnWuxJhJ5NcE-A@mail.gmail.com>
Subject: Re: [PATCH 4/7] Bluetooth: Add support for setting LE advertising data
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Oct 23, 2012 at 5:26 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Tue, Oct 23, 2012, Anderson Lizardo wrote:
>> On Tue, Oct 23, 2012 at 12:53 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> > +       if (hdev->adv_tx_power) {
>> > +               ptr[0] = 2;
>> > +               ptr[1] = EIR_TX_POWER;
>> > +               ptr[2] = (u8) hdev->adv_tx_power;
>> > +
>> > +               ad_len += 3;
>> > +               ptr += 3;
>> > +       }
>>
>> 0dBm is a valid TX power. Not sure the if() clause is valid here.
>
> If it's not, we'd need to extend the storage size of hdev->adv_tx_power
> (to have some invalid value) or add another variable to hdev to indicate
> that we know the tx_power. FWIW, create_eir also uses the same test for
> including the inq_tx_power, so either both or neither should be fixed.
> For simplicity I'd just keep the 0-test unless 0 is a really common
> value.

0dBm is right in the middle of the valid range for BR/EDR. From "7.5.4
Read RSSI Command" (page 934):

BR/EDR
Range: -128 <= N <= 127 (signed integer)
Units: dBm
...
LE:
Range: -127 to 20, 127 (signed integer)
Units: dBm

>From "7.8.6 LE Read Advertising Channel Tx Power Command" (page 1061):

Range: -20 <= N <= 10

and from "7.3.35 Read Transmit Power Level Command" (page 857):

Range: -30 <= N <= 20
Units: dBm

IIRC, TI based LE controllers I tested for Proximity used to have 0dBm
TX power for active connections (as measured using Read Transmit Power
Level Command or TX Power GATT characteristic). It's not uncommon,
IMHO.

My suggestion would be to have a separate boolean for checking if
Advertising/Inquiry TX Power was read. I suppose this is not critical
as this information is not mandatory on Advertising Data anyway (at
least LE Proximity profile uses the connection specific TX power, not
advertising TX Power).

>> Also, I'm worried how we are going to put other advertising data here,
>> i.e. Manufacturer Specific data or Service Data. On last BlueZ meeting
>> we proposed (and have been implementing) the Set Controller Data mgmt
>> command to set them. Is this still an acceptable approach?
>
> Yes, though we only have 31 bytes to play with here which is quite
> little. Also, we might want to make this dependent on the LE GAP role.
> E.g. we might be more interested in manufacturer specific data for
> broadcaster role than for peripheral role (maybe a user space
> application *only* wants its data for broadcaster role).

I agree, but If I understand correctly, it will be BlueZ's
responsibility to enable/disable Broadcaster/Observer modes depending
on whether there is any active application registered over D-Bus.

>
> Johan

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

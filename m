Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 10 May 2018 21:31:28 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
 hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990.
In-Reply-To: <20180509172425.GH19594@google.com>
References: <1525448106-18616-1-git-send-email-bgodavar@codeaurora.org>
 <1525448106-18616-3-git-send-email-bgodavar@codeaurora.org>
 <20180505011713.GE19594@google.com>
 <595e02f711f40a104ed86b7eb06b28d7@codeaurora.org>
 <20180509172425.GH19594@google.com>
Message-ID: <932e28f7f38f64f2f1a5aded07806185@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-05-09 22:54, Matthias Kaehlcke wrote:
> Hi Balakrishna,
> 
> On Wed, May 09, 2018 at 03:37:34PM +0530, Balakrishna Godavarthi wrote:
>> Hi,
>> Please find my comments inline.
>> 
>> On 2018-05-05 06:47, Matthias Kaehlcke wrote:
>> > Hi,
>> >
>> > On Fri, May 04, 2018 at 09:05:05PM +0530, Balakrishna Godavarthi wrote:
>> > > Add support to set voltage/current of various regulators
>> > > to power up/down Bluetooth chip wcn3990.
>> > > Add support to read baudrate from dts.
>> > >
>> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> > > ---
>> > >  drivers/bluetooth/hci_qca.c | 555
>> > > ++++++++++++++++++++++++++++++++++++++------
>> > >  1 file changed, 483 insertions(+), 72 deletions(-)
>> > >
>> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> > > index f05382b..075fab7 100644
>> > > --- a/drivers/bluetooth/hci_qca.c
>> > > +++ b/drivers/bluetooth/hci_qca.c
>> > > ...
>> > > -	bt_dev_info(hdev, "ROME setup");
>> > > +		/* disable flow control, as chip is still not turned on */
>> > > +		hci_uart_set_flow_control(hu, true);
>> >
>> > The interface of this function is confusing. enable = true disables
>> > flow control ... Not the fault of this driver though :)
>> [Bala]: yes it is bit confusing. i taught to update.. but not sure of
>> impact.
>>         so instead of updating, using the same function and written a
>> comment above.
> 
> Sure, not much you can do about it. Just mentioned it since I was
> about to comment that things are done inversely, but tean checked
> hci_uart_set_flow_control() and saw that it has this odd
> interface. Folks more familiar with the Bluetooth subsystem are
> probably already used to it ;-)
> 
>> > > -	if (speed)
>> > > -		host_set_baudrate(hu, speed);
>> > > +		/* Enable flow control */
>> > > +		hci_uart_set_flow_control(hu, false);
>> > > +		/*  wait until flow control settled */
>> > > +		mdelay(100);
>> >
>> > A busy wait of 100ms doesn't seem a good idea. Use msleep()
>> > instead. Is it really necessary to wait that long?
>> [Bala]: yes this delay is required for BT Soc to bootup and settle 
>> down.
> 
> :(
> 
>> > What follows looks similar to the Cherokee path. I didn't look at all
>> > the details, but it's probably possible to share some more code.
>> [Bala]: yes these are two different chip.
>>         we also have difference in setup. the follwing are major 
>> differences
>>         Cherokee uses flow control. where ROME flow control is 
>> disabled.
>>         ON sequence also varies.
> 
> Ok, I'll give it another pass in the next revision to see if I have
> suggestions to make it at least a bit less redundant.
> 
>> > > +static const struct btqca_vreg_data cherokee_data = {
>> > > +	.soc_type = BTQCA_CHEROKEE,
>> > > +	.vregs = (struct btqca_vreg []) {
>> > > +		{ "vddio",   1352000, 1352000,  0 },
>> > > +		{ "vddxtal", 1904000, 2040000,  0 },
>> > > +		{ "vddcore", 1800000, 1800000,  1 },
>> > > +		{ "vddpa",   130400,  1304000,  1 },
>> >
>> > 0 missing for min_v?
>> 
>> [Bala]: min_v is  the minimum voltage required for BT chip.
> 
> I referred to the value '130400', which happens to be exactly 1/10 of
> the max_v '1304000', so I suspect the voltages are the same and a zero
> is missing.
> 
[Bala]: Good catch, the same regulator is used for WLAN too. that could 
be reason i could not able to catch this issue during testing
         will update and retest it again.

>> > > +			regulator_set_voltage(qca->vreg_bulk[i].consumer,
>> > > +					      vregs[i].min_v,
>> > > +					      vregs[i].max_v);
>> >
>> > Check return value.
>> [Bala]: i am checking the status for regulator enable
>>         do we really require to check the status. as this same 
>> regulators
>> are used by different sub systems.
>>         we will get an error during regulator enable when voltages are 
>> not
>> settled down.
> 
> regulator_set_voltage() could fail due to requesting a voltage range
> not supported by the regulator. In this case regulator_enable() could
> still succeed, but not supply the requested voltage.
> 
[Bala]: will catch the return status.

> Thanks
> 
> Matthias

I will send the patch after testing these changes.

-- 
Regards
Balakrishna.

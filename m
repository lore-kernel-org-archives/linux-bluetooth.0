Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 29 Jun 2018 21:02:54 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
 hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
In-Reply-To: <20180626195322.GO129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-4-bgodavar@codeaurora.org>
 <20180625232057.GH129942@google.com>
 <2ed980b7cd83a87dd76b05a4bca014ce@codeaurora.org>
 <20180626195322.GO129942@google.com>
Message-ID: <aef5aa597133c47651d4e258fea41067@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-06-27 01:23, Matthias Kaehlcke wrote:
> On Tue, Jun 26, 2018 at 06:53:47AM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2018-06-26 04:50, Matthias Kaehlcke wrote:
>> > On Mon, Jun 25, 2018 at 07:10:09PM +0530, Balakrishna Godavarthi wrote:
>> > > Redefinition of qca_uart_setup will help future Qualcomm Bluetooth
>> > > SoC, to use the same function instead of duplicating the function.
>> > > Added new arguments soc_type and soc_ver to the functions.
>> > >
>> > > These arguments will help to decide type of firmware files
>> > > to be loaded into Bluetooth chip.
>> > > soc_type holds the Bluetooth chip connected to APPS processor.
>> > > soc_ver holds the Bluetooth chip version.
>> > >
>> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> > > ---
>> > > Changes in v8:
>> > >     * updated soc_type with enum.
>> > >
>> > > Changes in v7:
>> > >     * initial patch
>> > >     * redefined qca_uart_setup function to generic.
>> > > ---
>> > >  drivers/bluetooth/btqca.c   | 23 ++++++++++++-----------
>> > >  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>> > >  drivers/bluetooth/hci_qca.c |  3 ++-
>> > >  3 files changed, 25 insertions(+), 14 deletions(-)
>> > >
>> > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> > > index c5cf9cab438a..3b25be1be19c 100644
>> > > --- a/drivers/bluetooth/btqca.c
>> > > +++ b/drivers/bluetooth/btqca.c
>> > > @@ -327,9 +327,9 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev,
>> > > const bdaddr_t *bdaddr)
>> > >  }
>> > >  EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>> > >
>> > > -int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
>> > > +int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>> > > +		   enum qca_btsoc_type soc_type, u32 soc_ver)
>> > >  {
>> > > -	u32 rome_ver = 0;
>> > >  	struct rome_config config;
>> > >  	int err;
>> > >
>> > > @@ -337,19 +337,20 @@ int qca_uart_setup(struct hci_dev *hdev,
>> > > uint8_t baudrate)
>> > >
>> > >  	config.user_baud_rate = baudrate;
>> > >
>> > > -	/* Get QCA version information */
>> > > -	err = qca_read_soc_version(hdev, &rome_ver);
>> > > -	if (err < 0 || rome_ver == 0) {
>> > > -		bt_dev_err(hdev, "QCA Failed to get version %d", err);
>> > > -		return err;
>> > > +	if (!soc_ver) {
>> > > +		/* Get QCA version information */
>> > > +		err = qca_read_soc_version(hdev, &soc_ver);
>> > > +		if (err < 0 || soc_ver == 0) {
>> > > +			bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
>> > > +			return err;
>> > > +		}
>> > > +		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
>> > >  	}
>> >
>> > I thought we agreed in the discussion on "[v7,4/8] Bluetooth: btqca:
>> > Redefine qca_uart_setup() to generic function" to call
>> > qca_read_soc_version() in common code. Did I misinterpret that?
>> >
>> [Bala]: After integrating wcn3990, calling qca_read_soc_version() in
>> qca_setup()
>>         is not preferable. as we will have multiple common blocks of 
>> code in
>> qca_setup.
>>         calling function to set an operator speed is required in the 
>> both
>> the if -else blcoks
> 
> We can probably agree that there is no ideal solution, there is some
> ugliness in on way or the other. IMO the conditional
> qca_read_soc_version() in qca_uart_setup() based on the vale of
> 'soc_ver' is far worse than a small piece of redundant code.
> 
> If qca_read_soc_version() was done in qca_setup() the code could look
> something like this:
> 
> static int qca_setup(struct hci_uart *hu)
> {
> 	...
> 	if (qcadev->btsoc_type == QCA_WCN3990) {
> 		...
> 		qca_read_soc_version();
> 		ret = qca_set_speed(hu, QCA_OPER_SPEED);
>                 if (ret)
>                         return ret;
> 	} else {
> 		ret = qca_set_speed(hu, QCA_OPER_SPEED);
>                 if (ret)
>                         return ret;
>                 qca_read_soc_version();
> 	}
> 
> 	speed = qca_get_speed(hu, QCA_OPER_SPEED);
> 	qca_baudrate = qca_get_baudrate_value(speed);
> 
> 	 /* Setup patch / NVM configurations */
>         ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type, 
> soc_ver);
> 	...
> }
> 
> Yes, 'qca_set_speed(hu, QCA_OPER_SPEED)' and the error handling is
> redundant, but it's only 3 lines of trivial code in exchange for
> making qca_uart_setup() more consistent and not spreading
> the qca_read_soc_version() calls over multiple files, depending on the
> SoC version.
> 
> If you are super-convinced that the split is superior leave it as is,
> I might already be doing too much bike-shedding, and after all it
> isn't my code.
> 

[Bala]: not a problem. will update as suggested.

>> > > diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> > > index 5c9851b11838..24d6667eecf1 100644
>> > > --- a/drivers/bluetooth/btqca.h
>> > > +++ b/drivers/bluetooth/btqca.h
>> > > ...
>> > > -static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t
>> > > baudrate)
>> > > +static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t
>> > > baudrate,
>> > > +				 enum qca_btsoc_type soc_type, u32 soc_ver);
>> >
>> > Remove trailing semicolon.
>> 
>> [Bala]: i didn't get you.
> 
> Sorry, I should have left more context:
> 
>> static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>> 				 enum qca_btsoc_type soc_type, u32 soc_ver);
>> {
>> 	return -EOPNOTSUPP;
>> }
> 
> This is a function definition, not just a declaration. The semicolon
> would make it a declaration and make the compiler unhappy about a
> function body where it doesn't expect it.

[Bala]: i will update.

-- 
Regards
Balakrishna.

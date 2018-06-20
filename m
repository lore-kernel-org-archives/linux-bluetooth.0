Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 20 Jun 2018 16:23:25 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 thierry.escande@linaro.org, linux-bluetooth@vger.kernel.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 4/8] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
In-Reply-To: <20180619200338.GD169030@google.com>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-5-bgodavar@codeaurora.org>
 <20180618211942.GT88063@google.com>
 <fdd4fd89b53ba0fb85a53e4d4d33b0d5@codeaurora.org>
 <20180619200338.GD169030@google.com>
Message-ID: <f37214cb19823893f2679787139ec471@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-06-20 01:33, Matthias Kaehlcke wrote:
> On Tue, Jun 19, 2018 at 12:39:07PM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> Please find my comments inline.
>> 
>> On 2018-06-19 02:49, Matthias Kaehlcke wrote:
>> > On Sat, Jun 16, 2018 at 11:57:14AM +0530, Balakrishna Godavarthi wrote:
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
>> > >
>> > > Changes in v7:
>> > > 	* initial patch
>> > > 	* redefined qca_uart_setup function to generic.
>> > >
>> > > ---
>> > >  drivers/bluetooth/btqca.c   | 23 ++++++++++++-----------
>> > >  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>> > >  drivers/bluetooth/hci_qca.c |  3 ++-
>> > >  3 files changed, 25 insertions(+), 14 deletions(-)
>> > >
>> > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> > > index c5cf9cab438a..f748730039cf 100644
>> > > --- a/drivers/bluetooth/btqca.c
>> > > +++ b/drivers/bluetooth/btqca.c
>> > > @@ -327,9 +327,9 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev,
>> > > const bdaddr_t *bdaddr)
>> > >  }
>> > >  EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>> > >
>> > > -int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
>> > > +int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate, uint8_t
>> > > soc_type,
>> >
>> > Use 'enum qca_btsoc_type' as type for 'soc_type'.
>> >
>> 
>> [Bala]: will update.
>> 
>> > > +		   u32 soc_ver)
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
>> > > +			bt_dev_err(hdev, "QCA Failed to get version %d", err);
>> > > +			return err;
>> > > +		}
>> > > +		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
>> > >  	}
>> >
>> > Why is this needed? A caller that passes in soc_ver = 0 could just
>> > call qca_read_soc_version() themselves.
>> [Bala]: hci_qca support two chip one ROME (already up-streamed) and 
>> other
>> wcn3990.
>>         there setup sequence differs.
>> 
>>         wcn3900:
>>         1. set baudrate to 115200
>>         2. read soc version
>>         3. set baudarte to 3.2Mbps
>>         4. download firmware. (calls qca_uart_setup)
>> 
>>        ROME:
>>        1. set baudrate to 3.0 mbps
>>        2. calls qca_uart_setup to read soc version and download 
>> firmware.
>> 
>>       so to make use of existing function qca_setup_uart(). passing 
>> soc_ver
>> as argument.
>>       if soc_ver is zero, then read soc version (i.e. for ROME chip).
>> 
>>       Pls let me know, if you have any queries.
> 
> I don't really understand this argumentation. Let's look at the code
> at the end of this series, where both Rome and wcn3900 are supported:
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1045608/6/drivers/bluetooth/hci_qca.c#1059
> 
> The version could be read (for Rome only) after setting the operating 
> speed:

[Bala]: yes we can read SoC version after setting operating baud rate. 
an advice from SoC vendor that, read SoC version before setting 
operating speed.
         one advantage from reading SoC version before setting operating 
baudrate,it will helps us to understand whether the soc is responding to 
any commands in default baud rate
         before setting operating speed.
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1045608/6/drivers/bluetooth/hci_qca.c#1111
> 
> I concede that having two "if (qcadev->btsoc_type == XYZ)" branches in
> qca_setup() is kinda ugly, but I think it's still better than the
> conditional call of qca_read_soc_version() in qca_uart_setup().

[Bala]: we require an if-else block  for soc type.As wcn3900 support 
hardware flow control where as ROME is not supporting hardware flow 
control.

-- 
Regards
Balakrishna.

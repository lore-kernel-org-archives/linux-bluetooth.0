Return-Path: <mka@chromium.org>
Date: Tue, 26 Jun 2018 11:32:07 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
Message-ID: <20180626183207.GM129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-5-bgodavar@codeaurora.org>
 <20180625234354.GI129942@google.com>
 <20180626000529.GJ129942@google.com>
 <66681ee5281749e17394cab6f58083d8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <66681ee5281749e17394cab6f58083d8@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 26, 2018 at 10:43:31AM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-06-26 05:35, Matthias Kaehlcke wrote:
> > On Mon, Jun 25, 2018 at 04:43:54PM -0700, Matthias Kaehlcke wrote:
> > > This is a nice improvement, a few remaining questions inline.
> > > 
> > > On Mon, Jun 25, 2018 at 07:10:10PM +0530, Balakrishna Godavarthi
> > > wrote:
> > > > In function qca_setup, we set initial and operating speeds for Qualcomm
> > > > Bluetooth SoC's. This block of code is common across different
> > > > Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
> > > > a wrapper function to set the speeds. So that future coming SoC's
> > > > can use these wrapper functions to set speeds.
> > > >
> > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > > ---
> > > > Changes in v8:
> > > >     * common function to set INIT and operating speeds.
> > > >     * moved hardware flow control to qca_set_speed().
> > > >
> > > > Changes in v7:
> > > >     * initial patch
> > > >     * created wrapper functions for init and operating speeds.
> > > > ---
> > > >  drivers/bluetooth/hci_qca.c | 89 +++++++++++++++++++++++++++----------
> > > >  1 file changed, 65 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > > index fe62420ef838..38b7dbe6c897 100644
> > > > --- a/drivers/bluetooth/hci_qca.c
> > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > @@ -119,6 +119,11 @@ struct qca_data {
> > > >  	u64 votes_off;
> > > >  };
> > > >
> > > > +enum qca_speed_type {
> > > > +	QCA_INIT_SPEED = 1,
> > > > +	QCA_OPER_SPEED
> > > > +};
> > > > +
> > > >  struct qca_serdev {
> > > >  	struct hci_uart	 serdev_hu;
> > > >  	struct gpio_desc *bt_en;
> > > > @@ -923,6 +928,60 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
> > > >  		hci_uart_set_baudrate(hu, speed);
> > > >  }
> > > >
> > > > +static unsigned int qca_get_speed(struct hci_uart *hu,
> > > > +				  enum qca_speed_type speed_type)
> > > > +{
> > > > +	unsigned int speed = 0;
> > > > +
> > > > +	if (speed_type == QCA_INIT_SPEED) {
> > > > +		if (hu->init_speed)
> > > > +			speed = hu->init_speed;
> > > > +		else if (hu->proto->init_speed)
> > > > +			speed = hu->proto->init_speed;
> > > > +	} else {
> > > > +		if (hu->oper_speed)
> > > > +			speed = hu->oper_speed;
> > > > +		else if (hu->proto->oper_speed)
> > > > +			speed = hu->proto->oper_speed;
> > > > +	}
> > > > +
> > > > +	return speed;
> > > > +}
> > > > +
> > > > +static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
> > > > +{
> > > > +	unsigned int speed, qca_baudrate;
> > > > +	int ret;
> > > > +
> > > > +	if (speed_type == QCA_INIT_SPEED) {
> > > > +		speed = qca_get_speed(hu, QCA_INIT_SPEED);
> > > > +		if (speed)
> > > > +			host_set_baudrate(hu, speed);
> > > > +		else
> > > > +			bt_dev_err(hu->hdev, "Init speed should be non zero");
> > > 
> > > The check for 'speed == 0' is done in multiple places. From this
> > > code I deduce that it is expected that both INIT and OPER speed are
> > > set to non-zero values. What happens if either of them is zero? Is the
> > > driver still operational?
> > > 
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	speed = qca_get_speed(hu, QCA_OPER_SPEED);
> > > > +	if (!speed) {
> > > > +		bt_dev_err(hu->hdev, "operating speed should be non zero");
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	qca_baudrate = qca_get_baudrate_value(speed);
> > > > +	bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
> > > > +	ret = qca_set_baudrate(hu->hdev, qca_baudrate);
> > > > +	if (ret) {
> > > > +		bt_dev_err(hu->hdev, "Failed to change the baudrate (%d)", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	host_set_baudrate(hu, speed);
> > > > +
> > > > +	return ret;
> > > > +}
> > > 
> > > In the discussion on "[v7,8/8] Bluetooth: hci_qca: Add support for
> > > Qualcomm Bluetooth chip wcn3990" you mentioned the possbility to move
> > > the hci_uart_set_flow_control() calls into _set_speed(). This seemed
> > > interesting but finally it isn't done in this series. Did you
> > > encounter that it is not feasible/desirable for some reason?
> > 
> > I got that half wrong. "[v8,7/7] Bluetooth: hci_qca: Add support for
> > Qualcomm Bluetooth chip wcn3990" adds the flow control calls to
> > _set_speed() however there are still_set_flow_control() calls in
> > qca_setup(), which confused/s me.
> > 
> > Could you provide a brief summary on the situations (relevant for this
> > driver) in which flow controls needs to be enabled/disabled?
> 
> you will not find enable or disable of hardware flow control in this patch.
> there is no hardware flow control in ROME chip.
> you will find hardware flow control in wcn3990 i.e. patch [v8 7/7]

Makes sense, when looking first at this I forgot the flow control
handling was only added for wcn3990.

> in wcn3990. we disable hardware flow control, when we sent mandatory
> commands to BT chip.
> 
> i.e while sending power on pulse i.e 0xFC byte for wcn3990 to boot up
> completely and sending change baudrate request to BT chip.
> before sending these commands, we disable the chip flow control and enable
> flow control once we sent these commands.
> 
> so in our current code after integrating wcn3990, we disable flow control
> two times.
> 
> 1. Before sending power on pulse i.e. qca_send_vendor_cmd(hdev,
> QCA_WCN3990_POWERON_PULSE); in qca_setup.
>    so we find disable or enable hardware flow control in qca_setup()
> 2. Before sending change BT CHIP baudrate request i.e.
> qca_set_baudrate(hu->hdev, qca_baudrate); in qca_set_speed().

Thanks for the information!

If there are more mandatory commands it could be an option to have a
wrapper for them or do the flow control handling in
qca_send_vendor_cmd() to avoid cluttering the main code path.

Just an idea, no need to do this now.

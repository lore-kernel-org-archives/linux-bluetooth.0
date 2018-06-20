Return-Path: <mka@chromium.org>
Date: Wed, 20 Jun 2018 16:10:56 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	thierry.escande@linaro.org, linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org, hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 5/8] Bluetooth: hci_qca: Defined wrapper functions for
 setting UART speeds
Message-ID: <20180620231056.GJ169030@google.com>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-6-bgodavar@codeaurora.org>
 <20180618215128.GU88063@google.com>
 <36000c0c93849527efdc19f6a6dc106e@codeaurora.org>
 <431406f54800ff5d1a20b69e5a2fdf9c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <431406f54800ff5d1a20b69e5a2fdf9c@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Balakrishna,

On Thu, Jun 21, 2018 at 01:19:00AM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-06-19 12:41, Balakrishna Godavarthi wrote:
> > HI Matthias,
> > 
> > Please find my comments in line.
> > 
> > On 2018-06-19 03:21, Matthias Kaehlcke wrote:
> > > On Sat, Jun 16, 2018 at 11:57:15AM +0530, Balakrishna Godavarthi
> > > wrote:
> > > > Subject: Bluetooth: hci_qca: Defined wrapper functions for setting
> > > >          UART speeds
> > > 
> > > s/Defined/Define/
> > > 
> > > or
> > > 
> > > s/Defined/Add/
> > > 
> > [Bala]: will update the text.
> > > > 
> > > > In qca_setup, we set initial and operating speeds for Qualcomm
> > > > Bluetooth SoC's. This block of code is common across different
> > > > Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
> > > > a wrapper function to set the speeds. So that future coming SoC's
> > > > can use these wrapper functions to set speeds.
> > > > 
> > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > > ---
> > > > 
> > > > Changes in v7:
> > > > 	* initial patch
> > > > 	* created wrapper functions for init and operating speeds.
> > > > 
> > > > ---
> > > >  drivers/bluetooth/hci_qca.c | 64
> > > > ++++++++++++++++++++++++++-----------
> > > >  1 file changed, 45 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/drivers/bluetooth/hci_qca.c
> > > > b/drivers/bluetooth/hci_qca.c
> > > > index fe62420ef838..3e09c6223baf 100644
> > > > --- a/drivers/bluetooth/hci_qca.c
> > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > @@ -923,21 +923,10 @@ static inline void
> > > > host_set_baudrate(struct hci_uart *hu, unsigned int speed)
> > > >  		hci_uart_set_baudrate(hu, speed);
> > > >  }
> > > > 
> > > > -static int qca_setup(struct hci_uart *hu)
> > > > +static void qca_set_init_speed(struct hci_uart *hu)
> > > >  {
> > > > -	struct hci_dev *hdev = hu->hdev;
> > > > -	struct qca_data *qca = hu->priv;
> > > > -	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
> > > > -	int ret;
> > > > -	int soc_ver = 0;
> > > > -
> > > > -	bt_dev_info(hdev, "ROME setup");
> > > > -
> > > > -	/* Patch downloading has to be done without IBS mode */
> > > > -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> > > > +	unsigned int speed = 0;
> > > > 
> > > > -	/* Setup initial baudrate */
> > > > -	speed = 0;
> > > >  	if (hu->init_speed)
> > > >  		speed = hu->init_speed;
> > > >  	else if (hu->proto->init_speed)
> > > > @@ -945,27 +934,64 @@ static int qca_setup(struct hci_uart *hu)
> > > > 
> > > >  	if (speed)
> > > >  		host_set_baudrate(hu, speed);
> > > > +}
> > > > +
> > > > +static int qca_get_oper_speed(struct hci_uart *hu)
> > > 
> > > Return type should be unsigned int.
> > > 
> > [Bala]: will update
> > > > +{
> > > > +	unsigned int speed = 0;
> > > > 
> > > > -	/* Setup user speed if needed */
> > > > -	speed = 0;
> > > >  	if (hu->oper_speed)
> > > >  		speed = hu->oper_speed;
> > > >  	else if (hu->proto->oper_speed)
> > > >  		speed = hu->proto->oper_speed;
> > > > 
> > > > +	return speed;
> > > > +}
> > > > +
> > > > +static int qca_set_oper_speed(struct hci_uart *hu)
> > > > +{
> > > > +	unsigned int speed = 0, qca_baudrate;
> > > 
> > > initialization is not needed.
> > > 
> > [Bala]: will update
> > 
> > > > +	int ret = 0;
> > > > +
> > > > +	speed = qca_get_oper_speed(hu);
> > > >  	if (speed) {
> > > 
> > > nit:
> > > 	if (!speed)
> > > 		return 0;
> > > 
> > > 
> > [Bala]: will update.
> > 
> > > >  		qca_baudrate = qca_get_baudrate_value(speed);
> > > > -
> > > > -		bt_dev_info(hdev, "Set UART speed to %d", speed);
> > > > -		ret = qca_set_baudrate(hdev, qca_baudrate);
> > > > +		bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
> > > > +		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
> > > >  		if (ret) {
> > > > -			bt_dev_err(hdev, "Failed to change the baud rate (%d)",
> > > > +			bt_dev_err(hu->hdev, "Failed to change the baud rate (%d)",
> > > >  				   ret);
> > > >  			return ret;
> > > >  		}
> > > >  		host_set_baudrate(hu, speed);
> > > >  	}
> > > > 
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int qca_setup(struct hci_uart *hu)
> > > > +{
> > > > +	struct hci_dev *hdev = hu->hdev;
> > > > +	struct qca_data *qca = hu->priv;
> > > > +	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
> > > > +	int ret;
> > > > +	int soc_ver = 0;
> > > > +
> > > > +	bt_dev_info(hdev, "ROME setup");
> > > > +
> > > > +	/* Patch downloading has to be done without IBS mode */
> > > > +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> > > > +
> > > > +	/* Setup initial baudrate */
> > > > +	qca_set_init_speed(hu);
> > > > +	/* Setup user speed if needed */
> > > > +	ret = qca_set_oper_speed(hu);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +	speed = qca_get_oper_speed(hu);
> > > > +	if (speed)
> > > > +		qca_baudrate = qca_get_baudrate_value(speed);
> > > 
> > > nit: the sequence
> > > 
> > > qca_set_oper_speed()
> > > qca_get_oper_speed()
> > > 
> > > is slightly awkward to read. This could be avoided if the speed was
> > > passed as parameter, though I understand this isn't done for symmetry
> > > with qca_set_init_speed(). An alternative could be:
> > > 
> > > static int qca_set_speed(struct hci_uart *hu, unsigned int speed, enum
> > >     qca_speed_type speed_type)
> > > {
> > > 	unsigned int qca_baudrate;
> > > 
> > > 	if (speed_type == QCA_OPER_SPEED) {
> > > 		qca_baudrate = qca_get_baudrate_value(speed);
> > > 		bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
> > > 		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
> > > 		if (ret) {
> > > 			bt_dev_err(hu->hdev, "Failed to change the baud rate (%d)",
> > > 				ret);
> > > 			return ret;
> > > 		}
> > > 	}
> > > 
> > > 	host_set_baudrate(hu, speed);
> > > 
> > > 	/* If the order doesn't matter set the host baudrate first and
> > > 	   return if speed_type != QCA_OPER_SPEED */
> > > 
> > > 	return 0;
> > > }
> > > 
> > > static int qca_setup(struct hci_uart *hu)
> > > {
> > > 	...
> > > 	speed = qca_get_init_speed(hu);
> > > 	if (speed)
> > > 		qca_set_speed(hu, speed, QCA_INIT_SPEED);
> > > 
> > > 	speed = qca_get_oper_speed(hu);
> > > 	if (speed) {
> > > 	   	qca_set_speed(hu, speed, QCA_OPER_SPEED);
> > > 		qca_baudrate = qca_get_baudrate_value(speed);
> > > 	}
> > > 	...
> > > }
> > > 
> > > Just a suggestion, ok for me if you prefer to keep it as is.
> > 
> > [Bala]: will study and update the same.
> 
> [Bala]: you are suggestion looks ok to me. i am thinking to optimize
> further.
> 
> static unsigned int qca_get_speed(struct hci_uart *hu,
>                                   enum qca_speed_type speed_type)
> {
>         unsigned int speed = 0;
> 
>         if (speed_type == QCA_INIT_SPEED) {
>                 if (hu->init_speed)
>                         speed = hu->init_speed;
>                 else if (hu->proto->init_speed)
>                         speed = hu->proto->init_speed;
>         } else {
>                 if (hu->oper_speed)
>                         speed = hu->oper_speed;
>                 else if (hu->proto->oper_speed)
>                         speed = hu->proto->oper_speed;
>         }
> 
>         return speed;
> }
> 
> static int qca_set_speed(struct hci_uart *hu, unsigned int speed,
>                          enum qca_speed_type speed_type)
> {
>         unsigned int qca_baudrate;
>         int ret;
> 
>         if (speed_type == QCA_OPER_SPEED) {
>                 qca_baudrate = qca_get_baudrate_value(speed);
>                 bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
>                 ret = qca_set_baudrate(hu->hdev, qca_baudrate);
>                 if (ret) {
>                         bt_dev_err(hu->hdev, "Failed to change the baudrate
> (%d)",
>                                    ret);
>                         return ret;
>                 }
>         }
> 
>         host_set_baudrate(hu, speed);

nit: if the order doesn't matter consider setting the host baudrate
first and return if 'speed_type != QCA_OPER_SPEED', which reduces the
indentiation (just a minor not really important thing though).

I also see a point in not setting the host baudrate if the chip
baudrate couldn't be set, so whatever ;-)

> 
>         return ret;
> }
> 
>  static int qca_setup(struct hci_uart *hu)
>  {
>  	...
>     /* Setup initial baudrate */
>         speed = qca_get_speed(hu, QCA_INIT_SPEED);
>         if (speed)
>                 qca_set_speed(hu, speed, QCA_INIT_SPEED);
> 
>         /* Setup user speed if needed */
>         speed = qca_get_speed(hu, QCA_OPER_SPEED);
>         if (speed) {
>                 ret = qca_set_speed(hu, speed, QCA_OPER_SPEED);
>                 if (ret)
>                         return ret;
> 
>                 qca_baudrate = qca_get_baudrate_value(speed);
>         }
> 
> }
> 
> will have two functions,
> qca_set_speed(): for setting speed
> qca_get_speed(): to get the speed.
> 
> is this preferable?

Looks good to me, thanks!

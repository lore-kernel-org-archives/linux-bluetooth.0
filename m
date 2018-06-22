Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 22 Jun 2018 20:41:01 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 thierry.escande@linaro.org, linux-bluetooth@vger.kernel.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 4/8] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
In-Reply-To: <20180621220939.GA129942@google.com>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-5-bgodavar@codeaurora.org>
 <20180618211942.GT88063@google.com>
 <fdd4fd89b53ba0fb85a53e4d4d33b0d5@codeaurora.org>
 <20180619200338.GD169030@google.com>
 <f37214cb19823893f2679787139ec471@codeaurora.org>
 <20180620233306.GK169030@google.com>
 <ac99931766b3a12716c7e161057043ca@codeaurora.org>
 <20180621220939.GA129942@google.com>
Message-ID: <e8c7e89e0a6a8779c8b237424814f6fc@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-06-22 03:39, Matthias Kaehlcke wrote:
> On Thu, Jun 21, 2018 at 04:50:28PM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2018-06-21 05:03, Matthias Kaehlcke wrote:
>> > Hi Balakrishna,
>> >
>> > On Wed, Jun 20, 2018 at 04:23:25PM +0530, Balakrishna Godavarthi wrote:
>> > > Hi Matthias,
>> > >
>> > > On 2018-06-20 01:33, Matthias Kaehlcke wrote:
>> > > > On Tue, Jun 19, 2018 at 12:39:07PM +0530, Balakrishna Godavarthi wrote:
>> > > > > Hi Matthias,
>> > > > >
>> > > > > Please find my comments inline.
>> > > > >
>> > > > > On 2018-06-19 02:49, Matthias Kaehlcke wrote:
>> > > > > > On Sat, Jun 16, 2018 at 11:57:14AM +0530, Balakrishna Godavarthi wrote:
>> > > > > >
>> > > > > > > @@ -337,19 +337,20 @@ int qca_uart_setup(struct hci_dev *hdev,
>> > > > > > > uint8_t baudrate)
>> > > > > > >
>> > > > > > >  	config.user_baud_rate = baudrate;
>> > > > > > >
>> > > > > > > -	/* Get QCA version information */
>> > > > > > > -	err = qca_read_soc_version(hdev, &rome_ver);
>> > > > > > > -	if (err < 0 || rome_ver == 0) {
>> > > > > > > -		bt_dev_err(hdev, "QCA Failed to get version %d", err);
>> > > > > > > -		return err;
>> > > > > > > +	if (!soc_ver) {
>> > > > > > > +		/* Get QCA version information */
>> > > > > > > +		err = qca_read_soc_version(hdev, &soc_ver);
>> > > > > > > +		if (err < 0 || soc_ver == 0) {
>> > > > > > > +			bt_dev_err(hdev, "QCA Failed to get version %d", err);
>> > > > > > > +			return err;
>> > > > > > > +		}
>> > > > > > > +		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
>> > > > > > >  	}
>> > > > > >
>> > > > > > Why is this needed? A caller that passes in soc_ver = 0 could just
>> > > > > > call qca_read_soc_version() themselves.
>> > > > > [Bala]: hci_qca support two chip one ROME (already up-streamed) and
>> > > > > other
>> > > > > wcn3990.
>> > > > >         there setup sequence differs.
>> > > > >
>> > > > >         wcn3900:
>> > > > >         1. set baudrate to 115200
>> > > > >         2. read soc version
>> > > > >         3. set baudarte to 3.2Mbps
>> > > > >         4. download firmware. (calls qca_uart_setup)
>> > > > >
>> > > > >        ROME:
>> > > > >        1. set baudrate to 3.0 mbps
>> > > > >        2. calls qca_uart_setup to read soc version and download
>> > > > > firmware.
>> > > > >
>> > > > >       so to make use of existing function qca_setup_uart(). passing
>> > > > > soc_ver
>> > > > > as argument.
>> > > > >       if soc_ver is zero, then read soc version (i.e. for ROME chip).
>> > > > >
>> > > > >       Pls let me know, if you have any queries.
>> > > >
>> > > > I don't really understand this argumentation. Let's look at the code
>> > > > at the end of this series, where both Rome and wcn3900 are supported:
>> > > >
>> > > > https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1045608/6/drivers/bluetooth/hci_qca.c#1059
>> > > >
>> > > > The version could be read (for Rome only) after setting the operating
>> > > > speed:
>> > >
>> > > [Bala]: yes we can read SoC version after setting operating baud
>> > > rate. an
>> > > advice from SoC vendor that, read SoC version before setting operating
>> > > speed.
>> > >         one advantage from reading SoC version before setting
>> > > operating
>> > > baudrate,it will helps us to understand whether the soc is
>> > > responding to any
>> > > commands in default baud rate
>> > >         before setting operating speed.
>> >
>> > Is the recommendation for Rome or wcn3990? I was referring to Rome and
>> > the current code sets the operating speed and then reads the SoC
>> > version (inside qca_uart_setup())
>> >
>> 
>> [Bala]: my statement is wrt to wcn3990. yes, ROME will set operating 
>> speed
>> and read version.
>> 
>> > > > https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1045608/6/drivers/bluetooth/hci_qca.c#1111
>> > > >
>> > > > I concede that having two "if (qcadev->btsoc_type == XYZ)" branches in
>> > > > qca_setup() is kinda ugly, but I think it's still better than the
>> > > > conditional call of qca_read_soc_version() in qca_uart_setup().
>> > >
>> > > [Bala]: we require an if-else block  for soc type.As wcn3900 support
>> > > hardware flow control where as ROME is not supporting hardware flow
>> > > control.
>> >
>> > Since you mention if-else and flow control I'm not sure if you
>> > understood correctly what I suggested. My suggestion is to add
>> > something like this:
>> >
>> > if (qcadev->btsoc_type == QCA_ROME) {
>> > 	ret = qca_read_soc_version(hdev, &soc_ver);
>> > 	if (ret < 0 || soc_ver == 0) {
>> > 	   	// Note mka@: we might want to skip this log,
>> > 		// qca_read_soc_version() already logs in all error paths
>> > 		bt_dev_err(hdev, "Failed to get version %d", ret);
>> > 		return ret;
>> > 	}
>> > }
>> >
>> > right here:
>> >
>> > https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1045608/6/drivers/bluetooth/hci_qca.c#1111
>> >
>> > which is functionally equivalent to the current code.
>> >
>> > You could even do the error check in the common code (just checking
>> > for 'soc_ver == 0', assuming that qca_read_soc_version() doesn't set
>> > it to something different in case of error).
>> >
>> > Anyway, I won't insist if you prefer it as is and Marcel is ok with it.
>> 
>> [Bala]: thanks for clarifying my doubt, but if remove the
>> qca_read_soc_version() from qca_uart_setup() and handle it 
>> qca_setup().
>>         in that case, we will have common blocks of code, when we 
>> integrate
>> wcn3990 into existing qca_setup()
> 
> Excellent!
> 
>>        static int qca_setup(struct hci_uart *hu)
>>       {
>>         ...
>> 
>>         qcadev = serdev_device_get_drvdata(hu->serdev);
>> 
>>         /* Patch downloading has to be done without IBS mode */
>>         clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> 
>>         /* Setup initial baudrate */
>>         speed = qca_get_speed(hu, QCA_INIT_SPEED);
>>         if (speed)
>>                 qca_set_speed(hu, speed, QCA_INIT_SPEED);
> 
> I said earlier that a _set_speed() followed by a _get_speed() is a bit
> odd, and that it would be better to get the speed first and pass it as
> a parameter. After looking again over the larger code I'm not
> convinced anymore this is such a good idea, since the above pattern is
> repeated multiple times, when it could be just:
> 
> qca_set_speed(hu, QCA_INIT_SPEED)
> 
> (+ error handling, which is also missing in the code above)
> 
> Just a thought, not asking you to change it back, do whatever seems
> best to you.
> 
>>         if (qcadev->btsoc_type == QCA_WCN3990) {
>>                 bt_dev_dbg(hdev, "setting up wcn3990");
>>                 hci_uart_set_flow_control(hu, true);
>>                 ret = qca_send_vendor_cmd(hdev, 
>> QCA_WCN3990_POWERON_PULSE);
>>                 if (ret) {
>>                         bt_dev_err(hdev, "failed to send power on 
>> command");
>>                         return ret;
>>                 }
>> 
>>                 serdev_device_close(hu->serdev);
>>                 ret = serdev_device_open(hu->serdev);
>>                 if (ret) {
>>                         bt_dev_err(hdev, "failed to open port");
>>                         return ret;
>>                 }
>> 
>>                 msleep(100);
>>                 speed = qca_get_speed(hu, QCA_INIT_SPEED);
>>                 if (speed)
>>                         qca_set_speed(hu, speed, QCA_INIT_SPEED);
>> 
>>                 hci_uart_set_flow_control(hu, false);
>>         } else {
>>                 bt_dev_info(hdev, "ROME setup");
>>                 /* Setup user speed if needed */
>>                 speed = qca_get_speed(hu, QCA_OPER_SPEED);
>>                 if (speed) {
>>                         ret = qca_set_speed(hu, speed, 
>> QCA_OPER_SPEED);
>>                         if (ret)
>>                                 return ret;
>> 
>>                         qca_baudrate = qca_get_baudrate_value(speed);
> 
> It seems setting 'qca_baudrate' could also be done in the common
> path. Would require an extra qca_get_speed(hu, QCA_OPER_SPEED) call,
> in exchange this would be done in a single place closer to where
> 'qca_baudrate' is actually used.
> 
> Actually as it is now 'qca_baudrate' could remain uninitialized for
> Rome if no operating speed is defined, which judging from
> qca_get_baudrate_value() should result in QCA_BAUDRATE_115200.
> 
>>                 }
>>         }
>> 
>>         ret = qca_read_soc_version(hdev, &soc_ver);
>>         if (ret < 0 || soc_ver == 0) {
>>                 bt_dev_err(hdev, "Failed to get version %d", ret);
>>                 return ret;
>>         }
>>         bt_dev_info(hdev, "wcn3990 controller version 0x%08x", 
>> soc_ver);
>> 
>> 
>>         if (qcadev->btsoc_type == QCA_WCN3990) {
>>                 hci_uart_set_flow_control(hu, true);
>>                 /* Setup user speed if needed */
>>                 speed = qca_get_speed(hu, QCA_OPER_SPEED);
>>                 if (speed) {
>>                         ret = qca_set_speed(hu, speed, 
>> QCA_OPER_SPEED);
>>                         if (ret)
>>                                 return ret;
>> 
>>                 qca_baudrate = qca_get_baudrate_value(speed);
>> 
>>         }
>> 
>>         /* Setup patch / NVM configurations */
>>         ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type,
>> soc_ver);
>>         if (!ret) {
>>                 set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>>                 qca_debugfs_init(hdev);
>>         } else if (ret == -ENOENT) {
>>                 /* No patch/nvm-config found, run with original 
>> fw/config */
>>                 ret = 0;
>>         } else if (ret == -EAGAIN) {
>>                 /*
>>       ...
>>       }
> 
> Overall looks good and should still become a bit more compact if the
> handling of flow control is done in _set_speed() as you suggested in
> "[PATCH v7 8/8] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
> chip wcn3990"

[Bala}: to over come calling qca_get_speed() for qca_baudrate.
         i prefer passing qca_baudrate as pointer argument to 
qca_set_speed().
         that  will actually helps to lower function calls. intern 
increase the speed of execution too.

code snippet after integrating wcn3990:

     static int qca_set_speed(struct hci_uart *hu, unsigned int 
*qca_baudrate,
                          enum qca_speed_type speed_type)
{
         struct qca_serdev *qcadev;
         unsigned int speed;
         int ret;

         if (speed_type == QCA_INIT_SPEED) {
                 speed = qca_get_speed(hu, QCA_INIT_SPEED);
                 if (speed) {
                         host_set_baudrate(hu, speed);
                         *qca_baudrate = qca_get_baudrate_value(speed);
                 } else {
                         bt_dev_err(hu->hdev, "Init speed should be non 
zero");
                 }

                 return 0;
         }

         speed = qca_get_speed(hu, QCA_OPER_SPEED);
         if (!speed) {
                 bt_dev_err(hu->hdev, "operating speed should be non 
zero");
                 return 0;
         }

         qcadev = serdev_device_get_drvdata(hu->serdev);
         /* Disabling hardware flow control is preferred while
          * sending change baud rate command to SoC.
         */
         if (qcadev->btsoc_type == QCA_WCN3990)
                 hci_uart_set_flow_control(hu, true);

         *qca_baudrate = qca_get_baudrate_value(speed);
         bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
         ret = qca_set_baudrate(hu->hdev, *qca_baudrate);
         if (ret) {
                 bt_dev_err(hu->hdev, "Failed to change the baudrate 
(%d)", ret);
                 return ret;
         }

         host_set_baudrate(hu, speed);
         if (qcadev->btsoc_type == QCA_WCN3990)
                 hci_uart_set_flow_control(hu, false);

         return 0;
}


static int qca_setup(struct hci_uart *hu)
{
  ....
  qcadev = serdev_device_get_drvdata(hu->serdev);

         /* Patch downloading has to be done without IBS mode */
         clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);

         /* Setup initial baudrate */
         qca_set_speed(hu, &qca_baudrate, QCA_INIT_SPEED);

         if (qcadev->btsoc_type == QCA_WCN3990) {
                 bt_dev_dbg(hdev, "setting up wcn3990");
                 hci_uart_set_flow_control(hu, true);
                 ret = qca_send_vendor_cmd(hdev, 
QCA_WCN3990_POWERON_PULSE);
                 if (ret)
                         return ret;

                 serdev_device_close(hu->serdev);
                 ret = serdev_device_open(hu->serdev);
                 if (ret) {
                         bt_dev_err(hdev, "failed to open port");
                         return ret;
                 }

                 msleep(100);
                 /* Setup initial baudrate */
                 qca_set_speed(hu, &qca_baudrate, QCA_INIT_SPEED);
                 hci_uart_set_flow_control(hu, false);
                 ret = qca_read_soc_version(hdev, &soc_ver);
                 if (ret < 0 || soc_ver == 0) {
                         bt_dev_err(hdev, "Failed to get version %d", 
ret);
                         return ret;
                 }

                 bt_dev_info(hdev, "wcn3990 controller version 0x%08x", 
soc_ver);
         } else {
                 bt_dev_info(hdev, "ROME setup");
         }

         /* Setup user speed if needed */
         ret = qca_set_speed(hu, &qca_baudrate, QCA_OPER_SPEED);
         if (ret)
                 return ret;
         /* Setup patch / NVM configurations */
         ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type, 
soc_ver);
         if (!ret) {
                 set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
                 qca_debugfs_init(hdev);
         } else if (ret == -ENOENT) {
                 /* No patch/nvm-config found, run with original 
fw/config */
                 ret = 0;
         } else if (ret == -EAGAIN) {
                 /*
                  * Userspace firmware loader will return -EAGAIN in case 
no
                  * patch/nvm-config is found, so run with original 
fw/config.
                  */
                 ret = 0;
         }

         /* Setup bdaddr */
         hu->hdev->set_bdaddr = qca_set_bdaddr_rome;

         return ret;

}


-- 
Regards
Balakrishna.

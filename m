Return-Path: <cyrus@holtmann.org>
From: <Lukasz.Rymanowski@tieto.com>
To: <tglx@linutronix.de>, <par-gunnar.p.hjalmdahl@stericsson.com>
CC: <gregkh@suse.de>, <devel@driverdev.osuosl.org>,
	<linus.walleij@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-bluetooth@vger.kernel.org>, <pavan_savoy@sify.com>,
	<vitalywool@gmail.com>, <alan@lxorguk.ukuu.org.uk>, <arnd@arndb.de>,
	<marcel@holtmann.org>, <linus.walleij@stericsson.com>, <pghatwork@gmail.com>,
	<lee.jones@linaro.org>, <mathieu.poirier@linaro.org>
Date: Mon, 28 Mar 2011 13:05:35 +0300
Subject: RE: [PATCH v2 1/2] staging: Add ST-Ericsson CG2900 driver
Message-ID: <7D7F2FD3846CF6429ACEBDFB5A2DD86F07E35E5F89@EXMB01.eu.tieto.com>
References: <1301302950-10628-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <alpine.LFD.2.00.1103281110210.31464@localhost6.localdomain6>
In-Reply-To: <alpine.LFD.2.00.1103281110210.31464@localhost6.localdomain6>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

>> +/**
>> + * cts_interrupt() - Called to handle CTS interrupt.
>> + * @irq:	Interrupt that occurred.
>> + * @dev_id:	Device ID where interrupt occurred.
>> + *
>> + * The cts_interrupt() function is called if interrupt on CTS occurred.
>> + * It disables the interrupt and starts a new work thread to handle
>> + * the interrupt.
>> + */
>> +static irqreturn_t cts_interrupt(int irq, void *dev_id) {
>> +	struct uart_info *uart_info =3D dev_get_drvdata(dev_id); #ifdef=20
>> +CONFIG_PM
>> +	disable_irq_wake(irq);
>> +#endif
>> +	disable_irq_nosync(irq);
>> +
>> +	/* Create work and leave IRQ context. */
>> +	(void)create_work_item(uart_info, handle_cts_irq);
>> +
>> +	return IRQ_HANDLED;
>> +}

>Have you thought about using a threaded interrupt handler? That would make=
 all this work cruft go away.

Good point.
To be honest we did think about it but in the time we where we were busy wi=
th other issues.
Anyway, shall we resend patches now or we can push patch for it once driver=
 gets in the tree ?

/Lukasz

>Thanks,

>	tglx

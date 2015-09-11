Return-Path: <cyrus@holtmann.org>
Message-ID: <55F2A28D.9010506@intel.com>
Date: Fri, 11 Sep 2015 11:44:45 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Frederic Danis <frederic.danis@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Bluetooth: hci_bcm: Add suspend/resume runtime
 PM functions
References: <1441785286-5840-1-git-send-email-frederic.danis@linux.intel.com> <1441785286-5840-4-git-send-email-frederic.danis@linux.intel.com> <5F941F10-620B-4282-848E-895D52744850@holtmann.org> <55F19651.8090908@intel.com>
In-Reply-To: <55F19651.8090908@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred

>> For hci_intel we are doing this in the enqueue function when the
>> Bluetooth subsystem has to send us data. Why would we do this on the
>> TTY receiving side here? If the device is not active, we would not be
>> receiving anything in the first place. I am failing to see the logic
>> here.
> hci_intel also performs this when receiving LPM_OP_TX_NOTIFY packets.
> Afaik, Broadcom device does not have this feature and we need to delay
> the suspend when we receive a packet.
>
> I will move bcm_schedule_work() after h4_recv_buf() to perform it only
> on completed packet.

What about using a delayed work with work_delay << autosuspend_delay so 
that the work is not queued each time but every work_delay in worst case.

hci_uart proto callback is called with rx spinlock in
hci_uart_tty_receive which is the receive_buf ldisc callback.
In drivers/tty/tty_buffer.c we can see that flush_to_ldisc (work) locks
a mutex (&buf->lock) and push the data to ldisc via receive_buf.

So, I don't see any problem to remove the hci_ldisc rx_spinlock and 
replace it by a mutex, or even don't use locking at all.

Regards,
Loic
-- 
Intel Open Source Technology Center
http://oss.intel.com/

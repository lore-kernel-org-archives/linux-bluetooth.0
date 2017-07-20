Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <59708C48.3020500@rock-chips.com>
Date: Thu, 20 Jul 2017 18:56:08 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
CC: briannorris@chromium.org, dianders@chromium.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        xiyou.wangcong@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5] Bluetooth: btusb: Fix memory leak in play_deferred
References: <1500511321-16092-1-git-send-email-jeffy.chen@rock-chips.com> <1500541861.10409.2.camel@suse.com>
In-Reply-To: <1500541861.10409.2.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

On 07/20/2017 05:11 PM, Oliver Neukum wrote:
>> >+		if (err < 0) {
>> >+			if (err != -EPERM && err != -ENODEV)
>> >+				BT_ERR("%s urb %p submission failed (%d)",
>> >+				       data->hdev->name, urb, -err);
>> >+			kfree(urb->setup_packet);
>> >+			usb_unanchor_urb(urb);
>> >+			usb_free_urb(urb);
>> >  			break;
>> >+		}
>> >
>> >  		data->tx_in_flight++;
>> >+		usb_free_urb(urb);
>> >+	}
>> >+
>> >+	/* Cleanup the rest deferred urbs. */
>> >+	while ((urb = usb_get_from_anchor(&data->deferred))) {
>> >+		BT_ERR("%s urb %p submission failed (%d)",
> This looks very good, except for this message, which is incorrect.
>
hmm, since we already print error log when submission failed before, 
i'll remove this, thanks.

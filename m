Return-Path: <cyrus@holtmann.org>
Subject: Re: sniff mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100908241126k6cf31de0s282c0f360b6948ec@mail.gmail.com>
References: <2d5a2c100908241126k6cf31de0s282c0f360b6948ec@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 11:40:57 -0700
Message-Id: <1251139257.2950.60.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> It is just me or hci_conn_enter_active_mode will never do what its
> name suggests. This check will always succeed:
> 
> 	if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
> 		goto timer;

so conn->power_save is used to disable automatic sniff mode for incoming
connections. Mainly HID since they manager it by themselves.

> But in hci_mode_change_evt whatever mode different than HCI_CM_ACTIVE
> reset power_save to zero:
> 
> 
> 		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
> 			if (conn->mode == HCI_CM_ACTIVE)
> 				conn->power_save = 1;
> 			else
> 				conn->power_save = 0;
> 		}

And again, we are not setting the sniff mode. We disable automatic sniff
mode feature.

> So it seems that if mode is SNIFF power_save is 0, so this check will
> only fail if mode is in fact HCI_CM_ACTIVE, and then latter on we got
> this:
> 
> 
> 	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
> 		struct hci_cp_exit_sniff_mode cp;
> 		cp.handle = cpu_to_le16(conn->handle);
> 		hci_send_cmd(hdev, HCI_OP_EXIT_SNIFF_MODE, sizeof(cp), &cp);
> 	}
> 
> I was expecting that only when mode is HCI_CM_SNIFF it would send
> HCI_OP_EXIT_SNIFF_MODE, or Im missing something?

This reads as if NO mode change is pending, then exit from sniff mode.

Regards

Marcel



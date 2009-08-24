Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 24 Aug 2009 15:26:42 -0300
Message-ID: <2d5a2c100908241126k6cf31de0s282c0f360b6948ec@mail.gmail.com>
Subject: sniff mode
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

It is just me or hci_conn_enter_active_mode will never do what its
name suggests. This check will always succeed:

	if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
		goto timer;

But in hci_mode_change_evt whatever mode different than HCI_CM_ACTIVE
reset power_save to zero:


		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
			if (conn->mode == HCI_CM_ACTIVE)
				conn->power_save = 1;
			else
				conn->power_save = 0;
		}

So it seems that if mode is SNIFF power_save is 0, so this check will
only fail if mode is in fact HCI_CM_ACTIVE, and then latter on we got
this:


	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
		struct hci_cp_exit_sniff_mode cp;
		cp.handle = cpu_to_le16(conn->handle);
		hci_send_cmd(hdev, HCI_OP_EXIT_SNIFF_MODE, sizeof(cp), &cp);
	}

I was expecting that only when mode is HCI_CM_SNIFF it would send
HCI_OP_EXIT_SNIFF_MODE, or Im missing something?


-- 
Luiz Augusto von Dentz
Engenheiro de Computação

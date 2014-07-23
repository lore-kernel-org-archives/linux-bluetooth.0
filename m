Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Jul 2014 13:14:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: johan.hedberg@intel.com
Cc: linux-bluetooth@vger.kernel.org
Subject: re: Bluetooth: Don't bother user space without IO capabilities
Message-ID: <20140723101413.GA24653@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan Hedberg,

The patch 02f3e2545791: "Bluetooth: Don't bother user space without
IO capabilities" from Jul 16, 2014, leads to the following static
checker warning:

	net/bluetooth/hci_event.c:3770 hci_user_confirm_request_evt()
	warn: we tested 'rem_mitm' before and it was 'false'

net/bluetooth/hci_event.c
  3760          /* If no side requires MITM protection; auto-accept */
  3761          if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
  3762              (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
  3763  
  3764                  /* If we're not the initiators request authorization to
  3765                   * proceed from user space (mgmt_user_confirm with
  3766                   * confirm_hint set to 1). The exception is if neither
  3767                   * side had MITM or if the local IO capability is
  3768                   * NoInputNoOutput, in which case we do auto-accept
  3769                   */
  3770                  if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
  3771                      conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
  3772                      (loc_mitm || rem_mitm)) {

Checking for "conn->io_capability != HCI_IO_NO_INPUT_OUTPUT" implies
"rem_mitm" is false.  So this could be written as:

			if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
			    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
			    loc_mitm) {

But it's not totally clear which is more readable.  Feel free to ignore
this email if you want.  :)

  3773                          BT_DBG("Confirming auto-accept as acceptor");
  3774                          confirm_hint = 1;
  3775                          goto confirm;
  3776                  }

regards,
dan carpenter

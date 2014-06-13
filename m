Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: Updated bluetooth.git tree
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <9A6A4711-653B-480A-9852-4C12B9352E0A@holtmann.org>
Date: Fri, 13 Jun 2014 14:59:25 +0200
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <B05CD64C-D9BF-46F1-88CA-C3FB0D0079BA@holtmann.org>
References: <9A6A4711-653B-480A-9852-4C12B9352E0A@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> since Dave closed the net-next tree for preparing his merge request to Linus, I took his tree and merged it into bluetooth.git tree. This will become the base for our 3.16-rcX patches.

I rebased bluetooth.git against net.git and bluetooth-next.git against net-next.git now. I also separated all the patches between the trees and then pulled bluetooth.git changes into bluetooth-next.git tree. This should give us a good base for the 3.17 merge window.

The bluetooth.git tree is ready for a pull request for John. It contains the following patches now:

92d1372e1a9f Bluetooth: Allow change security level on ATT_CID in slave role
c73f94b8c093 Bluetooth: Fix locking of hdev when calling into SMP code
7ab56c3a6ecc Bluetooth: Fix deadlock in l2cap_conn_del()
f8680f128b01 Bluetooth: Reuse hci_stop_discovery function when cleaning up HCI state
21a60d307ddc Bluetooth: Refactor discovery stopping into its own function
50143a433b70 Bluetooth: Fix indicating discovery state when canceling inquiry
fff3490f4781 Bluetooth: Fix setting correct authentication information for SMP STK
4ad51a75c70b Bluetooth: Add clarifying comment for conn->auth_type
ba15a58b179e Bluetooth: Fix SSP acceptor just-works confirmation without MITM
e694788d73ef Bluetooth: Fix check for connection encryption
b62b65055bcc Bluetooth: Fix incorrectly overriding conn->src_type

Compared to the last email we have 3 additional fixes. Two deadlock fixes and one bug in our security handling.

Regards

Marcel


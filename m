Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 2 Feb 2010 22:28:53 +0530
Message-ID: <912bb79a1002020858lda468aci6fef3e73fac07bd6@mail.gmail.com>
Subject: Kernel panic when SCO connection
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
When I try to connect SCO socket, Kernel getting crash.
Linux kernel - 2.6.22
Bluez - 4.58

error message,
__tx_submit:hci0 tx submit failed urb c0552c14 type 3 err -19

sometimes in connection is showing error while connection as below,
hci_acldata_packet:hci0 ACL packet data for unknown connection handler 2

It would be really appreciable if  somebody put some on light on this
issue, OR suggest me any patch or documentation.

-- 
With Regards,
Nirav Rabara

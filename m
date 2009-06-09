Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 9 Jun 2009 10:17:17 -0300
Message-ID: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
Subject: regression introduced on v2.6.30-rc1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

It seems there is a regression introduced on v2.6.30-rc1 while using
DEFER_SETUP on a RFCOMM socket. It happens when the user reject the
authorization:


2009-05-27 13:38:14.048925 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0040
2009-05-27 13:38:14.052864 > HCI Event: Number of Completed Packets (0x13) plen
5
    handle 42 packets 1
2009-05-27 13:38:14.174975 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0040


No hci disconnect command is sent so the ACL link will stay up
forever, I suspect some timeout got removed in rc1 since with v2.6.29
after some period the ACL is disconnected, but for my surprise it
seems HCI_IDLE_TIMEOUT is not being used.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação

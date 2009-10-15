Return-Path: <cyrus@holtmann.org>
Message-ID: <267658.23250.qm@web94907.mail.in2.yahoo.com>
Date: Thu, 15 Oct 2009 09:47:57 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: alternative to hci_ldisc for BT-UART
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Currently if the BT chip has an UART transport, it stops me from making of UART for any other purpose when BT is active.
In combo-chip cases(BT/FM), the TTY line discipline has to be more generic so that any other driver can make use of that line discipline to send across data to chip.

Is this possible and valid ?

regards,
Pavan


      Connect more, do more and share more with Yahoo! India Mail. Learn more. http://in.overview.mail.yahoo.com/

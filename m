Return-Path: <cyrus@holtmann.org>
Message-ID: <412755.94322.qm@web94903.mail.in2.yahoo.com>
Date: Wed, 30 Sep 2009 11:55:52 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: hci_h4p and firmware download
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I see that the nokia's hci_h4p which makes use of the UART transport for BT chip and doesn't make use of the line-discipline, downloads the firmware to chip by making use of the firmware class in kernel.

Why do we require this ? Most manufacturers have their drivers compliant to hci-line discipline and similar to h4 protocol driver and the firmware download is often done from hciattach in user-space.

So,
a. what is the advantage of not having hciattach in system ?
[This kind of makes the UART connected to BT chip un-useable as a normal TTY device, and BT down would only mean hciconfig hci0 down, leaving the HCI-Core tasklets running and consuming more power, unlike killing of hciattach and hci-daemon]

b. what is the advantage of having firmware download in kernel ?

regards,
Pavan


      Connect more, do more and share more with Yahoo! India Mail. Learn more. http://in.overview.mail.yahoo.com/

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 25 Jan 2011 18:42:09 +0530
Message-ID: <AANLkTinQdwaAQk6LU_uLJ60YFOthhuwu5rL2gzZUXZ-k@mail.gmail.com>
Subject: why scan_disable during hciops_power_off
From: Pavan Savoy <pavan_savoy@sify.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

when hciops gets a set_powered with powered=0, then hciops_power_off is called.
However in here we write the SCAN_ENABLE (=0) to the device and then
do the HCIDEVDOWN...

so couple of questions,
1. are there controllers there which even after doing hci0 down,
allows other devices to be scanned?
for those what do hci0 down mean ? radio not switched off ?

2. what happens to the response? in case hci0 down is considered as
say close of UART?
There is a case I have a combo chip, and I need to keep UART opened,
because someone else is using the UART, and then
I do this power_off, the hci0 interface is down, and bluetooth just
dumps down the scan_disable and quits, but the response
which comes from the device has no takers....

so shouldn't hciops use a hci_send_req before HCIDEVDOWN ?

regards,
Pavan

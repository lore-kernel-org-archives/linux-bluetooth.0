Return-Path: <cyrus@holtmann.org>
Message-ID: <487821.92480.qm@web94906.mail.in2.yahoo.com>
Date: Thu, 3 Dec 2009 18:16:11 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: installing n_hci upon DEVUP
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@nokia.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am faced with a problem, where-in my transport is UART and the hci0 interface from my driver (a TTY line discipline driver) is exposed @ boot time.

On Bluetooth-On, I perform a dev-up (or run bluetoothd/hcid which does that), how do I set the initialize my transport @ this point ?

I so desperately don't want to use hciattach, and want to allow my line discipline driver to do the firmware download (the reason why i have johan in CC) like the hci_h4p.

However, I would like to maintain my driver as a line discipline to avoid making use of primitive UART calls [like the hci_h4p].
Want to make use of DMA enabled, PM featured UART if available.

regards,
Pavan


      The INTERNET now has a personality. YOURS! See your Yahoo! Homepage. http://in.yahoo.com/

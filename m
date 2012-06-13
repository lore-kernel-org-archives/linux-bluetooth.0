Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 13 Jun 2012 23:37:00 +0530
Message-ID: <CAHdPZaPcCAt_TacNzggpG1P4LEh4WHAm9GMDQbsScgwW4A7CRw@mail.gmail.com>
Subject: bfusb: No statements under write_lock_irq_save and restore at 459
From: "devendra.aaru" <devendra.aaru@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

The write_lock_irq_save and restore are not required at bfusb_close,
does we need to do a clear_bit on hdev->flags?

Thanks,
Devendra.

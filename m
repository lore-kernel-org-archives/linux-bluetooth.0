Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: how to set PSCAN mode in .conf?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com>
Date: Mon, 20 Oct 2014 15:27:38 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

> latest bluez doesn't read hcid.conf, so how can I enable "pscan" in
> the conf file?
> 
> I know "hciconfig hci0 pscan" works, but I would still like to set
> that via the .conf file.

the mgmt interface has a connectable option and with BlueZ 5 that will be enabled by default for < 3.17 kernel. With >= 3.17 kernels the kernel automatically enables it based on our BR/EDR device list.

Regards

Marcel


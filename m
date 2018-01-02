Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: hciuart: add nvmem dependency
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180102105044.1436954-1-arnd@arndb.de>
Date: Tue, 2 Jan 2018 12:18:11 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        David Lechner <david@lechnology.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tobias Regnery <tobias.regnery@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <6F6439FB-6B46-4EC0-B826-9E12D04D60DD@holtmann.org>
References: <20180102105044.1436954-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnd,

> When the hci support is built-in, but mvmem is a loadable module, we
> get a link failure:
> 
> drivers/bluetooth/hci_ll.o: In function `hci_ti_probe':
> hci_ll.c:(.text+0x226): undefined reference to `nvmem_cell_get'
> hci_ll.c:(.text+0x238): undefined reference to `nvmem_cell_read'
> hci_ll.c:(.text+0x244): undefined reference to `nvmem_cell_put'
> 
> This adds another Kconfig dependency to enforce valid configurations.
> 
> Fixes: 0e58d0cdb3eb ("Bluetooth: hci_ll: Add optional nvmem BD address source")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> drivers/bluetooth/Kconfig | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

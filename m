Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Purpose of line discipline in bt drivers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAH9_wRP6ENEa8MmsuqD4R-TR=SpJdaoi22BLHM8A4LNGPP29Fg@mail.gmail.com>
Date: Sat, 27 Jan 2018 22:28:51 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <839A14D6-376D-49B2-83AC-D3631BB065CE@holtmann.org>
References: <CAH9_wRP6ENEa8MmsuqD4R-TR=SpJdaoi22BLHM8A4LNGPP29Fg@mail.gmail.com>
To: Sriram V <vshrirama@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sriram,

> I am facing broken audio issues when using the broadcom bt chip
> especially when it comes back from suspend. While debugging the issue,
> 
> What is the purpose of doing a registering a ldisc in the driver using
> the call tty_register_ldisc call() in Bluetooth drivers which deal
> with power management.
> 
> I am referring to the below driver:
> https://android.googlesource.com/kernel/bcm/+/android-4.4w_r6/drivers/misc/bcm-bt-lpm.c

contact Broadcom about that driver or ask the Android team. It is not an upstream driver. Upstream uses hci_bcm.c which include proper power management and not some hacked up "stab you in the back” driver to make some userspace Bluetooth stack have access to hardware low power feature.

Regards

Marcel


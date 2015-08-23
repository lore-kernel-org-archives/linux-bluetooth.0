Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 1/4] Bluetooth: hci_bcm: Add PM for BCM devices
To: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
References: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com>
 <1438959640-15476-2-git-send-email-frederic.danis@linux.intel.com>
 <55C85A37.2030103@bazdara.com> <55C8BBD0.6010706@linux.intel.com>
From: Luka Karinja <lk@bazdara.com>
Message-ID: <55D9A428.4050904@bazdara.com>
Date: Sun, 23 Aug 2015 12:44:56 +0200
MIME-Version: 1.0
In-Reply-To: <55C8BBD0.6010706@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Frederic.

> In addition to this, bcm_uart_subver_table, btbcm_initialize() and 
> btbcm_check_bdaddr() may need to be patched to support new device.
> All is located in btbcm.c file.
>

Could you give me some pointers of how to find those values for my 
device? the chip is a BCM43341

Thanks

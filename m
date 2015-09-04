Return-Path: <cyrus@holtmann.org>
Message-ID: <55E9A5EC.2030804@linux.intel.com>
Date: Fri, 04 Sep 2015 16:08:44 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luka Karinja <lk@bazdara.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Bluetooth: hci_bcm: Add PM for BCM devices
References: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com> <1438959640-15476-2-git-send-email-frederic.danis@linux.intel.com> <55C85A37.2030103@bazdara.com> <55C8BBD0.6010706@linux.intel.com> <55D9A428.4050904@bazdara.com>
In-Reply-To: <55D9A428.4050904@bazdara.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luka,

On 23/08/2015 12:44, Luka Karinja wrote:
> Hey Frederic.
>
>> In addition to this, bcm_uart_subver_table, btbcm_initialize() and
>> btbcm_check_bdaddr() may need to be patched to support new device.
>> All is located in btbcm.c file.
>>
>
> Could you give me some pointers of how to find those values for my
> device? the chip is a BCM43341

Regarding bcm_uart_subver_table, you can retrieve Subversion value by 
performing "hciconfig -a".

For btbcm_initialize(), you should check Revision displayed by 
hciconfig. You may have to add a "case" to "switch ((rev & 0xf000) >> 12)".

After this, you should be able to use btattach with your chipset.

If you have a firmware for the chipset, you could also check if it uses 
a default device address and add it to btbcm_check_bdaddr().

Regards

Fred

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120919010603.GF24689@joana>
References: <20120919000657.GA9208@localhost>
	<20120919010603.GF24689@joana>
Date: Wed, 19 Sep 2012 12:20:01 +0800
Message-ID: <CAKzePaqgn-ZoX3YQKe4_J0zys88L2NrkhyRVgth62N6Lx81mtg@mail.gmail.com>
Subject: Re: [bluetooth:master 22/22] drivers/bluetooth/btusb.c:97:2: error:
 expected '}' before '{' token
From: Al Cho <acho@suse.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Jaroslav Resler <resler@cs.cas.cz>,
	kernel-janitors@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	"Cho, Yu-Chen" <acho@suse.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

Thanks for your kindly reminder.
Will pay more attention next time.

Cheers,
AL

On Wed, Sep 19, 2012 at 9:06 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Fengguang,
>
> * Fengguang Wu <fengguang.wu@intel.com> [2012-09-19 08:06:57 +0800]:
>
>> Hi Jaroslav,
>>
>> FYI, kernel build failed on
>>
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
>> head:   493969cf4728668412ecd428a60b39914d9831e3
>> commit: 493969cf4728668412ecd428a60b39914d9831e3 [22/22] Bluetooth: Add support for BCM20702A0 [04ca, 2003]
>> config: x86_64-allmodconfig
>>
>> All related error/warning messages:
>>
>> drivers/bluetooth/btusb.c:97:2: error: expected '}' before '{' token
>>
>> vim +97 drivers/bluetooth/btusb.c
>>     92                /* Canyon CN-BTU1 with HID interfaces */
>>     93                { USB_DEVICE(0x0c10, 0x0000) },
>>     94
>>     95                /* Broadcom BCM20702A0 */
>>     96                { USB_DEVICE(0x04ca, 0x2003) }
>>   > 97                { USB_DEVICE(0x0489, 0xe042) },
>>     98                { USB_DEVICE(0x0a5c, 0x21e3) },
>>     99                { USB_DEVICE(0x0a5c, 0x21e6) },
>>    100                { USB_DEVICE(0x0a5c, 0x21e8) },
>>    101                { USB_DEVICE(0x0a5c, 0x21f3) },
>>    102                { USB_DEVICE(0x413c, 0x8197) },
>
> I fixed this upstream already. Thanks for reporting.
>
>         Gustavo



-- 
Al Yu-Chen Cho
Software Engineer
Room B, 26/F, No. 216 Tun-Hwa S. Road, Sec. 2
Taipei, 106
+8862-2376-0010 X20031
acho@suse.com
SUSE

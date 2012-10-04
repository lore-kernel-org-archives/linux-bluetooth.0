Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349355967.27233.35.camel@aeonflux>
References: <cover.1347959921.git.jesse.sung@canonical.com>
	<1349335847-1615-1-git-send-email-jesse.sung@canonical.com>
	<1349335847-1615-2-git-send-email-jesse.sung@canonical.com>
	<1349344897.27233.13.camel@aeonflux>
	<CAH10aOiwWGseiYEiqk_h=WhNyGGGhpWPhU1TO8E948Ka+xHu9w@mail.gmail.com>
	<1349355967.27233.35.camel@aeonflux>
Date: Thu, 4 Oct 2012 21:39:18 +0800
Message-ID: <CAH10aOja5o=HjsLN3qKZey=POpjgMsf+V_RU=iHH+sk1oZOOuw@mail.gmail.com>
Subject: Re: [PATCH v2 resend 1/2] Introduced a load_firmware callback to
 struct hci_dev
From: Jesse Sung <jesse.sung@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> >> load_firmware will be called at the end of hci_dev_open() if it
>> >> is defined.
>> >>
>> >> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
>> >> ---
>> >>  include/net/bluetooth/hci_core.h |    1 +
>> >>  net/bluetooth/hci_core.c         |    2 ++
>> >>  2 files changed, 3 insertions(+)
>> >>
>> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> >> index 593cd1d..40972a3 100644
>> >> --- a/include/net/bluetooth/hci_core.h
>> >> +++ b/include/net/bluetooth/hci_core.h
>> >> @@ -281,6 +281,7 @@ struct hci_dev {
>> >>       int (*send)(struct sk_buff *skb);
>> >>       void (*notify)(struct hci_dev *hdev, unsigned int evt);
>> >>       int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
>> >> +     void (*load_firmware)(struct hci_dev *hdev);
>> >>  };
>> >>
>> >>  struct hci_conn {
>> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> >> index d4de5db..49be87a 100644
>> >> --- a/net/bluetooth/hci_core.c
>> >> +++ b/net/bluetooth/hci_core.c
>> >> @@ -725,6 +725,8 @@ int hci_dev_open(__u16 dev)
>> >>  done:
>> >>       hci_req_unlock(hdev);
>> >>       hci_dev_put(hdev);
>> >> +     if (!ret && hdev->load_firmware)
>> >> +             hdev->load_firmware(hdev);
>> >>       return ret;
>> >>  }
>> >>
>> >
>> > has anybody thought this through actually? Do we need to reload the
>> > firmware after every HCI_Reset? Since hci_dev_open() is used at least
>> > twice during normal operation. And for every RFKILL or power down/up
>> > cycle of the chip.
>> >
>> > And there is an internal process of hci_dev_open() trigger on
>> > registration and others triggered by hciconfig hci0 up. I am pretty much
>> > against having to wait for all this firmware loading crap during every
>> > bring up of the device. Especially since it always does a trip via
>> > request_firmware().
>>
>> In the second patch, firmware loading would be done only once per
>> power cycle of the chip. Since I think it should be the device driver, not hci,
>> who knows when and how to load firmware, the lock is placed in btusb.c.
>
> and how does the driver knows these details? That makes no sense. How
> does the driver know it got rebooted?
>
> The hci_dev_open() will start the transport. And as I explained before,
> that can happen twice during boot time.

Please take a look at the second part of this patchset, which is in patch 2/2.
Loading firmware is needed when the chip is rebooted, and a reboot would trigger
a probe in btusb. So btusb can know a firmware loading is needed whenever
a new patchram device is probed. And the load_firmware callback in
btusb would do
test_and_set_bit to ensure that the loading process would only be done once.

Thanks,
Jesse

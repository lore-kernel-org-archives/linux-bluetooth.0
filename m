Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC] Bluetooth: hci_ll: Convert to use h4_recv_buf helper
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180320201449.GV5796@atomide.com>
Date: Tue, 20 Mar 2018 22:00:02 +0100
Cc: Sebastian Reichel <sre@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, robh@kernel.org
Message-Id: <E7257152-583E-4BCC-B366-2627E62F1FE1@holtmann.org>
References: <20180320083704.11705-1-marcel@holtmann.org>
 <4DBD77C5-BBFD-4952-A296-30187D85A07F@holtmann.org>
 <20180320172827.ohla5v4a23v3u3qq@earth.universe>
 <20180320201449.GV5796@atomide.com>
To: Tony Lindgren <tony@atomide.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tony,

>>>> The HCILL or eHCILL protocol from TI is actually an H:4 protocol with a
>>>> few extra events and thus can also use the h4_recv_buf helper. Instead
>>>> of open coding the same funtionality add the extra events to the packet
>>>> description table and use h4_recv_buf.
>>>> 
>>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>>> ---
>>>> drivers/bluetooth/Kconfig  |   1 +
>>>> drivers/bluetooth/hci_ll.c | 214 +++++++++++++++------------------------------
>>>> 2 files changed, 70 insertions(+), 145 deletions(-)
>>> 
>>> is anybody able to test this change for me and verify that it doesn’t break things.
>> 
>> The diffstat looks nice :) I can give it a test on Motorola Droid 4
>> later this week. If you want feedback a bit earlier, maybe Tony
>> can give it a try (added to cc).
> 
> I tried applying it from the mailing list archive against
> current Linux next and -rc6 but it failed:
> 
> patching file drivers/bluetooth/Kconfig
> Hunk #1 succeeded at 147 with fuzz 2 (offset -13 lines).
> patching file drivers/bluetooth/hci_ll.c
> Hunk #2 succeeded at 88 (offset 4 lines).
> Hunk #3 FAILED at 364.
> 
> Any ideas which patch(es) I might be missing?

that might be a git am issue and it being rather strict.

$ cat 0001-Bluetooth-hci_ll-Convert-to-use-h4_recv_buf-helper.patch | patch -p1 --dry-run
checking file drivers/bluetooth/Kconfig
Hunk #1 succeeded at 147 (offset -13 lines).
checking file drivers/bluetooth/hci_ll.c
Hunk #2 succeeded at 88 (offset 4 lines).
Hunk #3 succeeded at 370 (offset 6 lines).

Regards

Marcel


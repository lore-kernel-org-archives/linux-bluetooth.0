Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F15B3FE9-19A2-44BF-9DE1-137F0993965C@holtmann.org>
References: <1422325138-20113-1-git-send-email-jpawlowski@google.com>
	<1422325138-20113-2-git-send-email-jpawlowski@google.com>
	<F15B3FE9-19A2-44BF-9DE1-137F0993965C@holtmann.org>
Date: Sun, 1 Feb 2015 23:07:48 -0800
Message-ID: <CAD0=r8z3_pT5z1wjxcg2sqacLbSidBss9LbJs-ReyaiMBdarYQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] Bluetooth: Add restarting to service discovery
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Feb 1, 2015 at 9:13 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jakub,
>
>> When using LE_SCAN_FILTER_DUP_ENABLE, some controllers would send
>> advertising report from each LE device only once. That means that we
>> don't get any updates on RSSI value, and makes Service Discovery very
>> slow. This patch adds restarting scan when in Service Discovery, and
>> device with filtered uuid is found, but it's not in RSSI range to send
>> event yet. This way if device moves into range, we will quickly get RSSI
>> update.
>>
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>> ---
>> include/net/bluetooth/hci_core.h |  1 +
>> net/bluetooth/mgmt.c             | 53 ++++++++++++++++++++++++++++++++++++----
>> 2 files changed, 49 insertions(+), 5 deletions(-)
>
> this patch looks good. However I can only apply it once you added the comments to patch 1/2.
>
> I have also run this patch now for a while with out own controllers and all seems to be working as expected. However I would like to see some test cases for mgmt-tester afterwards that ensures it is working correctly.
>
Ok, I'll look into that.

> Regards
>
> Marcel
>

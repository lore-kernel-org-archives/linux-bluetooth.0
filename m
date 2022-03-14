Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E563C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 13:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiCNN0q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCNN0q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 09:26:46 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD711141
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 06:25:35 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nTkhZ-0003z7-8R; Mon, 14 Mar 2022 14:25:33 +0100
Message-ID: <fceed7f9-e67a-613f-8af2-30bfe0520c6e@leemhuis.info>
Date:   Mon, 14 Mar 2022 14:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] Bluetooth: HCI: Add HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN
 quirk
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20220302225049.432025-1-luiz.dentz@gmail.com>
 <2CF7A301-D806-4E9A-A441-BE661FF3AD5B@holtmann.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <2CF7A301-D806-4E9A-A441-BE661FF3AD5B@holtmann.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1647264335;f5c43c52;
X-HE-SMSGID: 1nTkhZ-0003z7-8R
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

What's the up here? Two weeks ago two patches got posted to fix the
regression, but last week nothing happened afaics. A status inquiry in
the bug report about this was also left unanswered, that's why I'm
wondering if this fall off the radar.

https://bugzilla.kernel.org/show_bug.cgi?id=215576

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot ignore-activity
#regzbot poke

On 03.03.22 13:23, Marcel Holtmann wrote:
> Hi Luiz,
> 
>> This adds HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN quirk which can be used to
>> mark HCI_Enhanced_Setup_Synchronous_Connection as supported by
>> controller since using just the support command bits are not enough
>> since some controller report it as supported but the command don't work
>> properly with some configurations (e.g. BT_VOICE_TRANSPARENT/mSBC).
>>
>> Fixes: b2af264ad3af ("Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215576
>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> ---
>> drivers/bluetooth/btusb.c        | 58 +++++++++++++++++---------------
>> include/net/bluetooth/hci.h      |  9 +++++
>> include/net/bluetooth/hci_core.h |  8 +++--
>> 3 files changed, 46 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 558151f2f150..c862d0f963b5 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -36,33 +36,34 @@ static bool reset = true;
>>
>> static struct usb_driver btusb_driver;
>>
>> -#define BTUSB_IGNORE		0x01
>> -#define BTUSB_DIGIANSWER	0x02
>> -#define BTUSB_CSR		0x04
>> -#define BTUSB_SNIFFER		0x08
>> -#define BTUSB_BCM92035		0x10
>> -#define BTUSB_BROKEN_ISOC	0x20
>> -#define BTUSB_WRONG_SCO_MTU	0x40
>> -#define BTUSB_ATH3012		0x80
>> -#define BTUSB_INTEL_COMBINED	0x100
>> -#define BTUSB_INTEL_BOOT	0x200
>> -#define BTUSB_BCM_PATCHRAM	0x400
>> -#define BTUSB_MARVELL		0x800
>> -#define BTUSB_SWAVE		0x1000
>> -#define BTUSB_AMP		0x4000
>> -#define BTUSB_QCA_ROME		0x8000
>> -#define BTUSB_BCM_APPLE		0x10000
>> -#define BTUSB_REALTEK		0x20000
>> -#define BTUSB_BCM2045		0x40000
>> -#define BTUSB_IFNUM_2		0x80000
>> -#define BTUSB_CW6622		0x100000
>> -#define BTUSB_MEDIATEK		0x200000
>> -#define BTUSB_WIDEBAND_SPEECH	0x400000
>> -#define BTUSB_VALID_LE_STATES   0x800000
>> -#define BTUSB_QCA_WCN6855	0x1000000
>> -#define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	0x2000000
>> -#define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
>> -#define BTUSB_INTEL_NO_WBS_SUPPORT	0x8000000
>> +#define BTUSB_IGNORE			BIT(0)
>> +#define BTUSB_DIGIANSWER		BIT(1)
>> +#define BTUSB_CSR			BIT(2)
>> +#define BTUSB_SNIFFER			BIT(3)
>> +#define BTUSB_BCM92035			BIT(4)
>> +#define BTUSB_BROKEN_ISOC		BIT(5)
>> +#define BTUSB_WRONG_SCO_MTU		BIT(6)
>> +#define BTUSB_ATH3012			BIT(7)
>> +#define BTUSB_INTEL_COMBINED		BIT(8)
>> +#define BTUSB_INTEL_BOOT		BIT(9)
>> +#define BTUSB_BCM_PATCHRAM		BIT(10)
>> +#define BTUSB_MARVELL			BIT(11)
>> +#define BTUSB_SWAVE			BIT(12)
>> +#define BTUSB_AMP			BIT(13)
>> +#define BTUSB_QCA_ROME			BIT(14)
>> +#define BTUSB_BCM_APPLE			BIT(15)
>> +#define BTUSB_REALTEK			BIT(16)
>> +#define BTUSB_BCM2045			BIT(17)
>> +#define BTUSB_IFNUM_2			BIT(18)
>> +#define BTUSB_CW6622			BIT(19)
>> +#define BTUSB_MEDIATEK			BIT(20)
>> +#define BTUSB_WIDEBAND_SPEECH		BIT(21)
>> +#define BTUSB_VALID_LE_STATES		BIT(22)
>> +#define BTUSB_QCA_WCN6855		BIT(23)
>> +#define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	BIT(24)
>> +#define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
>> +#define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
>> +#define BTUSB_ENHANCED_SETUP_SYNC_CONN  BIT(27)
> 
> not in the same patch.
> 
>>
>> static const struct usb_device_id btusb_table[] = {
>> 	/* Generic Bluetooth USB device */
>> @@ -3848,6 +3849,9 @@ static int btusb_probe(struct usb_interface *intf,
>> 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
>> 	}
>>
>> +	if (id->driver_info & BTUSB_ENHANCED_SETUP_SYNC_CONN)
>> +		set_bit(HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
>> +
>> 	if (id->driver_info & BTUSB_CSR) {
>> 		struct usb_device *udev = data->udev;
>> 		u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 35c073d44ec5..7fe10ad044c1 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -255,6 +255,15 @@ enum {
>> 	 * during the hdev->setup vendor callback.
>> 	 */
>> 	HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
>> +
>> +	/*
>> +	 * When this quirk is set, enables the use of
>> +	 * HCI_OP_ENHANCED_SETUP_SYNC_CONN command to setup SCO connections.
>> +	 *
>> +	 * This quirk can be set before hci_register_dev is called or
>> +	 * during the hdev->setup vendor callback.
>> +	 */
>> +	HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN,
>> };
> 
> And NO. We are not penalizing well behaving hardware. We mark broken hardware as broken.
> 
> In addition, we really need to print out after ->setup() has run what quirks a given hardware sets and be verbose in dmesg about this mess. Companies really need to learn to get the stuff right or provide firmware updates to fix it.
> 
> If this command is broken, then also WBS support should also be disabled. We need to make them feel this pain and give incentives to get this broken hardware fixed.
> 
> Also I am only going to apply such a patch when I see the driver change to it as well.
> 
> Regards
> 
> Marcel
> 


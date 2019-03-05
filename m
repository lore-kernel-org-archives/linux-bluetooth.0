Return-Path: <SRS0=u2q6=RI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23739C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 18:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE70C20842
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 18:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfCESmY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:42:24 -0500
Received: from mailfilter01-out40.webhostingserver.nl ([195.211.73.31]:11627
        "EHLO mailfilter01-out40.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727225AbfCESmY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Mar 2019 13:42:24 -0500
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Mar 2019 13:42:22 EST
X-Halon-ID: 29995b25-3f74-11e9-b585-001a4a4cb921
Received: from s198.webhostingserver.nl (unknown [141.138.168.154])
        by mailfilter01.webhostingserver.nl (Halon) with ESMTPSA
        id 29995b25-3f74-11e9-b585-001a4a4cb921;
        Tue, 05 Mar 2019 19:26:15 +0100 (CET)
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=[10.8.0.6])
        by s198.webhostingserver.nl with esmtpa (Exim 4.90_1)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1h1Elb-000SCo-Iu; Tue, 05 Mar 2019 19:26:15 +0100
From:   Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH 2/2] Bluetooth: btbcm: Add default address for BCM2076B1
To:     Stephan Gerhold <stephan@gerhold.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
References: <20190305130901.56660-1-stephan@gerhold.net>
 <20190305130901.56660-2-stephan@gerhold.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <7b48753f-f103-f522-68c5-38479feb4552@exalondelft.nl>
Date:   Tue, 5 Mar 2019 19:26:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305130901.56660-2-stephan@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-SendingUser: hidden
X-SendingServer: hidden
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: hidden
X-SendingUser: hidden
X-SendingServer: hidden
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Op 05-03-19 om 14:09 schreef Stephan Gerhold:
> BCM2076B1 appears to use 20:76:A0:00:56:79 as default address.
> This address is used by at least 5 devices with the AMPAK AP6476
> module and is also suspicious because it starts with the chip name
> 2076 (followed by a different revision A0 for some reason).
With BCM43340 (Edison) it's the same principle. With the fake address I 
found everything (in user space) seems to work except PAN/NAP (bnep) and 
no decent error message anywhere making this quite hard to debug.
> Add it to the list of default addresses and leave it up to the
> user to configure a valid one.

Which way is the user supposed to configure the valid one?

The only way I found is bd_addr (tool from bluez that is not normally 
built/installed).

Using this tool requires hci0 to be up and bluetoothd to be restarted if 
that was already running, which is quite inconvenient.

I also saw there was a patch to put the address in dt.

But nowhere did I find a kernel parameter to pass the address. Did I 
miss something?

>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> drivers/bluetooth/btbcm.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index ea1a20a49f91..35394076267b 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -34,6 +34,7 @@
> #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 
> 0x00}})
> #define BDADDR_BCM20702A1 (&(bdaddr_t) {{0x00, 0x00, 0xa0, 0x02, 0x70, 
> 0x20}})
> +#define BDADDR_BCM2076B1 (&(bdaddr_t) {{0x79, 0x56, 0x00, 0xa0, 0x76, 
> 0x20}})
> #define BDADDR_BCM43430A0 (&(bdaddr_t) {{0xac, 0x1f, 0x12, 0xa0, 0x43, 
> 0x43}})
> #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 
> 0x43}})
> #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 
> 0x43}})
> @@ -69,6 +70,9 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
> * The address 20:70:02:A0:00:00 indicates a BCM20702A1 controller
> * with no configured address.
> *
> + * The address 20:76:A0:00:56:79 indicates a BCM2076B1 controller
> + * with no configured address.
> + *
> * The address 43:24:B3:00:00:00 indicates a BCM4324B3 controller
> * with waiting for configuration state.
> *
> @@ -80,6 +84,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
> */
> if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
> !bacmp(&bda->bdaddr, BDADDR_BCM20702A1) ||
> + !bacmp(&bda->bdaddr, BDADDR_BCM2076B1) ||
> !bacmp(&bda->bdaddr, BDADDR_BCM4324B3) ||
> !bacmp(&bda->bdaddr, BDADDR_BCM4330B1) ||
> !bacmp(&bda->bdaddr, BDADDR_BCM43430A0)) {

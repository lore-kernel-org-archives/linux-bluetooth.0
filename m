Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0EDC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 13:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC17E6103B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 13:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbhHENRJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 09:17:09 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46233 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbhHENRI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 09:17:08 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id B8544CECF0;
        Thu,  5 Aug 2021 15:16:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [BlueZ PATCH] doc: Add a doc for Intel hardware variants
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210805002123.22339-1-hj.tedd.an@gmail.com>
Date:   Thu, 5 Aug 2021 15:16:53 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9513A8F2-3C17-4381-A953-42E056029E45@holtmann.org>
References: <20210805002123.22339-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch adds a document for Intel hardware variants currently
> supported by the kernel and its firmware list.
> ---
> doc/intel_variants.txt | 134 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 134 insertions(+)
> create mode 100644 doc/intel_variants.txt

please use - instead of _ for file names in that directory.

> 
> diff --git a/doc/intel_variants.txt b/doc/intel_variants.txt
> new file mode 100644
> index 000000000..ef406a530
> --- /dev/null
> +++ b/doc/intel_variants.txt
> @@ -0,0 +1,134 @@
> +Intel Hardware Varaints

=== for title separation.

> +
> +These are the list of Intel Bluetooth devices and its information.
> +
> +Some of devices were tested the following test cases:
> +	Firmware loading after cold boot
> +	Firmware loading after restart
> +	Device discovery
> +	Connection to LE Mouse
> +	A2DP
> +	HFP
> +	Update to new firmware if available
> +
> +

And provide a link to the linux-firmware tree.

> +Device List
> +-----------
> +
> +WP2

Lets do Wilkins Peak 2 (WP2) etc. Otherwise this is a bit too cryptic for outsiders.

> +- USB(0x8087:0x07dc)
> +- Legacy ROM device
> +- Driver flag: BTUSB_INTEL_BROKEN_INITIAL_NCMD
> +- HW variant: 0x07
> +- FW files:
> +	intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> +		tested: Patch Version: 87    Release Version: 20.60.0.2
> +			70353356f ("linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B3/B4)")
> +
> +	intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
> +		tested: Patch Version: 42    Release Version: 20.60.0.2
> +			629a5e089 ("linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B5/B6)")
> +
> +
> +StP
> +- USB(0x8087:0x0a2a)
> +- Legacy ROM device
> +- HW variant: 0x08
> +	intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
> +		tested: FW Build: REL_50_0002    Release Version: 20.60.0.2
> +			9489f5524 ("linux-firmware: Update firmware patch for Intel Bluetooth 7265 (D0)")
> +
> +
> +SdP
> +- USB(0x8087:0x0aa7)
> +- Legacy ROM device
> +- Driver flag: BTUSB_WIDEBAND_SPEECH
> +- HW variant: 0x08
> +	intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
> +		tested: FW Patch Version: 0x42(66)
> +			195ecf149 ("linux-firmware: Intel BT 7265: Fix Security Issues")
> +
> +
> +LnP/SfP/WsP
> +- USB(0x8087:0x0a2b)
> +- Legacy Bootloader device
> +- Driver flag: BTUSB_WIDEBAND_SPEECH
> +- HW variant: 0x0b
> +	intel/ibt-11-5.sfi
> +		tested: FW Build: REL0522    Release Version: 20.100.0.3
> +			f0896585b ("linux-firmware: Update firmware patch for Intel Bluetooth 8260")
> +- HW variant: 0x0c
> +	intel/ibt-12-16.sfi
> +		tested: FW Build: REL1221    Release Version: 22.50.0.4
> +			4116d72b9 ("linux-firmware: Update firmware file for Intel Bluetooth 8265")
> +		tested: FW Build: REL0306    Release Version: 21.10.0.6
> +			1f8ebdfc2 ("linux-firmware: Update firmware file for Intel Bluetooth 8265")
> +
> +
> +JfP
> +- USB(0x8087:0x0aaa)
> +- Legacy Bootloader device
> +- Driver flag: BTUSB_WIDEBAND_SPEECH | BTUSB_VALID_LE_STATES

Just mention the HCI Core quirks that are set and not the btusb flags.

> +- HW variant: 0x11
> +	intel/ibt-17-0-1.sfi
> +	intel/ibt-17-16-1.sfi
> +
> +
> +ThP
> +- USB(0x8087:0x0025)
> +- Legacy Bootloader device
> +- Driver flag: BTUSB_WIDEBAND_SPEECH | BTUSB_VALID_LE_STATES
> +- HW variant: 0x12
> +	intel/ibt-18-0-1.sfi
> +	intel/ibt-18-16-1.sfi
> +		tested: FW Build: REL19718    Release Version: 22.50.0.4
> +			687d64a4d ("linux-firmware: Update firmware file for Intel Bluetooth 9260")
> +		tested: FW Build: REL13313    Release Version: 21.120.0.4
> +			db3038082 ("linux-firmware: Update firmware file for Intel Bluetooth 9260")
> +
> +
> +HrP/QnJ/IcP
> +- USB(0x8087:0x0026)
> +- Legacy Bootloader device
> +- Driver flag: BTUSB_WIDEBAND_SPEECH
> +- HW variant: 0x13
> +	intel/ibt-19-0-0.sfi
> +	intel/ibt-19-0-1.sfi
> +	intel/ibt-19-0-4.sfi
> +	intel/ibt-19-16-4.sfi
> +	intel/ibt-19-240-1.sfi
> +	intel/ibt-19-240-4.sfi
> +	intel/ibt-19-32-0.sfi
> +	intel/ibt-19-32-1.sfi
> +	intel/ibt-19-32-4.sfi

Any chance we can get SKU details included?

> +
> +
> +CcP
> +- USB(0x8087:0x0029)
> +- Legacy Bootloader device
> +- Driver flag: BTUSB_WIDEBAND_SPEECH
> +- HW variant: 0x14
> +	intel/ibt-20-0-3.sfi
> +	intel/ibt-20-1-3.sfi
> +		tested: FW Build: REL25791    Release Version: 22.60.0.3
> +			34803c20f ("linux-firmware: Update firmware file for Intel Bluetooth AX200")
> +	intel/ibt-20-1-4.sfi
> +
> +
> +TyP
> +- USB(0x8087:0x0032)
> +- TLV based Bootloader device
> +- Driver flag: BTUSB_WIDEBAND_SPEECH
> +- HW variant: 0x17
> +	intel/ibt-0041-0041.sfi
> +		tested: FW Build: REL25171    Release Version: 22.60.0.3
> +			25ddc612f ("linux-firmware: Update firmware file for Intel Bluetooth AX210")
> +		tested: FW Build: REL17510    Release Version: 22.20.0.3
> +			28185ecdc ("linux-firmware: Update firmware file for Intel Bluetooth AX210")
> +
> +
> +GfP
> +- USB(0x8087:0x0033)
> +- TLV based Bootloader device
> +- Driver flag: BTUSB_WIDEBAND_SPEECH | BTUSB_VALID_LE_STATES
> +- HW variant:

Regards

Marcel


Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C9BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 11:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787702071A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 11:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFQLBr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:01:47 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39834 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQLBq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 07:01:46 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1AFD2CECD2;
        Wed, 17 Jun 2020 13:11:36 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Requested feedback for new advertising MGMT command
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAKc116CHjs=hOLxz-76DxQpU-sSML1yxRnACuTCoOuCh3nFNog@mail.gmail.com>
Date:   Wed, 17 Jun 2020 13:01:44 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2FAC3F24-01C3-43A7-A6DF-01614A4B62AE@holtmann.org>
References: <CAKc116CHjs=hOLxz-76DxQpU-sSML1yxRnACuTCoOuCh3nFNog@mail.gmail.com>
To:     Daniel Winkler <danielwinkler@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

> We are working on a feature to allow advertising clients to customize
> both advertising intervals and requested tx power for each registered
> advertising set. It is clear that the existing "add advertising" MGMT
> command is not sufficient for these new features, so we have narrowed
> it down to two options for the new interface, and hope for your
> feedback:
> 
> Option 1 replicates existing MGMT command, and in addition provides
> new interval and tx_power members.
> 
> #define MGMT_OP_ADD_EXT_ADVERTISING 0x00??
> struct mgmt_cp_add_ext_advertising {
>    uint8_t  instance;
>    uint32_t flags;
>    uint16_t timeout;
>    uint16_t min_interval;
>    uint16_t max_interval;
>    int8_t tx_power;
>    uint8_t  adv_data_len;
>    uint8_t  scan_rsp_len;
>    uint8_t  data[];
> } __packed;
> 
> Option 2 packs the data into a flexible TLV data member. This allows
> unused/unnecessary parameters to be omitted, and also allows for
> future addition of functionality without redefining the MGMT
> interface, for instance when more of the extended advertising features
> are enabled in userspace.
> 
> #define MGMT_OP_ADD_EXT_ADVERTISING 0x00??
> struct mgmt_cp_add_ext_advertising {
>    uint8_t  instance;
>    uint32_t flags;
>    uint8_t  tlv_data[];
> } __packed;
> 
> Feedback/comments/concerns are highly welcome, thanks in advance!

I am leaning towards option 1 since it is a lot easier to read and also handle inside the code. We can add extra flags if default values should be applied.

The one thing that is rather more problematic is that fact that we want to provide tx_power and then we need to know what the tx_power level has been chosen by the controller. In HCI there is no combined command and thus setting the parameters first and then the data is possible.

So maybe one proposal could also be this:

Add Extended Advertising Command
================================

        Command Code:           0x00xx
        Controller Index:       <controller id>
        Command Parameters:     Instance (1 Octet)
                                Flags (4 Octets)
                                Duration (2 Octets)
                                Timeout (2 Octets)
				TX_Power (1 Octet)
				Min_Interval (2 Octets)
				Max_Interval (2 Octets)
        Return Parameters:      Instance (1 Octet)
				TX_Power (1 Octet)


We can implement this command in way that extension with new fields is possible. Not all commands need to be strict in length. Such a created instance is of course off by default.

And then you need to provide the AD with a separate command to activate the instance.

Set Advertising Data Command
============================

	Command Code:		0x00xx
	Controller Index:	<controller id>
	Command Parameters:	Instance (1 Octet)
				Flags (4 Octets)
                                Adv_Data_Len (1 Octet)
                                Scan_Rsp_Len (1 Octet)
                                Adv_Data (0-255 Octets)
                                Scan_Rsp (0-255 Octets)
	Return Parameters:      Instance (1 Octet)

This command should only be allowed if Add Extended Advertising is used and most likely also Advertising Data Changed event needs to be added to complete this.

The Flags might share a namespace if that makes sense, but not all are available for both commands.

Regards

Marcel


Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD9C282C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7060E21855
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfAWRqU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:46:20 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35577 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWRqT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 12:46:19 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 125A8CEFA4;
        Wed, 23 Jan 2019 18:54:06 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190123174504.12350-1-pali.rohar@gmail.com>
Date:   Wed, 23 Jan 2019 18:46:18 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8D9BABBE-2BBC-4BFE-BF7C-3BE24AF4DD10@holtmann.org>
References: <20190123174504.12350-1-pali.rohar@gmail.com>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

> ---
> tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> index 18569c895..a21410f5a 100644
> --- a/tools/parser/avdtp.c
> +++ b/tools/parser/avdtp.c
> @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
> {
> 	if (vendor == 0x0000004f && vndcodec == 0x0001)
> 		return "aptX";
> +	else if (vendor == 0x0000000a && vndcodec == 0x0001)
> +		return "FastStream";
> +	else if (vendor == 0x0000000a && vndcodec == 0x0002)
> +		return "aptX Low Latency";
> +	else if (vendor == 0x000000d7 && vndcodec == 0x0024)
> +		return "aptX HD";
> 	else if (vendor == 0x0000012d && vndcodec == 0x00aa)
> 		return "LDAC";
> 	return "Unknown”;

lets keep the focus on btmon support since nobody should be using hcidump anymore.

Regards

Marcel


Return-Path: <SRS0=gY20=5B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E649C0044D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8B320663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 15:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RX/wp1Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgCPPHd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:07:33 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:55209 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731758AbgCPPHd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Mar 2020 11:07:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584371252; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=I74FzD8gT42MrBJOC+YUJAHq1MUTpP7zxvPx0mJUftQ=;
 b=RX/wp1EcQaQMorzpTITv+oFWRclF7WZl4nFxFaT0KGw8+80aPJ/CdEX5dITkaBdNWE+FhFbm
 Pm9I6bfTsp4I6Vs/rhnIf0LcJT6FY94IEppHHUdyAO/eIvtq1S8I3Bgob8NCLUDqxsF5ROZk
 RZpDZm6WzpcSp5aSdczVe5GG8Zk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6f9623.7f69d522ab20-smtp-out-n01;
 Mon, 16 Mar 2020 15:07:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2E512C433CB; Mon, 16 Mar 2020 15:07:14 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94B9CC44791;
        Mon, 16 Mar 2020 15:07:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Mar 2020 20:37:13 +0530
From:   bgodavar@codeaurora.org
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, c-hbandi@codeaurora.org,
        hemantg@codeaurora.org, mka@chromium.org
Subject: Re: [PATCH v1 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QCA chip QCA6390
In-Reply-To: <20200314094328.3331-2-rjliao@codeaurora.org>
References: <20200314094328.3331-1-rjliao@codeaurora.org>
 <20200314094328.3331-2-rjliao@codeaurora.org>
Message-ID: <1ac67f48f34bc91e89a1b3a5d1c23453@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2020-03-14 15:13, Rocky Liao wrote:
> This patch adds compatible string for the QCA chip QCA6390.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index beca6466d59a..badf597c0e58 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -13,6 +13,7 @@ Required properties:
>     * "qcom,wcn3990-bt"
>     * "qcom,wcn3991-bt"
>     * "qcom,wcn3998-bt"
> +   * "qcom,qca6390-bt"
> 

[Bala]: Can you add a example snippet of QCA6390 dts

>  Optional properties for compatible string qcom,qca6174-bt:

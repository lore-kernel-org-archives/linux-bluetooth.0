Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB2FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C9222B40
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 15:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="1P6Odhno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgHDPuO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:50:14 -0400
Received: from hoster906.com ([192.252.156.27]:33422 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgHDPuO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 11:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=dkim; bh=KUzPGjgFdmTe
        MjE9x68YrAgI6gQ33T8A1Sxd6wkaRT8=; b=1P6OdhnoKFljtq8bfjNJJ0WkeKtX
        +3Hk9BvSKSlnAYJPNegNHuMHJBl6gIyPYaNCtPkWIeNw2iH3Rjmv4naon8/UajKB
        jy7+0vi4dDUvEw1TJI3QhutxKxFjAITuBoGONlZlyjdPd9KXrVLIpY0Oo46dT+GI
        M1FDmlelwfWIJJE=
Received: (qmail 32015 invoked by uid 503); 4 Aug 2020 15:50:13 -0000
Received: from unknown (HELO ?192.168.254.79?) (mike@mnmoran.org@162.39.210.203)
  by hoster906.com with ESMTPA; 4 Aug 2020 15:50:13 -0000
Subject: Re: [PATCH v3] Checkpoint Bluetooth Mesh.
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
References: <20200804154758.1086522-1-mike@mnmoran.org>
From:   "Michael N. Moran" <mike@mnmoran.org>
Message-ID: <355b50ed-e82f-a0df-0447-eaf0e113cec4@mnmoran.org>
Date:   Tue, 4 Aug 2020 11:50:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804154758.1086522-1-mike@mnmoran.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Humble appologies.
GIT send-email n00b at work.
Please ignore these


On 8/4/20 11:47 AM, Michael N. Moran wrote:
> ---
>   rpi/libdirs.b |  2 ++
>   rpi/notes     | 29 -----------------------------
>   2 files changed, 2 insertions(+), 29 deletions(-)
> 
> diff --git a/rpi/libdirs.b b/rpi/libdirs.b
> index bf34b9b..f340ed9 100644
> --- a/rpi/libdirs.b
> +++ b/rpi/libdirs.b
> @@ -1,2 +1,4 @@
> +src/oscl/buffer
> +src/oscl/platform/posix/oscl/kernel/platform
>   +src/mnm/btmesh/libdirs.b
>   
> diff --git a/rpi/notes b/rpi/notes
> index 544184a..e69de29 100644
> --- a/rpi/notes
> +++ b/rpi/notes
> @@ -1,29 +0,0 @@
> -[0] HCI_COMMAND_PKT
> -[1-2] HCI_CMD_LE_SET_ADV_DATA
> -[3]	length Number of significant octets in data
> -
> -struct bt_hci_cmd_le_set_adv_data {
> -[3]    uint8_t  len;
> -[4-?]    uint8_t  data[31];
> -} __attribute__ ((packed));
> -
> -HCI_COMMAND_PKT
> -
> -struct ad_struct {
> -    uint8_t len;	sizeof(ad.type)+sizeof(pb_adv_pdu)+pdu_len
> -    uint8_t type;
> -    uint8_t data[]
> -}
> -
> -struct pb_adv_pdu {	pbadv*
> -    uint32_t link_id;
> -    uint8_t trans_num;
> -	pdu[]
> -	}
> -
> -//////////
> -HCI_CMD_LE_SET_ADV_ENABLE
> -struct bt_hci_cmd_le_set_adv_enable {
> -    uint8_t  enable;
> -}
> -
> 


-- 
Michael N. Moran           (h) 770 704 9751
218 Wilshire Terrace       (c) 678 521 5460
White, GA, USA 30184       http://mnmoran.org


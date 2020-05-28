Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9A0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 23:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E95E207BC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 23:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyb/W9Ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391517AbgE1XKz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 19:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389436AbgE1XKx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 19:10:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D03C08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 16:10:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z6so204793ljm.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 16:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1hI74fsImfPuzOYhKCiqTGXVkbsrfNvc/o9rskSKsiU=;
        b=cyb/W9NsfnyYf1ctJsYnps51ZWA7joFM9zLsxbxFfS2gpDhE4a6t5rdNzbGzK0Opzg
         6/fUu2g4l5jW54Tex606hhn6G0SY/ZcO7vW8DBg9cM5U7/g5CZPnSyHX0sKQpBTIitEN
         dKUA/JMrn2QVrnScv6Nng9xPj61Gf6yxfzUE5uZlkXmYtB/QtgR0KV4va2V6xVJSeYKd
         Sc+bxxZl6+Q8FDWZDVYnXm9SqQL6SkOvFRDVSY7w0jS3meMuQM4fFrX8a9lWGQHR8kFT
         MnZ8VuJftd+MM7oQu6ObG67iP7FyDVxMcWtIGwEzkAUiSMrykLlhcj7WCDoWrMAGugHj
         xi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hI74fsImfPuzOYhKCiqTGXVkbsrfNvc/o9rskSKsiU=;
        b=axc6WnDcxlUlEQWX4kI1e+bGi9xXDIgDJUoQ6247lUKVNnC2ruY2t3gwIne8S87+Wr
         TrIqavatlASbfq1skNA7F7rzt2LEn4m+0xWyxh9vRFc6djeouIy0IzDKx3AcZwtiP2sJ
         zy9iHjiTIKLlOFfvjdsL/vJF33s7LlaG0+yAfUV6Bb0iDe3YDVpAXiEI/zUa+Prlc+th
         IEzGHx5laTY4OWp05VR0s0g/lroV20WHHAPMai3Dw3Vvgv0ClmdRkMODHiyj9hmYXDmu
         Kjdrc+C2dYX0wjQInxQTYQcZWRTGIb1rjuwODI0mRg0rUiX21QpZgF/RvWN/M8csG82H
         VnYw==
X-Gm-Message-State: AOAM531RiwVYZfen1m3lXD51DQW5uvIZf2MxirhFlovD/FBZ9sCSX7hX
        o4nGdDNWs0OLYZRUIWKp0OfRkqCYM3Y=
X-Google-Smtp-Source: ABdhPJyuGggvGzi8eoYPOHdQNo5IsqHlIbwtrSj1XB81NTo01dmFQZ7rPfW+6322atclffh9w2BIpw==
X-Received: by 2002:a2e:7808:: with SMTP id t8mr2785070ljc.353.1590707450590;
        Thu, 28 May 2020 16:10:50 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-255-20-215.ip.moscow.rt.ru. [188.255.20.215])
        by smtp.gmail.com with ESMTPSA id s28sm1890161lfs.3.2020.05.28.16.10.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 16:10:49 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] avrcp: Don't attempt to load settings if on volume
 changed is supported
To:     linux-bluetooth@vger.kernel.org
References: <20200528215300.225894-1-luiz.dentz@gmail.com>
 <20200528215300.225894-2-luiz.dentz@gmail.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <37d5cdb5-4d05-ce02-ce5a-f53bff81bd31@gmail.com>
Date:   Fri, 29 May 2020 02:10:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528215300.225894-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2020-05-29 00:53, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If only volume changed is supported that means the player cannot really
> indicate track/metadata changes so don't attempt to read them.
> ---
>   profiles/audio/avrcp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 75811bf98..8b3debe46 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3814,6 +3814,10 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
>   	if (!session->controller || !session->controller->player)
>   		return FALSE;
>   
> +	/* Skip if player status/metadata if only volume changes is supported */
> +	if (events == (1 << AVRCP_EVENT_VOLUME_CHANGED))
> +		return FALSE;
> +
>   	if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
>   			!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>   		avrcp_list_player_attributes(session);
> 

This patchset works, MTW2 is able to connect and play audio. Many thanks!

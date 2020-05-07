Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E008C4724C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 23:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37F3208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 23:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUD7DLtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgEGXvj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 19:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbgEGXvj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 19:51:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E6BC05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 16:51:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f18so8225889lja.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 16:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=iEiEB2/wETuXARxHXZ7IfGB421qX2YsFAOFX0B5Jd7U=;
        b=sUD7DLtlxtNz5Y5UaY6EV01vGU+IGIngv+K5BjTWasxpe9kFSZJV2k+5XSVzdr42mR
         mSQL3eHoK3BCjr3c8P+1Fyv8nQUWdJnisc6JV9hWJTZzXzzB/8QKfT+TVwRS2nMyqAQu
         kbNGrOUrqKe1Ac0dJpZJX7QRkAuqSwlLuZtC0s+dm9YDT3quS5uxjYT0cRzywusDZ03x
         4k8zk290Ee1dLYzDOXgWTvDaneh7fj5vzvfCwlUTu6aA+JuTLvpoF2RyYNyd/RXA5Gps
         ueeqRhyjrMjNtjHmooPn+0owEYj/RVzYj/KRLK4JG5jurFXVFIlzoqwH85pCAugMOVhk
         MEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iEiEB2/wETuXARxHXZ7IfGB421qX2YsFAOFX0B5Jd7U=;
        b=jkdnCeHmAbcnqnD1/SBxUttsMGrAqqVrPmp9/d3F+ooJA/tK+B8nGhElEpSTfgfsv9
         cfgEqyA3YttFyN+gjc/i7pLptZsUhjUiM9ooa3jiCfGBPA5Ruhr3gJMslNLqWjPBRlb3
         6Mwvd6pBCBodZAmcFXU4J+yNLCtZhSW6HdeeGP18CR/o4OtypKbLmRHdxHr4V1C/BYX8
         8UX/DCq6zlBI0zmJeWuSvbXdYm/dt2PTESwfDf7KCikvkMfu/N8i3mm2vjzuRd6KCkEg
         n/hi2VCeDsasY9HRmvtKlI4PvrVqu84CSpDgndTfYTyEk5XRYQGfCKPxV+h0ll04lCNP
         H1/w==
X-Gm-Message-State: AGi0PuZzTlaQGCF1AMzUn6AGgmSSiGmd/OveqzMAgMq9e8GXLUkhs11h
        RAj6Wgg9qbh93Y5YAoz/MNAvFNmxDtU=
X-Google-Smtp-Source: APiQypKeLwqKfDWYIGuc8yuxvK6gTptPt6y1e2FVVzS/IYu6LFEJS54RCoT0SbQGU5MG/StunM2yGw==
X-Received: by 2002:a2e:9c09:: with SMTP id s9mr10024441lji.169.1588895496066;
        Thu, 07 May 2020 16:51:36 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-255-20-215.ip.moscow.rt.ru. [188.255.20.215])
        by smtp.gmail.com with ESMTPSA id j19sm2660807lfh.19.2020.05.07.16.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 16:51:34 -0700 (PDT)
Subject: Re: [PATCH BlueZ] avrcp: Handle not implemented response to
 AVRCP_LIST_PLAYER_ATTRIBUTES
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20200507210336.2703338-1-luiz.dentz@gmail.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <f8aa3d48-c335-7ffa-c2f8-411bba6c21a0@gmail.com>
Date:   Fri, 8 May 2020 02:51:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200507210336.2703338-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I think this patch is correct, but unfortunately, it doesn't solve the 
problem with the Sennheiser MTW2 reboot.

On 2020-05-08 00:03, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If remote device respond with ctype set to not implement don't continue
> parsing the packet.
> ---
>   profiles/audio/avrcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 6b3f685d2..773ccdb60 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -2223,7 +2223,7 @@ static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
>   	uint8_t len, count = 0;
>   	int i;
>   
> -	if (code == AVC_CTYPE_REJECTED)
> +	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
>   		return FALSE;
>   
>   	len = pdu->params[0];
> 


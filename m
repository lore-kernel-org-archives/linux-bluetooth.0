Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D835C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 22:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJRWCo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 18:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiJRWCn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 18:02:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897EBE525
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 15:02:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so13332253wmq.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJICzRHpo/InYiWtJTb9YBEZ99DH0FQgMyLbWgRHe6E=;
        b=ptHyTeeTr+MqF19rUyiyqHrnTwxRsIVb7e2HLXR1bjGBUcgRiS65umxizwlDHfZOLt
         j9/FRNF9wkfixcQ6kE9ak2ak7vvdzxTTEPDvKkJDgrF/jCMM/msDEo+OYgFoXiBPFg6x
         5QYqz1ryo9qEy8rcCIndMSEZAZUDt4cxLnNVqRRsyaur2+nm8jFTEfdp0SK2duLYOXb6
         UM/lvAH9e2936bLqF54VGxJq4GeRpbhPkkxMu9+Wpl7PJ4fMcGpQyR9hTXWbCB9dbCAI
         AuSGgLY3fADV4jR5wTKqodtByiZQ0bSiyl/EreEKllu4H2nWZxyBAPLEeFWOBJPdr1GN
         xOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJICzRHpo/InYiWtJTb9YBEZ99DH0FQgMyLbWgRHe6E=;
        b=04gOGCW8/KsKpUU4cgqlwh2jdSPEtQlXQfOZtaG+f6I3DRuFyVROFWqHNEzf/+u0TV
         qzALkRy8vjwSCXBObTCXStXSK6pwbEsZGfSs/AQBoV9FoXp6r81gA6746QxGLW5UpoDW
         bfLge1TOIyQMfMHO4zRGvgpWCMz82YqsVHP7n/FT9loZOS4Wdnz9cGecv+3abrI5e1GI
         j4/+I+5LsgE7M+v+zf6b7F0YMQb7iyfkE/fFMiEtYOMZhm2MZEAeZZxygNtkB7HHDkEt
         D00L2S45P1prCvxS5ILzzTL4ihxBz4bj4/OpEzBKst/xZHs6Fhk35mPMQ/rhuLBUtruv
         99bQ==
X-Gm-Message-State: ACrzQf2cfcCdtVJ6xb7Ybh+TjquJzz3G0WE3ZlJ5iW62rgrUo57iGlkj
        xcFsM7TEJZYMX89jl5vNnuU=
X-Google-Smtp-Source: AMsMyM5e6FtpWzQykNvs3Gf6Vm3T8YuyV1hM0I5TmQJFJjk+nOKfSVzcTMbDRJP/j77olgthhwUJEA==
X-Received: by 2002:a05:600c:4e8a:b0:3c6:de26:9d6e with SMTP id f10-20020a05600c4e8a00b003c6de269d6emr3503034wmq.117.1666130561220;
        Tue, 18 Oct 2022 15:02:41 -0700 (PDT)
Received: from [192.168.1.8] (67.227.121.78.rev.sfr.net. [78.121.227.67])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d4885000000b0022e55f40bc7sm11892846wrq.82.2022.10.18.15.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 15:02:40 -0700 (PDT)
Message-ID: <28551f84-eff3-74fa-b17c-cfa16b027280@gmail.com>
Date:   Wed, 19 Oct 2022 00:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix not restoring ISO buffer count
 on disconnect
Content-Language: fr
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20221017224147.3629459-1-luiz.dentz@gmail.com>
From:   =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
In-Reply-To: <20221017224147.3629459-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I tested this patch and I'm not able to reproduce the issue after 
applying it.

Tested-by: Frédéric Danis <frederic.danis@collabora.com>


Le 18/10/2022 à 00:41, Luiz Augusto von Dentz a écrit :
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When disconnecting an ISO link the controller may not generate
> HCI_EV_NUM_COMP_PKTS for unacked packets which needs to be restored in
> hci_conn_del otherwise the host would assume they are still in use and
> would not be able to use all the buffers available.
> 
> Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_conn.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 5d6ee5075642..df914f521c9d 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1067,10 +1067,21 @@ int hci_conn_del(struct hci_conn *conn)
>   			hdev->acl_cnt += conn->sent;
>   	} else {
>   		struct hci_conn *acl = conn->link;
> +
>   		if (acl) {
>   			acl->link = NULL;
>   			hci_conn_drop(acl);
>   		}
> +
> +		/* Unacked ISO frames */
> +		if (conn->type == ISO_LINK) {
> +			if (hdev->iso_pkts)
> +				hdev->iso_cnt += conn->sent;
> +			else if (hdev->le_pkts)
> +				hdev->le_cnt += conn->sent;
> +			else
> +				hdev->acl_cnt += conn->sent;
> +		}
>   	}
>   
>   	if (conn->amp_mgr)

-- 
Frédéric Danis                       Embedded Linux Consultant
frederic.danis.oss@gmail.com

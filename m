Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62091C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiIMSYi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiIMSYJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 14:24:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E10A00E9
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 10:41:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gh9so29275089ejc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DSh1fcAi92GNDS/3Lu1DZwLxqUAdErIjYKBy1wxIczo=;
        b=cwduGKBHK1M3FBFr19Lc8dW+XJikV82GhG5ZVkq5iWb8tu57WQAHUUSDC01MVCbTDB
         EUqXO4o8HpgmPunO8kzwpwSl7ymIwxjvwrTHnLRaXPyp5ZK3twbdrESYirEKNf/45kF9
         cVfuwd9HsUOzk8H71E/93NUHym6MAFnkqpn0XD3Tz6/MvUxHqQMvlNjK1iN6H9E1St4C
         qbIYGEI6f2plReESre+DEQgXSEvuC2/MTtw8GB0CrLidLpYhkMk8y5A4FLLVT7tSBCyQ
         TgaHu3XkqL1i895Jd1Yt3XP3D57CYxWS4AOPKBB6lhk18TpMiabRGQOMlk9aI+29riII
         3OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DSh1fcAi92GNDS/3Lu1DZwLxqUAdErIjYKBy1wxIczo=;
        b=HTo0WU48OxKUyomTIUbkAHwqNIGazcHWA5YGtCVfrpMMaXWxLUmIShTEyF944kzlH7
         m/PAewOoFnUNYoCLBLaqWqYcYEYU32a+gwBDir3dnYaCMjUmN3IEkC9A2MoDIpK6Nvvo
         Uu1wfI7tkhF9pZD8RHyrtgIsulIbzyR8C9dHVnwTd3tC9U18y7MMKiZ85lqkusB4s5d8
         VwC3jiXxkvqK8+DX3g1/7zvjxcRZ/k1iQJ967BzcP8MK468VL3Puj9a/o0t0uLW6XwTP
         Epi3QlnbbsNO+suoR54tvqOTs+jNV8MKLN2IdQ1E1Z9rbQHViO9WBCK1/p9+vGqHXIEz
         32yg==
X-Gm-Message-State: ACgBeo3Ya0QTqDcQordYSNjjl6yySH+IwKqCFNvsDb2yCp+PfhlTU9q1
        p+aX3eP4spLX+Pg/6uzSOd6dOKbwyRo=
X-Google-Smtp-Source: AA6agR4L6MT62NBEzAIR113tjmnA14PrPpa/yRda/0C9OJ+liGnAOF7GYKk104RLZbfYh+0tTX+iXw==
X-Received: by 2002:a17:907:2bf4:b0:76f:1053:6e4 with SMTP id gv52-20020a1709072bf400b0076f105306e4mr22727681ejc.443.1663090860408;
        Tue, 13 Sep 2022 10:41:00 -0700 (PDT)
Received: from ?IPV6:2a02:1811:cc83:eef0:f2b6:6987:9238:41ca? (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id h15-20020aa7c94f000000b00451ea135705sm3932139edt.92.2022.09.13.10.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 10:40:59 -0700 (PDT)
Message-ID: <34e66c3a-5966-6b08-aed0-36ec1517a76b@gmail.com>
Date:   Tue, 13 Sep 2022 19:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] Bluetooth: protect remote oob data in build_pairing_cmd's
 callsites
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20220913152016.38691-1-dossche.niels@gmail.com>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <20220913152016.38691-1-dossche.niels@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 9/13/22 17:20, Niels Dossche wrote:
> Accesses to hci_dev->remote_oob_data are protected by the hdev lock,
> except for the access in build_pairing_cmd via hci_find_remote_oob_data.
> Adding the lock around the access in build_pairing_cmd would cause a
> lock ordering problem: the l2cap_chan_lock is taken in the caller
> smp_conn_security, while the hdev lock should be taken before the chan
> lock.
> The solution is to add the hdev lock to the callsites of
> build_pairing_cmd.
> 
> Fixes: 02b05bd8b0a6 ("Bluetooth: Set SMP OOB flag if OOB data is available")
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
> 
> Note:
> I am currently working on a static analyser to detect missing locks
> using type-based static analysis, which reported the missing lock on
> v6.0-rc5. I manually verified the report by looking at the code,
> so that I do not send wrong information or patches.
> After concluding that this seems to be a true positive, I created
> this patch. I have only managed to compile-test this patch on x86_64.
> After applying the patch, my analyser no longer reports the potential
> bug.
> 
>  net/bluetooth/smp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 11f853d0500f..3efa99fa5062 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -1803,7 +1803,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
>  		return 0;
>  	}
>  
> +	hci_dev_lock(dev);
>  	build_pairing_cmd(conn, req, &rsp, auth);
> +	hci_dev_unlock(hdev);
>  
>  	if (rsp.auth_req & SMP_AUTH_SC) {
>  		set_bit(SMP_FLAG_SC, &smp->flags);
> @@ -2335,7 +2337,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
>  	skb_pull(skb, sizeof(*rp));
>  
>  	memset(&cp, 0, sizeof(cp));
> +	hci_dev_lock(hdev);
>  	build_pairing_cmd(conn, &cp, NULL, auth);
> +	hci_dev_unlock(hdev);
>  
>  	smp->preq[0] = SMP_CMD_PAIRING_REQ;
>  	memcpy(&smp->preq[1], &cp, sizeof(cp));
> @@ -2380,6 +2384,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
>  		return 1;
>  	}
>  
> +	hci_dev_lock(hcon->hdev);
>  	l2cap_chan_lock(chan);
>  
>  	/* If SMP is already in progress ignore this request */
> @@ -2435,6 +2440,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
>  
>  unlock:
>  	l2cap_chan_unlock(chan);
> +	hci_dev_unlock(hcon->hdev);
>  	return ret;
>  }
>  

I'm sorry. The build failure is because I forgot to amend my commit locally. I've sent a v2 with all the changes.

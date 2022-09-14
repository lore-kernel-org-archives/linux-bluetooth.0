Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2792ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 09:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiINJr3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Sep 2022 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiINJr2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Sep 2022 05:47:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F47161B3C
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 02:47:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a26so4679252ejc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xX1BC1zE+4pPFFRGV5eLSMuFNVycNGnz7b+F9WB7kfU=;
        b=GeVEAHXzEIfPUiJgaGKejWbceYG2XhGbqyUjD1rf8cMuMf/9070HTgrNa+nigLY6si
         YR5xU6r4tgU1WHa7h68bMKBqvrM0or6JiHN/MfFTTP2exOYyvfOJ/GDJdTrE4s+AuryS
         sjLYcdAkkB5wkRaluBdFG5VS5ielI7lG4LW4eYoVSgHh2PtlYBIvnrOkctn+CFtejZ1R
         y2FlxYswXQXuLBcVth+ZKJa8/gMeEqb3NHQEMbgfVAU2uIsrQJqgVBMQpNR/wfTCuPXY
         NHpUC5FyUxPbOHDA7o+sNJRawed+830ooM2OOrGZFY8ULZjHVTiw/ojDQCxxwvDWBtiY
         aKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xX1BC1zE+4pPFFRGV5eLSMuFNVycNGnz7b+F9WB7kfU=;
        b=VWwi7wFCvtHOa+HiG8zy5z3IS2Ca0K23OyXFlpgRvjO6MdmfgPhq8NBNZnOsjAWXNW
         O90aIf2ERZMSt2c1PSUZ0Y81xfEkuuQXfxlkkFGjNHSe1qDXzhEci1RSDlBwWnGJp6bs
         OKWr18o/x/f29TRHx87fVUvKrJ7Z66+scR0UMQwWvP35au9pAkqZ7IWSBtegtyT2vSB8
         cvaWRyFyj6RP3DQ8+I6m9RiHaWgzQ/kuouKIghbSwOpPcToGBI0rzVMsA2iqiIikDucz
         eB+tHUNyy84+yt88N73fMfw5uTZFd9q58TS7Bzpyy3relM84hSxzjpkKiQ9m2EL0xziI
         qDHw==
X-Gm-Message-State: ACgBeo3lQfS8bWLsh3DdcQVk+SWsxBq8MIr8LfQOnxwV7sTopOr5o3dM
        f7pFKNphG9jut7V5T6LIr8u9t+cRqrA=
X-Google-Smtp-Source: AA6agR5rd9KYrSAHonCch6kl7ABtW36y30Ee456mSwYvShb4R4hj3WkCwGdbPq2Fw4QrMrcrlUM3zw==
X-Received: by 2002:a17:907:7678:b0:730:e1ad:b128 with SMTP id kk24-20020a170907767800b00730e1adb128mr25341949ejc.67.1663148845857;
        Wed, 14 Sep 2022 02:47:25 -0700 (PDT)
Received: from [172.17.234.72] (nata162.ugent.be. [157.193.240.162])
        by smtp.gmail.com with ESMTPSA id c11-20020a170906924b00b0072a881b21d8sm7288654ejx.119.2022.09.14.02.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 02:47:25 -0700 (PDT)
Message-ID: <00660cd3-7d71-13a4-f617-229e6defb701@gmail.com>
Date:   Wed, 14 Sep 2022 11:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] Bluetooth: protect remote oob data in
 build_pairing_cmd's callsites
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20220913173907.13792-1-dossche.niels@gmail.com>
Content-Language: en-US
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <20220913173907.13792-1-dossche.niels@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 9/13/22 19:39, Niels Dossche wrote:
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
> index 11f853d0500f..6611a789b6c1 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -1803,7 +1803,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
>  		return 0;
>  	}
>  
> +	hci_dev_lock(hdev);
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

Please disregard this patch as this can cause a deadlock as I now tested this with the CI runner locally.
Sorry for the inconvenience.

First, the lock in smp_cmd_security_req is not needed. Second, there is still a lock ordering problem with the other two callsites.
smp_sig_chan can call both smp_cmd_pairing_req and smp_cmd_security_req, at which point the hdev lock is not taken and the race is possible as far as I know, so the lock would be necessary.
The problem is however that taking the lock inside smp_cmd_pairing_req and smp_cmd_security_req around build_pairing_cmd will cause a lock ordering problem as that means hdev lock is taken after the chan->lock.
I don't know how to approach this from here on.
Thanks

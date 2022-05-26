Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC58C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 11:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347153AbiEZLYo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 07:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347150AbiEZLYj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 07:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9DCF95499
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653564276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHAlnYokbPDm5sHzersK7AiNCY1b15v1iGws20Njocw=;
        b=aVDAczMq9nRxOLYbwWDuqmBJIhqvC17XLoLFl1CkE3VEE3BJ+xxYYh6N41BkkwAUaJT+O5
        ur2j0bsELLMONzNNoVW8fpr3WKOEroC7aywhjT/SZIRieJ79i+45soj29BOW3i4FJZlOLv
        3TaNxFZODJP+3YUKr/jwGkuspAGVaug=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-W2UxU_LAP52rw9nuGWyLsw-1; Thu, 26 May 2022 07:24:35 -0400
X-MC-Unique: W2UxU_LAP52rw9nuGWyLsw-1
Received: by mail-wr1-f72.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so220405wrg.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rHAlnYokbPDm5sHzersK7AiNCY1b15v1iGws20Njocw=;
        b=bViDKKBnyBMZXGQZE5No8baEaCWgVRSmuLmyOMclB2/MrJ87S/CMZBHv4huV+G/ksa
         JX5EMCSLTxLcJ/W2nF/MxvwAshcYT0aNGBqeMK6zWpfTmlsw3RUbwFsKvnbCstkrNNan
         lmcLYIRKRZ0tfVTjPGELssLYyYUqREkvQxF6VtomdEesiKr6BbIKBV+3oJToGR9BdDZS
         /2QhbKaGcY7tunpg1/lm8U5iHFHLxDZ0rW5XUvHYnJxFhql+ka5cIgdYKEgY6S6XATx3
         QqyABRGhxM/xR4UJw/V3bDON7vgRF+liAi4NR3Acr/gQl3lOm3lgnJsT/3UxckmGBhs0
         GJnw==
X-Gm-Message-State: AOAM530PwU3Zc7VN92mTgRnZ8YX9QSee/s4nSEDHRa8KfkYjGRjXCYkF
        F0ulJOA9myJhsUeFjsVtKeUKsBEaudEgXce+sQc6BgROOC0OCecL8Y2lhOdBCMG+PZ1sPxnJ0v0
        0Vmuj7iuoEQnIMQuDdxCnBe9kNMsx
X-Received: by 2002:adf:d1c6:0:b0:20f:c7dc:8466 with SMTP id b6-20020adfd1c6000000b0020fc7dc8466mr20941655wrd.43.1653564274207;
        Thu, 26 May 2022 04:24:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVhEt94v61sw8ti8f9sTXCoLOXwnzyGUf1wdEfVwHoxd1ZJYbH2PGE0KfqATe1+yEk07VXVQ==
X-Received: by 2002:adf:d1c6:0:b0:20f:c7dc:8466 with SMTP id b6-20020adfd1c6000000b0020fc7dc8466mr20941635wrd.43.1653564274009;
        Thu, 26 May 2022 04:24:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id z24-20020a7bc7d8000000b003974ba5cacdsm1570171wmk.35.2022.05.26.04.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:24:33 -0700 (PDT)
Message-ID: <081b216e6496e8cc2284df191dcc2d8b604d04f7.camel@redhat.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: fix potential double free in
 le_scan_cleanup()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 26 May 2022 13:24:32 +0200
In-Reply-To: <20220526094918.482971-1-niejianglei2021@163.com>
References: <20220526094918.482971-1-niejianglei2021@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2022-05-26 at 17:49 +0800, Jianglei Nie wrote:
> When "c == conn" is true, hci_conn_cleanup() is called. The
> hci_conn_cleanup() calls hci_dev_put() and hci_conn_put() in
> its function implementation. hci_dev_put() and hci_conn_put()
> will free the relevant resource if the reference count reaches
> zero, which may lead to a double free when hci_dev_put() and
> hci_conn_put() are called again.
> 
> We should add a return to this function after hci_conn_cleanup()
> is called.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  net/bluetooth/hci_conn.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index fe803bee419a..7b3e91eb9fa3 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -166,6 +166,7 @@ static void le_scan_cleanup(struct work_struct *work)
>  	if (c == conn) {
>  		hci_connect_le_scan_cleanup(conn);
>  		hci_conn_cleanup(conn);
> +		return;

This looks not correct. At very least you should release the
hci_dev_lock.

Cheers,

Paolo


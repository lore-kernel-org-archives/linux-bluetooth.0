Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42078C32772
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 15:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbiHWPcT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbiHWPcC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 11:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B3F250D88
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661253432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vFwWtlaXBJfhkm+20Q4BimLsKsx1b4GpBGhXdNHVUg=;
        b=RNtXynllRVysYO2sjwjsBDsxX9p++HJlxLp2W1lPoJl72mu7/93SG1oLWYUt8sHb8Q+i+V
        yQ+LCxaohtM8HjYkJ61Q2FrrNkK0FeoAjAjhFZK5k9vFFQEehNpUaJsucilnfY8pb+biBU
        F/KOkzDQS14pTCYzCTn+fjv8Sbjkhv0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-533-4av-clwwNAGbcMzzr5XUZg-1; Tue, 23 Aug 2022 07:06:52 -0400
X-MC-Unique: 4av-clwwNAGbcMzzr5XUZg-1
Received: by mail-wm1-f71.google.com with SMTP id r10-20020a1c440a000000b003a538a648a9so7793352wma.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 04:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=9vFwWtlaXBJfhkm+20Q4BimLsKsx1b4GpBGhXdNHVUg=;
        b=HMqLFsPPBLQvCyQDMMsC5Zm3LSTDy357hjqwS/35mqdmxRPCoRkl024vyxqDNWVSoh
         Nqk6PCTFJzolYCtx3c2XmNKmMckN2oDa5dzgK8ZoODkxztOkQNjIE0ZhQoCCxpImUVr6
         8lJJlDtwWTAZMCKbxhDef4ZJGsT6JCKkyPdGMPYEWdOT0lJD6v25o+LyxYQH5gizQB0U
         GiSA19xVAjWwoktpPOHZpdbE6flcwH1VBdNLQ6hOWK9Lzqda0UMkgfwaKxcWCQdmefTI
         puvdpS8ZBxD5qY1Yg9oBfCSnl6dVhrAFMc9qxR1QzeN6AYhGvOakiUvg5j1/rikIJfWQ
         Hp9w==
X-Gm-Message-State: ACgBeo20K3o/XgakK4MCBiZYDchA66k9YH5ZxueUn3UVfqXoypFx88hv
        Eax/eQm9ZB6ESAcM9i/EIc9sTifGfpP07K8yLZQBW1Lj2ujHryP3/Wb3gjMZk7uLwagks7KHSYL
        +No5CRlhRGOWLcGdvKovCXsONzrUo
X-Received: by 2002:a05:600c:384f:b0:3a6:603c:4338 with SMTP id s15-20020a05600c384f00b003a6603c4338mr1822493wmr.192.1661252811619;
        Tue, 23 Aug 2022 04:06:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5DCT0OQblrn5cXEd8HIrkGgjZmmi8yFbjusnd23J8AN0pMS1n6Obdq1k352nw99irqcnP1SQ==
X-Received: by 2002:a05:600c:384f:b0:3a6:603c:4338 with SMTP id s15-20020a05600c384f00b003a6603c4338mr1822481wmr.192.1661252811386;
        Tue, 23 Aug 2022 04:06:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id i6-20020a5d4386000000b0022159d92004sm8043071wrq.82.2022.08.23.04.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 04:06:50 -0700 (PDT)
Message-ID: <6e47d3d9f8cc73c6baf26d2b5f320d51f67d9a04.camel@redhat.com>
Subject: Re: [kernel PATCH v2 1/1] Bluetooth: hci_sync: hold hdev->lock when
 cleanup hci_conn
From:   Paolo Abeni <pabeni@redhat.com>
To:     Zhengping Jiang <jiangzp@google.com>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Tue, 23 Aug 2022 13:06:49 +0200
In-Reply-To: <20220822214430.kernel.v2.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
References: <20220823044434.3402413-1-jiangzp@google.com>
         <20220822214430.kernel.v2.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2022-08-22 at 21:44 -0700, Zhengping Jiang wrote:
> When disconnecting all devices, hci_conn_failed is used to cleanup
> hci_conn object when the hci_conn object cannot be aborted.
> The function hci_conn_failed requires the caller holds hdev->lock.
> 
> Fixes: 9b3628d79b46f ("Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted")
> 
> Signed-off-by: Zhengping Jiang <jiangzp@google.com>

For the records, you should avoid empty lines between the 'fixes' tag
and your SoB.

Cheers,

Paolo


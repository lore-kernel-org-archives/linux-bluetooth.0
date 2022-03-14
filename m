Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE36C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 13:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbiCNNv6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiCNNv6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 09:51:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA6BB18
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 06:50:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id yy13so34154461ejb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XPW+xN5XoCrDs0Y4efAkfo4v193eBPz15LBopnsBJk=;
        b=6A81bsXgIwGOjyJpp+kEhTRqUtshXCX1tAHw1Q5TxZhRyWpTY/7l78rGWRK0w3bUjK
         /zzpvboEM5Oa26QP6ZwvJmIfI7B60KxZ+3nGI4rBM7vaJy65KHtjDtfHSJdGCU/X7c7I
         z5yZ9aCXELi9yn8QgtZTHf1iXjOd2Xwkara1gQ3NrcLV69LexA3e6BFZwmr0ywGpKVpq
         jAw975QsbbZ9bx6LJVVI663IT1JaMYJYOIp5J+swJnO2GnD0NYMiFYc+0aw97pzDeSuX
         8AFuInoe4M8gjT6tjRT+N/FFhUoje8Vm98jbLJdMZ4AtUl3cR9HONK1F9Np7twl2TlX5
         AjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XPW+xN5XoCrDs0Y4efAkfo4v193eBPz15LBopnsBJk=;
        b=JK6aK1hms9T5TpPPPFwkjRTZv10ko6xhrvGsZf8Bf/sj+2qCb2Np3VaSuIKstgRLXT
         g72rJI/5ptUWFioOKhXfYS4djI/8c7/4jd1ROHqcvTxDvRtQceoUfJ0tWm7GzxB43l+c
         IZ4RQh3e+In0NQD1Hcec00wvLyfLsOZ0Vxy+bXf2BLdy0syzyKIlJELVKAwjEFXBqSYi
         WXow/MYvuPNpl8aKyptaBewDtO4GxG8Rfhu3nTlpB15lMTR3Ta8vJIWRml8e5J+d4oJ0
         7jjyxv6/MaAURTaJ43b1JIJ7RMDAbkWJp83pAa9b9MBZKCi4xFdP1msHQEsrMkHoeFGf
         P2OA==
X-Gm-Message-State: AOAM53322x9lC3VRUB68TpHRSBugqlxip8gFw/y480MqGcs6LgSv/Xnl
        +nSyYEh+AorFLbc/139ETozzate3UmGl+7RJ
X-Google-Smtp-Source: ABdhPJzC++1j5BwogAXOLTD7SVsZrVTINyJ9kFawYi2cPI2Kljw5AmXsxnFqEgUBFoUeIYLHPaWn5g==
X-Received: by 2002:a17:906:d54f:b0:6db:ade0:9829 with SMTP id cr15-20020a170906d54f00b006dbade09829mr11648244ejc.127.1647265846451;
        Mon, 14 Mar 2022 06:50:46 -0700 (PDT)
Received: from axion.fireburn.co.uk.fireburn.co.uk ([2a01:4b00:f40e:900::24e])
        by smtp.gmail.com with ESMTPSA id i22-20020a170906251600b006d6d9081f46sm6810072ejb.150.2022.03.14.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 06:50:45 -0700 (PDT)
From:   Mike Lothian <mike@fireburn.co.uk>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_event: Fix HCI_EV_VENDOR max_len
Date:   Mon, 14 Mar 2022 13:50:44 +0000
Message-Id: <20220314135044.2040-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220125185305.2419774-1-luiz.dentz@gmail.com>
References: <20220125185305.2419774-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

I've only just noticed this patch solves my issue

https://lore.kernel.org/netdev/20220125144639.2226-1-mike@fireburn.co.uk/

Can it be added to stable too?

My patch can then be ignored:

https://patchwork.kernel.org/project/bluetooth/patch/20220312164550.1810665-1-mike@fireburn.co.uk/

Thanks

Mike


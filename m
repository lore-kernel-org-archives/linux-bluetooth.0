Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90750C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 14:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580507AbiAYOud (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389233AbiAYOqq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 09:46:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C405EC061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 06:46:42 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n8so25492472wmk.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 06:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jahFylLFQ4FlT07WI99OSrQG5jbtrsRBcgJaIkG4L6A=;
        b=UDcH1PgtLKoIYH3SlII+wx0/4ofsh2TWpwqNN3rDGUJPyk+oh+Ofe+0qIWvuCtbZP9
         Zgu4ogZ/grDV2ZBFLBQEkf3Cdw/+WoY/f+letjDjKKzHbvteFgVvNQOc8azY+NjzTZnq
         q/gZUi14p4GVYPMIcRdT6pOGfuFEnhYuW8zq0Hs2mCQe1rx9o8NHzFlHuYDddGMSLdzY
         SFhTjK+e+qkLJqs6FEWnWK/qjEgmJnbzvPIBRiky67qJ9TOlhcFhe+Bt1DHsNgYvXpuv
         +lzO9TyuPP4zTG1NilhtdAlH5z42n8fN1N8MVQxkH+ImbOhMWk5qgnaAhgTRv5rtAmXD
         fhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jahFylLFQ4FlT07WI99OSrQG5jbtrsRBcgJaIkG4L6A=;
        b=bKEfNIgFu0trSYiBF5poadLO/gAS2VpSa42s0o7rtk9SJMIPpgSrVK6jGePAGqq6hX
         CWyomkwmhIFdwOlBBjOidVxWpD9358bX/U5c8BJXOHnswOFMgs5QoWVLIEH8wN5l3TPo
         u5ThHXRC6aFhCo2PfrJM+fihwRuV14NiAncZ3reazC/Pk8mMvrH+7yJhd7Sh2CedPh/k
         fypyfYjtQbo1aIFIldAuOkuzMrFdVYVLu0EwJ5ZwZt1PZ9sskHMDwI3mrFs4ms9MSprd
         NtxsudTJIsB/i4M1zyz75IwYemSIQEfJPoUJH9jnN2GqeDl0HQ4HkjePBgKnIEBW7mKq
         QOdA==
X-Gm-Message-State: AOAM531zjyd6rPFmGv0kEdbQ9GX0t5MK8MLA4+9CdUMe+h3GzwuiIkuY
        Ek3Wr6CwjuPdCZFVLsI3VxP8eA==
X-Google-Smtp-Source: ABdhPJw4nvjztWbIig7Vl7dTcWWYzXRT6fmIpUqOb838PP6ua48xE1nLJHoHzDqJSYrIG8Pgx+jUOA==
X-Received: by 2002:a7b:c04b:: with SMTP id u11mr3392710wmc.104.1643122001214;
        Tue, 25 Jan 2022 06:46:41 -0800 (PST)
Received: from axion.fireburn.co.uk.lan ([2a01:4b00:f40e:900::64c])
        by smtp.gmail.com with ESMTPSA id w9sm579631wmc.36.2022.01.25.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:46:40 -0800 (PST)
From:   Mike Lothian <mike@fireburn.co.uk>
To:     luiz.dentz@gmail.com
Cc:     dan.carpenter@oracle.com, davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH 12/15] Bluetooth: hci_event: Use of a function table to handle HCI events
Date:   Tue, 25 Jan 2022 14:46:39 +0000
Message-Id: <20220125144639.2226-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20211201000215.1134831-13-luiz.dentz@gmail.com>
References: <20211201000215.1134831-13-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

This patch is causing a lot of spam in my dmesg at boot until it seems my wifi connects (or perhaps the bluetooth manager does something)

Bluetooth: hci0: unexpected event 0xff length: 5 > 0

Thanks

Mike

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A343AC7EE3A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 06:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbjEXGiw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 02:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239743AbjEXGil (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 02:38:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB74C189
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 23:38:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3093a7b71fbso344286f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 23:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684910318; x=1687502318;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjGg8aP9lSrFbHZtI1+yssCGmLexd80eMenQGevKTbk=;
        b=ud/SODPw7xjzhluzm88/yW67P7cMWJulS+ct5eFHjM1NJEgPuVRFHPRMFlXpgXiuVC
         cgd8RlpTFkrxhTfDJSQDMWfA2cmxDfe2abeMkMeV7TsqaJl6ddTQXxNCclRV3sDQmiuS
         Ed0fViISv0VeKAsZTlqK0gu+u/S0ztqMem6h52snWUp9hUa4V5lFB6EldL0pw+dbVwPO
         3eJxDpsbfbk9B7q6AtlvoorMbU1ZSOc/SzDa5G5faurChSFv2snhsh8tM45rtgTQofH1
         VGQ6bVV3Aa9jHfNWCVtDjYAGYWQyFzPv6res0d4U7MgB8HPMdV5em46Q4YJ3q5L8YCAu
         OfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910318; x=1687502318;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjGg8aP9lSrFbHZtI1+yssCGmLexd80eMenQGevKTbk=;
        b=Q09HKHhsmrssiHGY46yMHaC8bScDKN0BNM5teZphJPt/tFSBA0pr96js6yfpVPIyyH
         TbXgiglHjhSQR4hDoeAUlA+C7m0IjMhtdWSokDXueEHNysc97GoohLnAcapUFoGbOH9T
         Y3H3o+fkY+AaDBvarDuoeqSIxf4e3MAX8KffuZYr0RXLVJ6bvyNhA55Z5GQqjW0TqbeL
         QRmKQc7RqlrFPby5vVOIKsLXGBZltyVL1+FPQ775ICtP0dYHEL6+yd93lX2jBaHzGqW/
         B94TONXnSyZhhu4LG7uATnLi/pqlIdWlocjVnQirCYmR4PlZjVSjJip1ptPLB1spTfOB
         3Gvg==
X-Gm-Message-State: AC+VfDxQeyMybc/wi4nEQA+CM9vZGOZCI+p1AztWKDfR4fceqT0f44r/
        SwOPQ5fvvDwTBsI5N8hSBpIfq/UXKwOLNV3rfSQ=
X-Google-Smtp-Source: ACHHUZ5/57hMrDRrFo1ezsXMRMh7UWyL5jQ/jM0zpZ5iYylIp4lfqj+IrYP1AiY4GqkSingUHfcu9Q==
X-Received: by 2002:a5d:51c8:0:b0:309:3449:2886 with SMTP id n8-20020a5d51c8000000b0030934492886mr11356562wrv.39.1684910318263;
        Tue, 23 May 2023 23:38:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d4e11000000b003063772a55bsm13272656wrt.61.2023.05.23.23.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:38:37 -0700 (PDT)
Date:   Wed, 24 May 2023 09:38:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: Add initial implementation of BIS connections
Message-ID: <e52365b8-f5ee-48d9-ba86-34c4b350c8e3@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz Augusto von Dentz,

The patch eca0ae4aea66: "Bluetooth: Add initial implementation of BIS
connections" from Mar 9, 2022, leads to the following Smatch static
checker warning:

	net/bluetooth/hci_conn.c:943 hci_le_remove_cig()
	warn: passing zero to 'ERR_PTR'

net/bluetooth/hci_conn.c
    939 static int hci_le_remove_cig(struct hci_dev *hdev, u8 handle)
                                                           ^^^^^^^^^^

    940 {
    941         bt_dev_dbg(hdev, "handle 0x%2.2x", handle);
    942 
--> 943         return hci_cmd_sync_queue(hdev, remove_cig_sync, ERR_PTR(handle), NULL);
                                                                         ^^^^^^
handle is a u8.  It can hold error codes.

    944 }

regards,
dan carpenter

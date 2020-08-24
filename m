Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D9BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 04:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7FD2074D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 04:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSnacnz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHXE15 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 00:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgHXE15 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 00:27:57 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC53C061573
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2020 21:27:56 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m7so6330803qki.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2020 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TgYhbpDn3D0QSoFG2P+Jzpa0v4YA7FN0UjYK2FNiWsQ=;
        b=qSnacnz1I1cf4KLLZQMOyGCoh6NtlMhwUwWi3/HcTlMNbDkBJ9OsRJp/6VNI57Rfze
         uU1U+STFuozTanmdTeB1Ovb9L9qC24rbj/WOiHDM/IKEPyTp3lJl4Zx4YrPNpwqWMTL7
         y4lx36+mHxKGwOl7tNbUFNVXwfU46lN9QoUkjhAYaUFVAWyJ5jk8J68cdPygn2ryUqyc
         zJlqzQHhS887a78x4ggezCCGPtzyeAPKXJI/spdOGMW5OkW+TC4zd7V8OCMfPNaTyELB
         iQxiqN0faGviplVQi9nlhBipwzC5QKMSQz+XYIhpl/tpP/NnD1tB9OA1uFuzhrbBuHrz
         4doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TgYhbpDn3D0QSoFG2P+Jzpa0v4YA7FN0UjYK2FNiWsQ=;
        b=DlgeWqKdWO4kENSFZQ1UfKU9e/UZ208DVMK8UgUqxp8zhLE89x7N7rxPorT/R5Yduy
         2UDg5y/pz1566JbPVM99gE6BX37OHDaQTpzjKdt+9tjpmIOqAbhMtDDmnqN4FdVCUofv
         ahofuDs2vSSq+FIS6nNK/NtTAjxbLD376RQTHoNN71KdTig336vkbcvWGMlQZ0YmqT7B
         y9/N8l1EmP6bi/lBTYQ/De8ndLhWMmJnSjkvTkcRt2XLr53raE9QGYnZvCzyKHm0f6h4
         LRgls6zFISAzlRgr2sCTouotzBxxjBCYKU6DnGsxI5AeNjyaUnW6J7gV3hF3DeW4lTKM
         +OyA==
X-Gm-Message-State: AOAM532ObOhyRcPkr547LoSJ4rwgHBEM3g9AvlsEz7awu8Kn4apglAm2
        26+lBgUltUBYLpLNxudlGHkqh/AOGSw2MQ==
X-Google-Smtp-Source: ABdhPJzKnNroZADnOg/ujqXYqfTIWxdUuRbG7X9U9AZ+tPN9lMe3dFMI+ddJUaS/6nGmyt55Ri8i8Q==
X-Received: by 2002:a05:620a:652:: with SMTP id a18mr3206729qka.165.1598243275619;
        Sun, 23 Aug 2020 21:27:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.104.30])
        by smtp.gmail.com with ESMTPSA id n33sm10246879qtd.43.2020.08.23.21.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 21:27:55 -0700 (PDT)
Message-ID: <5f4341cb.1c69fb81.9bb8a.9693@mx.google.com>
Date:   Sun, 23 Aug 2020 21:27:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3150478193455029858=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,1/4] doc/mesh-api: Add "options" dictionary to Send/Publish
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200824035415.13420-2-inga.stotland@intel.com>
References: <20200824035415.13420-2-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3150478193455029858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
8: B3 Line contains hard tab characters (\t): "    		      one-segment messages"



---
Regards,
Linux Bluetooth

--===============3150478193455029858==--

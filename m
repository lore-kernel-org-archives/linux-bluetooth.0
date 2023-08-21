Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D630EE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 18:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHUS5J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjHUS5I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 14:57:08 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4541FFE
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 11:56:31 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bda8559fddso1041248a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692644153; x=1693248953;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EUVjODFl5J8mnUazYw0SUvEWLllQNMS1FBTBMdJEdX4=;
        b=a3fsp85/tHTCxvAc++pgMqLS1enfN6Ks+iM8avPNyht3ImcVzvhhBBKHHqSrPgELSL
         CgHHlclT00NxvIvi2eD5pg2CJK7CoBhDpgAMsGw8iR8lcg5Tt3nF+ydohAEbqiLGwsnY
         nPao8O49QJYbvuZyUT1/hMz6CpPi6eP6oIIfczhPBSolR2QDjUyy5ZJFAtk5bwhpEPHO
         hxm32usFGJOApaIvDog6QQofAtOHauX8zS8+W5YkmtW+9FSp/COc/oaoze/cEtaSdwmY
         q9tpckOOVY+Y5W3oLX1d6b2Q1e5zZcJVvzEnkOrOh5aS+DwlSctZnhBeKmo76VAkgdQS
         WK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692644153; x=1693248953;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUVjODFl5J8mnUazYw0SUvEWLllQNMS1FBTBMdJEdX4=;
        b=TXxlGAQTdUw/u8+Vk3BUj8VtEo3C8rww3nbZsCl8gzPbTtUYjKZTreRiKaehr8v+Mh
         4/cD6l07u71sgnEkJrD1GMXYxPA8e783UEMh/YgZIXKLm7cphMTx8gYrOOi6wNVfojX7
         ogkqUBPK0d+1WzZcP1yJuJ4JMFFjmWbqi0Tr2oCJpE7aYFLMnMkcr2PrgANRXDdjR95j
         p/nCT/EOfWRQIn2J81ePQj22MPhDgGnT5XaAyz9BZ33dT4Ss9fkTBI2+AG7Gu7LnlZO/
         xpO+sKXqEjkadBoOT4VaUXJunnm8Xwf0f9kzadGY+BmCa02XSbcipjDNueWMnqElRewk
         /VWw==
X-Gm-Message-State: AOJu0Yzo6m56LWfsj1xmYgwHbbeJIGE+ttKHZMDWml0Gdq7PM9VpJai1
        xTNWCreN8ippouY6A9qzFQ6nqv0qHhk=
X-Google-Smtp-Source: AGHT+IHyZs16Bydqh25RODA8kt9unsgR23jMtHb4WxdSfwCSUVZ0uolonLsVm+5gc7zXW9ZlVPDoSA==
X-Received: by 2002:a05:6358:3398:b0:135:51a5:4da0 with SMTP id i24-20020a056358339800b0013551a54da0mr6519762rwd.1.1692644153232;
        Mon, 21 Aug 2023 11:55:53 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.96.42])
        by smtp.gmail.com with ESMTPSA id ev9-20020a05622a510900b004109d386323sm590641qtb.66.2023.08.21.11.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:55:53 -0700 (PDT)
Message-ID: <64e3b339.050a0220.4fca3.31c8@mx.google.com>
Date:   Mon, 21 Aug 2023 11:55:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5777249199834957860=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [Bluez,v1] adapter: check wake_override when setting device privacy
In-Reply-To: <20230821102810.Bluez.v1.1.Ib819b0964a5b8339305d94611acab85774a6c8ce@changeid>
References: <20230821102810.Bluez.v1.1.Ib819b0964a5b8339305d94611acab85774a6c8ce@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5777249199834957860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777963

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      33.46 seconds
BluezMake                     PASS      1188.33 seconds
MakeCheck                     PASS      13.16 seconds
MakeDistcheck                 PASS      194.36 seconds
CheckValgrind                 PASS      317.52 seconds
CheckSmatch                   PASS      440.99 seconds
bluezmakeextell               PASS      134.63 seconds
IncrementalBuild              PASS      1031.74 seconds
ScanBuild                     PASS      1340.51 seconds



---
Regards,
Linux Bluetooth


--===============5777249199834957860==--

Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88561C0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3718920827
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="e4QSHBPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3718920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=silvair.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeKHCdY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:24 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:46259 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeKHCdY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:24 -0500
Received: by mail-lf1-f44.google.com with SMTP id f23so7456147lfc.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 09:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id
         :references:to:date;
        bh=lotyO7z8zkaWwRzzsU+C72cYzog5g4NWehYCvndure8=;
        b=e4QSHBPtsDFVNMg++guEfT0ODqv0uokwnqmX1gW8ZZn47zCwg+z7qfeOlVk3AsvJSh
         61NQI1i5FO2WH4h+KfFEH8w6GGM/+X1/j6YgirJfmBQW3jenfr/FEtWHPK26Qlul54o5
         1DzgtaK7CB8tYhnut2FRUAJXN0atVZ+pyDfdrtQoPL8bquAB/vcIJ1AZznteScu8cLdy
         NKU1znX/0I1vZk2qb4I2azmngZTRCBWGCJGTeGlUrw2yL7gI9hR0TtzyJaB0Ed+8airu
         rzooSQTcW/YFnWGx3Ykxy3tjZUhP6lfQauYPY7VzpnSFmmYxd5cfRZWfoYRiWcfZHTny
         j8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:references:to:date;
        bh=lotyO7z8zkaWwRzzsU+C72cYzog5g4NWehYCvndure8=;
        b=tW8G3nIMzL+UOdvYjdebjHCezgJB+TmUoEoRrv/7tkp4drdj0iEtPWC1AxgyvBwRZx
         fLS1f7L4VttIkRQ58PaLJFWysFnFpcnu2Eyi/xxmRO1wcYtNwCfufF8rnHOQLrKr/liq
         FB9heaxy2eJkeLnHv1jYPHMSQFSfiGKddqp2KJGjcpbI4G04k2ijg5EgLy7fW+u35+WB
         VjyaVXHHsyq15/MZ+D3zcbyL/V/WoThmRuus/l2pCuJnLZAiKthPpO7124Eq2Ls5f0om
         zlR4oxz/zS8A59osPIHA6QhxAoV+ohvINDGDCAJqeSIIfkx9xEnpn9xHBTKWXKhOHgdU
         vUQw==
X-Gm-Message-State: AGRZ1gJ2NqCjyOyujdOiNzYuOQDUAFLtHi4CWri9dElQCBJBuBVZLzjo
        Lk6/ooqetb3kH9IaErNKB5Dp5hdDc0A=
X-Google-Smtp-Source: AJdET5fhxNLMUCXM05o1FpIHCub2KbJNzfqwFrwyqabrDcVm6FeGjihuwpgwUUdUhGfdVYWpuA1nkg==
X-Received: by 2002:a19:db4a:: with SMTP id s71mr646943lfg.36.1541610128633;
        Wed, 07 Nov 2018 09:02:08 -0800 (PST)
Received: from [192.168.52.227] ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id s3-v6sm218280lje.73.2018.11.07.09.02.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 09:02:07 -0800 (PST)
From:   =?utf-8?Q?Micha=C5=82_Hobot?= <michal.hobot@silvair.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: mesh: configuration.json question
Message-Id: <E7A583DC-3A5B-4500-881C-E22CF5C1AA17@silvair.com>
References: <8781652A-AACD-4912-9A12-D7458DB85F94@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Date:   Wed, 7 Nov 2018 18:02:06 +0100
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear all,
Where can I get a sample configuration.json file? I found a sample =
composition.json, but nothing for configuration.json.

Thanks in advance,
--
Michal Hobot=20
VP of Product

+48 603 744 668

Silvair, Inc.=20
717 Market Street, Suite 100                       ul. Jasnogorska 44
CA 94103, San Francisco                            31-358 Krakow
USA                                                              Poland

www.silvair.com

NOTICE TO RECIPIENT

We inform you that Silvair sp. z o.o. with its registered office in =
Krak=C3=B3w (31-358), at Jasnog=C3=B3rska Street 44 is the controller of =
your personal data. You can find more information about processing =
personal data and your rights here=20
This e-mail message and any documents accompanying it contain =
information that belongs to SILVAIR. This e-mail is meant for only the =
intended recipient of the transmission, and may be a communication =
privileged by law, confidential and/or otherwise protected from =
disclosure. If you received this e-mail in error and you are not the =
intended recipient, any review, use, dissemination, distribution, or =
copying of this e-mail or attachment is strictly prohibited. Please =
notify us immediately of the error by return e-mail and please delete =
this message from your system.=20


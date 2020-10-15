Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FABC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 22:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6582076A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 22:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djk6/WMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgJOWfB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Oct 2020 18:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbgJOWfB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Oct 2020 18:35:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B3EC061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 15:35:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 77so545305lfl.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bK03MpN1XVyMcBYcxt70sCD5UknyU449shQfZ7x3E+U=;
        b=djk6/WMzx2Q8Nv+mZ7RMtTchaQUN+QPQN3Z3uVdvzpWCFZmKi0P4Hdh2ZC3hRCkVhx
         UPxAIq4lHQy3/DAD/Ntzlav5f9fNNxIxLrtD68aJUXsNrR9T2EU+I7MWdVnCu2iu/Ihz
         07gru3/IXYNSB5vGnn/DLAuhhamtKZ+GfadoRj0T8IPbP2rL9eH2HDCNHbbuiNCeuCTL
         YaPhoiRhafkACGAK7m0GboUFYvnduU8WuULTEBli54DzWq/Tqcuf87WyYx5gSIBRYu2I
         Eau29/4Obcz/gjV7u55PzbdG6vjKJ2oul/N7l8PfcPjhKP7Jov055euUA+BsoBHW6iqa
         fhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bK03MpN1XVyMcBYcxt70sCD5UknyU449shQfZ7x3E+U=;
        b=fDbsMBqKdj51wr8nKh7T3pgCiMnThDj9Tq/omUFQvHSdCSGvmMddfKwQl5YEmMWrtL
         6cTGP8PUiHug1lBYhMpf0lJ1oMOW4qW28cvkAotZk8tx5H4R2PFZXxDauodEy0PNxCk8
         5G/8gOzsqPwjchK06lLoShb2H8/pJeLcYpZgBgRMi9O9X1WC5Q58MxwKkPVoQxStIEgf
         FyeVLN/v0fBHIe5uZ0OwvSgenNVn7JsBnqKymSSpOQwIeuXvVX18oQwXrvKknncUhO9d
         25/Kpd+C1JeEn1dLE0jPA+f/kgYbLTrOUUIfE+79i0mABF7r6fxl1a7vX1wMErHxCci+
         MSLg==
X-Gm-Message-State: AOAM531UB0T7GDMljLlNH8YQvUDGFOBpKphLkmBxPUFeHaCjMoZKiWTw
        jO+mfh/Lp0bSx4YWoEKD+6lumvWfUje34DlY5xWhW1OjpmWeLQ==
X-Google-Smtp-Source: ABdhPJzQij+tG/Xeox7TL2T9yTjR3j8He+LQCRZXaEW6CKW/T7u2T5h5U+pI/ALDBnAqLvsj5IklidHB+kdZco03qdU=
X-Received: by 2002:a19:9d3:: with SMTP id 202mr251290lfj.329.1602801298159;
 Thu, 15 Oct 2020 15:34:58 -0700 (PDT)
MIME-Version: 1.0
From:   Alexandre Augusto <alexandre.a.giron@gmail.com>
Date:   Thu, 15 Oct 2020 19:34:46 -0300
Message-ID: <CABLzjm_w4kHpg6PyqjRLFQ7erTaSGfatOeEYFQ33CTvj=WyfaQ@mail.gmail.com>
Subject: Entropy source based on the Bluetooth RSSI
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

based on the motivation that IoT devices do not have many entropy
sources available, and also on the fact that trusting in a single entropy
source may be risky, I have researched on how to collect
randomness for such devices, aiming to propose an additional source
for them. The proposal is based on the Received Signal Strength
Indicator using bluetooth technology.

For those who are interested in:

Github: https://github.com/AAGiron/Bluerandom
Presentation: https://www.youtube.com/watch?v=iAKaKAmqCFo

I also want to say thanks in advance to Emil Lenngren for his valuable
comments here in this mailing list (back in 2019), and also to the
Bluez community.

-- 
Alexandre Giron

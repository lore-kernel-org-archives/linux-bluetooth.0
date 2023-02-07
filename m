Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40FCC636CD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 08:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjBGIly (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Feb 2023 03:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjBGIlw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Feb 2023 03:41:52 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ECF4203
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Feb 2023 00:41:50 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bd6so3021018oib.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Feb 2023 00:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r9v49Vo65PBkNR7woe40E1N8MMOoH+A7xNRAus3Bzow=;
        b=l7woEKEyG7w5ChTzG9rbLDt/AXds2KWYOv+awzliNG9U8PPZ8Z5KutAatIi9pBoTSp
         f00dkOSotkNQSSaKSVnknb940hhlRlNc66B2KJU1FEo2IKDXt7uYGHJVXJuuOvxceiXq
         v8vpWnNSTx9nGmYJrVpHTmEEo+jk7ybHzrrdrx3TRe4kNbL5xmzaNx9xbXIseJf3TaI+
         vGr2sIPBOcaFbqQ+jPicCBP4oJ5mHTbWTDewahBqzePUKwk01NmUvHjM84D777iJSPzi
         jQOCwJ2t80i2nlZTJRgXRR1/0/DIUWLgw4D+gGiXEqMWPPsjm1A6Hm2V9ATLXy49mXaV
         KLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9v49Vo65PBkNR7woe40E1N8MMOoH+A7xNRAus3Bzow=;
        b=XNj/hxbXEpilPWesVWHpv6qGTPtCLJDXmyhVew22kZfaGCUOuYXXkZZaK73+c3VsBT
         TrRjQDJrssj7x6sVAyIodUf1bqMXVMqT9PbKbtRJyIc8URvQpx4zOCVhVXflxHjuYK6P
         NsIZvrFK4mkPEnNGT5VzW35V/L7gt1EnM1fAFG2QGbaCOMf3NdXubVaYQewi/e08rveU
         uKD70ypSrZiqgCSzqKSSDZlYTNfexlYPkOP0ohud/NtbMRqBX1J2TgMbxOILvMoeP89C
         bwfZ75Ga/1n+VTiIZAkUVfpn9KOi0vl01sYz8Aw+lcO2hErIqzbgVhXvWzqzMvT6H6Zm
         zkzg==
X-Gm-Message-State: AO0yUKXwQ+BqhJ6O7PHJAXuYwfED2xNXfCkaw0GgyI8BbUSc6MjqkwEL
        SD5AWDQiAZHUut5YEj7QmBt3Shtk9Y8=
X-Google-Smtp-Source: AK7set9aVwlStw9vEXy/I2LvFqY0lURe4Ni8sgyRf3hgwiwqxiwW1WOE/De2QOlWMuh0CxDdaR6IbQ==
X-Received: by 2002:a05:6808:2a01:b0:374:3688:36ee with SMTP id ez1-20020a0568082a0100b00374368836eemr784034oib.54.1675759310069;
        Tue, 07 Feb 2023 00:41:50 -0800 (PST)
Received: from [172.17.0.2] ([40.84.170.1])
        by smtp.gmail.com with ESMTPSA id s26-20020a056808209a00b0035aa617156bsm5313340oiw.17.2023.02.07.00.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:41:49 -0800 (PST)
Message-ID: <63e20ecd.050a0220.25d83.24f2@mx.google.com>
Date:   Tue, 07 Feb 2023 00:41:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6141329854920421113=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, herbert@gondor.apana.org.au
Subject: RE: tls: Pass rec instead of aead_req into tls_encrypt_done
In-Reply-To: <Y+IJXEYPuaQWjfR5@gondor.apana.org.au>
References: <Y+IJXEYPuaQWjfR5@gondor.apana.org.au>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6141329854920421113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/tls/tls_sw.c:430
error: net/tls/tls_sw.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6141329854920421113==--

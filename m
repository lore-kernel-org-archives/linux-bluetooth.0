Return-Path: <SRS0=w8R0=PC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C44BC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Dec 2018 10:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213432173B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Dec 2018 10:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuVRxlOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbeLYKYD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Dec 2018 05:24:03 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:39688 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeLYKYD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Dec 2018 05:24:03 -0500
Received: by mail-pf1-f174.google.com with SMTP id r136so6693180pfc.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Dec 2018 02:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1tOmXk+IWBqu8g1oojNnpWT6GT9ul4+dTPKyCpyv6VU=;
        b=JuVRxlOvrQwGifHXBr68xyzGLyavj5lvxJbAzhrQ0SQgeMm6UOAFltwbKwKwWo2uXx
         Uh/NiZ1cqn4kUzobxH745szqbHQ9KDTecuyF2PXnd73PRNIzsiKehACWu5vmmkJ6LMhy
         o7OrKxdwyGEE8vbsUXMrBp9ddkZoGOBLR/q6G8GHmhts63wG9jzniprD0Iz3I7zplOLw
         WqJaqEBgQ8WQkWn0OaUd0uxiut0etATA2MZlQGGbeItiYMdiiAA4POhc7I7oT46AErwh
         nvLh5qRKzfOQ4lf6hzehuZN4jiWsQ9gQVykfQDy0fkRifFpPlRO2SxilOKoO8VZUVJ/Z
         bzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=1tOmXk+IWBqu8g1oojNnpWT6GT9ul4+dTPKyCpyv6VU=;
        b=FYMx8+gyNRhGHT30KW/XfOeLMMYwSDmp9oPCu3NULu0OhFlOe7T/yVEmB5pK9OsMs6
         Mj5kzDkelVQu7QI+6hiuanmy2Akcxa9E/M6SUF/l3HvVgoW+C/1l/TW1BH5Qzu+J+/Uu
         I/xN2g06W1yLjO3OY8vIGjT9wyH0eRZSvzVAMNTZawrbjtUioACMM8snr4O3d1Ggmdk7
         02Baj4lqGtCznMzyibB4GYvocrLnalDKMM8SBjWRRb3xdzvgKJWJMVYMAQ8CODb4baSw
         NRKdcEPhhg/cWzHigHckHklvFuqRkUnAm6QJiuUhB6jLE/ljCY/jRdC4u6SEa/sQfYyp
         nWNg==
X-Gm-Message-State: AA+aEWa8vJJ3Lay4NEzd2wK3iPecO0e8VrUl7znG1ycdk25v1ZsbuY6a
        VZk6oorruJ8T3QOgcXaFXi5/B2w=
X-Google-Smtp-Source: AFSGD/Wso9F/Ym7TtYwq5xGnLHYGTTLPaNIPHjRY5QUCj9wDs3H1S3LJnqw6ON9c2DFrWcSuXp1ldA==
X-Received: by 2002:a62:3943:: with SMTP id g64mr16391079pfa.114.1545733441939;
        Tue, 25 Dec 2018 02:24:01 -0800 (PST)
Received: from [10.0.0.16] (c-98-210-227-32.hsd1.ca.comcast.net. [98.210.227.32])
        by smtp.gmail.com with ESMTPSA id r130sm63044765pfr.48.2018.12.25.02.24.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 02:24:01 -0800 (PST)
From:   Cinaed Simson <cinaed.simson@gmail.com>
X-Google-Original-From: Cinaed Simson <Cinaed.Simson@GMail.COM>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: kernel requirements
Openpgp: preference=signencrypt
Autocrypt: addr=Cinaed.Simson@GMail.COM; prefer-encrypt=mutual; keydata=
 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
 FDV1prVcSN66lXaF
Message-ID: <7875abc6-0dba-4085-32a2-733e70661427@GMail.COM>
Date:   Tue, 25 Dec 2018 02:22:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi - I'd interested in playing mesh on 4 arm processors running stretch
with 4.18.8 kernel and the latest git version of bluez and ell.

What loadable modules do I need to enable in the kernel for a mesh using
asymmetic encryption - similar to the ssh Diffie Hellman key exchange -
where the password is similar the PIN - at least that's how I remember it.

And I believe I have to enable other modules too since some of bluetooth
user space stuff has been moved to the kernel.

Any help would be greatly appreciated.

Thank you.

-- Cinaed


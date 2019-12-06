Return-Path: <SRS0=M10/=Z4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CD7C43603
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 10:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA532173E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 10:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge9ZFOUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfLFKZE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:25:04 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:45424 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFKZE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Dec 2019 05:25:04 -0500
Received: by mail-pf1-f180.google.com with SMTP id 2so3119353pfg.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Dec 2019 02:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ghLrXJLhDfe3OOmUKO+fQNmcK1W4zF2wIIsHccAKmSk=;
        b=ge9ZFOUHZfegxCxal28s10akln3LO5YjRPCZA49kD2lm+bg0kkgoFGe7YI3y3V8gSA
         6D62zJn1PsiU5CEn3GJxIRDeHwXYvktIKj0mw13AzlJ+Vvp+EOFvwNhxGa90FkK3qrG8
         bOyLxEnVFDNgONydyywhhxaH2/lyEqH2MHBN2dHrk+lNf2GYCJJ3vlCznj1FMaAxB+sb
         OXVgL8BvRQaUk/nlJ00WNo98s1LDwxB8ArsdFbUjEc4cHb8dUPbDaJLEslWYOXhFEkVb
         fHKzhTpExcuosSi2rfe4ElhRhaZpdGETqgc/9k1pPIRuIymf/80GoO68Bx7r5jCYacKR
         5j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ghLrXJLhDfe3OOmUKO+fQNmcK1W4zF2wIIsHccAKmSk=;
        b=AFmU7uXE0W8EIzqyiGbwYPYSPEIlOtcUB4Q7eHFBZWKtosYcLRHRUNmjwstOqrpLOo
         14hnS5TYf8LtEce8uIMqrB/nYffyVxaifWURONANjxU7hxjRxvqm31T6op7U6OCoNTp6
         lzdcXBxaLWVfc5N9FbEl4yoo4MJzkRVgztgTCIpdWcU1nSe6Lt6BtS/mOG2Xcr4PHEO2
         sQ35mnnyVqRyE3cp0hwBc7k182v+7K9reyydIYhJcu0Kuf361l+edGtc6adpeC9QdpST
         lmazWV/RxWiYhCXauRdjQKO1euyxP+tzTfIkrEDnttHrnRw5PQsRbDtYT1oou7JPJ7Fk
         gc0g==
X-Gm-Message-State: APjAAAXyEHn9NkQIHmZ7ldX7JDvEDy4AWpUF+sv7DI+vMdr8Z9oDUzon
        Te/4jEbm0EIAiYM9e5toPb6fsoKRNQu588Hn+XRo2nNMLLY=
X-Google-Smtp-Source: APXvYqydI6OWFMUh0hbc7DCdB7x857T7V+hcc9Yj823ggvtHexIv4b8ilAIXokQzGtzYbxxuHV4kAJy0NZbwJ55v/kc=
X-Received: by 2002:aa7:9629:: with SMTP id r9mr13865753pfg.51.1575627902950;
 Fri, 06 Dec 2019 02:25:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:d103:0:0:0:0 with HTTP; Fri, 6 Dec 2019 02:25:02
 -0800 (PST)
From:   Abhay Agarwal <aabhay169@gmail.com>
Date:   Fri, 6 Dec 2019 15:55:02 +0530
Message-ID: <CALbZ3NJniYdZXgaNDR9778cfbr7kkNhGEeSm3pDqwOHXRp8Thg@mail.gmail.com>
Subject: Bluez mesh-cfgclient: Not able to configure the device
To:     linux-bluetooth@vger.kernel.org
Cc:     "ananupam.r" <anupam.r@samsung.com>,
        "aay.agarwal" <ay.agarwal@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

I am trying the mesh-cfgclient tool to control a sylvania smart+ bulb with it.
I am able to provision the device on PB-ADV.

Unfortunately I am not able to configure the device. It shows the
error message as
[config: Target = 00aa]# appkey-add 0
No response for "AppKeyAdd" from 00aa

Note that I have been able to configure and control the device
(on/off) using meshctl.

Please advise what can be the issue and how to debug this.

Thanks and Regards,
Abhay Agarwal

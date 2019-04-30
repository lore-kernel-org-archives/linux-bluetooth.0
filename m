Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B035FC43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 11:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCC021670
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 11:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da6l1FAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfD3LyQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:54:16 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:38049 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbfD3LyP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 07:54:15 -0400
Received: by mail-ed1-f45.google.com with SMTP id w11so5300537edl.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2019 04:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WOji0PqIX5CqMlHwNe3pcjvTy6UpUp/NZzLom2OB4+M=;
        b=Da6l1FAYOz4wOujgZXfroyJhFbQ7KkWZxBiOw3a0HAI3bc+aLhk6e23KI0kGlwmbW6
         lTpCcf7cf/MkxZOPAbGzyohn4STlk2fPhbM0hbkYBuNbXtZeiOGrPo7ZP4qAn7uAo27A
         TRZHnXWx255+taQy9uoiTkDAHnUmxwpBL+pPwysZETVehXeHaNzMZn9VtXjN82dhWKVY
         jfubk77CqbpTp0OK46OrChQvbpCHiVin3gCl/kYTX+gW2PV7ILocBMQlZVg1SInFIyLG
         CKQjF3VEI4Gd9iImKAsO0qYB1cssgOcxuOWidkh4mbMOsznWx2GfYOmtQRJAW+MI7G1c
         3TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WOji0PqIX5CqMlHwNe3pcjvTy6UpUp/NZzLom2OB4+M=;
        b=rt54kZcCkax9XQFRgfUe+BE6Z9hKAzOGHrDFXzLdW0Tk1MA86MCRXu0dtnVE0ZxsEE
         TRPMIhebndoqngIvgCdoAappzUxcqjlpgI1P+7zkDEwgrp7QiGX/034xoKyD/YIKINkw
         OIME4j47qaYp6zXg7IxlF10nGXsfbeC2ENYVxD+xN/bjUdhe2PiuVuGvVtjJ9JGTZ2fo
         muG+Q38wB63af6cX3c48ZObCnpFo3mywpSOUi40QFdd2JyK/xyfN+Jo6nMtu/v0LdQsc
         ZloOgVfnxcZeYpqCBZkS6VJOlOu7YWIOSAAGoPERBFDxwBn/wLbcGuXK5ICu+FCSjC5j
         NDMw==
X-Gm-Message-State: APjAAAUBKg4Ieg/SgF52ruwCzGfUvyXaoCsPTMgb9yvy2muCkVr82eiU
        gkopY8UmoVRX5sLrForvNIoKAKuiaxI=
X-Google-Smtp-Source: APXvYqzARKUYfILYvItPYabwQBGxqeAla140iz8X/llO1mhWAomZeNou/YztIvowgxvOqzJAHmzqpA==
X-Received: by 2002:a50:d519:: with SMTP id u25mr4543865edi.185.1556625253825;
        Tue, 30 Apr 2019 04:54:13 -0700 (PDT)
Received: from bksv-VirtualBox.bkogc.com ([152.115.31.4])
        by smtp.gmail.com with ESMTPSA id n7sm1214629ejk.72.2019.04.30.04.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 04:54:12 -0700 (PDT)
From:   Troels Dalsgaard Hoffmeyer <troels.d.hoffmeyer@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Troels Dalsgaard Hoffmeyer <troels.d.hoffmeyer@gmail.com>
Subject: [PATCH Bluez 0/1] Commit message fixup
Date:   Tue, 30 Apr 2019 13:51:46 +0200
Message-Id: <20190430115147.14631-1-troels.d.hoffmeyer@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429111441.20481-1-troels.d.hoffmeyer@gmail.com>
References: <20190429111441.20481-1-troels.d.hoffmeyer@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I didn't put a newline between the subject and the description.
I hope this commit message is better. It is my first time doing patches by email, and i'm still learning :)

I didn't know that setting the timeout to 0 would be a missuse.
I just modified the python advertisement example.
The problem i ran into was that creating and releasing these advertisments with timeout 0 could sometimes cause a segfault in bluetoothd

Troels Dalsgaard Hoffmeyer (1):
  advertising: Timeout of 0 should not fire a callback

 src/advertising.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1


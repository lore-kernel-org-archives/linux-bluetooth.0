Return-Path: <SRS0=/vUS=V2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CEAC7618B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1142070B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 14:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfG2Odc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:33:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51280 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfG2Odc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jul 2019 10:33:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so54083658wma.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2019 07:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:date:message-id
         :mime-version;
        bh=ZbxcKV8MceZYNkwHRTin2z4t1gJZTIRcyKnNXrdllN4=;
        b=HdetlVMIT8tlj6eyOMKAK1QZ7RfyMG69wq1Qe4ABtR4ZTm9E/TTe5oZcsjjACV2/B9
         bUmXthu6TyV1XszUBKptT3hGaFcWG2Otgaq+VTPY+GHnw4sTuORt/fFH1LNiStz+Q/Jp
         0jq/Gz3ieJPmWDdxcB+L5QkPUV1hdlJVWfyevE+hUPkJsFEAYxO5cSgji63aNBTXMa7I
         fOIUrBWnHBRW08gdWNGMyYGA2+EKyWqbwPgrYpNT76HS5IWAAD6mI6lDews8RfywStnV
         bhhWTCnvp9yFokpUfYvxWoMV3gRDaVBlucjnVK9S+efco5jVXWkGxybsuD6gUFtFHZ2e
         gfOw==
X-Gm-Message-State: APjAAAXIv4YKUGm2Ez6HdR57AYF6sqxL6Af7jJEmfCki+rzkptaanvmL
        7UkiWxpzCefUdhbp0lPsvAP0SuXSC7I=
X-Google-Smtp-Source: APXvYqzGb8IOXG87aySPcCfKCrPgWxg+823HpYUU+INPrMtmMVKciEZKp0bSdiyImwSvDc7jlWGW4A==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr93040617wmk.136.1564410810632;
        Mon, 29 Jul 2019 07:33:30 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id c11sm103850647wrq.45.2019.07.29.07.33.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 07:33:30 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Mario.Limonciello@dell.com
Subject: BT advertising packets and s2idle issue
Organization: Red Hat
Date:   Mon, 29 Jul 2019 16:33:28 +0200
Message-ID: <87sgqoewqv.fsf@kellner.me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi all,

I have been wondering what to do about the bug that advertising packet
will wake systems from s2idle when a device was previously paired with
the HCI_AUTO_CONN_ALWAYS flag (kernel bug #200039[1]). I was thinking of
creating a patch for bluez that would create a "delay lock"[2] and
de-register any such device from the kernel before entering s2idle, but
I wanted to check first if that is the best approach.
In comment #27 it is suggested that using a "LE Privacy v1.2" feature
could fix the issue as well. Is there some more information about this
available somewhere?  II can help out with development and testing as I
have an affected system myself.

Cheers,
CK

[1] https://bugzilla.kernel.org/show_bug.cgi?id=200039
[2] https://www.freedesktop.org/wiki/Software/systemd/inhibit/

--
Dr. Christian J. Kellner
Desktop Hardware Enablement
Red Hat

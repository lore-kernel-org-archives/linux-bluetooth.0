Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C047C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 13:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051E3206C3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 13:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLvGMPYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgFDNHx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgFDNHw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 09:07:52 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF5FC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 06:07:52 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v79so5831538qkb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=du0xvdosbOk3TgTOz25b9Grv94Uo7Tf/4Srq7EgFhiM=;
        b=lLvGMPYEz5ntO3uBuP6VekSZmQHiZkJ5jsCAtY2O7J3JyeNxacV9hNfxHLhOL6tKU5
         1uBxRQrvwMfc0W0QdXx+MqOWrvaICEUQoLGP4AVA/YSz0UAig1yzSCS1JU9s4sahR6Eg
         45iD/q6NM2mcrH5hM+SmnL/Fp6JXHC1tg5v2ovCBQpRLpFoPkNbteWISP+u+dxWbZoMe
         GKxxtQc3Y8DTFdIf8IK/2UzhqdSb6K03j6mja453abKP2TxhxPrUJTRqsgRLZB1HoRyN
         X4causiLB9NjGk0k0FbsgAH93qg5lrLHmNb42hU99MPqvMyyG/cUUF8VaEPkA0+mTlOK
         Dn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=du0xvdosbOk3TgTOz25b9Grv94Uo7Tf/4Srq7EgFhiM=;
        b=R8XSzM2G+Djks8J5gntv9rndtRJE4xDjy4+2ABOHITNEC/jnSpg51BQtkKV7JTLajf
         LUAlEaBX78FyxwUW76RBAk1y80rYb0cXHNc0DbsDl56D/P66rTm7RDF4HgCLvuw3ll7F
         Mc2ufKFC6lUgF2gbvmItGBdELExCtc2xiIJKmvhApDu2ePQs9+eEbYGJuQbyOGfD1suX
         naHs1tU6owKyfMTi+w+f4ZatODXiV40gtbA5HwhWqOjG4kmZfxNdNEKv2XY9YTKyUJHr
         0Wqi2dbmxAShaUbIYpsyLXsbXhsQzyf2M9viWBS/bxvQbfyiB0JtpKNp7bkNfU6SDah9
         tciQ==
X-Gm-Message-State: AOAM530mxIcY3dYccDFzcDuQ/UmZ4VI6vq/+ITGf7lhI4pdQdLdnoTzp
        zDelxhalaafvneDNFk67NbmQThAOYvo=
X-Google-Smtp-Source: ABdhPJypQoM7gnFdDfD+VIQYv0PYSfvWFSoMraL2cD7jjLGiNmfUiGEmtrcUYL06lxS7eb7eFnnpHg==
X-Received: by 2002:a37:2702:: with SMTP id n2mr4675629qkn.5.1591276067078;
        Thu, 04 Jun 2020 06:07:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.209.39])
        by smtp.gmail.com with ESMTPSA id h64sm3846061qkf.46.2020.06.04.06.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 06:07:46 -0700 (PDT)
Message-ID: <5ed8f222.1c69fb81.bef6.420d@mx.google.com>
Date:   Thu, 04 Jun 2020 06:07:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3985034793137061947=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, d.grigorev@omprussia.ru
Subject: RE: gobex: Fix segfault caused by interrupted transfer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <a86f93d2d5a946d86bcdccb52218f20a959434cd.camel@omprussia.ru>
References: <a86f93d2d5a946d86bcdccb52218f20a959434cd.camel@omprussia.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3985034793137061947==
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
12: B1 Line exceeds max length (82>80): "0xecc6eeda in dbus_connection_get_object_path_data () from /usr/lib/libdbus-1.so.3"
30: B1 Line exceeds max length (93>80): "2baea85dec1aebe0b100d4836dee8bcf29a51e94 - Bluetooth: L2CAP ERTM shutdown protect sk and chan"
31: B1 Line exceeds max length (90>80): "f65468f6e26c3bd05e642e10e80a485b99b7de05 - Bluetooth: Make __l2cap_wait_ack more efficient"
32: B1 Line exceeds max length (89>80): "451e4c6c6b3fd1a9f446a10eb9f6d4c2c476043c - Bluetooth: Add BT_DBG to l2cap_sock_shutdown()"
33: B1 Line exceeds max length (95>80): "cb02a25583b59ce48267472cd092485d754964f9 - Bluetooth: __l2cap_wait_ack() use msecs_to_jiffies()"
34: B1 Line exceeds max length (94>80): "e432c72c464d2deb6c66d1e2a5f548dc1f0ef4dc - Bluetooth: __l2cap_wait_ack() add defensive timeout"
35: B1 Line exceeds max length (82>80): "e7456437c15a2fd42cedd25c2b12b06876f285f0 - Bluetooth: Unwind l2cap_sock_shutdown()"
36: B1 Line exceeds max length (100>80): "04ba72e6b24f1e0e2221fcd73f08782870473fa1 - Bluetooth: Reorganize mutex lock in l2cap_sock_shutdown()"
37: B1 Line exceeds max length (100>80): "9f7378a9d6ced1784e08d3e21a9ddb769523baf2 - Bluetooth: l2cap_disconnection_req priority over shutdown"



---
Regards,
Linux Bluetooth

--===============3985034793137061947==--

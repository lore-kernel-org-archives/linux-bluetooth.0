Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABFDC28CF8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 15:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C30320851
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 15:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM2iUNbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C30320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeKUBs4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:48:56 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:33593 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeKUBs4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 20:48:56 -0500
Received: by mail-qk1-f177.google.com with SMTP id o89so3099441qko.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 07:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=D/9YKIYqwpPGY/No34Z0Q1hKsoZQylk9xjyUU38BavU=;
        b=ZM2iUNbR81iGXt/VpatHhSW7g6zJxoR36VbHFU1Cnmmzic/S50cWB8YdZQ6vf/FfrB
         ISL5+46kpmB2+tjX6TQ0OWkHBhgDCUF5IMzv/asMPbW8L67JdF+R3ir1Qy4UCvQaXdyk
         5AUwb2887L/W18XabTwZW76oewsoh7G8qjKZ7+FPguy6vXY8BCJyzvSBvCuR90YxA5BA
         rrS/I2+aei3/ha2Fj7eJNG6hQ1dVIh41+WlILu7x6MVBOF4EeDCy12n5+LWwiHnsDtTl
         SR7slamWgdye7YZqiAh1fX2vgye6L0FJFwtL0Wq4ZoFPOLidEzO2120bLTtxGbTq4UAa
         hL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D/9YKIYqwpPGY/No34Z0Q1hKsoZQylk9xjyUU38BavU=;
        b=NawCTMUVCsV2i/LLl7/yBSfCoLFu6Ibz2d0kr1AfV3d5PaqZnTTF0aFe/hDJuentJS
         +qhBEQ9Kc6qesaiQbse3aPkzMZU4Zf+BYGqPd8Y+Qi1RQpYFfoTlR1WW/Lt4X2ytDyL/
         0HgXly2wDcprkF4u7REfMsIC0BDBFeHsHDHcO4G81YssSf950XU2po967qG2MgSu3HD8
         AoFPeSaka15+flAOo2POkt5V/40aMDHftmVasWM37aggV4w47n6yHkIYJCo9k7c8IG1p
         aliSDmhHR1HYtU3oKxi1apa3NMpr0p1bJrOuViO+PBwwe328ZMtiqeHPxMYCmBvRe01b
         08+w==
X-Gm-Message-State: AA+aEWay+c+byOj88pYblyRJt/Rb5wSztZL7c4PGRu4pi64e6FC0DFAT
        1rgEUthOuEXrK6no0z6i8OeWuJBoIkxKhI9SIAca9NAYmRc=
X-Google-Smtp-Source: AFSGD/VXNxlSMaoUgbkc7DtaWcqEEYSGFf05KXPp+fz9OD9itfDYbcWSeisd+I1X7YdN9kyM6aKf4mTkt8iGTEqFnW0=
X-Received: by 2002:a37:4145:: with SMTP id o66mr2005664qka.129.1542727157313;
 Tue, 20 Nov 2018 07:19:17 -0800 (PST)
MIME-Version: 1.0
From:   sanjeev sharma <sanjeevsharmaengg@gmail.com>
Date:   Tue, 20 Nov 2018 20:49:05 +0530
Message-ID: <CAGUYZuT-kEQ1Sg3KUny29RiPFXo9Pst+wHVQ8s_U1reY8=gmqg@mail.gmail.com>
Subject: Bluetooth core specification query
To:     linux-bluetooth@vger.kernel.org, rajatja@google.com,
        marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear team,

is BlueZ 5.50 Release available on http://www.bluez.org/  is based on
Bluetooth Core Specification 5 or newer.

As per http://www.bluez.org/profiles/ Core specification 4.2 is mentioned.

please confirm.

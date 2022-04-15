Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0596C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 18:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbiDOSD6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 14:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345070AbiDOSD5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 14:03:57 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581099682A
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 11:01:28 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d198so3946009qkc.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xVC61ZVi69hwKcEX4AWBQMQhD2iLyLHZzkZr0J4M7Rc=;
        b=kelJGp7VLMEDHH8h5gpIQtpXi993CCKLVFJ7JnFxN4UpyknSYjQqf1dLAY38kxJRPK
         8rPovf2WrNsEICNkw81uDwNnIEN0GPvdURRIFAPNGe+u62+t0X0dXfAlxSzur2fhkaZ8
         vRH6NVPn0E/4k1XubS0RdFUbDHVFShtYlcZB45IELufRWFQLqThwddgR5d0B7gH+1UCl
         bnkYrhuYNC4WE9i8JvqoKYln/c+8LI24KIWulHnydAOUS7MHkluBPevRVNsynG8kJnqN
         GrM4VMp17ZUYa8bYBdCmpvyNGOODn10bNIwx9PTxvUAEoxzNiLZS/94sucwbRIqR9yCC
         inig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xVC61ZVi69hwKcEX4AWBQMQhD2iLyLHZzkZr0J4M7Rc=;
        b=YRzN6e4Qv13yOMOdFNXQSseY9KbRvPXz1Ix7vZzGkpn70VbtX8yZmEqaDU70SZqp2A
         niETt23+kWOSINeY/9ClbjoIBte4JjhnN4Ad7QhVdWFV6vIfuhJXHtFbiRt/0GtcB1BR
         o1jXZExod3krmlbo8C42+IkVEEZKmUJaEId2/DoIYgJnY/lQAslgI3HEMxwZDG9ZoH8H
         C+qO85aMzUcbB5elUJ7QRECbMvQT50hHdUwAK9UvSHNy4TjrAd3KtgjkXl6aUo4XWzPV
         Ucg8MHApnZOrGjhaXd3RcNp/BM7taTwrcrlKkow6dETDGzWx5+7gciRYc/9EJ+n688zy
         Ht5w==
X-Gm-Message-State: AOAM5331w8rs4aoCoD6iNh6jByQbU8gcTIVPhoa5d360DgBeqeQTrprj
        bCO+gWe4DRC3pYINAS6p+03Be3rhA17ebQ==
X-Google-Smtp-Source: ABdhPJxmQHnFyZedgpfPdtlsQRqJnshbrnkKFTXH2MbhRhnk3GLzy85Fh3devhGid43sT31wO9wMHQ==
X-Received: by 2002:a05:620a:2415:b0:69c:5c75:21d7 with SMTP id d21-20020a05620a241500b0069c5c7521d7mr107681qkn.412.1650045687307;
        Fri, 15 Apr 2022 11:01:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.112.216])
        by smtp.gmail.com with ESMTPSA id bi29-20020a05620a319d00b0069c3f6adc18sm2787016qkb.22.2022.04.15.11.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 11:01:26 -0700 (PDT)
Message-ID: <6259b2f6.1c69fb81.c4836.fc6b@mx.google.com>
Date:   Fri, 15 Apr 2022 11:01:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2888698630516238688=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@hotmail.com
Subject: RE: mesh: Use correct net_id for received CTL messages
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <VI1PR09MB4239579EE5A795C707FBE075E3EE9@VI1PR09MB4239.eurprd09.prod.outlook.com>
References: <VI1PR09MB4239579EE5A795C707FBE075E3EE9@VI1PR09MB4239.eurprd09.prod.outlook.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2888698630516238688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632621

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      42.96 seconds
Build - Prep                  PASS      0.73 seconds
Build - Configure             PASS      8.59 seconds
Build - Make                  PASS      1376.65 seconds
Make Check                    PASS      11.85 seconds
Make Check w/Valgrind         PASS      442.86 seconds
Make Distcheck                PASS      229.18 seconds
Build w/ext ELL - Configure   PASS      8.63 seconds
Build w/ext ELL - Make        PASS      1371.84 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2888698630516238688==--

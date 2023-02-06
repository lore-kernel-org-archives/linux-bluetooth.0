Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E1C05027
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 12:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBFMXP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 07:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBFMXO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 07:23:14 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D756E1EFC6
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 04:23:13 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r18so8032821pgr.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Feb 2023 04:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x4Z8Nh5mfuU/GM361yF+gHZlhOAVpoj9bNTaeW2aOTQ=;
        b=kvuzqHwks3NtQKvzoDZ+0ywbh/gprkhC8MhrsDacDgzF11tLabZ1CXdgEB8lehx8d7
         +GZtjfDbKie6D912KqfA5Z4eM70NJLtXOmQurva7xDvTsf716BHQaQ5n+YHUZ+dZfgBd
         2Z6pn9PnJyjK1+Qagc7fvoxv+V9aCkd1YlAMEIi19yXzncRFRsF6KHee0MpQwqhB1NtQ
         ApLUXZUmViW7FWxLIYgVPNFZzCGRpl2ft70oleuvIKVD8wX/keE6mKmy1Uxt+smVPret
         b1tWBto4gfwt2L8hTikJHUTvECsm97dhayNeoJreMdvB33CBhL37XVLv4WlpllGW6kPZ
         5PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4Z8Nh5mfuU/GM361yF+gHZlhOAVpoj9bNTaeW2aOTQ=;
        b=hNP19uo5G6jWNh4iATVbFrsX1NtwXLY41lNfxKE5TUvv5T4WJ4wrIZA90k+RGN2LK8
         1Ge3coyJDaZlf2lE0VLZ+AChsOWme42jFml+RqPxAxkUamfItW54TX/KCVOhDsxo/cvX
         /aWqgo7D/Xlf/9+BsuMiXaF65s3OqrOU3u3EoB074gC0ppZ3Q0fgWCazkqkwq1iBxWez
         zqfvyLJiYgpLiUBMRR16R20qCZh4jyieUnQPj/jzOxVrN6opkZDNAZrzEtRTht99Z8N3
         NahbwVwPwUrC2x8LsK2Guu80bo1MxQQ2Njf4nAa/8cjVoGdVvWYs74k+fWCLINjdJOvV
         OSvQ==
X-Gm-Message-State: AO0yUKWwFDGXdiat8aUc98M3MfiBpVuFaHBZ26LrouAoVmgYV2PXgCox
        mjuZbFYYpcmY/NGjf/b5efs9eR8VgEY=
X-Google-Smtp-Source: AK7set82jTNiBCyvdmwY3986XXjYJeGHXtvaNQbPdCiO2/CXueUnaAmm/h/XS+rkB3zz51bYBKrbdQ==
X-Received: by 2002:a62:db41:0:b0:592:613d:ef17 with SMTP id f62-20020a62db41000000b00592613def17mr10460210pfg.30.1675686193075;
        Mon, 06 Feb 2023 04:23:13 -0800 (PST)
Received: from [172.17.0.2] ([20.171.107.96])
        by smtp.gmail.com with ESMTPSA id h11-20020a056a00230b00b0058837da69edsm6981211pfh.128.2023.02.06.04.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:23:12 -0800 (PST)
Message-ID: <63e0f130.050a0220.b32f6.b3f3@mx.google.com>
Date:   Mon, 06 Feb 2023 04:23:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1935066599592307111=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, herbert@gondor.apana.org.au
Subject: RE: crypto: api - Change completion callback argument to void star
In-Reply-To: <E1pOydY-007zgU-U2@formenos.hmeau.com>
References: <E1pOydY-007zgU-U2@formenos.hmeau.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1935066599592307111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: crypto/ahash.c:240
error: crypto/ahash.c: patch does not apply
error: patch failed: crypto/cryptd.c:281
error: crypto/cryptd.c: patch does not apply
error: patch failed: crypto/essiv.c:166
error: crypto/essiv.c: patch does not apply
error: patch failed: crypto/rsa-pkcs1pad.c:210
error: crypto/rsa-pkcs1pad.c: patch does not apply
error: patch failed: include/linux/crypto.h:176
error: include/linux/crypto.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1935066599592307111==--

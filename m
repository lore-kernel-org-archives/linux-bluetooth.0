Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628C3EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jul 2023 14:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjGFOxv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjGFOxd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 10:53:33 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A3910F5
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 07:53:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a04cb10465so716851b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jul 2023 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688655211; x=1691247211;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=01wBUK9tlK9y9lq+Ni6k0JoEEsveidGcpvnlpCk3ETY=;
        b=LLGjysdLrlyHwR5YXfDg5ppTZ0aIKrBxOhLNjh6j8KC0Z1yrDfTCxJxvrYF9O5SeUT
         Rvo+5d1dXxrD6p8BBtErxJOmBjkYTPQnUwuL7gkKk7P38sME2FVsbqcD+GMvE6wvn++H
         nwF4wkLhXfm6WuZMRwtTr9D1M+Su6/2rGrsi2fE5Z4HFDOL1lw5fzRBtArssuesGvP20
         ItS01l4Nqcjpr9wKpLIQ09dR6G70nObTMETezzXwfYF2Q9F7AmDzXtOT5Px9FXfAoxho
         uQHDkNQQ2zOPH4lRcHZA4Vb/TxLeru952UmKW95Wm0xDOwJSGmaoOs+WEoPeHtw21+jf
         ZquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655211; x=1691247211;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01wBUK9tlK9y9lq+Ni6k0JoEEsveidGcpvnlpCk3ETY=;
        b=Tw2Dfxhql9F2LnCuNgmGctTMJNFGTNksB1+V64hxc6kNJF+eNayr0NtCHwxFXgy37h
         y5Jg/nFZe7khQ7JPvbtZhGb1enHMPAu7KxNo7+J2MTN4TZKYJGPuf2fX6VU9jA8Eu4kp
         KkaEUjnIGdc+3uIdoKojYFTo1Qx4yHR5aEtEMnq2HFqzI1zmpsv/j5bc84/CRl+LIUDD
         oeE47T8F7mYXEx055XtlTmu+DxFWvgteS7K6f2QKovNUTzeJ+3nDfIIRVoy38NknKpTV
         LuPJ0OHSw8D88oYZ8v+L75wHWcrUKEa7HPbGz/W+TocvEfd6SjDbxE+j6Z6i20asFMMC
         zT7g==
X-Gm-Message-State: ABy/qLYpyxdvLdSim411dGGFetn9aM3Nl0+5R6l37txVfMARx1ZpxY3q
        kB7CT2r920sRozTLekUZuzKvLObE0Gc=
X-Google-Smtp-Source: APBJJlFcLcQSvatpj/dNjzzEahoDqwIWDjne7yGwpLbGVSkCXFqN1gSY0XJUU9rFczqrj9BuScPvDA==
X-Received: by 2002:a05:6808:10c6:b0:3a3:9337:4099 with SMTP id s6-20020a05680810c600b003a393374099mr2251971ois.56.1688655210655;
        Thu, 06 Jul 2023 07:53:30 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.61.219])
        by smtp.gmail.com with ESMTPSA id c8-20020a633508000000b005579c73d209sm1452994pga.1.2023.07.06.07.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:53:30 -0700 (PDT)
Message-ID: <64a6d56a.630a0220.5427.2bdd@mx.google.com>
Date:   Thu, 06 Jul 2023 07:53:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6555554300904807036=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: adapter: Allow broadcaster to be passed up to application
In-Reply-To: <20230706133605.23325-2-claudia.rosu@nxp.com>
References: <20230706133605.23325-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6555554300904807036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=763113

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      27.78 seconds
BluezMake                     PASS      1032.58 seconds
MakeCheck                     PASS      12.05 seconds
MakeDistcheck                 PASS      159.81 seconds
CheckValgrind                 PASS      261.24 seconds
CheckSmatch                   PASS      351.87 seconds
bluezmakeextell               PASS      106.92 seconds
IncrementalBuild              PASS      917.45 seconds
ScanBuild                     PASS      1099.94 seconds



---
Regards,
Linux Bluetooth


--===============6555554300904807036==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3784C7618E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 16:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjDXQzb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDXQza (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 12:55:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87501712
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 09:55:29 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-74e076b66f7so242670285a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355329; x=1684947329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dE7C8ae3CJDvCxAaPd3igkr/XK8sNxMi/f0TpWBtvk0=;
        b=XBl9niqgQctTar+1BCo4+kMzmPz/e2Z42X36TYMjj9PHoFIhOILRbKsd0kwX6/i3iu
         Z2Spg8nfAt2tmak7NLRWj/fe5JUVIfiux0av7sNEqqQlaZkRb107ZjOOITv12lYW1lol
         g1FuxDJQtMF0a9s4nbncEGeXbtscwEE3YTRpH+LDrOyd4BvIyUO5ZlvYo8RTNsNEQhFv
         AbMQrQC1J9wwbbFcsbCZBXc31vvDFAxhqQoM8RDty7GpxmifCVvG/7z/Teq8S/aGLQcZ
         8TXSMzpG3k6UnPGfG1vCDIdC5JXrLIGl534LXHRm5Ab+jYZRvIKQOpEFxvX4I9BAY8EZ
         gTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355329; x=1684947329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE7C8ae3CJDvCxAaPd3igkr/XK8sNxMi/f0TpWBtvk0=;
        b=eSK0MM1jYjd4XtSzrj2uhnMcV0sjr5/1pveumDCVYg8+iv0slanD9sSJfrF1pvZfm/
         V6LHdKKaQIsGbUlfvXVyZtbzwuErzRPUtZeFbWegFmnmTfKsrzbWYbV7rrDcmc+FUaK0
         MHlUpUdSFpaDsydMHG9xLIJgv1Cre+sb1K+xV8sZ8rdeG8slHwWPvB6hoNddsG/Ei3ms
         VtNG0h3YUxDAwpdwdIJXKWW0EkMWuwZqhms7YUhBCAOnaDmprf7u+bQZxffxPjiTPNVg
         nTJ3i8hPYpcojJK1KWRQ0xqClxSA1PFeuVrhzkE5MZo3OTnyRJ+MCd09txI58tRYF/6i
         327A==
X-Gm-Message-State: AAQBX9dI5Cv5z2EJlos7vCCy2Dc+Rgzd82m7DSLGwBnvJ/wMec5n9DXn
        NVOurzRtZxTa9CmNLjJGn7LHVYRxtyc=
X-Google-Smtp-Source: AKy350bKwzk358huy6cxgJP5+aRtarNZLghrcTtzPIlf6E5tILVa4mopRinIqFGHkGB4P69BjZ7w6g==
X-Received: by 2002:a05:6214:1c43:b0:5e0:ad80:6846 with SMTP id if3-20020a0562141c4300b005e0ad806846mr28798282qvb.0.1682355328731;
        Mon, 24 Apr 2023 09:55:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.163.151])
        by smtp.gmail.com with ESMTPSA id y5-20020a0cf145000000b005ef650b5e1csm3405838qvl.61.2023.04.24.09.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:55:28 -0700 (PDT)
Message-ID: <6446b480.0c0a0220.3b7f7.c2c6@mx.google.com>
Date:   Mon, 24 Apr 2023 09:55:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6832018752113518158=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add initial code for handling BASS
In-Reply-To: <20230424152457.28000-2-iulia.tanasescu@nxp.com>
References: <20230424152457.28000-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6832018752113518158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=742785

---Test result---

Test Summary:
CheckPatch                    PASS      1.72 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      27.14 seconds
BluezMake                     PASS      996.70 seconds
MakeCheck                     PASS      11.53 seconds
MakeDistcheck                 PASS      154.19 seconds
CheckValgrind                 PASS      249.43 seconds
CheckSmatch                   PASS      335.82 seconds
bluezmakeextell               PASS      99.98 seconds
IncrementalBuild              PASS      1752.63 seconds
ScanBuild                     PASS      1063.00 seconds



---
Regards,
Linux Bluetooth


--===============6832018752113518158==--

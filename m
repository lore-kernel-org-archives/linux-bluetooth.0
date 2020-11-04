Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD1C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B432206FA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2+wKDMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgKDTW2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKDTW2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 14:22:28 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAE5C0613D3
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 11:22:28 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d1so9852482qvl.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 11:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ariarxNdiOTavRTrtPYMKuTqQ2CTo7TGnqnk8FGFGC4=;
        b=Y2+wKDMCDSH5x8YV0nXqbuF4pm/8wBQ6agvKwzvppGNLsyfHYPwnOSU749ZJyOT3EJ
         QfhNYIbOTXMEzZmNlLzu8lungUihLu6o15vjDoNcl9YFm/qhG7yJkTk3WDq5QQ0QUWth
         uORHko6MN6isGjv2DFSemg+vmJnZ4SSItpBxbjHP/EGcQ9eZnvIFdVPEsEyV6R67+LPj
         yVoUPyJ17v4sqSG1Pexsps69nYnm1pZNYNlI1bniBGLbZSvtkQLSM+h9tZIEfOQ0ipvD
         Z6AxWClMhD8jVx2mVLi8baSbrpCJlQ3oCpjrhEHuS1w75KtwB3xYTLx/M+Gr7xwBVdHw
         qfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ariarxNdiOTavRTrtPYMKuTqQ2CTo7TGnqnk8FGFGC4=;
        b=ZSSJ4MxmBQ3y4yqeeXjT77ubrURhhrpTkQYuYMKctTpH3luAMPjmEzb17e71NxfHrr
         DAMdzXYj/YJ8WsGlGZsyjXBNy2tGk6wPZxmbYdk2g1DpgiaZP1jDgoqamtE2+wlUy+l5
         LaUVKM3AqPW38WjaWzAvhrSoos1laSjiBF0b4fiIMB1oH7whxhujwPh5Nt4sqeAsEXoL
         92WW9gSLjJJRankqxnmDPQEAOZkSyznBofLw4My2HSF9GmIlxOuMK6kJ+iP/GFnCN7Zi
         8xp8cTYMzKw9+cDaDXXnSebmovodsK/OdBoDoFUTys/Ui1ySQZ6puTFvN/xWWz4EWN1y
         esZg==
X-Gm-Message-State: AOAM5333WaFWbSIXgwRA2LO0BVCb7SWpMDIRjXkArUexv3fqt6tJjCu0
        BaiUN+KhOcHNn1kuaEYl3bYA08PyPpTn2w==
X-Google-Smtp-Source: ABdhPJyFhjDMEaX9zYhyXUWYttFkgyPlWUsjlU6WHCQN1fIUCUJIugy21uKb7LP3vzmE4uhDopcZ8Q==
X-Received: by 2002:a0c:fa4f:: with SMTP id k15mr33159777qvo.60.1604517747386;
        Wed, 04 Nov 2020 11:22:27 -0800 (PST)
Received: from [172.17.0.2] ([40.79.73.134])
        by smtp.gmail.com with ESMTPSA id b20sm3115084qkc.33.2020.11.04.11.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:22:27 -0800 (PST)
Message-ID: <5fa2ff73.1c69fb81.39207.027a@mx.google.com>
Date:   Wed, 04 Nov 2020 11:22:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5367488515053856963=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v2] adapter: Fix a crash caused by lingering discovery client pointer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201102142933.BlueZ.v2.1.I474ca6a46b5ae198462df03d23f46dee652f74bb@changeid>
References: <20201102142933.BlueZ.v2.1.I474ca6a46b5ae198462df03d23f46dee652f74bb@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5367488515053856963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=375919

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5367488515053856963==--

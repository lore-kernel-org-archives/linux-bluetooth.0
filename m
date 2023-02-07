Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD1DC636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 05:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBGFiP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Feb 2023 00:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBGFiN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Feb 2023 00:38:13 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86242A995
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 21:38:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso832535pju.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Feb 2023 21:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VUoyVq/8pGcC1cEq7mHU0jMvmH/gDGF4XcPBfJ60Xr4=;
        b=Meu3Ra/5y1B8AEDq0CBFKQup4SvV6dM0Ucn7O9n99eYM0VBsZrWuEMVlTiHwTWvK0Y
         YZ4pgSeEMu8OIu6h8NdISiYBiSibTm8VWqIG9uSf+P54Xey6vAElzrUL/HBS7Z/b3EOV
         Ha2BDDACFpFDcNeyXDRXZXFd19RiIBH1hagoB9OYshXNMckQLNbNy6PLTHytXbxthL9Y
         r4U/NB9fKg5Eunvr0CJxA8AvBYFlqnrPUcpRpSdd+4U38f8MK1pexK8ezTl0jrW/frLu
         dmLlRx9Ex09xGO4jnESzQM2LUso4YoGIMFj9cfF4dcgH2QB6P+drgoPzVARXVkDiW1J4
         5SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUoyVq/8pGcC1cEq7mHU0jMvmH/gDGF4XcPBfJ60Xr4=;
        b=LaJLpMR4RHshjmvEXIkZoga+10fL8FJNmi+UhhDV4oQBU6oobDtc2kbcE3CMF6U0Eh
         Ib4HS+oSRRm1+jfaYEtZ4Iq576aD0sUWPM0BFKDL3MSXUUteb5a5WuJwBUSx7nuDi1+5
         XvNy06THSTdpawyQbCk7U5Q1U9nT79aTSsCFODY99wdGIyclne9RcFfbdVSdM01+nVGZ
         eZDToznhZTPoGs5XME5clnzBEbJQaKGeclbPczRgMQsjpiRKqEyNHEkyXHtf6yZqoC9B
         DVE0JUf+fALScRYONzENW86a5U50JfxIqj9yGyqNLHKpTV03vp8lKrls0cC67nnQQeUh
         lCoA==
X-Gm-Message-State: AO0yUKWyGlK3cLtAwKMg8hV5KaDZDJ801Z+pebKuU/umI/uTCyAI09H1
        cwb9DLrhG3+CJeX+maO8NMjShjlUzVE=
X-Google-Smtp-Source: AK7set8lrKr6BYlGvDfmwM0ymaR2dFJ/056JXKr/tWY7+huhzDndCPeHJNTNX/eO0EYDLS3QkrStDg==
X-Received: by 2002:a05:6a21:9205:b0:bc:7dc0:6a55 with SMTP id tl5-20020a056a21920500b000bc7dc06a55mr1805881pzb.29.1675748292099;
        Mon, 06 Feb 2023 21:38:12 -0800 (PST)
Received: from [172.17.0.2] ([13.87.244.194])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090a134400b00230ebb77818sm467963pjf.53.2023.02.06.21.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 21:38:11 -0800 (PST)
Message-ID: <63e1e3c3.170a0220.17e6d.0f78@mx.google.com>
Date:   Mon, 06 Feb 2023 21:38:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4214625783630867037=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steev@kali.org
Subject: RE: Add WCN6855 Bluetooth support
In-Reply-To: <20230207052829.3996-2-steev@kali.org>
References: <20230207052829.3996-2-steev@kali.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4214625783630867037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1207
error: arch/arm64/boot/dts/qcom/sc8280xp.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4214625783630867037==--

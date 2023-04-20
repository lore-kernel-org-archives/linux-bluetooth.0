Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE162C77B72
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 08:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjDTIjJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 04:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjDTIjI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 04:39:08 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4F540D9
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 01:39:07 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6a5ec0d8d8aso513597a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 01:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681979946; x=1684571946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+KeU7ZHRQEaWMKiX5LgI/0iMpAmPjzyEKIkJ/Nk34zU=;
        b=iSgUtl+iOdnuUDcvCQU9oGjF/XGeNMNtG/5Fja5r2Is/8L2Chi45LNqNDQLPIQuOmu
         IE6RJ0dcsDMwE5uQ5ttpPj93Uwkm9m7pK4hF4uQa7gm72l6hXDzn4U+MgEwpEOtPoeiV
         6ulUAILrdt9CdaqacrfrzUrQb7YU6Kc+JRSfymPwFX5BPKNUqfjqifDPtl2admQWQ2vn
         NQbAj3oGT8n6rqV67PziaaiNu+ni1rQtW9sVAi8+F7fzpMbh15HqNUASKEISbPQYGmAd
         AyaRfSiN/4CMV/TN5etE+xL+jcHVDPc4KVBjpypNN4OLW/WXsRAWbvjNQJuHiAu/lMYm
         /buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681979946; x=1684571946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KeU7ZHRQEaWMKiX5LgI/0iMpAmPjzyEKIkJ/Nk34zU=;
        b=cYB6CnhWNR+FpJxSgEsWlmtfSz95bcJGxVauAWP0TF6x9VO/ks/r7FsOqeLp/sxX7g
         Z8v9bTm5k2fs/UWQw7QNMZZe8YMNRZAWpO4oz9hddwj4YKnT3q0zG65Pm1UOkD4oOvrP
         3SHF71DMcZU1/WpyNtGfKho9/tMK8Z7edzPRqJtyDCnNeIQIm7EuoT50DnKTo/Y0PE8X
         Dk0Wai7PR3xtTIQUpe/WWGhASm+OqnF/RjkPuYfhFbq694A2pWe6EPCeJILUSIMuBJa5
         3Eo89BLVWPtrD/bcB2CShJAHaj+LAqCbieqI200ubwC29bndCti8+ojX17tupaPYjSm1
         P7lg==
X-Gm-Message-State: AAQBX9cQGlzXJk8A/O52zex49A/vH8ITW3bwlohHb1SbfaIGykwAndux
        XLn8Kf1em4ZpcYhJFuhCtGrp6U2kgnU=
X-Google-Smtp-Source: AKy350aguZNbNodtHTDgMnOoHWGG+o5Hm5+vYAxv0ETAhUTvBpiNaqU7EoNklsQOS0FXK8OCJB+Gzw==
X-Received: by 2002:a05:6808:1493:b0:38e:4c45:743a with SMTP id e19-20020a056808149300b0038e4c45743amr581434oiw.26.1681979946562;
        Thu, 20 Apr 2023 01:39:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.141.233])
        by smtp.gmail.com with ESMTPSA id b24-20020a056808011800b0038c0cf168afsm366789oie.7.2023.04.20.01.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 01:39:06 -0700 (PDT)
Message-ID: <6440fa2a.050a0220.63b76.14dd@mx.google.com>
Date:   Thu, 20 Apr 2023 01:39:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0859584555872323916=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v2] Bluetooth: btrtl: Add Realtek devcoredump support
In-Reply-To: <20230420082414.32017-1-hildawu@realtek.com>
References: <20230420082414.32017-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0859584555872323916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btrtl.c:31
error: drivers/bluetooth/btrtl.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0859584555872323916==--

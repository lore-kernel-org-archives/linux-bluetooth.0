Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08F9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 22:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiC1WYd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiC1WYc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 18:24:32 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C70E4133A
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 15:22:51 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d142so12702745qkc.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dgmQIAjpN6xjKY7UzJNU3WVoMHi4//JFFUQN0g7VakU=;
        b=giNXbX9uOLFxVZDQ9Y5tTgu7jxlTrGGkcdW7SknMM852vPMw9k1PK16RWP41WWutd6
         ChqbGkSDQ+2uX8OMKnSa7lLsUCCr4Tg3/eFs0TuSQyF0rObYAKgnbULVmYh2M7zTJ9t1
         8mVkTUonCbEtWzZtC3xcyslowN6vuenivFppzfNNRI2OlzTI7uVWxrbJu4mv21DEbEQB
         F23FksOHDgkH0Pcgki6EOu+bnO/d+PFuNtcODlbEYOgwWRbmAOvrtP8mkQl9bxyQGmwO
         Oqz43J+xstEV7HcBEqMZ3Ox6MW+yxNG7eN/vbzZHY9yd5HVasGXt6hOC7exhF5LgHGXS
         KOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dgmQIAjpN6xjKY7UzJNU3WVoMHi4//JFFUQN0g7VakU=;
        b=ZhlnBf5+Ah3VHxAhBaO6bODrY7qq5T3F8JWFHZR3Qi4+OZCpmRDUxzfvYI0ld1YDug
         w6rkkaYukl1cuikEPFIUemoS9hMdTNUw5Ok9pIdL3/ScSxUBxMUVeci3C2gdrWof/fE5
         aRgAd7uS0+6dA+P+hjVkd4hTPEhnUVtBk2/iKyahqvxkMOmtcNZVlJqH1ynIb3QFuE1q
         2nERNzExlAf2ivyT5BUZc5uhHPWwx6WrHH7lq7YrsiMptWvaCgjl7fUQ/iI0J39HPtZX
         g5PJb6V+uOQZ0vjdywEf/k623CvWW9k4t5wqZKW+aEk29UfkAXlTeKq9omJLwx6JSgX0
         C0ew==
X-Gm-Message-State: AOAM5316mzXLQdODbKNlcBHVv5JUMKBpVtWGACqnXA2YdjrhS9I1abQd
        4qi1pRvbOaXYoMlFN+2PS2J5Du/lM+zm3g==
X-Google-Smtp-Source: ABdhPJyo0B4CROdmhRtjH0U07Qg2v8bWnSjx2CUlDzWkHhAC2LUN6knaeCHXjlm/PJ5RV1nlojr6eQ==
X-Received: by 2002:a05:620a:244f:b0:67d:ccec:3eaa with SMTP id h15-20020a05620a244f00b0067dccec3eaamr17822334qkn.744.1648506170217;
        Mon, 28 Mar 2022 15:22:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.78.205])
        by smtp.gmail.com with ESMTPSA id z19-20020a05622a029300b002e1a763dac1sm13710031qtw.9.2022.03.28.15.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:22:50 -0700 (PDT)
Message-ID: <6242353a.1c69fb81.b19c7.5a48@mx.google.com>
Date:   Mon, 28 Mar 2022 15:22:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0729040328697014358=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] a2dp: Fix crash when SEP codec has not been initialized
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220328204150.1855063-1-luiz.dentz@gmail.com>
References: <20220328204150.1855063-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0729040328697014358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626998

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       PASS      1.00 seconds
Prep - Setup ELL              PASS      44.05 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.53 seconds
Build - Make                  PASS      1392.91 seconds
Make Check                    PASS      11.91 seconds
Make Check w/Valgrind         PASS      443.86 seconds
Make Distcheck                PASS      228.07 seconds
Build w/ext ELL - Configure   PASS      8.66 seconds
Build w/ext ELL - Make        PASS      1379.37 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============0729040328697014358==--

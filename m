Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F292EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 05:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D5160C49
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 05:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhJYFKI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 01:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhJYFKH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 01:10:07 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20428C061745
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 22:07:46 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id h65so10901962qke.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 22:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=taxiHcN0qJXkfrNbRFawDs1TNKHJ0HSXeAvD0lUzEUU=;
        b=XHGbPTIJ8ZLMIuVuCH+y4RDjqnk/o5bX4kaM8HtyRrHaNBCOheL+VE4Ie+npA9CBdD
         vLtTW9hPNvzjUXhcSP96o6urOleFijZdw4gjoXwfi2vvldeu1dx5QgjvPkmiCP1vQVxN
         jaQFUbqKf4pk2TEWxvRlKDCKa4dOTe/+t9PRd1wJaM/35b7OP6b2mlZ1akrF2nlXc98u
         lSW/chnYayTuoaZGuNxOKPRlT3tr7VrgL3yk7bUoq3golVX/ILWaTGQGaehwF7n0ReBc
         +1A+suMpfZ+uJwVaTz2vDY/7xn0t51XMXiz1smaHf/f9NxQdTM/GpOBETWZo0n3EhCpt
         /7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=taxiHcN0qJXkfrNbRFawDs1TNKHJ0HSXeAvD0lUzEUU=;
        b=MVcxlAz6oWAGLThJCvzIQhSUipAw0PYwD6mqn2EFq+mHHwVDAq+VWt+H5a06gR8804
         PQgLTeGNh5oS9P9Vdz9/nKSEs3Qu71AFE3ZOuJnRuLC+DtNLaAHk88OzXI65+wrD/1tr
         u4PAkGgmNiMMZLGB3qTCatbRyoVYLY7/cllDvbsLMGesJWe2MAxlCJ9c/ie4p7hNXK2h
         dLzxtUYsNtlbX+2/2PWk3tGuvfos2WEif4kfEZGTWP0g84IWI3VIu+cA3VssIJB3NV/Y
         Q3yPc/VziUg0qGjSj/l3oeDXW51dWlVtd3Wl37dX/Eh9wbXS3atWMn6gz7Fx632x4LlP
         qABg==
X-Gm-Message-State: AOAM5302dG43FGULiTf0MzSAm9PJIsIpAXe0AoNMCsMwH0LR0Q5A7NZO
        DrDGjw57MUtbOtrc7Wm5mJRDoZ5HOTHgCw==
X-Google-Smtp-Source: ABdhPJyK23dQ/1gwspZZ2+TjIp1+jwid78iBBM2qNgrDfPrEmFatXTOv/KTG3LK0FtwdrRZj3XKL5Q==
X-Received: by 2002:a05:620a:424b:: with SMTP id w11mr7211988qko.318.1635138465133;
        Sun, 24 Oct 2021 22:07:45 -0700 (PDT)
Received: from [172.17.0.2] ([13.77.80.148])
        by smtp.gmail.com with ESMTPSA id g1sm7975591qkd.89.2021.10.24.22.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 22:07:44 -0700 (PDT)
Message-ID: <61763ba0.1c69fb81.bfd4.20b1@mx.google.com>
Date:   Sun, 24 Oct 2021 22:07:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7823061654946290988=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/4] emulator: Add support to config the accept and resolve list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211025044725.482641-1-hj.tedd.an@gmail.com>
References: <20211025044725.482641-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7823061654946290988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=569309

---Test result---

Test Summary:
CheckPatch                    PASS      5.83 seconds
GitLint                       PASS      3.63 seconds
Prep - Setup ELL              PASS      49.33 seconds
Build - Prep                  PASS      0.53 seconds
Build - Configure             PASS      9.32 seconds
Build - Make                  PASS      218.93 seconds
Make Check                    PASS      9.42 seconds
Make Distcheck                PASS      272.11 seconds
Build w/ext ELL - Configure   PASS      9.76 seconds
Build w/ext ELL - Make        PASS      219.86 seconds



---
Regards,
Linux Bluetooth


--===============7823061654946290988==--

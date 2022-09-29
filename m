Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92862C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 18:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiI2SlA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 14:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbiI2Sk4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 14:40:56 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E52813F722
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 11:40:55 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id s9so1423309qkg.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=07W/Pf4HXebPAfh4bZZMIY+H0UVNf3s5JiwW6lDKVro=;
        b=fXYWYj/GUVdHdQTgci7gD88cz008GZtzG5FynNQ9NimwcGzFkm7y18zlkuFN6/u4h1
         XN2jAG3rE/pyhyyZhkKdF2JR+8Cej4v57Maj1Q3n5vtnQD4K5rDqZVt08lhDaOA1QhGn
         VF1EIHNWnkRzqzLqRcXSxfisLdjR3brcuesoWtod77rWIehuDPx40ALNNWggQs67r8I9
         GH/i0J+GzL7wIhtYH9kN2ktrflgLytWjSYGzB4lKdg/iyo+sajn6mJmhLi4B93ykSNrb
         kGGsL6n2/labvcZQHIzVw2w+4QAaYNIjvPYw209K7kET4LVC9PiAMowYQbNXGvRnKILX
         9b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=07W/Pf4HXebPAfh4bZZMIY+H0UVNf3s5JiwW6lDKVro=;
        b=uijFI6+8a7MZYvhC7ApCvb6ZH6jTeqpjeJ6AdGGnQgEVzT38+sm1EChroMosrAFiNK
         iYLvLVq0IgfRNPkR0NrqHahIHg6lCcWlPT9wkmWbcfPJ5o33u6ddgyzJNc76jbeBE9mp
         QEJki+L5abEAAInNnSyHwCkLGdQMVQzB4UB1jAi2/LTqnOEU0k/EccEepPSqDHwcU4Sr
         YTIavPwIp7XneUgzNwPm06Wz0DmUVUXcLS+Rm770dTLmHvL4j/+G3xsUg7x5EfRsFzY7
         dtm/f46hNRp4iRRS8nrawqYBZ3X8Ei/yzGfOAZXhvJjrSfVfyyWmu7sNmiwMS/P605Hb
         iHHQ==
X-Gm-Message-State: ACrzQf2kD1DdL4cRKto3HmjT6KfM4L7Su2GwHH3ypvjs1bWmS8YvQt+w
        X2FNs5nCkzzRwj6XfnJSgyPXQFS0saqREQ==
X-Google-Smtp-Source: AMsMyM62jBjcZUGt+aSdsdZkavUm9ndyi37ohoIkBziVhIKaogaG1FT1+iDv5c11xflFxRUVeKMdog==
X-Received: by 2002:a05:620a:28d2:b0:6ce:66a7:c0c6 with SMTP id l18-20020a05620a28d200b006ce66a7c0c6mr3380286qkp.166.1664476854556;
        Thu, 29 Sep 2022 11:40:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.221.155])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a454700b006b640efe6dasm97757qkp.132.2022.09.29.11.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:40:54 -0700 (PDT)
Message-ID: <6335e6b6.050a0220.d34d4.077d@mx.google.com>
Date:   Thu, 29 Sep 2022 11:40:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1069028684998600115=="
MIME-Version: 1.0
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
In-Reply-To: <20220923145602.25872-2-ceggers@arri.de>
References: <20220923145602.25872-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1069028684998600115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/advertising.c:1055
error: src/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1069028684998600115==--

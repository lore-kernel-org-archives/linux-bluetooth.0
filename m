Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA3CEB64DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 22:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFSW0I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 18:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFSW0I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 18:26:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF8911B
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 15:26:02 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-763a2e9494cso90908585a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687213561; x=1689805561;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G+9l3KkX+fmfAfIKfOFzrEndNE+T8AEuELSG2ez6a6M=;
        b=LX87dfwoazN8L+pcYTzK22BjRSD0Ccaw7IDpU0Y6pQSX2IUl8t4V7fWeikxXJUIPCm
         A/pbggIlSXWWCsmRChsZ50hgrmq1EK9/yTyvS+HhQDcoMsOqNokeMjgn7xdK9E5wOKha
         SyEhpZ2ot+q4C684zd1I80UabpvwN13q3sdDYNN9ez6NqamEBuR4tWMXvXhXig+XkjZA
         /RJBPnMqjPyuYzVendijWuR+KfcRI33qqRQ4NUYj6vk4LtlZ9BHdHESCKG+j+zRctuJP
         tfnzGonsOa47RS5hszHmJ4x5Dt6PfcGzflmTUOkSSUf0bq6ooZbjEcMY5VyBoUBo/hqt
         MUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687213561; x=1689805561;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+9l3KkX+fmfAfIKfOFzrEndNE+T8AEuELSG2ez6a6M=;
        b=khk1pxqLy89HVqOnMDUmIwnm5Smu8h6BUnht+bN9hHgSVGOGFcvzrsuWCsDqxc9HuE
         dnW2EKOuJ1HfTv4CVDI0lQNK4qKSKqYxivU5p06ORkLYabe96D5ytUWjk21cYglz/MTZ
         mBIOVUibxWkN/njCIp5e0+8i/uu0kXtiHxzzQZzwMA9h9KwohHp+yCUvsxlPrne3ZOPT
         4SAJMrAMrmwRgPiYIU/fYhbsExsjD80JKOS4eDlCzh4xoP4Sh64oyK7NcSl/jRKBo+N2
         IV/5qUzh4WEkEg1SKW7jszrsSxQR0SflsjbLSVefwh9CSQjVjWmYxb15Y+JxX4rACuuP
         Nn3w==
X-Gm-Message-State: AC+VfDxNo1vPrNz/w25keSP1iYTusC3IkWrw1B3FhrWZBp0b6xDqaqik
        85PK1fbV/g8bzMF3M/FPJwWS9N9svTs=
X-Google-Smtp-Source: ACHHUZ7IOLDzpKOTU5AA5gUfzAQ6zc3kES1jAdQX6b3x+/OHILdLmwYDRJwj73TSCuAvDUUEvf46BQ==
X-Received: by 2002:a05:620a:6847:b0:763:a7e9:6cfc with SMTP id ru7-20020a05620a684700b00763a7e96cfcmr1854182qkn.11.1687213561114;
        Mon, 19 Jun 2023 15:26:01 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.167])
        by smtp.gmail.com with ESMTPSA id p12-20020ae9f30c000000b007607324644asm367101qkg.118.2023.06.19.15.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:26:00 -0700 (PDT)
Message-ID: <6490d5f8.e90a0220.24537.0f92@mx.google.com>
Date:   Mon, 19 Jun 2023 15:26:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8800323859998116475=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] shared/bap: Add unespecified bit in audio context to PAC records
In-Reply-To: <20230619203032.6812-1-luiz.dentz@gmail.com>
References: <20230619203032.6812-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8800323859998116475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758478

---Test result---

Test Summary:
CheckPatch                    PASS      2.89 seconds
GitLint                       PASS      1.82 seconds
BuildEll                      PASS      27.80 seconds
BluezMake                     PASS      875.71 seconds
MakeCheck                     PASS      12.05 seconds
MakeDistcheck                 PASS      156.89 seconds
CheckValgrind                 PASS      259.09 seconds
CheckSmatch                   PASS      345.82 seconds
bluezmakeextell               PASS      104.47 seconds
IncrementalBuild              PASS      3647.17 seconds
ScanBuild                     WARNING   1066.68 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
client/player.c:3661:25: warning: Access to field 'acquiring' results in a dereference of a null pointer (loaded from variable 'ep')
                if (!ep && queue_find(ep->acquiring, NULL, link))
                                      ^~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============8800323859998116475==--

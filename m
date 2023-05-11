Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB25CC7EE22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 May 2023 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbjEKUg2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 May 2023 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbjEKUg1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 May 2023 16:36:27 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA430D3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 May 2023 13:36:25 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f4e7ce15c4so5731911cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 May 2023 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683837385; x=1686429385;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fgPT0LlOT7vIGrnGWaeEx0pPNsQJ0nNzojt+2t34KmM=;
        b=hVLs5obIwH4jYtHDE46e7B8skizAR0WiwlwsdIMX0i+acVZbulDST1Uf+UNu19cpr1
         4oJCZw1Z1WosuUc9QsRNnLvIJr3moG1Dmr0XQe54JTB94HRDTlw/UpWMWGBKbtsvKNYp
         szq0WzfQwjndmB6CVIvRv6OA2XhrbAq5Rkq5BL302webHdXFCLfqSa/weRMGh8DQLEqD
         oNLhN9CBDE64CkgQlPuBWYZcj1MtmFkaewsQPuRlffawkBiwn8ARxemNhKAsOVGG9h0s
         Z75SEg2OJGJPFxhZ3v/SgZCleXtErEfd5TLbx9vr8S1gDMuI9vMMBtAPXoJkir3pfSqq
         YgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683837385; x=1686429385;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgPT0LlOT7vIGrnGWaeEx0pPNsQJ0nNzojt+2t34KmM=;
        b=a4vKlg8FSUqX3Dc3bfpU7V6G2apbdQI23xY+jfO4ZeDRFiTklBSaHcYvutWK/idLYq
         XzvUGDCM6vbBVbD3+ft//6SGvHY6WkKFsciGaryRcV807kUJLu3F3Vy6NfxeT1nRBTpj
         v9R1IUu2i/H3B/iPhSJTUPfWkoGBCnlWgUdhYAs68P3rDNOfAv/GIHZf4JjIP9uzEHwK
         VmortJaL2zJFBXkwzLK6MoOzwaW6sSIS81bljWfSI9grhhbzAkGqXE3rMZ96pU9lzY3p
         oZlg3BFsWgjIGop7UgiuChrTjmiRSl7uxXt8pzEE91FFq1Dk39Tj2X+DJC/NWtp1yXXn
         cFrw==
X-Gm-Message-State: AC+VfDwACQzrRrR/SvZU3ZqeMJN5mf2nsPk/O7xvTQUzd00XGt5f3O2k
        h9IY4VRsrGjTnkYEp8wHLY2dc1wXoo0=
X-Google-Smtp-Source: ACHHUZ6lBjoD0czAVwwz+tfeHxh75z2kk4KMUMGWuCyoNuNMp60D9L2s2boKg7umZ5nOx+FKbDQhFg==
X-Received: by 2002:a05:622a:40c:b0:3dd:a248:5474 with SMTP id n12-20020a05622a040c00b003dda2485474mr31555078qtx.34.1683837384754;
        Thu, 11 May 2023 13:36:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.128.132])
        by smtp.gmail.com with ESMTPSA id e29-20020ac8011d000000b003d7e923736asm2533631qtg.6.2023.05.11.13.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:36:24 -0700 (PDT)
Message-ID: <645d51c8.c80a0220.2ec25.dfc2@mx.google.com>
Date:   Thu, 11 May 2023 13:36:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5683969920652456568=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/player: Fix not checking for SupportedUUIDs
In-Reply-To: <20230511202825.3983806-2-luiz.dentz@gmail.com>
References: <20230511202825.3983806-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5683969920652456568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/player.c:3015
error: client/player.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5683969920652456568==--

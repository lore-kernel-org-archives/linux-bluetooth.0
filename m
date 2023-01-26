Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3327C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 13:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjAZNn5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 08:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjAZNny (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 08:43:54 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7543A3C2C
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 05:43:50 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id 187so1883949vsv.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 05:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj+QaIYKyrU14fPXJUuR+N6o3Kv3DDMa4FhBVagEzEU=;
        b=ImLkIcJXj/LdO04EmcCPg/NG6qwPgIvevezwiCqxAey01sUVBjCH4lmk+xMiL3/9s1
         W1ocssQLWdodz56CKuZRvjxUkz+tk8PNRX1CilrPVGVgLe6ccW1JkEIOgxbk9iwLKzl9
         P/P3890bwsxaRCpcXBcbOLU2O5Nbj9eSMJq0N42pXSOK7HOzlZE4+GHzMbWTXfqhhUfL
         oMrE9PQoeMxrRevBZZHZrMDpuksbmZZ5kexx5GvuezrVGDzutAO02j98IIz3mLPKAghf
         uAylowe09vReXs4gHOkK/S0NPEVItOXLMQAh5QCFUxUYacEnHcrEReq66oLwLjwo/Fwk
         xEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cj+QaIYKyrU14fPXJUuR+N6o3Kv3DDMa4FhBVagEzEU=;
        b=8B9GRVN0hXKCv0tmvdQKtVLEjWn1l0NcYqj4aukkyiKXP6X8FDLnVWeM+KS4TOorLH
         6/JS4TiltwyxfnY0ZFHawmF7Z1PRy/X1hU49J30lPuz8jJzJY1TcihBw+i1S/w0rkPHr
         vycFe6BLF+359NOkdSb9NDuo9Ylu55ab/viALX0ZCykMCoQM/2AINypFstYVu/59uaGr
         rgfKqK2b6zZeZwjDbXVq0LQpHNS2GGjU1H4FiABWxNtrCUwU+VexHPwZf1/CBkj48TWb
         DFbXMj93Tw8/b4xfabZL1UILWvqQoKv3H4RiPhpo1zrf8n4bjMudRfOUmHRkj0fiZgmz
         aMiQ==
X-Gm-Message-State: AO0yUKW4/xO2AkJeANbSNtNQDshkclw6EtWwBYK+zH2y/bx8zPGi/0wr
        sanUyuF0KTKgt2OK9awf7TR9Fmery8qJ/g==
X-Google-Smtp-Source: AK7set9leNTwSHVkFWFUUwhKfA0XkAUK3NJvV1fhpTvJmmqkQSxWIzNP46/Lb2osxe9h8PGSI/7bOw==
X-Received: by 2002:a05:6102:558b:b0:3e4:a209:e8d with SMTP id dc11-20020a056102558b00b003e4a2090e8dmr11665012vsb.2.1674740629112;
        Thu, 26 Jan 2023 05:43:49 -0800 (PST)
Received: from [172.17.0.2] ([172.176.217.64])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a0a0700b006fbbdc6c68fsm917678qka.68.2023.01.26.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:43:47 -0800 (PST)
Message-ID: <63d28393.050a0220.2ff5a.250e@mx.google.com>
Date:   Thu, 26 Jan 2023 05:43:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5351782364333776931=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pchelkin@ispras.ru
Subject: RE: Bluetooth: hci_sync: cancel cmd_timer if hci_open failed
In-Reply-To: <20230126133613.815127-2-pchelkin@ispras.ru>
References: <20230126133613.815127-2-pchelkin@ispras.ru>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5351782364333776931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:4703
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5351782364333776931==--

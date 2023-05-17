Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6E3C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 00:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjEQAIC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 20:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjEQAIB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 20:08:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137DC122
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 17:08:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3063433fa66so34495f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684282078; x=1686874078;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ryxOEZO7bRfcFo2ONNIJ0CRpvw+N63AG5L+IMmGeiGs=;
        b=WSIbN0dQydW30pYv0wNRNPW2psHUWw5hD8CjFEokdGk9tPinwYArVjgldF9aby704L
         HSbqpUMpTGJHvlRY8SG1Rkur7cZybIdyGEcHy5+zIuwIhueZWLl3FYs3FvMH+XQB7Ncc
         IGxerxekU4XUjFJorj0aDaX1ZUG2+2SnO59k5IuBQ6nVz3R5S7iSOpF8dvUFOPv1nmN9
         o4jnks3LLJhZUwup8/ujQ8ScosRlOuTqZbJbHTDp/lP0AjjMdZBZTLXCiVyjYGCqVJki
         fbPu6tmY0m8gQ4R4DG1zr1xKC0zYBSc5dJXQflP99T3bbH55dmVaTaGFtxHNr27dBW1H
         gHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684282078; x=1686874078;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryxOEZO7bRfcFo2ONNIJ0CRpvw+N63AG5L+IMmGeiGs=;
        b=LCvktvCGc9f0FjFvlDB0wacP96d2WoW/uXDqEQWNHX7bnUhjmvpF0SXJMJc9Ej6mIC
         FJ4JEDcD+i/UOxXmsN+eVmemzVr1VbLN+Badk82ahBW3svqrIbGC6oyQP9Dz+mMK797s
         2F1QV86pX3Qv5mFdYBfgu9dvtHhv2CyOWv1tQop3dcGMsEBAHz0vgdYV79RjGP6twbch
         1P4+rFdieMqHDPqurkmMM6U2RIIED3Ov6GSp8RMbE1XcvZB8OQY36nP0HYNop113iueJ
         3bYaQlqc6b8Uv4db8xy6bDfPXk1HJ9RMLmwkPSmZTCJ8bOZnzpWdfXbI5qKCHne6dzWZ
         G0Zg==
X-Gm-Message-State: AC+VfDyV/mx+9guU0zaDtYRKWJSs5EWYOQkzw1bmBaPEh5++gDvi46mg
        ap9XtUBjC2pf4m55K6+GHxP3iGp57PbIwqdiCD1/6ukjnYY=
X-Google-Smtp-Source: ACHHUZ5jioTI86cJL0qWcN0u4OPToyC4L7ByjGxp/8kYt6Bi08WeOfexJWxcgfCOkubGG6fyruCd25QqH5MMCI0D204=
X-Received: by 2002:a5d:63d0:0:b0:309:3ddc:1c8c with SMTP id
 c16-20020a5d63d0000000b003093ddc1c8cmr377711wrw.20.1684282078259; Tue, 16 May
 2023 17:07:58 -0700 (PDT)
MIME-Version: 1.0
From:   Jake Rue <jakerue222@gmail.com>
Date:   Tue, 16 May 2023 17:07:47 -0700
Message-ID: <CAHe0yEZ3_OtS_2g9To6HyBiO359wiiazyGrUNJ2CsuC=gRB4Rw@mail.gmail.com>
Subject: Where does the DeviceID Version value in EIR for Linux hosts come from?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When I look at btmon output of advertising reports for BT Classic for
Linux boxes, I see something like this:

> HCI Event: Extended Inquiry Result
[cut]
        Device ID: USB Implementer's Forum assigned (0x0002)
          Vendor: Linux Foundation (0x1d6b)
          Product: 0x0246
          Version: 5.4.0 (0x0540)

I am wondering where the 0x540 version comes from / corresponds to
about the host software stack version (I couldn't find such a constant
in the BlueZ source code or googling around. But for instance a BlueZ
5.64 had this value, so it doesn't match 1:1 to BlueZ). But it seems
to change slightly over time for different Linux machines.

And I'm also curious about the 0x246 product ID, though it seems like
that's always the same for all Linux machines I've seen thus far.

Cheers - Jake

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB92C4332D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 23:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B58164F3E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 23:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575724AbhCBXB2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Mar 2021 18:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbhCBRbU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Mar 2021 12:31:20 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8388BC0611BD
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Mar 2021 09:07:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o16so3513668wmh.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Mar 2021 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7CcNTMXA/G6oxQbeohLgrlaaAzwj4u2cgd+yTSSMMvU=;
        b=m0Wn/FUQx1Y45IaUEp8k0ILlKUKOiplrZERbdjxKU/mYZ1ULH7bkFeaTruo167Vsvw
         LBa65WB7s4piOzIF/UygFQFoydGOuciSEyqL9wM7dnVJN8ctdZrYuOHeffiVSjedZFVD
         tCKFbnKeWSm+Nxz3hLeW6Ag/A4U8BL6iNOtjoAL8DTwldTvHD3kHJFXvZcCJRrWtr6Ip
         5aAD+Yb7aLhkocyG4E8lDQhEN1riegXix+jR3Q8MxECR5PyQdsPEkm/0oYAj593rvYWb
         H83qvbZk/Hs8Xkh24q5uuZp+xCNoc4UBVSJ6flOcu7em0x+w8Am7DfXy5UZ+QBPaxOAr
         H6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7CcNTMXA/G6oxQbeohLgrlaaAzwj4u2cgd+yTSSMMvU=;
        b=eUu1KaUK0N8wtbvxQJxLAOyckr/UuWLErAp2gE5EY1ZBeUSskV5vPuDN1kLURgYLUn
         6i0emN6fTpHOpwglZ/LVG4l5Rk3c9J3CmgAi1MGdfnUauvatp/7ahQ6qsehAE4yol8q8
         MNw0z5+XfLukDa7RYT1MtwCKZ0HVJYS+IX/oi3ymrwrRlwQnXa05ZcNPdQq7CTBLdWeL
         qBA9GgWIiYV6QIcXyCd/QwknZ9yXGWO8+qRmVlyujQOWqfkBBKEWHnbjeWe8XiY7ttfX
         Zwb13goO8GrZIQq/Cd3IqfKw5OmbiEDnMttX7ef1XEmKIyiLHUukseoAkjoD90E499ZS
         frMg==
X-Gm-Message-State: AOAM533KOXxCfNdmvvf6gqJaW407+c9ksrKMJ8HMiG7Jc9RlYt1rteEG
        SCHcIxUcESr07YLgP/PDHaR2tgP6kPEDuJ3sB15GPyG9yj9twWHu
X-Google-Smtp-Source: ABdhPJxn6sdGV+qfvrmcOwtFvsAkApVCCVxuhIBLd8un2aoHWBExUIyAmbICOTlMU9CEwgay9XurPWl8kTqWMHJwVfg=
X-Received: by 2002:a1c:2155:: with SMTP id h82mr5066607wmh.169.1614704861759;
 Tue, 02 Mar 2021 09:07:41 -0800 (PST)
MIME-Version: 1.0
From:   Mihai Emilian <be.mihai22@gmail.com>
Date:   Tue, 2 Mar 2021 18:07:30 +0100
Message-ID: <CAP_L5iPNbYrni-U_EH=Yf5Tb3b7tGN6wFKp-h+HNE8ob028k5w@mail.gmail.com>
Subject: Autopairing
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear bluetooth community,

I am trying to create a pairing agent using bluez API in C.

The problem that I am trying to solve is autopairing from a known list
of MAC addresses (i.e auto-accept pairing for known devices in the
list).

I tried registering a bluetooth agent with NoInputNoOutput capability.
However, when I try to access Pair, I receive Authentication Failed
error.

Another problem here is that even if I call RequestDefaultAgent after
registration, it seems that the bluetooth settings agent (UI) is still
called and prompts me to yes/no.

I have the following questions:

From the api doc:
"Special permission might be required to become the default agent"

- Is there anything else I have to do to acquire these permissions?
- The return value from RequestDefaultAgent and RegisterAgent is void.
How can I check whether my agent has been registered/became default?
- I also tried trusting the discovered device after registering the
agent and trying to make it default, which didn't make any difference
- is this required?

Here's my source code:
https://pastebin.com/Wj3rdHy3

Thank you for your time.

Best regards,
Mihai

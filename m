Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0F5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 22:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F230E64F51
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 22:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhCOWgu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 18:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhCOWgS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 18:36:18 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C265FC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 15:36:17 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x9so10366207qto.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=goJoHH6bMCGxmFplMZA73s6J1j5HCj52LUS0c3PblM8=;
        b=P67Ch8sr/4B9Wzdpi72zcn9ErF28s8I7wTdUl4dSHHrp7g/kJU0uONXJdu+TFFBccm
         TaL12wZJtMU5gapH8U2YnhkWj4hpZiXxgPw7X/FZUlbqvG99JdhVSiXg2yHAGPzWmmE1
         +DiDYVFxtTRHS9xerLr8WDPZ+StTlKRvDGFvxSoI/Lma54rA/4MbB8+hh+vRJRzWWr4A
         t3AiuKEboLR9Pyrer12n6iCOVq7PHM5RyehBzvZhFjUQRCy8NVc4GLox0Y1+imELEvDK
         ssEHe6i/8fmV7rQosa4x9T6Yc5GnIE5R9deyRuIO9Q/d7L6GO7Ge1ae7NQjaGa8zkSnQ
         K4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=goJoHH6bMCGxmFplMZA73s6J1j5HCj52LUS0c3PblM8=;
        b=UtmMxZZ76NCDO1fL+lYPrLyljRr7D0P/ws9RoIp11S8URXmBss1VKD9oMATeNE//5C
         oy6SGUqpf/8IVRPmJGisKwGbAr+p6ulwoUbXw/9Ilg95u7BVpeKjEjSf7N/8TGKRmNc8
         ALaLyPTuckNxSxjWb9xWM8f+qgn23eHuUsZWuubi4Ke4c5/63RVGinxZjttWt4JtU5aO
         d914XvXebtWitPlEiJ2I5pif5Il+3yz0mV6Iwu0fk+mHK0ZpYq2hs+urw+SRmNv4wpna
         OSjvthemNuGDpJiJzq1AaSJd81ZsKXjFMIhxiakXNfFogCQJgBgFDVE6pWEwbHi8ndrH
         iXZw==
X-Gm-Message-State: AOAM533Wm4V7GoFfeY3PqM+i/6kC7tjKtgYCP3vRF/c7O5r9quBezcVq
        oPv+OyoCqB70vsrkruDlrqJtpro72GZlnw==
X-Google-Smtp-Source: ABdhPJw0q0OKjPwI4Tf2qVRXjyw7NaPuVxXfAqKa4LXoiJy83F0RcPcnuOFES1A3f4HNDURzsFy0pg==
X-Received: by 2002:ac8:4f10:: with SMTP id b16mr13815477qte.235.1615847776944;
        Mon, 15 Mar 2021 15:36:16 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.47.94])
        by smtp.gmail.com with ESMTPSA id 124sm2256350qke.107.2021.03.15.15.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 15:36:16 -0700 (PDT)
Message-ID: <604fe160.1c69fb81.970b.d80d@mx.google.com>
Date:   Mon, 15 Mar 2021 15:36:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7586858986747215988=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [Bluez,v2] adapter: Fix discovery trigger for 0 second delay
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210312165017.31829-1-frederic.danis@collabora.com>
References: <20210312165017.31829-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7586858986747215988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=447189

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============7586858986747215988==--

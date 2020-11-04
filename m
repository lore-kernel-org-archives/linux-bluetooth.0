Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156ECC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF772080D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9o3ppFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgKDTWi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKDTWi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 14:22:38 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B61BC0613D3
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 11:22:38 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 11so833273qkd.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 11:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MOxMUR8OejH05CQEChPHQphRigjuu/iCnVq/We+7eMc=;
        b=j9o3ppFyTJ/4W4pSuxShZXTvfcmI+CnDiI5heeJxItLaaIEl1UdbNXVha/JKGMtcWp
         kweTnSXyY2yhFBNbsahSGWRfh+PTMHVV98Inaw8koztxl6Aj06mBS9vr6poG2GhN77G0
         D0HmCIsNHAM35TfQv/A4NQURHKTnHvHlz17gZ7rMiHlcBZRTOz+HUzPaYofy1Iu+6HGd
         l3tC8tSYGlqmBG7DFS8cmBKJtMVNd4q22FmwYdrAtlToZpM6IZi3yKQocZXOwz8N2oou
         zqcNwHCGGqUBzpGt1H2uJWHMGa8sN5QgkdYXrvC6qnAeC4ToDr4UVJh2M9t2LtSXO/gq
         rCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MOxMUR8OejH05CQEChPHQphRigjuu/iCnVq/We+7eMc=;
        b=QtmVKSB/oK05rQSSx6jBRGxcLjCSK9c7800A6ss8MRN3LOmr0E3l61+nx6UM9FYb3c
         E9YB/NYRKV/8vdoqQxWyI0ZDCWt9Fs473UccKxM2tuPCNKpRpjf1DL+uBwx2xJ570kTb
         oRDhKjtqfEAGARwI76DL2VLrg2MZaJ0o1AhWd4U5IkyURCjxYsFePRdHstdTcyRRzauD
         f73vGE8k9IfwpiHHJE2+2GWdFghQoodl4Jn2rDjtFzxaSwJdfkW29uMVTCehHXs+neES
         SS5kzX+IdGCPuGhQBw1F/3K+kBzy/6EdJ1JCCi5XGqzuSF4sEUiBh2owGpfMuNFE7VTS
         YtYg==
X-Gm-Message-State: AOAM531TSbqgHV2ILEuCLa9/tUQZsajqJXEY1w1H0pez7q24/R2zamWb
        KPju1WVjRpvHlq5gUPR6njws0JU6AoI0AA==
X-Google-Smtp-Source: ABdhPJwe+i+tl03lwlZcwX11XW/Yy0nSxVZjbetRCI9ur3G17ANRISg9wwdPgBV6uBJladnlZ2eFng==
X-Received: by 2002:a37:7e41:: with SMTP id z62mr26830328qkc.495.1604517757089;
        Wed, 04 Nov 2020 11:22:37 -0800 (PST)
Received: from [172.17.0.2] ([13.77.95.78])
        by smtp.gmail.com with ESMTPSA id t60sm865546qtd.65.2020.11.04.11.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:22:36 -0800 (PST)
Message-ID: <5fa2ff7c.1c69fb81.c85ff.56eb@mx.google.com>
Date:   Wed, 04 Nov 2020 11:22:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1003699706878902953=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v1,1/3] policy: add checks before connecting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201104133318.Bluez.v1.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
References: <20201104133318.Bluez.v1.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1003699706878902953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=377031

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


--===============1003699706878902953==--

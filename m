Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C604C5519F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 04:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D3024181
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 04:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nadtlfrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgKREbF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 23:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgKREbE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 23:31:04 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CC7C0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 20:31:03 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id v20so440315qvx.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 20:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ytaNC1ix2ISUJ2HDuLlDQd3ZArsvqrrRkJU2d+sc728=;
        b=nadtlfrDUc575QP1W/RhtQmLEsvyEzdcBMmDFzkKwzxRcqgtY09qaPS9mb5LWdrD4B
         NtJz+/df6L5MgUtKdj3sCTx4Vy0/Uw400ssqaMTNm7zysJ3vW3/AFF3V9kTOakfj778d
         dyXZsnBPQsB+1+WV+d1BOwkTqrEiOrqWg89jyCMCURSoXJwLwAM0TrkcjWe4FZg32Tyi
         1rzG3ud8OEDqHT5yEMKku/umRAJqGL6bSQ4OauWS71lbfjXCiaakqdqGZU9VdwmYc49F
         nFvI41Gmqcl1jc/kPAzYrfwxrRqKnRBAlZ47vNXrabI5k7Pdq3/1kFWTOnlJvDnafm48
         2GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ytaNC1ix2ISUJ2HDuLlDQd3ZArsvqrrRkJU2d+sc728=;
        b=rw6HK9lNOYoUDyKae0LbxrF50jhyvJgEugymNcPgOUl3COBsiyk6tmCX7gJQ3VEN6N
         ozqtql4Je0Q0kqgBIjj5pMGXkzW/dqaWdGxdbMozLg7Zrphr/KpNu4An5k7V7FTehdvU
         KHU3ZxLeBobI7tNaFG+FpTvwnjyVjrdw40zAfS9HIm0QDuVmMji4aSMBXSFDcei3bY6R
         8Kq2VAOhSTptiifE+kpz21fcsJk0Rwt+w/+xF2LvxPNZh6EaZoqnbmxW2rTjhiltoTBR
         vPf5bK7tEC6UrTrEP+p3uJLpAB94sEy6ExAVZhfeQlRfritcgN+6vERhm1WWHP+Xybaq
         DXPQ==
X-Gm-Message-State: AOAM532+RXDudxhb/sgdPxruQuSytv9PT5eZJpx3+AQxm21+4f/lm4MT
        SoJ+mwJD16fu4MPxUhKghxnJOuv/QbXMAA==
X-Google-Smtp-Source: ABdhPJw89doGwQqFXKa9F2VfntywPBKkJZt5FMQ1Ut97awKiyl7/KnkXIAX1Uu442gb6nuyOjuW/3w==
X-Received: by 2002:a05:6214:a8f:: with SMTP id ev15mr2892498qvb.20.1605673862509;
        Tue, 17 Nov 2020 20:31:02 -0800 (PST)
Received: from [172.17.0.2] ([52.179.140.15])
        by smtp.gmail.com with ESMTPSA id s68sm15851199qkc.43.2020.11.17.20.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 20:31:01 -0800 (PST)
Message-ID: <5fb4a385.1c69fb81.8211d.fb7b@mx.google.com>
Date:   Tue, 17 Nov 2020 20:31:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6056985342566680600=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: core: Align parameters name of ScanAdvMonitoring
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201118114650.1.Ib657f37256b0e7adf3915ac5341c9d20db2fd2ef@changeid>
References: <20201118114650.1.Ib657f37256b0e7adf3915ac5341c9d20db2fd2ef@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6056985342566680600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=386479

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


--===============6056985342566680600==--

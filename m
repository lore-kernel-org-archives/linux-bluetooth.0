Return-Path: <SRS0=dtqE=NX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D09C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 05:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB67214DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 05:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emQv54f7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB67214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbeKLPRj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:17:39 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:37444 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeKLPRi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Nov 2018 10:17:38 -0500
Received: by mail-ot1-f54.google.com with SMTP id 40so6903667oth.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Nov 2018 21:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UOdMofPKybpJd1WR05TuZwwDU4oI7gsDKhZNN6CxYmQ=;
        b=emQv54f71aX8/543fLCraB6OOXP/sDuDmRKac9WJg8ejT4AqxtAb/QPOq/Si5FChwO
         6PSkJwdK0twef2cqVPSQ69dsZ57qiZ8bA6rJxD8JLrzUmQHMH8yvmz7agaO+n//0fCUe
         cfQsYgtLSLyRt9FV686f+FylxdRTbMsH4cF4zCZ3PTB2jhPKfuNqspPVtNK8Nf/6VpHw
         xeNm35Mk8zOuz2apKitdS31g+N1v7DmEj7x6pC1kGDsbi/Y3Hbc9t+Uu5Ta6EVC/VxI7
         Su9LhsuUlQhxDuVLDVcFWxpcrSCnv9szRhdhxDRinWfs4JArQbsvkRXHDDXTRtEcH1Wv
         Oj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UOdMofPKybpJd1WR05TuZwwDU4oI7gsDKhZNN6CxYmQ=;
        b=RPprBQp+nhXsS/3nirusSo8i67PMYus0hqYLAuiYfi6GyUKOmYplmJnZjsdEhPbFRG
         k2DsX2eWY4kAjBy9hcBaFtUNtJxEBSndt3HONGbPZEZ4wNxWQb4XXiyraAFfAbAiwJJZ
         308DU119ZL7frVx96f39gf16DjphK3b2Ot9lcde50HeIgNoaQ8hiR5ZTkTDq2Sl3NeMX
         aPyTSGbiiHFysfdJFAzGs1CPeAy5RURrWGpyHyhbtJfpVfSpdUnRMs3aEDk8ClTiVg9r
         ZsCvLOXe/J6lXEz9B90N9HsK45y+C0iKHmZRvLGCDcEjN96iO49SY2xYSsKsfHSHdxyH
         R5eg==
X-Gm-Message-State: AGRZ1gITwk4E3PA/rhT4uYhkOx7McmKqQRTyNH6DV5dGBi47c/Spp2D1
        x85Kwzi+fo5XCoHVTOJKgSSUo/41HbwrtaPWUp7t7N1y
X-Google-Smtp-Source: AJdET5dcKt2yHz28KNf2V5/Gq9hNIF+VA9pMEY9TbL6WlmzQdkCuieocFNLChe42UKveWizzt6fcCd5XWuSg7uumrEQ=
X-Received: by 2002:a9d:2831:: with SMTP id m46mr10649567otb.291.1542000363974;
 Sun, 11 Nov 2018 21:26:03 -0800 (PST)
MIME-Version: 1.0
References: <CAKz1w-==yXd4EL39ULE6bcYU3fTpZB9D0EqdgRhq4L38kVzYEg@mail.gmail.com>
 <CAKz1w-kFDGH-zfYu1GjoJqfs+9uvHvxnG=qwgj8EscAidDNd1w@mail.gmail.com>
In-Reply-To: <CAKz1w-kFDGH-zfYu1GjoJqfs+9uvHvxnG=qwgj8EscAidDNd1w@mail.gmail.com>
From:   Dylan Taft <dylanetaft@gmail.com>
Date:   Mon, 12 Nov 2018 00:25:52 -0500
Message-ID: <CAKz1w-nQRUOKU3WaTLBOY7nExfG6Lv59PpFddbvintyLRmduAg@mail.gmail.com>
Subject: Re: Odd l2cap_sock.c Code?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I think I was able to figure my own confusion out after browsing the
bluez userspace tools.  The kernel does not handle anything above the
L2CAP layer.  This is ATT and that negotiation is in user space,
nothing to do with sockopts!

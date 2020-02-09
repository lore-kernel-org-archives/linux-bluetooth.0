Return-Path: <SRS0=VTGX=35=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A6EC35250
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Feb 2020 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DA020726
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Feb 2020 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orlIVuPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgBINVl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:21:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40430 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgBINVl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Feb 2020 08:21:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so4225922wru.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Feb 2020 05:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=viqMTeV8aHU0TNXPkTPu/N167+JygZA4ToYCC2qTqa8=;
        b=orlIVuPFcwS7WIWf5q7f5VXxCvYM06AoT7mSMgI5UXP9+J38ai10X6Wc2+EXUw+Ynu
         gFn3+iFXN6iNNf0uXsxpH8QvgvLpzmviHhQVfNgGerDfyJnhKDaCavQQwcp6zLipPoSB
         uovUiCDvIQtTaA8WYr/UrUvLSQ0C1DSx/NytrASWdFlglJM1Xfldg609y79qB3SIO5px
         E9MQ7iCfiRj4G33EufGsbanG/FOUei15LPG8LBJtYA1SbWv7L8ks5aeE5tRtQoUKaA36
         rrXKbwg4t9ezEjkJMTuOpWKumpYHB8pUxqjW+cEccmvwjCqBrPNX/fOREkupXg3UdVR5
         l9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=viqMTeV8aHU0TNXPkTPu/N167+JygZA4ToYCC2qTqa8=;
        b=O+76s3xy5kkKGcztL2M7evDX0iWT2QpGl197knqPgj2+ZDw9y3B3/OhWRnd1ZGxQf2
         WQNNHky+5MqHk5LHKuuEfUoLF0IsWEMCWdqOPS2vNtLpH8xAPASteqVFI08dPdzzKEMK
         o9+YoHqAhqpRMpBd3migYt+62+nGDUnsgjAuZ9UwRnqfMiYVDPL+zEtKLmmX3aXvqOyO
         KcGQ6muDipSj9Aa3HSYStfjA8UtlqCc8PoyWPhmXkNHgz+q2x7rm6+OK7Z3wmHbDb1JX
         FkTqJdGaeDEQ8xz6/WyI3MTLDjMecrlkyvQA+V5ay+kAwqoOe8XxweusvfWGkKj6edAN
         lBEw==
X-Gm-Message-State: APjAAAWGePhJaPshPQE/RlGd05RYtT/RDWKIBAl6U+YG5oBjP0CZp/mC
        dLVj6bKS5EC4eI7oTOHi6et8kzeD
X-Google-Smtp-Source: APXvYqwgXPjoVAobePTxwHJk+lTfbm9bdFBhEBuoht/++bAJpvTPVuL25HRSlDeI2qcqvXiauVLDjg==
X-Received: by 2002:adf:f283:: with SMTP id k3mr9759837wro.69.1581254498559;
        Sun, 09 Feb 2020 05:21:38 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x7sm12021680wrq.41.2020.02.09.05.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 05:21:38 -0800 (PST)
Date:   Sun, 9 Feb 2020 14:21:37 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: OCF_READ_LOCAL_CODECS is permitted only for root user
Message-ID: <20200209132137.7pi4pgnassosh3ax@pali>
References: <20191228171212.56anj4d4kvjeqhms@pali>
 <45BB2908-4E16-4C74-9DB4-8BAD93B42A21@holtmann.org>
 <20200104102436.bhqagqrfwupj6hkm@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200104102436.bhqagqrfwupj6hkm@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Saturday 04 January 2020 11:24:36 Pali Rohár wrote:
> On Saturday 04 January 2020 10:44:52 Marcel Holtmann wrote:
> > Hi Pali,
> > 
> > > I wrote a simple script "sco_features.pl" which show all supported
> > > codecs by local HCI bluetooth adapter. Script is available at:
> > > 
> > > https://github.com/pali/hsphfpd-prototype/blob/prototype/sco_features.pl
> > > 
> > > And I found out that OCF_READ_LOCAL_CODECS HCI command cannot be send by
> > > non-root user. Kernel returns "Operation not permitted" error.
> > > 
> > > What is reason that kernel blocks OCF_READ_LOCAL_CODECS command for
> > > non-root users? Without it (audio) application does not know which
> > > codecs local bluetooth adapter supports.
> > > 
> > > E.g. OCF_READ_LOCAL_EXT_FEATURES or OCF_READ_VOICE_SETTING commands can
> > > be send also by non-root user and kernel does not block them.
> > 
> > actually the direct access to HCI commands is being removed. So we have no plans to add new commands into the list since that it what the kernel is suppose to handle. If we wanted to expose this, then it has to be via mgmt.
> 
> Hi Marcel! Thank you for information. I have not know that this API is
> "deprecated" and is going to be removed. But userspace audio
> applications need to know what bluetooth adapter supports, so can you
> export result of these commands to userspace? My script linked above
> calls: OCF_READ_VOICE_SETTING, OCF_READ_LOCAL_COMMANDS,
> OCF_READ_LOCAL_EXT_FEATURES, OCF_READ_LOCAL_CODECS

Hello! Just a gently reminder for this question. How to retrieve
information about supported codecs from userspace by non-root user?
Because running all bluetooth audio applications by root is not really a
solution. Plus if above API for root user is going to be removed, what
is a replacement?

-- 
Pali Rohár
pali.rohar@gmail.com

Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00314C2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 12:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94CB206BB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 12:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1YW7Jy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfFGM6E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:58:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53500 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfFGM6E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 08:58:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so1978130wmj.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yX9oswfkvlM9WKs9agNfZ/5SS6ScsZDTutNPvAdhMrw=;
        b=N1YW7Jy+8mUanp/Gh64hE6DP4g4nHrHmPO8pPHLX0qtYWXNtUZymLh1cn6sGQcTFjk
         VSi75zwcuT6vqNltUTD4Co9boWDBI5PMH+XEr0+ITKbtTUuyNaorjxCneuwGMBNtQYbb
         SsRAmBi1TXUGeo+VWsl4QS29yPYJCS3hXGaclO/c5UM0a+vV1To6ogf8PG93q1AjoSRE
         jUbPPhi8bfPrd5RrvxkH1hsecDH8YQrwQ0FeZoWkph1L+Oq1ETRf2ZCWG4gdy6xMCXTl
         CJDRAvK8KgN+kkqOKcQn397ZAK0nnPmGsuBMbmccYqbDGiYBt80duyl0U8snol21czQz
         Fvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yX9oswfkvlM9WKs9agNfZ/5SS6ScsZDTutNPvAdhMrw=;
        b=bC+XFmGUI0IlLg104Qkhgcm18FNWgT5G+2IBQ7zS7VqNWGz1dkrdVqvGNiY6CuYTSl
         HO4FdPrwCd27NOJY/78bqiZs8t5yurhetLB1hUjUawgOe7owh4rDbo5gz7H1MCtqjr7s
         oAFAojWBS5J19G9bL3RcIo8FBcONt/2+cmrnUWfvl1qb7DTGlZYj1i9AyGPMRDj2ZJzW
         FGcWl3H45+eY/LQQDqckdVrwD5NcPtUsTyGz4IsRp35N6KtvgLASls7WTR2KQvI7UZNh
         VWuAeKowWcZJj2m+qDllfTYny5GJ/lGW2Hk2l3rjfv+KBCL31rBhx4staWUY2KBBIHhx
         6e2g==
X-Gm-Message-State: APjAAAVReBY8nnwXvo3r0pdxuxahRa+g1acY1CRwC0Om4MFksQnn9p+F
        +GQI5nTcdFCUdctoY+lBgpZO9coipBA=
X-Google-Smtp-Source: APXvYqybTPUIorva0KXnAVYg7aPjI1S/TMVSEAC7Ft2mg3r61sGueYFHY1v/bJExIbXSu/0BmOGgDg==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr3673759wmj.65.1559912282727;
        Fri, 07 Jun 2019 05:58:02 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w14sm1710420wrk.44.2019.06.07.05.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 05:58:01 -0700 (PDT)
Date:   Fri, 7 Jun 2019 14:58:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: bluez - check for new a2dp features
Message-ID: <20190607125800.trsx2o3njaiaitu2@pali>
References: <20190513170550.bsbr2mh7w36hj7io@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190513170550.bsbr2mh7w36hj7io@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 13 May 2019 19:05:50 Pali Rohár wrote:
> Hello!
> 
> In current git bluez master repository are new features related to A2DP.
> E.g. support for codec switching or fallback to other local dbus
> endpoints when current selected rejected connection...
> 
> Moreover codec switching support is behind experimental runtime switch.
> 
> For pulseaudio a2dp module I need to do runtime check if above features
> are supported by currently running bluez instance (which registered to
> dbus org.bluez. It is needed to ensure that pulseaudio does not
> introduce regression for older bluez version without above new A2DP
> features.
> 
> But currently I have not found any way how to detect if bluez supports
> codec switching or if it has support for trying another local SEP for
> connection.
> 
> So, could you please export e.g. bluez version as dbus property? And
> also property if codec switching is supported and enabled by that
> experimental flag?

Hello, I would like to ask for some possibility to export these
information. Without them it is not really possible to have stable
implementation which would work with both old and new bluez version.

-- 
Pali Rohár
pali.rohar@gmail.com

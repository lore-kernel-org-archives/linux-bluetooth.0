Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492B9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Oct 2021 07:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D6F860EFE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Oct 2021 07:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhJKHCD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Oct 2021 03:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhJKHCC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Oct 2021 03:02:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D98C061570
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Oct 2021 00:00:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r18so52763950wrg.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Oct 2021 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OFwvO+5O26jNeJwoqotjqSerIJKGdnZeWd3xTRtCT7w=;
        b=mvJcpty7kt+1nZiphV30bvaToBP06DmQdDZ5kVlZqeL5/dWP2hOVGQwnlte1Izb+QC
         TaC7KAopbLnv2jxCRWqe/soYLUFVKzcRfcOgQLQWebBs+6sFmLdFM7uKJdTEDbYNyHZR
         2EqWuSZNMMZX96yJAhkxe8X+H32XZw/gLi0EydFfH1+18pEUZb3GnNWrKzp1O/96BTmk
         iy2kPFSAMjMsQwXR50U9PZ5b8QmLcmiLQMFbgpHVHPXeNr2tqzk8LndXLhlQ4C2mLDrq
         r96yWMSoEhIurmPaXQEFmxUIq8k+3URZQYm1tkW/0iPERUYoKaNUq+J/uRE2IPHbbG+1
         Nd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OFwvO+5O26jNeJwoqotjqSerIJKGdnZeWd3xTRtCT7w=;
        b=aR3V/6Jp/9o22sYEUleXttzYuAVb9yiVaxQAGr0Mmy11QTvVoxgQnXtXdcAXqeGd69
         U0W9FLwII36X5uEJW7DxdBYPtP2+cq4p2pL1tKYIj8m7l4BZIjuTMWyAxnibRlZHWylx
         myvZRR6WCh+cUv9JokksnpOydj0xs2IXBD/zUTGrq7aUfieb+PYcLmzd6GF46OjosAoN
         MokigHsS5ROnB0DJzjhj1f5MbmfNTNsUqRaYsnbBaDXTHLfin6ZqM/FLSJWeKg94UesW
         Pg1vwGmjWGO2ILFjiuvVgJDfPn08g9i65VuBS9VB28Zl/gtudSF3yD9Rh2/klm4TnQeZ
         8o5A==
X-Gm-Message-State: AOAM532j+kYN/j+r4YZJ315fp8O1LjbPTAPtqzz1qtWzDwflkfAiQHYg
        AQiJTuUINcLPCO8i1SktrvM=
X-Google-Smtp-Source: ABdhPJzPh2SL9sg4YAVqdUPmxADpUwZo/aixtjieh5mQA4fxYb8PNbgblqUr2h0/2eSbm6vIgoqirg==
X-Received: by 2002:adf:a45e:: with SMTP id e30mr22396222wra.269.1633935601776;
        Mon, 11 Oct 2021 00:00:01 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id n7sm7017389wra.37.2021.10.11.00.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:00:00 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Mon, 11 Oct 2021 09:00:00 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LinMa <linma@zju.edu.cn>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, tiwai@suse.com
Subject: Re: [PATCH] Bluetooth: avoid page fault from sco_send_frame()
Message-ID: <YWPg8Ck2ZbXZxOtD@eldamar.lan>
References: <15f5a46.b79d9.17ba6802ccd.Coremail.linma@zju.edu.cn>
 <c998d16d-f45a-8be4-2898-9e94509cb2ea@i-love.sakura.ne.jp>
 <60f604f8-2a89-fd3f-996f-9d9e4a229427@i-love.sakura.ne.jp>
 <CABBYNZK-JvPcB_T39_NUE-O6ztE6crNEfmFxszEtAu3OkrKF2A@mail.gmail.com>
 <a7bed103-dbb1-6783-aba7-f18a4d495c13@i-love.sakura.ne.jp>
 <883dc4b7-d1a1-3d31-a5a8-8fa1791084b6@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883dc4b7-d1a1-3d31-a5a8-8fa1791084b6@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, Sep 04, 2021 at 11:02:58AM +0900, Tetsuo Handa wrote:
> Commit 99c23da0eed4fd20 ("Bluetooth: sco: Fix lock_sock() blockage
> by memcpy_from_msg()") in linux-next.git should be sent to linux.git
> now as a mitigation for CVE-2021-3640.
> 
> But I think "[PATCH v3 3/4] Bluetooth: SCO: Replace use of
> memcpy_from_msg with bt_skb_sendmsg" still contains bug.

Did his one felt through the cracks? I'm confused about the statement
in https://bugzilla.suse.com/show_bug.cgi?id=1188172#c8 so Cc'ing
Takashi Iwai as well.

Regards,
Salvatore

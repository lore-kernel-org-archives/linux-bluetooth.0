Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88066C169C4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 11:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF0B218D3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 11:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovCz5GTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfAaLNZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:13:25 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44569 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaLNZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 06:13:25 -0500
Received: by mail-wr1-f48.google.com with SMTP id z5so2774507wrt.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 03:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mXWQQxfwxqQ09ppegXOxGqcYq7eYiJbZ1dWb4tLdO5s=;
        b=ovCz5GTyQAMzAzRct9Uh9+F0VVL+afnDckzI77YPRHrOEHuItCTf7jdwV9RoqpS+L2
         PTcIUbSM7b8gbt/hZuK4WySg7sDWUIcWMIwwxinOiUdEwWVJG5CEfXEGwzarLi7BOZM0
         Hz7VLmO44vBQi2hOGhDWmlxyTxXzRNxk/VlpJxlluq7A5vNtcFvmhLwH+KRVVaWYcV6j
         ITo1dHXqB2sjdjIDlpSFD5vpe2kMCCmvnsNb/R1pCA5rgMVKUoUhBPjSfD9F3GieTX3H
         4H2G3uuPKIvEW/VHug6DjMOBdu7LleGPtkSxEWJQ28Z4snzT1Pjr+/6XZZWnLHP2GihX
         hSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mXWQQxfwxqQ09ppegXOxGqcYq7eYiJbZ1dWb4tLdO5s=;
        b=BDy3tTUPBck5clR3hee+epLmPuQN1+ZX/KF2mqXX3ho34fcByFjsDYg1idStHMlEGd
         qFAORdZ5l1JSUjZ6jvtH23Jb+1Qn8p8feSVd7ewaKW2V6TZH6C8yxoetLG8J/A7Nic8v
         O1DKXlTnB+IfLqE7PKE49NakvWRNqpUIqcxlxRY3VriM3wWlQnSaGMJRb9Kbdb5GrvAr
         5M77huH7Dpy2MYscxQ/zdk3VMT2VPxfegDPX7VA+j2C5bM5EROBVcezmAmsUhjqrnD9A
         1b7OKSTll+fKujszcMwvDzQOm6ZJjXfQPOz86oXR1XVpRSBFB5zCUHcqCwCtdocuQVZn
         8vDA==
X-Gm-Message-State: AJcUukd3wsWoqbiC+yW5uEF6B2yM4nsAvlqtSRkZT8ABq2EtzsbBpmzq
        NtcLF7fjKBV4xyBa9FvAnGY=
X-Google-Smtp-Source: ALg8bN56bGMaS8esVBjV4rf5Sfqzykni0ZlwOxUqykRFPZDPCzy2nIutygDxDObPyRkQQefDCoRbVA==
X-Received: by 2002:adf:b502:: with SMTP id a2mr36034225wrd.54.1548933203708;
        Thu, 31 Jan 2019 03:13:23 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b13sm3161688wrn.28.2019.01.31.03.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 03:13:22 -0800 (PST)
Date:   Thu, 31 Jan 2019 12:13:21 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] a2dp-codecs: Fix SBC_MAX_BITPOOL and add SBC quality
 modes
Message-ID: <20190131111321.h5yjt4xd2wab4awc@pali>
References: <CABBYNZJCKhfX8jdYPqQvXDrtGQvMVT-htqE8WoyGYPLh1E78zA@mail.gmail.com>
 <20190129171207.8976-1-pali.rohar@gmail.com>
 <CABBYNZ+dY0pKjie9TxFPQN6TC7Kp4YYQNRii5=m66WKpi8VHNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+dY0pKjie9TxFPQN6TC7Kp4YYQNRii5=m66WKpi8VHNQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thursday 31 January 2019 12:52:09 Luiz Augusto von Dentz wrote:
> Applied, thanks. Note that I did have to change some comments which
> had line going over 80 columns.

Ok, no problem.

-- 
Pali Rohár
pali.rohar@gmail.com

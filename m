Return-Path: <SRS0=lq+R=X6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99805C4740A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Oct 2019 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7F92084D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Oct 2019 19:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="xuyfeer4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfJETBd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Oct 2019 15:01:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40476 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJETBd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Oct 2019 15:01:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so9714880ljw.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Oct 2019 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OmuNX1Dm3wBTMWSqvok4LenXuGgL18t2SUYVGL/ckpk=;
        b=xuyfeer4D76eEYnXSvZKz8oZ7H9LVofyMqjU8sbqOwoUbdGp0Lm5v5XtFHpcYAZALl
         Djja39Mx20wHsq0gSC3K80cIWwiflHbBrGX9P7DZSuNIR04EMPWkebKNM8W2VPTE8oLK
         6tlQ9xSCqavsi8RwPG6NByTyMmk7tzn2WSOr8Rly2MN3WXlSGJeO3aIAWyrtxon1mjih
         wlC2qdySyjUnDkwDgZFH4cHTyyoe9Qy8pevBBJnxuiKJU2Bpy+AKuiNZeeL0SXnQxFSj
         gix/xEIqFsX+5T3EuNwd8jqRVAtgp3RPyouQnvW19uYbj9DrEhEdeiA0tOVMwG2FB63D
         Wb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OmuNX1Dm3wBTMWSqvok4LenXuGgL18t2SUYVGL/ckpk=;
        b=pu+J6+VM5H/X0FIzSXba6jn85FRJ/lzlt2lQvPs9sgMcSYXAF6XaJLXshAo12xjMmc
         pGyF306mfMcqC6deJ/slvws7c+Vf1j/rbh34n9mzKzPJIpqKZWjVcWX4/tra2BpZDpqt
         XvTkS+q+fuAmQuXo0/zS/SsTCgGN4ov9n7dTrUL6KOAJalM+4oRuQ4fFd0UfdM8pqRt7
         fwdIzFetkifthST+pujj2cKdbsirZHXt0YhfzRb0f3h7PEfeWvS0Yuf9nsMope97/YGb
         iob62Ps+w9EOjazJkyYPxVwW6DM4GMo1M2icLBQBLcjdB9Olkymc40b4k6KCsce0X3/F
         6AZg==
X-Gm-Message-State: APjAAAWZvZfmgMIg5llmGyA1f29luO9Bcf3+5UXoj1bafLTbD7+6sVR+
        bUutkLNHkavPsU7w5IvIFt80tA==
X-Google-Smtp-Source: APXvYqyPJRzhHAX+tqloqeJwxVTkpqIaoHldFU93FfH++mE+FyDxkjw1wBR7+ZN6lAY3ltzaWwS2hQ==
X-Received: by 2002:a2e:8603:: with SMTP id a3mr13340035lji.98.1570302091460;
        Sat, 05 Oct 2019 12:01:31 -0700 (PDT)
Received: from kynes (apn-95-40-29-56.dynamic.gprs.plus.pl. [95.40.29.56])
        by smtp.gmail.com with ESMTPSA id y204sm1805141lfa.64.2019.10.05.12.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 12:01:30 -0700 (PDT)
Date:   Sat, 5 Oct 2019 21:01:25 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/4] mesh: Streamline crypto functions
Message-ID: <20191005190125.3cvnkt6h5r2c5uqr@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
 <318d1a2fdef7f14b6130a99dea3443e82bcbc453.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <318d1a2fdef7f14b6130a99dea3443e82bcbc453.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 10/03, Gix, Brian wrote:
> I am applying patches 1-3 of this patch set. The 4th (removal of
> redundent crypto routines) is problematic for Unit Testing, where
> we want to be able to show the discrete steps of packet assembly
> and disection.
> 
> You are welcome to submit a follow-up to patch 4 if you like,
> that will work with the Unit Test code.

Alright, thanks. I'll think about it.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND

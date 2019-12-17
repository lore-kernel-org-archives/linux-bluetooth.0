Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CD3C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 15:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3154921582
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 15:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ouPpD+4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfLQPeH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:34:07 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:45621 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfLQPeG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 10:34:06 -0500
Received: by mail-lj1-f176.google.com with SMTP id j26so2306845ljc.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2019 07:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L25UcNPsuUd94/75Kw2ELqNYSD7aGCOoTrCyfSg49Fw=;
        b=ouPpD+4G/UIOC3ria9O1b4Tg8kTgL7QjeNM9k7kCqPOAyhieW8LWnok3MRSmVLwtfL
         ePo56xoBoPiB2LFcrFHn0BKgDlEsQOzoOa3yz5iTLdhN6eNWnLueeVtiXr0wWuNbCHZZ
         p96Ljs+RBDDwsYzuh97HTv86uB2NKsKmJOXvSXI4dpJ1WNe+Eh6/Io0yUqyZCytX13xP
         KQoNE9PKtj4y4M0MDPLGNvaRPoNQWjQdfsohML3pz4nTIfoy0en9R8OLxKtn4Nnd7ep8
         lTNupfOKyo4sUEuiLeaem3KZVC9X9TzvrBpM2i/Ky2XWlHPuWktGAJZbbJzuricqFMpT
         Vf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=L25UcNPsuUd94/75Kw2ELqNYSD7aGCOoTrCyfSg49Fw=;
        b=aAMu2L214Khd4nIpC4/foa/xIBtNB9YBK9PpJql3k2MVaEr4WNZJx0rtZqb1GgDOn4
         jtsNRKqippIs1j+SDgfOJOeVlxW/euLRavl2xFXTtfcyT+QQ8tA1WD+cdPyyIfkbwvMN
         Qwdwq/XRyWX1MI4JNmk8P+lQ1sZNd0Bd3E0CrvN3cLIiFeVzZfRXEf9ZoYS4/FBuBPfw
         i2oFfi3RNGbu6BbHH5nTKwtZgyoqmVlg96EfLAkR7r/xB/kiLEkpNzQXS4FV/MtenSqC
         AjpiT8S6mhjvSA8n9vqJ2F6fF1YMtZKsFIR7G6GSLmYsb41dVu6fx0WFTYR9eSDCq6rx
         5BRw==
X-Gm-Message-State: APjAAAXSJADLqCMgwIaQi3mb8TXXvgvEFj+Dt+P+o/VVDu+b4kG1ciRz
        UxTKElcJYnM4Y245Jtsg1GtMUl6HEIQaQA==
X-Google-Smtp-Source: APXvYqy+IL9fqplSstRDHRuwLVZx97+E4z+/GNXE+QUCMTSmQ/0lQIIJS5TrPIt+xsWfwE4BOR/QwA==
X-Received: by 2002:a2e:7405:: with SMTP id p5mr3710470ljc.34.1576596844650;
        Tue, 17 Dec 2019 07:34:04 -0800 (PST)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u18sm1386900lje.69.2019.12.17.07.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:34:03 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Tue, 17 Dec 2019 16:34:02 +0100
To:     Yury Galustov <yury@ygsoftware.com.au>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh-cfgclient fails with 'Segmentation fault'
Message-ID: <20191217153402.teo4tv44fxgbvmkd@mlowasrzechonek2133>
Mail-Followup-To: Yury Galustov <yury@ygsoftware.com.au>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <mail.950b9bbe-7735-4634-bbe9-de9ff9bc7bd4@storage.wm.amazon.com>
 <mail.950b9bbe-7735-4634-bbe9-de9ff9bc7bd4@storage.wm.amazon.com>
 <0101016f14697e81-b2b4716b-65b2-47c1-949b-36193e42ecf7-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0101016f14697e81-b2b4716b-65b2-47c1-949b-36193e42ecf7-000000@us-west-2.amazonses.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 12/17, Yury Galustov wrote:
> pi@raspberrypi:~/bluez-master $ ./tools/mesh-cfgclient
> Warning: config file "/home/pi/.config/meshcfg/config_db.json" not found
> 
> [mesh-cfgclient]# create
> Segmentation fault
> 
> Happy to debug the code if somebody would explain how )

You might try running it under a debugger:
 $ gdb ./tools/mesh-cfgclient -ex run
and capture the backtrace via "bt" command.

Although honestly, I'd recommend playing with D-Bus API directly, e.g.
in Python.

The command line is a bit alpha.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND

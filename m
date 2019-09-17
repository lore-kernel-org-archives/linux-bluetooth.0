Return-Path: <SRS0=BfW8=XM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661B9C4CECD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Sep 2019 06:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369B721670
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Sep 2019 06:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="0iBNhtbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404396AbfIQGzR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Sep 2019 02:55:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36732 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404394AbfIQGzR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Sep 2019 02:55:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id x80so1954186lff.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2019 23:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P0AuMVcmd5E803CCP8Gv40hfCz1Qke42hcV+tzw7VRo=;
        b=0iBNhtbiKEN3B4+whFyqsoHQ2Ulw7clIInjJtSX7izs21oqctnCDQuort6nZ4TjMW8
         UwP9nmdl+VPbKvaC3/Z13xYWlqTXhJTWOd1QTYCRwmBXvWBB3MlCKxp8yaeZeiLptr1P
         iELE8zUz1eN79Mb66Qg3eYDi+RgKMlGNzpDa+O8zO1+zhMlvep8tNCacruE0Ne5KeTF2
         Q5xR3NbLmjwaQg+OvpqcaoS/OYqJ/66Rixqd+MT6fRuanSpOmt7WBKzvmq08YGtf3uTD
         C8dh/4U81e6+toihqzcnhr9b3UwsG/N7q6PjBtBIUzRB/Y/d0SIzh5q1uBmdYWJoKyUV
         oigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=P0AuMVcmd5E803CCP8Gv40hfCz1Qke42hcV+tzw7VRo=;
        b=aRJH+S3nzK4+LTJwvq79/WXWEjG23s9DX/is282GI2VZHHnDcsnrC6IBW6CJSgZkba
         2en3lbP5ng048nGGRPAS2k9JtgYB1kbSAUTCwPpRxd5vw1K4jg9gHejAPQMKk9N1w6h7
         DgHzX2uRYZOe91kdGjzqIZVnb+4x8r3n9q3ksnvsLl7K1Ckz9fdeuatSk2WebG9FnrRP
         v9cxqqv2BfVD5KgBzgoXDe4ywe4qKFiYvgp4EzTpvUB9UH5SX6JNuachSji42v1SXO3L
         uldN15RWZQomGnQmS11vPej1cTVkzVsSY1y2RbXxkzXrUPcfrXHlfUrh9/PazvovCSsI
         7kJg==
X-Gm-Message-State: APjAAAWmgmLuXHxL9/10wsGs0aQj7AJm3WDHKNvGdIdtJm20MafLm70x
        GOVI//uNNw2kbWK2t42o9mLb79K1Y7g=
X-Google-Smtp-Source: APXvYqxiEFGUkZlSqyl3yn7WYQqSHtMcQnSeXX1jfCYgZrPmnzfEAch11M8Oi/PEnG0sEmhOwKY8Yg==
X-Received: by 2002:a19:641e:: with SMTP id y30mr1223896lfb.148.1568703314966;
        Mon, 16 Sep 2019 23:55:14 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id q19sm174890ljj.73.2019.09.16.23.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 23:55:14 -0700 (PDT)
Date:   Tue, 17 Sep 2019 08:55:13 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org, Brian Gix <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ 0/4] mesh: Streamline crypto functions
Message-ID: <20190917065513.ibenc7hxd7x77geg@mlowasrzechonek2133>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        Brian Gix <brian.gix@intel.com>
References: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 08/19, Michał Lowas-Rzechonek wrote:
> This patch-set is a cleanup of redundant and/or unused parts of
> mesh/crypto, making both the usage and the implementation a bit
> more consistent.

Ping? :)

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND

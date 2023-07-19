Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218F5C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jul 2023 08:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGSICJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGSIB5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jul 2023 04:01:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B31FEC
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 01:01:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so61181265e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689753713; x=1692345713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UX6ZdyM5wEmrpik0psSyRcU5JjoiPAf9kF8mqF500wc=;
        b=fRTysXfaetG2sRpxmcXhoCnfUYUJQpX2v9kigO3Ow3Ym7PV4HJgRVZPRxGGipWYNII
         ij0vahFhRkjOpRklb6VrgUVM2Qn0HAOSMJ+CHdABKKNS6M4Oo7kYsLqVWXHTr20T+AY/
         EpTqeAu2TaJPZA6V96kfWCkqauePTuJDojJ2fKwo9KQ0llo+DO71hJnUxh6vx1+bVTdZ
         fqyZueCd4APPQ2sz0Pvvt2O304SeVOUO4UdPv267KPbOAlP+2UCFgpLOfzTD5Piv5Kly
         qIIZtzbSQLSLpcGxhq990xYAtkZ62oIu83ZscZ1V+XgEWcKmwNuWJpZ/FMSD2dIP7Nbt
         zXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689753713; x=1692345713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UX6ZdyM5wEmrpik0psSyRcU5JjoiPAf9kF8mqF500wc=;
        b=NkjyT5WFjhjc1Qx6lyHAsjQtdjuOFexZEo9YZI+U7BnDiH8Oj0GjJj4rExysllmEDt
         AAemJqXjUPS96L2P5nhQXscWRdZLyJnSg1qRA/T6rtggDtBJijKNGPtmCBbHCKmARW34
         dX6ZgZgB9OkIRfLyr+QYsMPzpgAHsCDyg7qjJIFr+cqp8CbdJwgd2SrBHnJ3swixD5Qn
         DyyzRoOFXZsC98ZBmUiRd40y0gq1Lz0LsDR4rBRxZ1F0f4zTLGoL8cAWo9NsN+woHW9h
         IoHfgmltzjtXDmTJdx+aWElxIadGlCBYzKvBdf6r8kUtxU+4ecnEAUeh7+AnQkfrUSnw
         sH2A==
X-Gm-Message-State: ABy/qLYNvUG9c9xCRlbVzt6Oslmm1bRbPLJxhaw3NNO4xJNz7ZuAdj5p
        zcXBK3edynAI+M+w9YXS0BAHaQXH2TXJwu2e7oo=
X-Google-Smtp-Source: APBJJlG4+7m3F5TQkfxgng+M1KHTqM/pNFhvkgHWvvYQzFLuUECfGrZYt9qwv14oKUpbg9GMZfE6Tg==
X-Received: by 2002:a5d:6212:0:b0:314:1a98:ebc0 with SMTP id y18-20020a5d6212000000b003141a98ebc0mr1378282wru.26.1689753713507;
        Wed, 19 Jul 2023 01:01:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v12-20020adfedcc000000b00314315071bbsm4583287wro.38.2023.07.19.01.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:01:52 -0700 (PDT)
Date:   Wed, 19 Jul 2023 11:01:49 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_conn: clean up some casts
Message-ID: <182a5159-3378-4d3b-8d05-bcb931cf450a@kadam.mountain>
References: <5cbde2b4-69b5-4b25-a095-251c8347cb09@kili.mountain>
 <CABBYNZK5MfkOSVUBtWLOLt+H-BBdYrQbZv=rmYtn4WtDyvJopw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZK5MfkOSVUBtWLOLt+H-BBdYrQbZv=rmYtn4WtDyvJopw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jul 18, 2023 at 12:30:57PM -0700, Luiz Augusto von Dentz wrote:
> Hi Dan,
> 
> On Mon, Jul 17, 2023 at 3:20 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The ERR_PTR/PTR_ERR() functions are only for error pointers.  They're
> > not a generic way to cast pointers to int.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > We should really create INT_PTR/PTR_INT() functions.  But this is a
> > cleanup until someone creates those.
> 
> Is there any reason you didn't create such macros? I mean we could
> have it local first, or perhaps we just do HANDLE_PTR/PTR_HANDLE to
> avoid any confusion.
> 

Yeah.  I can do that.

regards,
dan carpenter


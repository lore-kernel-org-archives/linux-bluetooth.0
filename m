Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E00C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 20:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAD224658
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 20:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="R8RG8m5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgANUJy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:09:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45642 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANUJy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 15:09:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so10817301lfa.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 12:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DKHEpaoLf285dEVOAs+XzBk6c4opLS+onpETsfXASjs=;
        b=R8RG8m5jbwifEFn/Bb8JF/BVMaOttgII9m/wLPOR+fhyu+c5fWAgbYjJobd/pkxCJ0
         sZN1dqlkH6PCLL/g8PRQF3+EnH4dT8VTd5pdfhOKWlCTB2AWzk9uJAQPX9N4UeXMlqDr
         EnCWcDmF8VPenz3gxzvbAyXXGuO9R6QdVDicms9R8BEKL3UkXg1+a9onO6ftMQ48dQ6s
         SkCXkpEPErK+UATUVJaOec3F5nhHR6EHq69K0sGfHyprjR2FCXcCo+p+dvkR4oBrR0qB
         LXLieBYfcOcKkCQFcq+JbNeqrx1KgAXeUd8hsxkd86FHd33t5EJubN2DpFSDQhOAT50V
         tehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DKHEpaoLf285dEVOAs+XzBk6c4opLS+onpETsfXASjs=;
        b=Wna7pld9EByy+DfhSJq48XEtjUz6IeXgJgNKKSvMSvCAX6dFvhLkDhVP635QwI+/Au
         H/9ZHzAsgWyCF0XaYnsMyiO+9Ao5/MRknqmGbJOiXYt9h12j/quAgfDIrrrdwo6hvwbI
         kzHioZfgUdSbVZAxiU36xhhYPwoLfh4fEQwtFlwaOeMX+mOUadRNeQ8plANQLE7ml6G3
         ztnxYflsRgwzxGh1nh5/5iSj34uIaOCLnxCC/j13u6d65ESqV2VvfkmeH4xABtIBMtd8
         x+o0qLVNdS9RcSZEt+QXEnTeQum19LQcFKulL3/P8R9+YsBSKRRUO3TYIW7OHkVST9Ku
         OJyQ==
X-Gm-Message-State: APjAAAUvAY8k8grjnvPK3A5OlaWH283tV92A7rP3bWan53o1IXWQP8CD
        x7a6jxRCetA5mb6y84iY9unOcpNKcOg=
X-Google-Smtp-Source: APXvYqw+x5ZAyJwxlKarlhjU4VetPeB9ZDQ6+aEZ1rbUv0fJEXHAqZ8xSXzNrd6ILg1jDcRwG3CKhg==
X-Received: by 2002:a05:6512:307:: with SMTP id t7mr2778572lfp.201.1579032592229;
        Tue, 14 Jan 2020 12:09:52 -0800 (PST)
Received: from kynes (apn-5-60-0-97.dynamic.gprs.plus.pl. [5.60.0.97])
        by smtp.gmail.com with ESMTPSA id 140sm7873534lfk.78.2020.01.14.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 12:09:51 -0800 (PST)
Date:   Tue, 14 Jan 2020 21:09:48 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH RESEND BlueZ 1/1] mesh: Add --io option
Message-ID: <20200114200948.xgy2idbjcmhqybdm@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200113122726.768-1-michal.lowas-rzechonek@silvair.com>
 <20200113122726.768-2-michal.lowas-rzechonek@silvair.com>
 <e2a55b9eca724eafb6c019a0e306d33cfb45a617.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2a55b9eca724eafb6c019a0e306d33cfb45a617.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 01/14, Stotland, Inga wrote:
> I wonder if it would be better to re-use "-i" option by changing it's
> meaning form "index" to "i/o".
> 
> So that " -i hci<#>" will map to generic i/o on a specified controller
> and no "-i" option means any controller.
>  
> Yes, we will loose some uniformity across all of the bluez in a sense
> that "-i <#>" won't work, but imo it's preferable to having two options
> with inter-dependecies.

Hm, might be... The reason I added the "--io=<type>:<options>" was the
"<options>" part.

For example, we have a non-HCI radio adapter that uses
"--io=uart:/dev/tty<n>" syntax, or remote radio using
"--io=tcp:<host>:<port>" syntax.

So maybe I could parse  "-i <n>" and  "-i hci<n>" (where <n> is a
number) as a shortcut for "-i generic:hci<n>"?

That would allow us to merge both options and rename "--index" to
"--io".

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND

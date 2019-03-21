Return-Path: <SRS0=3vvc=RY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C760C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 13:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C7A20811
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 13:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pT2BGtQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfCUNtP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:49:15 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:47009 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUNtP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 09:49:15 -0400
Received: by mail-ot1-f46.google.com with SMTP id c18so5379333otl.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2019 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=w/5nTHi+xo9kLdcuD4oVXII+257NF2+5Ug/EnTUefA4=;
        b=pT2BGtQ30x3UsCswx8HV9FHC9FNkvNlclzG43L1znQ6owxo2hQTtdvp9EXb/MtPDeQ
         wOldeBvAZeHjwdzA+x54xk+bKM/7rNMJz4+71lquDte3w/Tlm/0EmJk2Xm5E5hPagz9Y
         v8Igq59kPhKUs2BJLu45eofLzBjYMgW2jjMDWgkReGVf1JLUbDCr+1PZyZaIDhBoMtMw
         VFd4QeR49DSls3kZHx+HQZTu2tLi+oCqtHOS8tb8lFKLkHQ8068TWy0kSf/GzJ8qRsci
         o7KvSnrFmG14Lg+6PKyJ++JS8CrPvTgbJw1jsYqKWPn8tnV9Jl4VDkrqv4SkmcIpgab1
         zJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=w/5nTHi+xo9kLdcuD4oVXII+257NF2+5Ug/EnTUefA4=;
        b=R0juz/SwnzZrBeWK9IwY9J2GDwpvSMvbWNy4J2IDFPFPsBzc4q8tBQgWIdPXZDh1yh
         U0C0Ab7Hp2NClgv60zjWV13bvuoI9EqIs58eszbtvkZLch4ZPoSuGPWlvtiEE8gwgx+9
         dABk9a1rQV/Dxc+bVYOso/yRA0l5RicBv3ToK7DYLbY2uIZlXr+trErDEcjGNbXLtWHx
         xeer1Y2Sk3rzxn4/eQOP+vAy1xcVln+44SC/nYjFZ5Sdgon/mXbCMXCUdgw5yOHpcsbh
         fa9cH92j9wNKg/iWhpriN+ONJDeqPmU2tY37aV/eFH70Gd1hNaE66EyxWalpEk5XEkAw
         tpKA==
X-Gm-Message-State: APjAAAUYxVzuQFjqUWAxpiz7/LVP1Oht5LE2r6qfl3Q9i96GVX0scCPJ
        7WMNpEPyiDbRCAQX2fhe0ZbPJ+SLVj/iWxYYZFCU6lcP
X-Google-Smtp-Source: APXvYqzHOhRsN7oJYorGtzIoLPN80f3zU+cqVQfdSDaNwnPUgqI/w2VN1MRYGiGo+WkFhURSllDfHhoPjU9nB8qJ/9g=
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr976897otp.24.1553176154315;
 Thu, 21 Mar 2019 06:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGuyqoGXTArrUiWKkX9AGkUAa0qAhXGn2b5sgPiaDM968MmzQw@mail.gmail.com>
 <CABBYNZKOisJtGZV6fq7h58yhHvw=B_9BqiNLnwgMAP8rdM2jQA@mail.gmail.com> <CAGuyqoFbadJA_2U_s15ZeNUS-Rb12XL76eCmAh=9GFXbdjaZog@mail.gmail.com>
In-Reply-To: <CAGuyqoFbadJA_2U_s15ZeNUS-Rb12XL76eCmAh=9GFXbdjaZog@mail.gmail.com>
From:   Miguel Sancho <miguel.a.sancho@gmail.com>
Date:   Thu, 21 Mar 2019 14:49:02 +0100
Message-ID: <CAGuyqoHhtZv9ixyn40kotbK+cMbKgp6KZt1EYVPcRS+_rTv4=g@mail.gmail.com>
Subject: Re: BlueZ 5.50: Avoid service discovery in every connection
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
I find information in the cache about the GATT Characteristics of the
remote device.
Under the STORAGEDIR, there are only 2 files:
1) <local MAC>/<device MAC>/info
2) <local MAC>/<device MAC>/attributes
where are the Characteristics cached?
Thanks
Miguel

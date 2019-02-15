Return-Path: <SRS0=5uBP=QW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C66DC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 19:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2744E222A1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 19:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=itmarketsintelligence-com.20150623.gappssmtp.com header.i=@itmarketsintelligence-com.20150623.gappssmtp.com header.b="upUFB3Hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfBOTbR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:31:17 -0500
Received: from mail-qk1-f200.google.com ([209.85.222.200]:42034 "EHLO
        mail-qk1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbfBOTbR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Feb 2019 14:31:17 -0500
Received: by mail-qk1-f200.google.com with SMTP id 207so9024047qkf.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Feb 2019 11:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itmarketsintelligence-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:message-id:date:subject:from:to;
        bh=Z0tkzToy63MSaLYsw4NHH5Pc9MUwcTwslQQ8+TymNvE=;
        b=upUFB3Hj+au+/aHwWEuOwCe36hN7s/6YfmAQTcMG/GKjHiF4LFn/w58gC79MWs5Fs1
         49LkcDJhPK7x40gDYJYMhYbbUraHbT8dUBN/m0OyJ9nWk+HO7/gwqcDEdVNdEdft/ALY
         7cCbHzpWrRMzJAWLcmvw/GEoOh+TcNiWrHCWpEcey+5uBNSVKLSPgQfRXcUHWwZ/tnt2
         brKTava+8iTKK6eSFIOCFfMvNt4vTXh89DnFszK9OJmI0uDrfdOsnk6DcBgpYUCBs34m
         ZLBolnOy8KPprrz2sln1aXp9MZB6oinz/S3pbB6GoxEcpNugkDxjNptACSOlhxuipgjR
         F2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to;
        bh=Z0tkzToy63MSaLYsw4NHH5Pc9MUwcTwslQQ8+TymNvE=;
        b=udUyeXPDGP5NXoBUxjyEiAVFLwUEFxrCatz0mKZjnG1CBwmKnspJ6EMri4gJbOgpEn
         fIXK0RpBKn4EQgVUKxb6tiw5T3KO7UceFnAsUytW8WhsDwH6xFNncL/74hv2CEBOGym2
         S7hlDKo8qQs0L4LymJxo94rJcSTsjaNIhzEeQRPfQojHFi9gI7gHI78Od3UfBTbIY+TA
         yPqa4Ppy/ffHdbVZ+MNu8qT/vuSfZqhGNP72XexUAS8OAraTV6XVIo3zd701R/bi+/yU
         WhCEgX2crKGeU3mWadvg74zk7wJr5A3O1IL2gjtdV39pxPteQ9QS/8RGUelN9VQmc6TP
         1j1w==
X-Gm-Message-State: AHQUAubKi0atzMGlHI1dltbLXwtxg8l8J1JVRVTmM1F+s+Pu3e2jZkEh
        kmJcTq7xmEimAeKC2e9KQQInN82q9wbZ
X-Google-Smtp-Source: AHgI3Ia5C9r0RNJp6H7r1XuZO+LJrlBXpFiVC8jMLjdSg1wHSY3jYMwtIeTPa9SrrM1+dSxkmFq7vLm7eQ==
MIME-Version: 1.0
X-Received: by 2002:a37:d9c2:: with SMTP id q63mr6019596qkl.61.1550259076404;
 Fri, 15 Feb 2019 11:31:16 -0800 (PST)
Message-ID: <0000000000008f19760581f3d1cf@google.com>
Date:   Fri, 15 Feb 2019 19:31:16 +0000
Subject: Decision makers contact list
From:   martha.evans@itmarketsintelligence.com
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Would you be interested in targeting Cybersecurity Users across the globe  
for your Q1 marketing strategy?

Here is how we can help you:

Security users by vendor: Cisco, Juniper, Check Point, Aruba Networks,  
Symantec and many others.

Security users by security solution: Email, SIEM, Firewall, UTM, Endpoint,  
DDoS, IAM, Cloud security, App security, Web security, Vulnerability, VPN,  
Authentication and many others.

Cloud users of IaaS, PaaS and SaaS: AWS, Azure, Rackspace, vCloud,  
Salesforce, Jira, ServiceNow, SharePoint, Office 365, Box, Workday,  
SuccessFactors and many others.

For Channel and Partner: MSP, MSSP and CSP companies decision makers,  
Industry specific IT security decision makers Banks, Credit unions,  
Insurance, Education, Healthcare, Retail, Manufacturing, Government, Oil  
and Gas and many others.

We can customize this list as per your specific technology, revenue size of  
companies and job titles from those companies.

Await for your positive response!

Thanks,
Martha Evans

If not, I would be happy to update my notes I just need to hear from you  
first!

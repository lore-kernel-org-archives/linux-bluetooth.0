Return-Path: <SRS0=nRr/=NV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00898C43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Nov 2018 19:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE4D208E3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Nov 2018 19:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlXiAQsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE4D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbeKKFgb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Nov 2018 00:36:31 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33982 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725761AbeKKFgb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Nov 2018 00:36:31 -0500
Received: by mail-wr1-f42.google.com with SMTP id j26-v6so5272500wre.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Nov 2018 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rwIsmpCpLQOsReOpiGX18ZYD8RK5e4uwD9T/WSvA9QA=;
        b=JlXiAQsjEYrBxchzXifb+tbzA2xEEgKfIz+x/UH5DeIwVYUv7Dp5p0wPRDSG9Ca3tN
         AVjVBOdNvRZKgFLZtnU9D84gLMglLwnsoViPTOjIbGpXsRdKaBecTXMZiLf4KdeCiY9+
         gW4JF/ltfRfku0BK0xIv13NMp+gEKrtJL84AVBvY6zLDrPmHe8fapVRn7OeIrjgWJgo/
         ZJBWwLZn15vZEMsJzYKkKOmePp+IPhMUX0sGDn42ttsqj+TLhl3T3smVbBkjMsrCRE9U
         fAGtJBL4c4LasCOmQO3YCOsA70wPhrmg3QW8SrPARix5QkxgWUKhnUXn46tGQUdg/uub
         ytqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rwIsmpCpLQOsReOpiGX18ZYD8RK5e4uwD9T/WSvA9QA=;
        b=H6ZqyMlFFvSCqx3et7ZGMdV4m0S59kE8JoMtSuypxTRAfKW34er3pq8Azmb+cNyF47
         h+n6aF2M69owVNFGiK8yWeHVsI7zdkBheXwGvYzeqxAeeUzGYXH3b9Wmvv0NkoMk6z5q
         QQeauO5OIFN4lC1+ZS6oU4uNxeLeX5NW2xlF9E9gmofgvbmWIh3gDksF2R0bmH+DOSJb
         uYl95/O+7BYaGcRnr9ZglgdMxgZl/tZ9mO74tSQ/msnDDxbIEYfKJp5gHCGPNW2hIwtn
         HJZb9jYf6SKrArVacqpneXjBXdPOTzxEGwjIh1TspT1Cl/i1ZH//7NwLWvKKyNqlF0Ad
         WFRQ==
X-Gm-Message-State: AGRZ1gILswUhOmtnKT1kQVn7c/OHq3i2IblZryGisvDJ+bQkFk2s204O
        dYF5EhNFA0bIGo/XGVz1rDN1jAp8XZE=
X-Google-Smtp-Source: AJdET5fjZUIE8VL36aRWM/CggJV0WywbZhgfvCnNN41uRGT+RvWzpyB8XNV9FdT2ekSHlBs8gx7/Yw==
X-Received: by 2002:a5d:47d2:: with SMTP id l18-v6mr13283516wrs.319.1541879422393;
        Sat, 10 Nov 2018 11:50:22 -0800 (PST)
Received: from localhost ([85.207.23.41])
        by smtp.gmail.com with ESMTPSA id l9-v6sm3699090wme.36.2018.11.10.11.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 11:50:21 -0800 (PST)
Date:   Sat, 10 Nov 2018 20:50:20 +0100
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] doc: Initial Bluetooth Mesh API
Message-ID: <20181110195020.GA27197@jhedberg-mac01.local>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
References: <20181107004950.9153-1-inga.stotland@intel.com>
 <4DBB63ED-41C4-4F27-B2BC-1ADB090B1656@gmail.com>
 <c2485caca3145e8aaaa1a8396b294b46a55b97e3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2485caca3145e8aaaa1a8396b294b46a55b97e3.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Thu, Nov 08, 2018, Stotland, Inga wrote:
> From D-Bus Api Design Guidelines: (
> https://dbus.freedesktop.org/doc/dbus-api-design.html#api-versioning):
> 
> "In summary, version numbers should be included in all service names,
> interface names and object paths:
> 
>     com.example.MyService1
> 
>     com.example.MyService1.InterestingInterface
> 
>     com.example.MyService1.OtherInterface
> 
>     /com/example/MyService1/Manager
> 
>     /com/example/MyService1/OtherObject
> "
> 
> I chose to do the name versioning based on the official guidelines.
> However, if we want to preserve the historical bluez approach, I don't
> mind changing it.

That's a good point you've brought up, however I think we should stick
to consistency within the project in the first place.

Johan

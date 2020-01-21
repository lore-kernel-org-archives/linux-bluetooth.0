Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07BEC2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 18:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C5321835
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 18:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXuO1sic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAUSdf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:33:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37044 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAUSdf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 13:33:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so1928162pfn.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 10:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aF5EYkhMw6GO7fFRao1vTdbWQpVK4Xv98i8luxhIRKY=;
        b=eXuO1sicbvJha9IHPv9Dj/BcQ8SVcv+KkGh/rhtdYyk+df4QhOzjR5yqHHE92NxySz
         o36SIn6bC5TMb/ll92O7JnELQLuiCxk+9b0m5wpgj7VhrgM7jYLOhgwcd6aJiI2W+Zi0
         FEACoXxCnTRCINpSMSrTSqP1MXHZrzZhBANzw6zD+ZdaIPK69ooDQwpB3+ll4/3CUH3g
         EkCQp0O0w9NLtickkABDnEGaCByzyYInxXZIygOeyoW0CDFovZagPdjk1a6hAYubnTBh
         3hTE6gC0CghKXAPe4YSGMJrWgdF7lFjWGw+oJazo/FATsLCD0pBvZ9kWfQFZ3RGpAvte
         uBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aF5EYkhMw6GO7fFRao1vTdbWQpVK4Xv98i8luxhIRKY=;
        b=dyrm07qvLkhtF1L0P5hV7oIoZDglA2PAxrXbvZDjC/nHFSYZCEGhQ8DfRm4ZNjbY9A
         VJPQaiuna+Hnzinq2KPkWNm78eDl7+TaVTj7tsxzZl+Q6tfvQFE828ME7OrMob/ipBeR
         7/0oS6Z6c8qQE3Qzsch+i8YTOmkYDZtNC+mESdzqjgeCrMFgqI9rx3lvpJXnjuL5823O
         FeEVqpkLOOJ+Mzgu/5FK7DHvTGP9IMO9zhw4tx8q2D+g4Jwn1ifchRLfH+qiNq+vw9Ri
         moobt7l5Uv3VdF8blGEs7AQzoU8fpYy4/XvWcnvuaHydYRzzU8jtokWVpZuox+l0Buji
         6VMw==
X-Gm-Message-State: APjAAAWzHK9JZQqpCSpqoTCsjAI2ZSuGaGUwrRrboMPWnh/Zk6sPZXCl
        a5+iRD6j8f+xiiUIyxepbP/YeBr29AW32Q==
X-Google-Smtp-Source: APXvYqwwJN+/n1A7fO3Bppf6fyEFoKOZJA+XLfRW/rEycTsp6HJnPoe4+0RqHg8lBYwKbPT7DKj2Tw==
X-Received: by 2002:a63:780d:: with SMTP id t13mr6608618pgc.82.1579631614137;
        Tue, 21 Jan 2020 10:33:34 -0800 (PST)
Received: from gvmorozo-mobl1.ccr.corp.intel.com (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id e2sm127408pjs.25.2020.01.21.10.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 10:33:33 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
Date:   Tue, 21 Jan 2020 20:33:28 +0200
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com>
References: <20200120202708.111383-1-alainm@chromium.org>
 <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
 <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On 21. Jan 2020, at 20.25, Alain Michaud <alainmichaud@google.com> wrote:
> I'm not familiar with the dynamic_debug feature.
> 
> On ChromiumOS, the interface proposed here is used by the user
> feedback system to allow the collection of BT_DBG output when the user
> is trying to send us feedback.  If there is a better way to do this,
> we can certainly use that. but may need to be pointed in the right
> direction.

I think Marcel is referring to this:

https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html

Johan

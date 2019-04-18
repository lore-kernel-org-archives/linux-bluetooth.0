Return-Path: <SRS0=fj53=SU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52616C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 15:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1670F20869
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 15:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMwkV5BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbfDRPaK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:30:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38809 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRPaK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 11:30:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id v1so1958885lfg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2019 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fvzUxxbPYEgbH3m/VBmB3XogJiX7LWJsvWfwY6xHsTc=;
        b=sMwkV5BEfZbfIdvOLq3cwmOp0LcLm1POrnbZYrsTSR1aA0FQLZ+oLUNUqlJa39OGkP
         1MnJlNgBlNIyeR3LzgWi/lpWBzc+F6InkDmYYqO2Eehr9zstw/4yGXRKDjHj5OhHeVT7
         jBvwQ60BQ22wjyA006c03eC4X0CqUOnQNFXQrP9jXjSVK0e+2cYIBcLT81HJL22IVB1z
         6Yafxpsdy+uYGmZtPSbHt88TkFOaQfG5EA+lOekqOtlGKg0b/EmNlhRH+XWXqu3psPZ0
         NApssTMDCNs1QM/1d7EB0uQiI+GjAGzWHQoj7bkGHLV9aoK7jaLhMLSBSp9YXTQhQXU8
         SdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fvzUxxbPYEgbH3m/VBmB3XogJiX7LWJsvWfwY6xHsTc=;
        b=GExw/cytwh6V6QbL/7a5/S5VpD4zQKT8W1kzdbmNFI4Y90Qup0mSQ/ktMIwNnMlfkH
         6gNDC1isYJaTTZW9FvJhcV4+nUwbAWYKxibQRgURj8Tl+MPXrlMxg5CDKcT7c7kOJ7t1
         FqEus69ULxcZd+zwObeYlTwMyK0qchTPz80plPycd2TznEnP5Hmkw/VcMEom6vEvLLST
         iKvG5xGOsgFm1AVncddHfS62DK4S0GPxocVH+VdbvnGsATIHI+DkMJIkkg59JvyrfImi
         FJL8YMffUKycghiCSGAFgQw3hgqH4m3exsRS+U5nk12fq1eF2x70XTnglG32MCQM2VD8
         c7yg==
X-Gm-Message-State: APjAAAVDA/vb5NUPHQ1YBCa5icqYWsADHtJJ4WWUJTbMPSvRfkRk0j+y
        RkkKQ81EzwkujuLTonBYm4U=
X-Google-Smtp-Source: APXvYqyszukMTPhOZwV9QLgmirxumbkuBy83Cz2DNrE1/AjIEEjJ/HcE1OwGAP9wiRGdGZbvSK+whw==
X-Received: by 2002:ac2:5143:: with SMTP id q3mr4192573lfd.169.1555601408355;
        Thu, 18 Apr 2019 08:30:08 -0700 (PDT)
Received: from n19i3s6caik3ccls0-1.v6.elisa-mobile.fi (n19i3s6caik3ccls0-1.v6.elisa-mobile.fi. [2001:999:0:3b2b:f945:e197:4134:3140])
        by smtp.gmail.com with ESMTPSA id v4sm456481ljh.40.2019.04.18.08.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 08:30:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BlueZ v5 1/1] mesh: Add APIs for Provisioner and Config
 Client
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4376CAFE9DF@ORSMSX103.amr.corp.intel.com>
Date:   Thu, 18 Apr 2019 18:28:14 +0300
Cc:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7F44065-0021-4172-B28F-7DBAFB8F11EB@gmail.com>
References: <20190415194946.13121-1-brian.gix@intel.com>
 <20190415194946.13121-2-brian.gix@intel.com>
 <20190417055132.scxvzhusx2suasdv@kynes>
 <DEBB0CAA2616974FAE35E4B560B9A4376CAFE9DF@ORSMSX103.amr.corp.intel.com>
To:     "Gix, Brian" <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> On 17 Apr 2019, at 20.58, Gix, Brian <brian.gix@intel.com> wrote:
>> From: Michal Lowas-Rzechonek
>>> +	 uint64 token ImportLocalNode(string config_file)
>>=20
>> I am somewhat uncomfortable with passing a file path here. The caller =
would
>> need to create a temporary file, which is a little cumbersome, and =
might fail if
>> the daemon is running on another machine.
>>=20
>> Not sure what are the size constraints (if any), but I think it might =
be better
>> to pass the JSON as a string.
>=20
> Indeed, this has been discussed internally as well, and is still =
subject to the change you mention. We are still wait8ing for input from =
all stakeholders, and your preference is noted.
> will be composing all Config Client messages (except for OTA key =
messages)

Passing a file name like that could also be a security vulnerability: =
you=E2=80=99d allow a non-privileged process (the D-Bus client) to =
request a privileged process (meshd) to go open and read a file that the =
non-privileged process otherwise would have no access to. The =
non-privileged process could then e.g. make some inferences of the =
content of this file based on subsequent meshd behaviour (logs, etc). So =
either a file descriptor or just a string parameter sounds saner to me.

Johan


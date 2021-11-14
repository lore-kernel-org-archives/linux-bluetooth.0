Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Nov 2021 11:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB48D60EE7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Nov 2021 11:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhKNLvE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Nov 2021 06:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhKNLvE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Nov 2021 06:51:04 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EFDC061746
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Nov 2021 03:48:08 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g17so37620282ybe.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Nov 2021 03:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=l2AjIcA200luhAvIV6Y4Gf8Evv6mr+gMr0zSOMeBGF0=;
        b=i9+R1hcZxRsTCcafcYyQcyKIDoHAMvWtMN9DrFPnOxFZxr2urAGzevcKaQsMS8Vsnt
         yloT840eamaT2uibRhiEVTgVFI9YQ1j5Q9mYQdLbAu+XoGokmVAD5RAJEkzf0YE0WpZD
         IvSmyDeh/l3gjjqO53w2dNZSgFj8SBtf+enrPLbjXTCaQScznyyw6RuBt6hNymbySQHf
         PN1KQZODsM5NLVYoPR73mKjJr1hZniPuwHuB6kQlf7g+jXFtEJIHHsTIhsOscxv+s0zy
         vNrltE23IGrqNDByiCi6yf/F2CjrbwjGldpBoShqMShLkH03gIHnLk8Gp8cQK3M8To/G
         Vszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=l2AjIcA200luhAvIV6Y4Gf8Evv6mr+gMr0zSOMeBGF0=;
        b=UkEs2wpvK01qhqr2DmHBVViBhxQMXMN3m/a8TK5sz9MHn+XM8t0X8RZn4XBHbHqd62
         GCSe+9MTR6U6Miuz58LtmqrD+zBxfQ8MrjwboDJV8k4wwbLiXjFmYkYYUGcFjfx5FueI
         iM+tuh2ALyrrID4Ew5K9djstEl/0Uj0ejAO6nCFACm+T1ThST+doj+CyiMcgqgD7GFKi
         1MEOnhocGz4p2Q00FO0fhI/e51Vx3LuVXk9OJNtGifi96/wbFBBw87VEXbj/WgdIJSF1
         Bkm1m9+V/kSydLlEIIUA/ac61cD+t0jf1fqhxPle3z5i1bA9tVI2aJAvaAUbvHBJxdu9
         bVRw==
X-Gm-Message-State: AOAM530HGwlzFRUs6Kfz67cNdnJDyugoIbY/ufsErixtHdMQwiNkqAfi
        YGKNQIUilLmU1CbJc7HGYBiE2fqMP+VeXXnhRnyobW/PAzU=
X-Google-Smtp-Source: ABdhPJx2O6LXhoRdrDrXfwxuVdVlGvOcar9RIAJ8pP+YnKwh63D3NeaYJYuP9Z5veBjcyqhmzSDtpycoMQC/awyVXJc=
X-Received: by 2002:a25:2f13:: with SMTP id v19mr32387788ybv.410.1636890487229;
 Sun, 14 Nov 2021 03:48:07 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sun, 14 Nov 2021 19:48:04 +0800
Message-ID: <CAMEJMGGQd2PnZfS9XnpRQEcJ=U5kS5gqy682VOsz1vSKLuwy8g@mail.gmail.com>
Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch
 is Running an Operating System with Linux Kernel 4.4.120!
To:     linux-bluetooth@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A
Switch is Running an Operating System with Linux Kernel 4.4.120!

Good day from Singapore,

I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch is
Running an Operating System with Linux Kernel 4.4.120!

INTRODUCTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

My name is Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 14
Nov 2021. I live in Singapore. Presently I am an IT Consultant with a
Systems Integrator (SI)/computer firm in Singapore. I am also a Linux
and open source software and information technology enthusiast.

You can read my autobiography on my redundant blogs. The title of my
autobiography is:

=E2=80=9CAutobiography of Singaporean Targeted Individual Mr. Turritopsis
Dohrnii Teo En Ming (Very First Draft, Lots More to Add in Future)=E2=80=9D

Links to my redundant blogs (Blogger and WordPress) can be found in my
email signature below. These are my main blogs.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent versions of my autobiography will be published on my
redundant blogs.

My Blog Books (in PDF format) are also available for download on my
redundant blogs.

Over the years, I have published many guides, howtos, tutorials, and
information technology articles on my redundant blogs. I hope that
they are of use to information technology professionals.

Thank you very much.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

***************************************************************************=
*****************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC9FC282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 18:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9626C2067D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 18:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTbDD0iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgAHSnL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:43:11 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33936 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgAHSnL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 13:43:11 -0500
Received: by mail-oi1-f173.google.com with SMTP id l136so3575539oig.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEDDBw2JdxDxTJpu/5+uRjl92iCg15NYbAU4Ncny4yI=;
        b=CTbDD0iR13hdmEfRKBcz8srFK+n3McbUmw6HOkQk4cccU/rUxVygcZhtErfxZq1MHO
         /KIBVtb10C8UpWk14MDfbObc1kkd5Gq3ITbxI8YBMyLwBn8tvORa4aJc2YhNFlZfQSN+
         KAQwi+SvYMcIBHI2xaJZDVPTcKhn2/6Eif0jNvkTt1Rk1toSG/JTAZE3+ZxpfxVbpMpx
         0RQ9PwalcVAi9u8WPdgj7zDBYMdqU6UIrT9sUBPcPUOKlVmofYWi7roNX7GuWdvJV6QM
         a8aMQF3EWg7yuHUYCG+k59WqKaJf6d8pZgtoEXgGMcA2pheuQj6O2O9RvNmlt0IKYDnj
         wHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEDDBw2JdxDxTJpu/5+uRjl92iCg15NYbAU4Ncny4yI=;
        b=b+OTX5moyXvNSGuHE8JivpiRZ9m31IWWOk/gJNYFHPYU/aa8jz9VjwB16xeikvTeA8
         gDgieSqN2Hk+zZSgjP0eoyxroy8FM9B6ivIxjjsGWU9m5KLgA+JXfiV8gbfGLEfDZLSb
         HPIVNPOM2fJlnVrptuK0zWdbj4CO3QCZJJ1yPDLyh0EejZGDPmQQ7NQ32lTdCJ1Oj44a
         VK+cP3VFHqSr7e/loUs7B/2HQf4YI8HHyqaQAqx6Vnv2YZKVqjl9cCHu8hfSuQL7rKeU
         PimIeQ8lvP86iStAmyOb0UmEkZBjVjz5Wyv4rIQhI85+lwsxq4O6EGdFdO1MfQFoNFkw
         +rDw==
X-Gm-Message-State: APjAAAUoaEef6E4qPDmLnM/eB5XS3PSpHgqXsoLkGdY2JDRA9hORwmKd
        mk2gLHTetUO4HJJa4JVnSayDRTVD02K/l/oJdtvHRcw5g+A=
X-Google-Smtp-Source: APXvYqyME8GqUYK7Upcv+9clXd0evAyhadyyMH7N03Yd0k5QYBMdQNBTsxKLpFE0DRSyN3nOXlwsEkoVuBqa4bKyl/0=
X-Received: by 2002:aca:b1d5:: with SMTP id a204mr14263oif.82.1578508990161;
 Wed, 08 Jan 2020 10:43:10 -0800 (PST)
MIME-Version: 1.0
References: <85C0B54E4752CA4F873E7C78CF0B26F5020662DB2C@LNDWSMBX02.ad.mpc.local>
In-Reply-To: <85C0B54E4752CA4F873E7C78CF0B26F5020662DB2C@LNDWSMBX02.ad.mpc.local>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 10:42:57 -0800
Message-ID: <CABBYNZ++9739ptHJm+tiUUJANN_MfRpurvfdD=a4Qw3OHE-Epg@mail.gmail.com>
Subject: Re: Limiting what devices can pair over Bluetooth?
To:     James Pearson <james-p@moving-picture.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi James,

On Wed, Jan 8, 2020 at 3:47 AM James Pearson <james-p@moving-picture.com> wrote:
>
> We don't normally enable Bluetooth on Linux (CentOS 7) installs for security reasons, but we have a case where we would like to use a Wacom tablet over Bluetooth
>
> I would like to be able to configure things so Bluetooth can _only_ be used to pair with Wacom tablets (or just HID devices?)
>
> As I never used Bluetooth in anger before, I'm struggling to find out where to start looking - does anyone know how to do this - or any pointers for where I should start looking?

Are you asking this from the system or user perspective, from the
system we don't have a configuration where you can restrict the types
of devices that the user can pair, on the other hand there is nothing
stopping the user interface (gnome, kde, etc) to implement such policy
on their bluetooth settings, though be aware targeting a subset of HID
devices may not be possible.

-- 
Luiz Augusto von Dentz

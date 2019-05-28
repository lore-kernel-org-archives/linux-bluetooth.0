Return-Path: <SRS0=Ljem=T4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6804BC04AB6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 May 2019 18:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407DA20989
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 May 2019 18:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOO3XECv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfE1Syl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 May 2019 14:54:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41668 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1Syl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 May 2019 14:54:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id l25so1340656otp.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2019 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKHUIEhTJXhflAqu0Z9f6ym6yr12iKBblkzAFB90rFY=;
        b=fOO3XECvhQtD25IZQEyF8A7Tk+SNV54xGe2HA70Tm4hhypo8tnRnLxJkFO2fS/XT12
         IKVsRSxJpAE5acpIu6+QqHi60sojLLgHPc+rXqAfg4er0ErpHIEfcG1hnTJ5sIbFwGJh
         L528SQKKjCZ6++vLs0QUVQYMK3rLH7hp6w1B1K02p72gslCy+pCpAQEFHSdYAaVjWXws
         WkvtNGgQLoJNtSg0DN90IytvPAEx3TdZNFhTxtpaf9KkLkW33FHrjfhAfr+KKf1Iw4aT
         J/uB4KhhzHmc09PhUH/leZu6745kHf53K70hbFUcVlSvk8Ew1Yqk4SxALga0um/QX9oa
         Q1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKHUIEhTJXhflAqu0Z9f6ym6yr12iKBblkzAFB90rFY=;
        b=MC0kkytkin3k6i4oYUls0+miirG6CmLVO0jkcbeTuGxzEZKpS8FqjjbShs3g5icAoV
         PfsjMWwFYuxSdTKyBWFd4Ratpsi1tnCkl6ohPY3793IxElxZFnvpV09KRA0Vs+Mirqkt
         BhaIg6u2W7S0fwNnYo2mB4O5Q/239trbxswW737TcD8pLdtTtKLCEyD3PaZnMJ9WAu23
         u3O+4sWRLyYiV7k58+f7P7bHvf9TGhnAj4EnjYnrUOnoTCtCcTmBs1N20ijvtxPCNnfb
         vp2csR+V3BAx7rj1VxR6ox37xtnl3ZWAC1s8TCf7m6H00/DldJWsUQqlPwtcgKi83pn5
         cL4A==
X-Gm-Message-State: APjAAAWeR0c8VwMoUBzybZl4ld2aTmuroQGcdGq6gzQH8sTFmOA0mVye
        m1CR1Wwtt+vSpZQ9MMYY3rxKh5rDlaD5onr2ROA=
X-Google-Smtp-Source: APXvYqxpe2Dy3CWAsLhTgnkMbXA0gQUcNpPOdqpfFssL0XW4Dv2CUW+x1lUp1oVa31CbGR8v5Nh/UPN4/ptkqGOHPJQ=
X-Received: by 2002:a9d:469b:: with SMTP id z27mr3881341ote.11.1559069680508;
 Tue, 28 May 2019 11:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <f61b05a1-3e87-d09e-6892-ac1999dc6abd@gmail.com>
In-Reply-To: <f61b05a1-3e87-d09e-6892-ac1999dc6abd@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 May 2019 21:54:26 +0300
Message-ID: <CABBYNZL8JopSfd4AYyYHLAHLzaSNuGPmHbMSOF9wbeNo_QwOLg@mail.gmail.com>
Subject: Re: Problems with bluez
To:     Matteo Formigli <matteo.formigli@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matteo,

On Tue, May 28, 2019 at 9:38 PM Matteo Formigli
<matteo.formigli@gmail.com> wrote:
>
> Hi all!
>
>
> I am using Ubuntu 16.04 and there is no way to make the bluetooth work.
> Every time I try to pair to my bluetooth headset bluez crashes. I really
> don't know where to start solving this problem and I really hope that
> someone on this list can help me.

Maybe it would help if you update your version of BlueZ, or better yet
update your ubuntu, if that still doesn't work then we may have a look
at some logs and HCI traces.

> Thanks in advance for your help!
>
> Matteo
>
> P.s. The following is the output of the dpkg --status of the bluez packgage
>
> :~$ dpkg --status bluez
> Package: bluez
> Status: install ok installed
> Priority: optional
> Section: admin
> Installed-Size: 4119
> Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
> Architecture: amd64
> Multi-Arch: foreign
> Version: 5.37-0ubuntu5.1
> Replaces: bluez-alsa, bluez-audio (<= 3.36-3), bluez-input,
> bluez-network, bluez-serial, bluez-utils (<= 3.36-3), udev (<< 170-1)
> Depends: libc6 (>= 2.15), libdbus-1-3 (>= 1.9.14), libglib2.0-0 (>=
> 2.31.8), libreadline6 (>= 6.0), libudev1 (>= 196), init-system-helpers
> (>= 1.18~), lsb-base (>= 4.1+Debian11ubuntu7), kmod, udev (>= 170-1), dbus
> Breaks: udev (<< 170-1)
> Conflicts: bluez-alsa, bluez-audio (<= 3.36-3), bluez-utils (<= 3.36-3)
> Conffiles:
>   /etc/bluetooth/input.conf
>   /etc/bluetooth/main.conf
>   /etc/bluetooth/network.conf
>   /etc/bluetooth/proximity.conf
>   /etc/dbus-1/system.d/bluetooth.conf
>   /etc/init.d/bluetooth
>   /etc/init/bluetooth.conf
> Description: Bluetooth tools and daemons
>   This package contains tools and system daemons for using Bluetooth
> devices.
>   .
>   BlueZ is the official Linux Bluetooth protocol stack. It is an Open
> Source
>   project distributed under GNU General Public License (GPL).
> Homepage: http://www.bluez.org
> Original-Maintainer: Debian Bluetooth Maintainers
> <pkg-bluetooth-maintainers@lists.alioth.deb
>


-- 
Luiz Augusto von Dentz

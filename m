Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2EDC282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 20:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6255620656
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 20:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4mHixGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgAHUxp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:53:45 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39008 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgAHUxo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:44 -0500
Received: by mail-oi1-f174.google.com with SMTP id a67so3940290oib.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 12:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Z1gHOeWqaHhh5ruaHpP7OWGZVt4+rCp2rrObJwefHA=;
        b=L4mHixGHnFyEJD/3I8xR8wBaMHO/ltLfFdZP6kgdw7+vcP+TD5mZmUH3gJ3/DF+0l7
         +ES/+pda/DTWHZ+Qq5PQYquliWQT9GUCUw6E3XO6rKORmyDLNzSot4SeRrqFVeBwLfC/
         S6lP5Am7yeus690CcgdJkqshc7Pryv5y4WeVo+ByCzQe6H3MslIEPRRzpyOty8pzKxEY
         L0qzcdxYEXkza5LF+ppkKpapMrFDoBP1EwJE0k2YVDNSu9LGHOn/daaH7N0mszf7X90h
         Wb4pnQTryAv5X4JdP+/kDDGApoZ+cVfRaCmqVVc1cEuxspzaCSn1c7I5VI6O2Yjgp/MY
         ndfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Z1gHOeWqaHhh5ruaHpP7OWGZVt4+rCp2rrObJwefHA=;
        b=NrfL2MV7HbTfUrKvT3K8glX1md0L1khmsFwhzONkkFKSL5CKhvaH0xuTE6YJxljoH4
         UsbimQ/v86dR7JrhCTes+fs6jTUHlO9Er8xwQUNLNCFrr6/G+J4mbOW3xi/GI7BMUROE
         BHmCfVqfjxssfXqlAMIk+6ILggWa0V7YXrvUErY7YXIzak6ieYcksNOPmLuOr+D2/ka7
         a7XbMOF6aD5UQf9U4nCmoOP664m7thsv7N5q07M3W2jh3/SPdjBmoBFFT314fPnkl9/z
         BlKIX7Tk+sSzxMRyxWOv+qZPo+oI+Mn99Qvy3siMJewxcqGANw0S9WaIzyp0u2j+Cz/T
         B4Cw==
X-Gm-Message-State: APjAAAXOIerNIIqzu05L4XB47zsV74iuo6brsVgM0/Y1A5CXKA0qpF5N
        Ndm1hBeMN1RWHTRsYwC1ckAaO1l4Ov/jJXOnjZBa8sRE
X-Google-Smtp-Source: APXvYqw7YSoueuMPLsgQp+ukbsi8UwGz/Gcvfcu8QDZV3aNZypIQYsB+1RnbdehhSMioewReZC55dSLHOla1yQTI84Q=
X-Received: by 2002:aca:b1d5:: with SMTP id a204mr424693oif.82.1578516823674;
 Wed, 08 Jan 2020 12:53:43 -0800 (PST)
MIME-Version: 1.0
References: <85C0B54E4752CA4F873E7C78CF0B26F5020662DB2C@LNDWSMBX02.ad.mpc.local>
 <CABBYNZ++9739ptHJm+tiUUJANN_MfRpurvfdD=a4Qw3OHE-Epg@mail.gmail.com> <ac3d2402-abad-96dc-b042-8c8c7d592124@moving-picture.com>
In-Reply-To: <ac3d2402-abad-96dc-b042-8c8c7d592124@moving-picture.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 12:53:31 -0800
Message-ID: <CABBYNZKAkZLvce-MfpscV6Y=9+UBVXAdcVgKAWTH8HupW8_qVA@mail.gmail.com>
Subject: Re: Limiting what devices can pair over Bluetooth?
To:     James Pearson <james-p@moving-picture.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi James,

On Wed, Jan 8, 2020 at 12:15 PM James Pearson
<james-p@moving-picture.com> wrote:
>
> Luiz Augusto von Dentz wrote:
> > Hi James,
> >
> > On Wed, Jan 8, 2020 at 3:47 AM James Pearson
> > <james-p@moving-picture.com> wrote:
> >>
> >> We don't normally enable Bluetooth on Linux (CentOS 7) installs for
> >> security reasons, but we have a case where we would like to use a
> >> Wacom tablet over Bluetooth
> >>
> >> I would like to be able to configure things so Bluetooth can _only_
> >> be used to pair with Wacom tablets (or just HID devices?)
> >>
> >> As I never used Bluetooth in anger before, I'm struggling to find
> >> out where to start looking - does anyone know how to do this - or
> >> any pointers for where I should start looking?
> >
> > Are you asking this from the system or user perspective, from the
> > system we don't have a configuration where you can restrict the
> > types of devices that the user can pair, on the other hand there is
> > nothing stopping the user interface (gnome, kde, etc) to implement
> > such policy on their bluetooth settings, though be aware targeting a
> > subset of HID devices may not be possible.
>
> Ideally I would want to limit this at the system level - although I can
> not find anything user interface-wise that mentions limiting access
> either (although I might be looking in the wrong places?)
>
> My aim is to prevent Bluetooth being used (in any way) to transfer
> files/data on/off the workstation
>
> I've found that if I blacklist the bnep, cmtp and rfcomm kernel modules
> (just leaving the bluetooth and hidp kernel modules enabled) then the
> Wacom tablet still works over Bluetooth

bnep is for tethering, depending on the system that might be useful,
and if you block RFCOMM you no only block usage of file transfer but
also HFP, but perhaps you don't care about those so that would be fine
to disable. Btw, for getting file sharing you would just need to
disable obexd though it doesn't seems it is a user service which you
can disable with systemctl.

> Would this be sufficient to prevent any kind of file transfer over
> Bluetooth ?
>
> Thanks
>
> James Pearson



-- 
Luiz Augusto von Dentz

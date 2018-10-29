Return-Path: <SRS0=L2xa=NJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF8C0044C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Oct 2018 12:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02EF2082D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Oct 2018 12:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKLKCgaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02EF2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbeJ2VHf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:07:35 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:46965 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbeJ2VHf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Oct 2018 17:07:35 -0400
Received: by mail-ot1-f41.google.com with SMTP id q5so1842562otl.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Oct 2018 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHvwtlx1BahZMAH5Nv22HAn0zyhsSPNBUdwGWJ2fm2U=;
        b=dKLKCgaGpMhbsekayTcmIaRYwraEpeQnU4p4OSo4P68epZTqTYVXJfWjOIwKHQeZBk
         AWKDDLT1/i4cof6b6keUiqQLc+xVzmsiF0cgpI/texqMePYtfJnhEJhUwyXFIgxccGk6
         Fw+iy9Byiby7/zesxoj0w3hA7aLdqyUIqH8sK31rPVP9T2q5M+3LcsggvpUc0WkJrXOh
         JGu4lgo0X8/RbVrx59pXe+s7xhK9k+tW+C7WKW0oU8nXJ6IIEIFd7TcpMPHYXMSDuYGH
         Bo54q3sOUAmaF+MfLu3rjGGVYFAz32uDQRaw6DavbIQm486TILllIq7lMBL8wJJ0ICSM
         p3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHvwtlx1BahZMAH5Nv22HAn0zyhsSPNBUdwGWJ2fm2U=;
        b=RwncGTmuDKLKl+Bg3LGkdPGpd1C8sjn8UNPfbXfiNAH2VUplb1kWdaVW0VEJSnyyrn
         4D2sGSod57oyEfEzDKYoG1JL9a2KYSReRoYr2Ke4QU8yj1d/YVrs4XfRAQwN8t732p6T
         U/7HmfPlLjm8Kh2XRVJU360VgGVdtzWYLiMrlR+X54hWcFDe/wJzDDLuCyrs/45haOsA
         KW2fkuCmHu17IPuLwq87hidqNnBjdeBu0oVDja8p1UP5m6hnb/z6Ymi3l7dZGlickOlP
         TiDSANuXfegTLJR/hcyIMCDpBuq7bjv5mGO7TAG+czZW9xv8A4rPIdQbDeia6AJEQWfv
         IHYA==
X-Gm-Message-State: AGRZ1gJWclEAZqSZ5o9ib19s7+Urm8Q32y9VIKef4FjMeMfV252Jfpu/
        gur3JhiBz+jQ1AavgLOFvhxBsk6pa8PVCn+rkv0=
X-Google-Smtp-Source: AJdET5clO3U7QquNtWHEGeJ6wfYAE29XpibokkhGtUrhW8LTIpDgo7HrIZETDtK5SpEhqIVaj5wDj2AzLm3CwrsOums=
X-Received: by 2002:a9d:4a22:: with SMTP id h31mr868020otf.254.1540815548064;
 Mon, 29 Oct 2018 05:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-57c6852c-55a5-44e1-aaac-732cb9e2bb40-1540815015379@3c-app-gmx-bs10>
In-Reply-To: <trinity-57c6852c-55a5-44e1-aaac-732cb9e2bb40-1540815015379@3c-app-gmx-bs10>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 29 Oct 2018 14:18:54 +0200
Message-ID: <CABBYNZLTf6mEN5QvCOXVjdvgH2gAh9BPDrf_FqJ1FBn7DV34dA@mail.gmail.com>
Subject: Re: Advertise changing data in python
To:     ulrich.berl@gmx.net
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ulrich,
On Mon, Oct 29, 2018 at 2:13 PM ulrich berl <ulrich.berl@gmx.net> wrote:
>
> Actually i do some tests with bluez/test/example-advertisement - it works fine.
>
> Now i need to advertise changing data (like timestamp, counter, ...) provided in the manufacturer data.
>
> In a loop i have to do a RegisterAdvertisement for each changed manufacturer data ?
> Or i have to register the TestAdvertisement once and then change only the self.add_manufacturer_data part?


Currently I think you will need to unregister and register again, but
it shouldn't be hard to make it detects changes and automatically
update the advertisement.


-- 
Luiz Augusto von Dentz

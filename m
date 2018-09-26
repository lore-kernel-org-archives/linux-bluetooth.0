Return-Path: <SRS0=Mlcw=MI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8BDC43382
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Sep 2018 11:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D4720843
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Sep 2018 11:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2EDK/5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D4720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeIZRkg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:40:36 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35312 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeIZRkg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Sep 2018 13:40:36 -0400
Received: by mail-lj1-f171.google.com with SMTP id w4-v6so1439668ljd.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Sep 2018 04:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYNRul1nqj273xxZErsEPZwj86AFP6QpqDfDj0nQVxs=;
        b=t2EDK/5rrzSKrDBf6KT7SZ9tfg/DW3EmS0nM/Orfied236EQE/ZsnilVgaL0kvmUNG
         APCfoSVRg0mbu0UoGsMh3wAgfiwm4pzZMIC+6eVLVlAUlqzaq7UqlI1oQdRcSz7Uihvn
         2rPnEHC/xHryqZ86/M2awIzQ9SQ4FICvjBTDzUQN3X4/N6/wqZXAg6rp/1koDb5DJD24
         crvqU3TabkcP3DWQNf1Q1MQfSt0ouzJfcc/BA92LqCk2k/NsEDPMpcVm5syDVAkhx6sd
         go4zElunlulCr0o4DbEGTp56mutKt9LZKH548La5aI1hOjt9IVIOqCwbeyQwiFPSo18c
         KOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TYNRul1nqj273xxZErsEPZwj86AFP6QpqDfDj0nQVxs=;
        b=tLmoGK3xS3dgku0rubRgBSJ5VwJgEId1psUpfHpR8UcvdJyGYwlxriXANeq1RpAm4f
         J4YehzLfEV2+nABqh3fze7ChJQ/8kD1YOlluRWOm3P3CecU+uYe5Mx7LPZr8ZhZ5MITO
         jOks7QFFW/HsqBxrOI0rJXfrh0ymRGlZRdbtVWtTN67TyC0qv8n/I/vDanj/BnC0dtH/
         wa+LEgoPKDWolpt9dgio+tVPit8/Z+5ibrSVqRnKb2E5s5M6+CwvgywKEkJXGCgqKIyM
         qEyykVZSQiLUuEPlnH+V3DMQ3D/AFSVY/MagzCO0pnfLiuiflDkXK5ncDNAl4iGyj0Xw
         APdg==
X-Gm-Message-State: ABuFfoieQ73sCVsXnme/XoXCfEyXLNO1qSKSIKOhtvFH+EQXtsYPhw5Z
        C7NmFonIzpVAmcsqHy4X5FU=
X-Google-Smtp-Source: ACcGV62hp/kknr2is7rK1rhEMZlAgudPwgqZVs8q6tmcmOmCunUWENyrWjKWK8hkvHr05nL7LwnhQA==
X-Received: by 2002:a2e:9b88:: with SMTP id z8-v6mr1655180lji.112.1537961284339;
        Wed, 26 Sep 2018 04:28:04 -0700 (PDT)
Received: from x1c.lan (85-76-70-99-nat.elisa-mobile.fi. [85.76.70.99])
        by smtp.gmail.com with ESMTPSA id d126-v6sm671908lfe.75.2018.09.26.04.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 04:28:03 -0700 (PDT)
Date:   Wed, 26 Sep 2018 14:28:01 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     fabien dvlt <fabiendvlt@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: Security block and Bluez - connection issue with Android
Message-ID: <20180926112801.GA8013@x1c.lan>
Mail-Followup-To: fabien dvlt <fabiendvlt@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <CAOiLkfOuenvh5ZLQD_k-yi7mL1Epr+gGJZ65zr2Fcp2SzE9F7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiLkfOuenvh5ZLQD_k-yi7mL1Epr+gGJZ65zr2Fcp2SzE9F7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fabien,

On Tue, Sep 25, 2018, fabien dvlt wrote:
> > ACL Data RX: Handle 13 flags 0x02 dlen 12           #198 [hci0] 21.813116
>       L2CAP: Connection Request (0x02) ident 7 len 4
>         PSM: 25 (0x0019)
>         Source CID: 75
> > HCI Event: Encryption Change (0x08) plen 4          #199 [hci0] 21.813155
>         Status: Success (0x00)
>         Handle: 13
>         Encryption: Enabled with AES-CCM (0x02)
> < ACL Data TX: Handle 13 flags 0x00 dlen 16           #200 [hci0]
>       L2CAP: Connection Response (0x03) ident 7 len 8
>         Destination CID: 0
>         Source CID: 75
>         Result: Connection refused - security block (0x0003)
>         Status: No further information available (0x0000)

This looks like the well-known race condition for ACL data and HCI
events on USB where the two come through different endpoints. From the
host perspective there's not much we can do since we can't make
assumptions that the connection request was sent over an encrypted
connection if we haven't seen the encryption change request at that
point.

Johan

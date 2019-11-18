Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41866C43215
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 17:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF515222A3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 17:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKjpiZLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKRRf1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:35:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42040 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfKRRfZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 12:35:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so20534466wrf.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 09:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fgiG8DT5fPgARrDyuF+q220ThmwLgCP/WJyEtvcPUHs=;
        b=TKjpiZLsVfjGHbNGCQvjk2b4eZXUn2SgdA/npAadsfs0xhr2L2N+B6Ck4kz4i/745E
         5Ipnyggb4fqwN1POnazcjtbIjvPXpofSC82NWd5+FlSCFtLxRmZvm/5CbVMlV9evzieA
         p/GOrXLExSU3aKPBt1kkYXNWd7S9WhMgroA5f0mXjRhVxN70bwZb6/I1PGdyTT7XKzz7
         D0WzcdkJ4B31weYKJ4G/Zrz/F8A7NgTkUpTy3eRr1jFv37f7tUQZnoD501M1n5YUGbGe
         PtMJY9oyjQ7sEWiFdZoiHPM1pdB+QUC/NDJHwY39pYnx8HKnnk4vt03ZXwbyqHyHZyse
         Aenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fgiG8DT5fPgARrDyuF+q220ThmwLgCP/WJyEtvcPUHs=;
        b=SOfbf+iMg9relqUjqoRHKR6KGk4Txge8JxWahqBuJYx2u2tW+wbSUHUIqB47H3qS+z
         zy3mK5c8KlgWUtYzysBB/6AC4NM8Sglr+kFbM1HPlNGQMSDy998GGLwjjNBT7XB3JzVN
         cfXHaW+rWmnxMWAbw6MQFUyP7lXRYMHJ69ZT/i9QnE6Q2aixbgpZStR381z5zHgaTuD4
         n7Qr1vMxyF7dIMRuc8i0WR5zfpAIHKHT2Y3tMfM4doAFYIkpvaGf3ld21qdGF5puFfqB
         8dcTZT9+SNPUFqHbPUh82YzBu3dhCgZWsKGz20P6Kdzwhe3LuWS0pQ6pRr4UDAoR20gM
         sAmQ==
X-Gm-Message-State: APjAAAVxn2531eC2oS+CrWbS/HkVQm3Dw7xbABm8SjiL39dYK5hSTq8i
        9ZPrPcHpnKUmrpTuztloKco=
X-Google-Smtp-Source: APXvYqxps6er3e7+ax+C8OaILteQJO4LMDe86AMv0i/GR1uO6Xr+KLaNXyUfz9BE8LKUD5w7pwMF7Q==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr31293733wrw.222.1574098523590;
        Mon, 18 Nov 2019 09:35:23 -0800 (PST)
Received: from localhost ([37.238.189.2])
        by smtp.gmail.com with ESMTPSA id n65sm70024wmf.28.2019.11.18.09.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:35:23 -0800 (PST)
Date:   Mon, 18 Nov 2019 20:35:20 +0300
From:   Mohammad Rasim <mohammad.rasim96@gmail.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 1/2] Add entry for BCM4335A0 UART bluetooth
Message-ID: <20191118173520.wfznan64jcaawndk@manjaro.localdomain>
References: <20191115165026.19376-1-mohammad.rasim96@gmail.com>
 <20191115165026.19376-2-mohammad.rasim96@gmail.com>
 <b22e57eb-978f-9ec8-9ca6-06c0f5e7b9f6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b22e57eb-978f-9ec8-9ca6-06c0f5e7b9f6@suse.de>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 19/11/16 10:43AM, Andreas Färber wrote:
> Am 15.11.19 um 17:50 schrieb Mohammad Rasim:
> > Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> 
> Lacking a commit description. Please add a sentence.
> 
> > ---
> >  drivers/bluetooth/btbcm.c   | 1 +
> >  drivers/bluetooth/hci_bcm.c | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> > index 2d2e6d862068..22464bf8cda3 100644
> > --- a/drivers/bluetooth/btbcm.c
> > +++ b/drivers/bluetooth/btbcm.c
> > @@ -339,6 +339,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
> >  	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
> >  	{ 0x4217, "BCM4329B1"   },	/* 002.002.023 */
> >  	{ 0x6106, "BCM4359C0"	},	/* 003.001.006 */
> > +	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
> >  	{ }
> >  };
> 
> Beyond this patch: There appears to be no order in this table at all?
> Not alphabetically, not numerically, not by comment.
> 
> >  
> > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> > index 7646636f2d18..7b4bb5dbea1d 100644
> > --- a/drivers/bluetooth/hci_bcm.c
> > +++ b/drivers/bluetooth/hci_bcm.c
> > @@ -1422,6 +1422,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
> >  	{ .compatible = "brcm,bcm4345c5" },
> >  	{ .compatible = "brcm,bcm4330-bt" },
> >  	{ .compatible = "brcm,bcm43438-bt" },
> > +	{ .compatible = "brcm,bcm4335A0" },
> 
> You can't use compatible strings without defining the binding first. Why
> do you need it? If you do, use lowercase names.
>
I don't really need it per se, I can use any compatible (i've used bcm43438-bt before) but I thought I'd add a compatible so that the device dts can describe the exact model of the module, if that is ok I will update the broadcom-bluetooth.txt binding in the next version

> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
> 
> Regards,
> Andreas
> 
> -- 
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer
> HRB 36809 (AG Nürnberg)

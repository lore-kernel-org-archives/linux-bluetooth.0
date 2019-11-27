Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4ADC432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 07:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406532070B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 07:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIZidArr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfK0HLN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:11:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37817 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfK0HLN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 02:11:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id b10so10327916pgd.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2019 23:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IXvhZp13gnNAlj/j/gD9smncQpNXS7Dl5DtWhLuqD5w=;
        b=aIZidArrrBxAdQMHq+KQ0mbe4s0dHpGnTFtW9mTX03v2lQYuihI0XbbsmgXYAfkof4
         uFtdY7Bf1x7CgdtNr2yzyP9ptxMnyegGQxMNWjN3FRL9vSolJGSAj+Ka5MQpkDdsvVsW
         78J6CtVttsI+6zpeYysmNh0RZdmT+woF3ECkjQG9ocFdEvFOxX+SGj3WABq5/ozxwaYe
         P/cC8nRlZuRnYNPkYWqWYRE3Wxei7u82FU4F5RhesST6MxAxyfHSeMVpAmYv/dwsKeH6
         OevOsIAuLwqugIK1s926akFCNzjDvAAqQJ4AkFP1ZCK7aZ8dQrpK3F8dYt0RLx/1E9+r
         kdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=IXvhZp13gnNAlj/j/gD9smncQpNXS7Dl5DtWhLuqD5w=;
        b=V9tz2bD3N495QUkB5DRfI6mwdwh3DqAyNDFXpYr/F8Lg81nbPJlfbDrlcY/FbZWGMz
         iQNI68U3GgbNGO4EoY1IlGORirnkbxoKhXACosx2Da3b+dOJ0TBtW4I4MjrdaFvUbTc4
         ZYFhvLLhjUiZy0lXKFuF6ZuG/mBezQUnmMOKp8w1h+rWxc/Psipa1h7GG4P7eEDaRmpy
         aepHv+Nw4+C+GOzUolANQAbtmEyXpplf/svfWnhbjzhrryVoPe8Jzb6scFYxiUhI6nqR
         p6pAR661jxXQ+UBOxsP0z5VsnY+d20l1BFOViRYp6RLyNtyw01PbXogt2f3/CxBadQYT
         R4uA==
X-Gm-Message-State: APjAAAU1smVHiZ+F9LaVM6Ak1/Rf7ArUMSHwmyjEv8Xnoevo09nfWavV
        /cNh+qN1+rGxvNeXFaSgLFC2BWwCX9oOcQ==
X-Google-Smtp-Source: APXvYqzETV+/HkPCvOOi+R/J+YQZ3EndFHyE1n8AIh/8bVMVAspDYmEx1mw0pMQDZBZyNHdkK3KG1g==
X-Received: by 2002:a63:334f:: with SMTP id z76mr3082342pgz.277.1574838671197;
        Tue, 26 Nov 2019 23:11:11 -0800 (PST)
Received: from localhost (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id 67sm4922135pfw.82.2019.11.26.23.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 23:11:10 -0800 (PST)
Date:   Wed, 27 Nov 2019 09:11:05 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Bluetooth: hci_bcm: Disallow set_baudrate for
 BCM4354
Message-ID: <20191127071105.GA32820@akivisil-mobl1.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20191126071732.67337-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126071732.67337-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Nov 26, 2019, Marcel Holtmann wrote:
> Without updating the patchram, the BCM4354 does not support a higher
> operating speed. The normal bcm_setup follows the correct order
> (init_speed, patchram and then oper_speed) but the serdev driver will
> set the operating speed before calling the hu->setup function. Thus,
> for the BCM4354, don't set the operating speed before patchram.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_bcm.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)

All four patches have been applied to bluetooth-next. Thanks.

Johan

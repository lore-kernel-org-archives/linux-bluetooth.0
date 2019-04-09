Return-Path: <SRS0=4NR/=SL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65FBC10F0E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Apr 2019 20:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9D020857
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Apr 2019 20:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMZaTeor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfDIUza (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:55:30 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:33373 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDIUz3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Apr 2019 16:55:29 -0400
Received: by mail-pg1-f176.google.com with SMTP id k19so107877pgh.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2019 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oZWGnbKeyxNPlH/GM6/rfIm4cSPONRKv7cIAd2SCgM=;
        b=dMZaTeore0dLBPXb8Hwg2j71RhEeNX1qRPKkUdluAC5TrHUjKaTOrYX3Ubtte8sNRK
         Bq303sBr/KQW8sUcD5SyMu7vIguwyX6h8ZOj58WS0tthWuf7lZbpsQJrh1F9LerWYYML
         8dwPI+V87NvkfVLAuIaOvnR5P2YEh3apnGSXmvAvY77MemWW0tKjHx6dMrMfpiPg4uDl
         NgbXW+GiNPgeTrGCadR2rE/fPFQcexQCrdGBjXcJvDUMk+RABZszZ5BZCCsItWgoodJg
         wXeH6rffB6pVaqJfWDYliBp0RxZ+mSGUTfwQDPqBVFMCa4kyeiu/+HG0WZQLQxy7LkOq
         m2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oZWGnbKeyxNPlH/GM6/rfIm4cSPONRKv7cIAd2SCgM=;
        b=fZDN7TJXP2oxN1PFIjI6ByJARUjmqdixD7uHyAy4MmJ/0vHTubYkgdb3HCoBKj0Tzo
         TUl91CtSDsYfYf6R4/45k9OSTPdeglzV1C5gabCuKCs3SacBxHNB9ZIaCPV7NeGj3NhJ
         VpHzCtYohsceDAabKWV647XOO3WoonV0AuBn5H3GIU3FFPKuaZDmCrWL8eq2gTJ2B/Nq
         yQph9es18o5M2v9vcv/7wErqcURfCOULrFe//yRyrqxIROsz0r9shpxqHpL14BtaGKUv
         5LQQkl4n/uDzuS2V1NLY8sIjztOXQ3cXhWoonPbMtimanncQLQ5tVtG43NCI/1O+v6rw
         RF+g==
X-Gm-Message-State: APjAAAWZZY3kqwLZ/TOdoeIDWHyI2UrhuxXjJAMcD37bj0nBqbJ0btkI
        XNp3msGrZT2wrPc6ayXN+uo51sJXDhEehIR7WZyLLQ1y
X-Google-Smtp-Source: APXvYqxr2Cts9pN3BWBGE01RUS8H3rYUuOToWAGVQ/jKwaw/oXt4kLt4O8Liavp8Dln/JTZyIpkY7ABfp74s67Rhddo=
X-Received: by 2002:a63:481:: with SMTP id 123mr37608977pge.167.1554843328928;
 Tue, 09 Apr 2019 13:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <87ee5fc2175747e1a7cf5b50bad819d4@ausx13mpc124.AMER.DELL.COM>
In-Reply-To: <87ee5fc2175747e1a7cf5b50bad819d4@ausx13mpc124.AMER.DELL.COM>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Tue, 9 Apr 2019 22:55:17 +0200
Message-ID: <CAO1O6seYhTMHrgCQ+9gPCo_UOtXfhh9mRCVoUosP_Eq0FXD=sw@mail.gmail.com>
Subject: Re: Pairing failure with BLE 4.0
To:     YouRen.Chen@dellteam.com
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Jared.Dominguez@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi YouRen,

Den tis 9 apr. 2019 kl 22:31 skrev <YouRen.Chen@dellteam.com>:
>
> Hello,
>
> Recently, I posted a bug report regarding authentication failures when
> pairing with BLE 4.0 devices. I was told to raise this issued to the
> Bluetooth mailing lists and I hope this is the correct email to contact.
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822633

Could you please also post the HCI log?
In a terminal window, execute "sudo btmon" to start logging. Then try
to pair your device (reproduce the issue). The btmon tool should now
have printed the HCI packets to stdout.

/Emil

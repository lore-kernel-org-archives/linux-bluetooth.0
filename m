Return-Path: <SRS0=CZwu=R4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B64C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 12:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B5E20854
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 12:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN3e0m+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfCYMX4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:23:56 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:34403 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfCYMX4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Mar 2019 08:23:56 -0400
Received: by mail-pg1-f171.google.com with SMTP id v12so6486836pgq.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2019 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kp4QnOKIDPKgIhFgxztrNqWgoXokwhQ3R+1ziVD/5lE=;
        b=CN3e0m+C5WxTaN5PL1jKpovkBzBWBrxNKEa7Fd5y/w2amdq4s4S3ae7YqRiVqSdvRy
         WaqtGWKODhVHZqZ/YvYtIA/E4t/4PzQ95IBCuIJ6KM2EeM3lz8X39ptdrbNL49YUUPEo
         KNRCAsrlG97/bNf+pd62J8iXEYuy25Bz44LTTLoDa3TPIdNoEIOc/odcJvQq6WkyNI4I
         s2EO8Sr2gG3ltMg5LkT+a7LQk3odc6iU2AVz1LGaiXU0WfdGgtgWJUy23MHWXk2fsooM
         w2gDM9dbqpwxG9jIlab6bBatnuJd9drE4aAvi1naTLLwzl+nOq65byPbENLA168vs4ad
         zVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kp4QnOKIDPKgIhFgxztrNqWgoXokwhQ3R+1ziVD/5lE=;
        b=nM3gI5sZVnyLMLSExroHl9g8yju6mGtOkGX4/ZA1R6/ApNjZO9v7q42vyp2j8C8tCC
         All1JzSmpmD53WoYiL0p6KtGXjVT7UiHS3sdbPEh3GPw1NAFNCXyzV/NTyeCQj6PPBJT
         ElZB2yCHKdG6Er3+utroxs4PvYkLFQcm5lUhhMH+AGckbfGOd0QUEp12h/ehg7sGhBMu
         hfZw6KjqnqcPoYJ9EZbnLNoReBb+fzVxF8I9h6o4qM+mAmQ6bxsEzz3cXbFJugNX1x7p
         ZxDfY9zzHJcL1zAad2RzgkgE9WlKAxdMoEe5IblF8Axulc03/PyQDbWSS57K9db1CP7p
         Lj8w==
X-Gm-Message-State: APjAAAXci1r9EWD266pUvZ6NklHWK82rpaZ2aPk38kY9KRmf2ADLMWmt
        s82iznZVXQTC/iysa9MJHsUjvA/x6NjGwDm77EQxbhck
X-Google-Smtp-Source: APXvYqwrct5b58Mpl36mQQ5o4DRGYA6itcRX9wJoHa3tBAQtEc59TwVtV7FwqAORG9ghvFEwpy/+lscY6DgrUXYWDrY=
X-Received: by 2002:a62:174c:: with SMTP id 73mr23792722pfx.33.1553516635430;
 Mon, 25 Mar 2019 05:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <CABLzjm-SLs_AzgS2S=3ogN=P9Jk9OjBuSMaNFTpXawrAsNfe+g@mail.gmail.com>
In-Reply-To: <CABLzjm-SLs_AzgS2S=3ogN=P9Jk9OjBuSMaNFTpXawrAsNfe+g@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Mon, 25 Mar 2019 13:23:44 +0100
Message-ID: <CAO1O6sfDYV9q5z2b64SS1MDSuXUYS6fvxQWc00NsX_1qLxEorQ@mail.gmail.com>
Subject: Re: Information about HCI LE Rand command
To:     Alexandre Augusto <alexandre.a.giron@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alexandre,

Den m=C3=A5n 25 mars 2019 kl 13:03 skrev Alexandre Augusto
<alexandre.a.giron@gmail.com>:
>
> Hello,
>
> I would like to know, if possible, information about the bluez LE Rand
> command (ocf 0x0018) at HCI code. How does it generate the number? Is
> it vendor-specific (or secret)?

According to the Bluetooth core specification, it shall be a "A pseudo
random number generator compliant with [FIPS PUB 140-2]
(http://csrc.nist.gov/publications/fips/fips140-2/fips1402annexc.pdf)"
which shall be seeded "with at least the minimum entropy required by
the pseudo random number generator". What algorithm each Bluetooth
controller actually uses is therefore vendor specific. I guess most
controllers will use some SHA-based or AES-based algorithm. Note that
it is not the host (BlueZ) that generates the number; it just asks the
controller to generate it for the host.

/Emil

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF65BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 20:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiI3UOK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiI3UNi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 16:13:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AA515AB67
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 13:12:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o7so1214360lfk.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 13:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=13qNX2YIm32qczrMM05ApVPyy8Mxxk7YBkav0t9dG8M=;
        b=NcbMHU9aia2t3fx7/PzUfPlLRCHtOUmx+ftZIBIqrqoqr6IEOzNjucdlVRVBJZocyz
         91Mk1MBPrGoSN7wGVEBUxwwG4V5Mtl6oVYk7YcUb3vceHTy7SmnNjC/N7reY+khtkgqi
         VasdzAORDleiM3afjp1dIAKCbvNzshJnfx8k+vZ3NnKz92o6Na6i4RUu5d+vtj4rqKuz
         QNqxGWtIdDOGnbw1jikquTRMocCtpM4EWkWhinf6UjwC/Mj0a1cUMn3RJLVQnAIUDLIH
         aH541577XMduH9QAYp/YlCoy787UJCQCVv1x/FtygAIj4AuHKXLp0vwNPrqaNgBbXkNo
         HjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=13qNX2YIm32qczrMM05ApVPyy8Mxxk7YBkav0t9dG8M=;
        b=Qq7uc8I+LxyCCkNGkN0Dx4Qnc5w7gdIifV25guzqpmV7IiPdUWeEpkEEnrCeIhO5xe
         cuUPgv6gRvcCaKM8/tNEaGPAPYyPsvaS3e9qvj/AiEu+sO2/8UZD88hKxZfaO9dBVqPE
         +o60YBnFAs0DO7kc93tdWfr8o34oe9NN3Aeq1dhjFGUurL/nNvFMKiSGCIcbNwN9puzA
         +VZZzeSDnDvvUp4lZiRKugz0IeWBX5pR/IB1cX/TPseZG0mPAN658eQa8tfYP0+0nM8B
         3S8QVZeOEBFTtzUNZZeBRB/LQH9Wj3fHHoJkolBEF/F9s6Vs4OwK/TbW4RCOXfXZysfx
         rogg==
X-Gm-Message-State: ACrzQf3AGu0lE7zExNCXan6df8TJgWo7SXKd6iGNjYdhrHHjY3qNAPc6
        ng8UsS0q2LcQ1ghvycLnI4UWZvc73W5eaCCsKHEjQTur
X-Google-Smtp-Source: AMsMyM49LoCZuTFBwquuLoTEwviwNtCsTM7G3nKDE3jAIzaiJXSXBdOBg/M6aNGd/vxG4vHrcg5h5Lgliv0AshB2aDw=
X-Received: by 2002:a05:6512:687:b0:4a1:d59f:dc7c with SMTP id
 t7-20020a056512068700b004a1d59fdc7cmr3765987lfe.564.1664568745832; Fri, 30
 Sep 2022 13:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <1906152.PYKUYFuaPT@n95hx1g2> <CABBYNZKZBmxNK4P+PR-xFcOsDoYPFi8xL12oyYaCGMktirU1vg@mail.gmail.com>
 <3455076.iIbC2pHGDl@n95hx1g2>
In-Reply-To: <3455076.iIbC2pHGDl@n95hx1g2>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 30 Sep 2022 13:12:14 -0700
Message-ID: <CABBYNZL94jw-pGuqv-zUaxLk_OFwEBxLcWm2Oyg3Q3FQPK_XRA@mail.gmail.com>
Subject: Re: bluetoothctl: Connecting to a GATT service using BR/EDR
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,

On Fri, Sep 30, 2022 at 12:56 PM Christian Eggers <ceggers@arri.de> wrote:
>
> Hi Luiz,
>
> On Friday, 30 September 2022, 21:33:28 CEST, Luiz Augusto von Dentz wrote=
:
> > Hi Christian,
> >
> > Connecting over BR/EDR as a central is currently not supported, it
> > will probably require some changes in order to enable it although the
> > likes of bt_att/bt_gatt_client shall have proper support for it.
>
> currently it takes several seconds to read 70 KiB over a FIFO like GATT
> characteristic. Is this normal? In which configuration I can get the
> maximum throughput? Is it worth to tune the BLE parameters or should I
> use BR/EDR with a "classic" profile instead?

If you want to maximize throughput you will probably need to change
the connection parameters and perhaps use L2CAP directly since ATT is
not very efficient and you either have to resort to unreliable write
without response+notify or wait for write responses. If you want to do
file based transfer Id suggest you looking into implementing Object
Transfer Service which uses L2CAP CoC to maximize data transfers,
alternatively you can use OBEX if you prefer using BR/EDR, that said
it would be great to have support for OTS since that is used by the
likes of Media Control Service which is part of LE Audio stack.

>
> regards,
> Christian
>
>
>
> _______________________________________________________
> Christian
> Eggers
> Software Engineer
> ARRI
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Arriweg 17,
> 83071
> Stephanskirchen
> www.arri.com
>
> +49 8036 3009-3118
> CEggers@arri.de
>
> Get all the latest information from www.arri.com, Facebook, Twitter, Inst=
agram, LinkedIn and YouTube.
>
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Sitz: M=C3=BCnchen =E2=80=91 Registergericht: Amtsgericht M=C3=BCnchen =
=E2=80=91 Handelsregisternummer: HRA 57918
> Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik G=
mbH
> Sitz: M=C3=BCnchen =E2=80=91 Registergericht: Amtsgericht M=C3=BCnchen =
=E2=80=91 Handelsregisternummer: HRB 54477
> Gesch=C3=A4ftsf=C3=BChrer: Dr. Matthias Erb (Chairman); Dr. Michael Neuh=
=C3=A4user; Stephan Schenk; Walter Trauninger
>
>


--=20
Luiz Augusto von Dentz

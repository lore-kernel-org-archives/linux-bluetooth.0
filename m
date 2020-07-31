Return-Path: <SRS0=UTuE=BK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3C5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 13:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0444208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 13:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXakR4S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgGaNoE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgGaNoE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jul 2020 09:44:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EB1C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2020 06:44:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so8970008ljc.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2020 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lo9C2xqeYkWsxppLoGKUzu0q9gC446jx7IkUkPm91X8=;
        b=dXakR4S/Bb/wgfWJjE1KHhI61z0LuDuKggBu7VYG0hOFo2/ebDpUuE5uj/fiVZHPda
         qM9UkOM+7N4oMJNTMTGXATXVFL5LW/G9G4l+ygQnwtNDURg7aTQ+1EvAT+987Y2NhxSX
         c69BSSHsIdu4Z3fN799/c7+orNWu1xgqNAMEiGzop0bZHzc4xbJRKK8fcEmF6JOPSOVQ
         7XdvZdQqLqPc9IbxV6UpCYMlHT3lU2kbJ6qN/EVvbNiypslfeYbwKXC/bieg2RmWfBoG
         4UPZ2r7SiYGSkQAvEmbutL/oc7DAHkWM9A74RU9rxHu0aXAan4rlMYSvbPealg/s3LO0
         RoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lo9C2xqeYkWsxppLoGKUzu0q9gC446jx7IkUkPm91X8=;
        b=clzrnTq28AhSyUrofvnegm/tXbwZaFqZBOoqvRhXjvryWObeoU6H21JPezKrpBHIL/
         O2DRQ4XhDcjdh1tnCm8cfrR5f3JkdwpgYBilIXK4SWplg6k4wbCYdSBszQpovedhnOi9
         x9wXbkf0s43fzwSe2LKqAvu9LprbN0ozP+Rd9Zc+dPKJk3PIrFU8goPN49nxuF82tXV3
         K1imaPIP3NmWXLSmStIKHx3zfYyhHOqbt2vgdK2K7hfR/PxSvttY2Tdxl4FEj2NY1fCn
         kh3cyJeFylOj1+ZWcxgnSYOf2f+r78YrzZLnU0wrdgL/5aLhpslRPeo+gdbOoLTIMvaU
         YaaA==
X-Gm-Message-State: AOAM531KZNgVFAVp0ag+Ith4xXreDgxpcOl5L4csNtw2vzRd7DeRx4k+
        oo6SK2RhJdmYJrQ3ULcUByk=
X-Google-Smtp-Source: ABdhPJyZr/T9Nc7yd1lyN7Zn1ZVws7thHHCvNHgvE7Q6gu3OtIcK8IIJWcMkjehqDt4hQhk4lvneuQ==
X-Received: by 2002:a2e:3503:: with SMTP id z3mr1805872ljz.336.1596203042378;
        Fri, 31 Jul 2020 06:44:02 -0700 (PDT)
Received: from localhost (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id v14sm1676084ljk.10.2020.07.31.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 06:44:01 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:44:00 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH] Bluetooth: Remove CRYPTO_ALG_INTERNAL flag
Message-ID: <20200731134400.GB77314@jhedberg-mac01.home>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20200731074158.GA20263@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731074158.GA20263@gondor.apana.org.au>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Herbert,

On Fri, Jul 31, 2020, Herbert Xu wrote:
> The flag CRYPTO_ALG_INTERNAL is not meant to be used outside of
> the Crypto API.  It isn't needed here anyway.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied to bluetooth-next. Thanks.

Johan

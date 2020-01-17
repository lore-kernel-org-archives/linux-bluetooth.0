Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E27C33CB6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 20:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A5D2072E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 20:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKKQ5n+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgAQUoi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:44:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41195 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbgAQUoi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 15:44:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so12467487pfw.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2020 12:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=i2h0O1gU99AEuZaUmDXHRg2aO0OE8cDx8Heji2bKUVY=;
        b=FKKQ5n+8Yqq68dsJ0PaFnlkzhllZelrpSD3TJtxWrl0tgxJ8xVIp565oYdTQWbgkAK
         pxB8X0m8NFW0K0A3Ya1fkyO88n9Xv5+jjdtbSncP0cY2bqb0UfkAI6f8iw/zbti/qTfe
         4eDW02jX06SsFiQiGFleRDghPPPlnYTLtHJVxKZa3P2WOWJJkW+HEpYHpZ5uu75WQEIS
         xVlYL0eYNEPT0zc2kH1uhY1fpoQezi+BeqzGJyo0W/vAGN7Wg6Sxbvu4RGSoFdvhZQzB
         AS/nS9CxlxH0WxGtUzWQRa763lBHL2OsZb9Li4m3AyHZg7LDxXI6DAcjC6oLJ4+oyJh0
         xjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=i2h0O1gU99AEuZaUmDXHRg2aO0OE8cDx8Heji2bKUVY=;
        b=Yp1S+SbDnEMv/lCqC3IsWzTOVvXRcZxia9tGCyxSFw6HrXUzaARx6bmyr1NXxiBEEM
         d1GX2bOpPudKmFMLGWy7QV2yL8CBkEKQop8eWF7dESMwJMT+Vdz2+6AxD6o8fuY5LIXe
         MveqxGP+wQc5wXapiHQjnB6QbyD/4SMvKsKE7dVQfoTEB5eVB3FYZzqcu8VnJmuaRDWK
         t31BXud8oXbgBXrHNAycRLaDhdS0lrG+q/VRDUrSBdWBNffgeeZ3JZ5ReFcK8tixSHIm
         M+0tZ9m/hbzt/P6UlRpvp0xf4zcZf+kKO3y7w0yPmEu8ETvgkZfBSGZSwZUFIIYqg1Yk
         x8YA==
X-Gm-Message-State: APjAAAWZuHMvcewJP7f0BQPrCoTZLGtVVUpFN4JCutJjYpK1/59bL4Vj
        CF2MMwfngqZRpHwW/kt8hbs=
X-Google-Smtp-Source: APXvYqzzbZ6CoYe2oiv7dD9spg/BQSFrcZXiu5qlmLmIN0eLEONjAxTY/mjdpFzbrudwJv8bluXyHw==
X-Received: by 2002:a63:6b8a:: with SMTP id g132mr46591515pgc.127.1579293877214;
        Fri, 17 Jan 2020 12:44:37 -0800 (PST)
Received: from [10.175.242.213] ([192.102.209.37])
        by smtp.gmail.com with ESMTPSA id s21sm30322931pfe.20.2020.01.17.12.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 12:44:36 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:44:35 -0800
From:   Luiz Von Dentz <luiz.dentz@gmail.com>
Subject: Re: [Bluez PATCH] Adding missing op_code string conversion.
To:     Alain Michaud <alainm@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org
Message-Id: <1579293875.12244.4@gmail.com>
In-Reply-To: <20200117042421.68430-1-alainm@chromium.org>
References: <20200117042421.68430-1-alainm@chromium.org>
X-Mailer: geary/3.32.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Thu, Jan 16, 2020 at 8:24 PM, Alain Michaud <alainm@chromium.org> 
wrote:
> Adding the missing string conversion for MGMG_OP_SET_BLOCKED_KEYS.
> ---
> 
>  lib/mgmt.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 276445d0a..101cf5f95 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -893,6 +893,7 @@ static const char *mgmt_op[] = {
>  	"Set Appearance",
>  	"Get PHY Configuration",
>  	"Set PHY Configuration",
> +	"Set Blocked Keys",
>  };
> 
>  static const char *mgmt_ev[] = {

Applied, thanks.












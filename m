Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CCDE95A61
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Oct 2023 12:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbjJGMSz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Oct 2023 08:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbjJGMSy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Oct 2023 08:18:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B4EB9
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 Oct 2023 05:18:53 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4181e268447so18555321cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Oct 2023 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696681132; x=1697285932; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vfnCoY4Nt0lRRgy3WGJC8oo1C97glUYFyLqXMc5XbWU=;
        b=T+5Uj0BTqfSBVIFHxcZ1mmiPU6WI4H+hBiRbJJsmtUe30qjCZZvNVjWqpuWS4C2wv9
         324TAZ66VjKM9mcaFAgXvEv9n+GbBdY8Fs6BPfY7QDDiNnuuT5sQZQWCZwW4poElHQza
         /OpElp/gcH9xmxg2TGnVC7KNtJX/kpprXIgELW/i1ob7Yr1Bac/wwakXS23aqH5xs/gB
         pBQGTNxNeEcmKTkIkDuJWS8XZ0SM12v3ckVH1tWUTDPoKOeZPT5ERcfHxP7IM2bvDdeZ
         /PiPHooP3+jphKPlgcAZKjcQq2JHUm2vTBITR5c3LEVc6MBlhRf6n0T9vp6FR0F8oLEw
         +i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696681132; x=1697285932;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfnCoY4Nt0lRRgy3WGJC8oo1C97glUYFyLqXMc5XbWU=;
        b=tr2yDLJmyd/KwhdPP+NBhonbdMM8AgNN5QG5oy0Ng9Vwlge6wUZryDqZEVOXzq2Tjk
         Ntua+R2x5c81IuLW9PW/NT8ObFcgNRyaeerb1TzlKfDBU9mF/iusTXcgvK2KA8ih4+EZ
         quAgme6Te7nV8oYQZJl9Zfer6hlK1TpLcgfAxzAfpc9WClxVFcevc7Gl7BVoqm7m2+07
         ygw3PJuMbvtlI8mn7J+RWejHS8pCXRiFpcoCPo8vLcpS8ZfBcA/T/zzg46Z7TSDnPCEf
         2Ab6u0Jr+nU2666rNsiqXym9lOQ8mzkprAB3YBQuYXkHmskmf9FNg1rI4vzjB4Qd1gBt
         80EQ==
X-Gm-Message-State: AOJu0YxM5DTg9A2OsVxhTWeaVOFq+cEcdXeXzXqBwK0H6HNWTG0NK9/2
        eBw+4+U9yFKc7NprqtKK5v2HGSRwWRk=
X-Google-Smtp-Source: AGHT+IHBw38UcUpzokKlXqZnMHLFxOmPobgj076ouGYVKa650hJ9HPUofuILH4fH1drkG7C4hbBeZQ==
X-Received: by 2002:a05:622a:512:b0:419:52a9:9ffc with SMTP id l18-20020a05622a051200b0041952a99ffcmr11619974qtx.35.1696681132433;
        Sat, 07 Oct 2023 05:18:52 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.174])
        by smtp.gmail.com with ESMTPSA id x6-20020ac85386000000b004198ae7f841sm2004432qtp.90.2023.10.07.05.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:18:52 -0700 (PDT)
Message-ID: <65214cac.c80a0220.87d0c.a00a@mx.google.com>
Date:   Sat, 07 Oct 2023 05:18:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1113152781292155182=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yuran.pereira@hotmail.com
Subject: RE: Bluetooth: hci_conn_failed: Fixes memory leak
In-Reply-To: <AM9P192MB12672AA34A0480B522D23741E8C8A@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
References: <AM9P192MB12672AA34A0480B522D23741E8C8A@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1113152781292155182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:1248
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1113152781292155182==--

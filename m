Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C84C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 17:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCORjM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCORjL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 13:39:11 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E32F77E
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 10:39:10 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id mg14so1410229qvb.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 10:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678901949;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7kDJ0p1+zvLZZGBnKdQfVT3HU6zIXUVLonk33LEctJ0=;
        b=WfCOwb/J5R0v9f9hGev+t/3MFXqFlLMiVsjg9BAxCkbOiuDFe9WC58+MC8OcaKmTB8
         fHA77SnQqQ9c50n2UmgXsWyQqFTm/JHaYZPn2EjFlslQbjjZJGKa0hxux5HBs0NXrAuO
         S8vQWpr+iBjvar3P14bvRSBXEUqddgUmcxlDyd9gXDDWzxUejsJ8idS7Fr+DWvb7pLOZ
         uJeb7tW7GG1fxUnLLKMK8L4ovdW3udIUoyZzKgIcs2sCpyfAZ/kNB3oP7/azJ1X5gB92
         Buy85KBq4kfrf7LkMT85sN7xcG+Lf7ArKMWaXtlfGGM/WyKahWHIZ+NmzO5NlDgMNG8L
         zDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678901949;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kDJ0p1+zvLZZGBnKdQfVT3HU6zIXUVLonk33LEctJ0=;
        b=pQYEv0Zfo2dh7evDws9tkWBS5ufXNFXU+xTS52rZoMSEy20dguZCcafypSuxy06E5d
         khrKsEGb1o37cclXjt0jcexi+vLYJlSleyyi/jUcC5w+f83WPSBTKC0XAJoxdYwh+ImM
         h9acm5uSJDoZqGLhFQILA4ALJnnienl0+9Fjiny4LnHrT1ZxlVB4q3A6tpmJ+DdrINet
         HMy5JtsxXKMK2e6knKJmtahAXOdhTDtctcn8nBUn8lEB/PHussiXnmD5S3hqF96+9XKb
         0mbM338M2U3f/19lqFo87kG/Um+1JcvqImNlAK3vRJVezlmLYsiNwlwOwfnwVpWJzMbK
         Lprg==
X-Gm-Message-State: AO0yUKX9BTklW5fR3qb1Xrfl16cLcfboms77WGF5yH8erg4rx+K2c9GA
        ITLgbrLFzGvQptJJNhGAke0KOnMrAgs=
X-Google-Smtp-Source: AK7set8XwBipkuOnpGutk94M0SBizy6jNRVms6QR4bvS2dLG29dvimfjDOcuPODsEw4I1mVSY7PRNA==
X-Received: by 2002:ad4:5dca:0:b0:5ad:45f2:4307 with SMTP id m10-20020ad45dca000000b005ad45f24307mr8430378qvh.11.1678901949563;
        Wed, 15 Mar 2023 10:39:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.196.114])
        by smtp.gmail.com with ESMTPSA id c1-20020ae9ed01000000b007461fe6d6e3sm196653qkg.49.2023.03.15.10.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:39:09 -0700 (PDT)
Message-ID: <641202bd.e90a0220.2584e.1754@mx.google.com>
Date:   Wed, 15 Mar 2023 10:39:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5727514709459218068=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, macroalpha82@gmail.com
Subject: RE: Bluetooth: Add support for RTL8821CS
In-Reply-To: <20230315173657.28692-2-macroalpha82@gmail.com>
References: <20230315173657.28692-2-macroalpha82@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5727514709459218068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: Documentation/devicetree/bindings/net/realtek-bluetooth.yaml:4
error: Documentation/devicetree/bindings/net/realtek-bluetooth.yaml: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5727514709459218068==--

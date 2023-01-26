Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D28C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 20:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjAZU7w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAZU7v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 15:59:51 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADFD7AA1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:59:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id o12so3324767ljp.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/zoSGpXYS8dvMZ6OZp5hoypKJ1SmuuoY05IJFyDgBg=;
        b=ES4P6mQqRoLbv7u+hsbiYB0dAxk6JFRLuTZOWGFEEhj4t5c78lf8hv3UBdQsfBAsQc
         INjt+o3OZM+W42WHN1+5IKMpnZVU7IQs8vV/BKOf9yUaj3a525q14qak0BaFdVkqqh/L
         5D9sm60PXXA+gVx20/b7E7pc2UO3uniVLEVLJF5ARZZrEsiLmaQ7E1RJGTyySau+u1Nc
         Ik+bYJvdsaLc17UR5xAaccZFqyuc1Qt2PGoZJJug5XmUBVjXFD42Lcm4Avy1GLkxKCVX
         0qkak7+eIl//hz+67+EaYFpJ2iYfwdNddwedQHeUamIKMDdmktj9zK6GbfrereAj0In6
         0G/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/zoSGpXYS8dvMZ6OZp5hoypKJ1SmuuoY05IJFyDgBg=;
        b=CiejhI/WXxydXFrSKP3D3Vl7vUMpTXzNR555UKBHwFMybJ22n3eDMRSCMfd63LbjKz
         duQPv6u5oqIW9juuJGQM3FGTLi9W/vrG2zjZeb0uHNdIm2JAp5DWA5lw5AS6ZASV6709
         TtCOnr/ND2UtTShjTjMWt5COYBrqKAHk5RNRDkXNonyHKj/2uIJPqhS/+sxo3ayteBXy
         muTAbRMbu7rOnplSgdV6RMcaf7XR5Ks5L+pPjFots32yK0F1s+U8gBo+URxlaFRE+LZb
         V5jGhYlXZ+diwI2TzYYSrguWVLgiRm7o/masYy2ISIvD6nbOtionOjYN51fH9WMABJps
         ktgg==
X-Gm-Message-State: AFqh2kqx5FwhK7sk94Vw/imMDGSAejYkigg9LQMF+TN8LMZMMNb0Psj0
        pS4kUhfNyZ0zhvIVo2Wgtyzb2cfmaoR7qs1L1G1ELJ0K
X-Google-Smtp-Source: AMrXdXtAjWZ43sdoomh8isAjV8SnAHmLpPU05Ll2G3jA3hqzu78hqjA0cmAOFZvyJBbGO5w9oDZRJpdkulikhSrnLzA=
X-Received: by 2002:a2e:914b:0:b0:28b:75e1:ec29 with SMTP id
 q11-20020a2e914b000000b0028b75e1ec29mr1966003ljg.96.1674766788613; Thu, 26
 Jan 2023 12:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20230126074356.431306-2-francesco@dolcini.it> <63d23c50.170a0220.124e7.0ce5@mx.google.com>
 <Y9KYpw+V1e7wLiT/@francesco-nb.int.toradex.com>
In-Reply-To: <Y9KYpw+V1e7wLiT/@francesco-nb.int.toradex.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 26 Jan 2023 12:59:36 -0800
Message-ID: <CABBYNZKsD1FAXz1y+8=ogWLmrN0OhctcoRJJXEz=dorv8H8nfQ@mail.gmail.com>
Subject: Re: Bluetooth: hci_mrvl: Add serdev support for 88W8997
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Francesco,

On Thu, Jan 26, 2023 at 7:15 AM Francesco Dolcini <francesco@dolcini.it> wr=
ote:
>
> On Thu, Jan 26, 2023 at 12:39:44AM -0800, bluez.test.bot@gmail.com wrote:
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D7=
15765
> [snip]
> > Test: SubjectPrefix - FAIL
> > Desc: Check subject contains "Bluetooth" prefix
> > Output:
> > "Bluetooth: " prefix is not specified in the subject
> > "Bluetooth: " prefix is not specified in the subject
> > "Bluetooth: " prefix is not specified in the subject
>
> These warning are bogus, the reason is that the series include a couple
> dts/binding changes that have a different rule on the commit message
> prefix.

Or CI only expects patches to Bluetooth subsystem or drivers, so
perhaps the dt-bindings changes shouldn't actually be send here if
there are not meant to be applied to bluetooth-next? Or we need some
sort of smart filtering so PW don't assume everything sent to
linux-bluetooth shall be tested by our CI.

> > ##############################
> > Test: CheckSparse - WARNING
> > Desc: Run sparse tool with linux kernel
> > Output:
> > drivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrade=
s to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16=
 degrades to integerdrivers/bluetooth/hci_mrvl.c:170:23: warning: restricte=
d __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: r=
estricted __le16 degrades to integer
> This sparse warning was not introduced by this series.

Yep, that is why they are treated as warnings not errors, still it
would be a good idea to fix those to avoid it popping up again.

> Francesco
>


--=20
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED3E95A82
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Oct 2023 06:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbjJHGPI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbjJHGPI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Oct 2023 02:15:08 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4DC5
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 Oct 2023 23:15:07 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65afd8af8bbso23113246d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Oct 2023 23:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696745706; x=1697350506; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dPYbFLFTEqUca6Vt2UZF1Sz1Bi4J8zAjtuI6OJHSPhc=;
        b=cnk1IQ3Li41fqE4Z9q3AcJAkUDGlxzl1M/m+13F+khCIKDeK2GS5iS6paOat8FrM0I
         1xICQQtkes3gfhM6qbgRGLX8AYhpNbsnp4rYbGA361vIL6k9DfdUuM/ycRcMtpxiukx5
         gCdGGlYOGAy3uy++pI/HNeIeFamL26nu2yPsXQRzbUlkqhATJ4QUS5XRC7sjZzHS5H0n
         FwIjxwgDRnJpTNB9xl6aQMw7iWeQNpgHT4KqJ70iFs8+NqfYNv0vl6zhaVswgRDlF4Ca
         EvQYpNujkP8Yir66FqPvxuZR94HP7OCornVoDTbB+m8f2AqVkvE4plPciDDvXIEjces/
         IGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696745706; x=1697350506;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPYbFLFTEqUca6Vt2UZF1Sz1Bi4J8zAjtuI6OJHSPhc=;
        b=uxOXE70JDSpJDO+pjK0i4ib9CAumeDvQ0365ocHgZJcEVYN+rHneXefDRv5YPpcG4H
         Ojm5GAoCn/8wt8/X65TqM0CI0/+tRD+YIBJuPogieql3iDDeXqIIxQ7vc6FtYIQNoeo2
         zvNb9oKNGirDUCmXji1jMwJTTrAGY10JHII5j+V8zry0NCff0LNIxbJoPosFbOVfbf+2
         swEGJ1a/7A/S2OR7lJc6Mdo1m2YXrvOQKFmDFJ+PDPNzwF3JgyyrI7PFu7DjEcD8MEMu
         CvNaSM1BDtvCpX/qrz1Ry6S8z62n4ctqViF2Y/Nq5UcjJUy9/qQL5PU0Q2F6luWUw5fP
         X/NA==
X-Gm-Message-State: AOJu0Yzd9mmigZTJi0nTm747l+K4seFzHUViWAVYyX8csxsspz3IJuaL
        u38OPDcddP+gWHV1xt6bqyaXfEPHc3E=
X-Google-Smtp-Source: AGHT+IEZdVwnWxP4gKaZZfmgk0+vHmBQxaxbVJ3nUdq9HRDlV7HjcuaBg/YlBtikkxIg5FCeCmPVpw==
X-Received: by 2002:a0c:b347:0:b0:65b:26d4:7fb6 with SMTP id a7-20020a0cb347000000b0065b26d47fb6mr10945424qvf.4.1696745705991;
        Sat, 07 Oct 2023 23:15:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.60.109])
        by smtp.gmail.com with ESMTPSA id g14-20020a0cdf0e000000b006584984f3dfsm2757524qvl.26.2023.10.07.23.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:15:05 -0700 (PDT)
Message-ID: <652248e9.0c0a0220.b1135.c353@mx.google.com>
Date:   Sat, 07 Oct 2023 23:15:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2338572102873138167=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yuran.pereira@hotmail.com
Subject: RE: Bluetooth: hci_conn_failed: Fix memory leak
In-Reply-To: <AM9P192MB1267F1B8CA16CEEF884C9F2CE8CFA@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
References: <AM9P192MB1267F1B8CA16CEEF884C9F2CE8CFA@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2338572102873138167==
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


--===============2338572102873138167==--

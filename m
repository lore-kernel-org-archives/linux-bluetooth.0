Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD6C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 14:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCWONs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCWONr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 10:13:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C89233CC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 07:13:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a16so17238544pjs.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679580826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OsXQYIOxmRIdZhbjrmdQf8k5g0I5D1+lOILcfqJwwSU=;
        b=IWPww3+teAl30tzYFgTrVPCRh0e19XQ69crCPb/XJ1b1H+p+ELp9pav0Hz3TlZ/Ka6
         fM7x0yEUcNkkrALM1Xs+6fBqj+FuxFmTclimwr+DnoN1UxFhNUW2j4PBI4KJ2NnyWR4j
         Yc7UZaYfUH0OPAxakoSn4XWpd3XtVZUi3BNNK5GWgSisSTsaOcPTrqi8VgOzU0MorVcB
         63AaSpJa+fYkNxYBeqn/krRfRbf+TAUA/aM7vB19SjpqJroIznWbHRsf0NZFEDK+SzFS
         bwebX3m5aohyqs9r7gAeo/QZqvFTqf2x8h5/xf641mw6g+rN7XSWFDWflTmLGhvu1HjO
         jR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679580826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsXQYIOxmRIdZhbjrmdQf8k5g0I5D1+lOILcfqJwwSU=;
        b=iB+MKTE2x+QiEdRIc7l50uU3BE1JPhxPiES8vJ23y0gWRb51H+803CFb3lmuz/jGZn
         1eVfsYrOY0TaQGSuLw8w96EZsh0Hl+uHxqtF/bvAeZCAmmA3MBYVV771V396x+v3payM
         Q8V60OtuD2EAltBF/ssJsvOYOBHopcoA0vz8AAI7MjMn7t7dUgC35VJ8fkEJ9jPsVfc9
         gZoDCLdTAUuFLxgevHfqctgzmCeKfgmOBLifg5dC9V1CF3oyzjo0dS8FO8tUsQjtqOIX
         a/MMGDP1OVUEcUtqG2tq0sY9jGI51oRDjQwsdBPwEFQti631oWwBB9YQ8w8gI+mCiN8V
         I8QQ==
X-Gm-Message-State: AO0yUKUPRuqaMvSQEy1zdGXDujKmp9czPlBK5EzjZNsba4jwcmQAypQy
        WrXqb38LJ8oXeb1uBYOKQkpN42jMnkY=
X-Google-Smtp-Source: AK7set8tdgUqNcVQcFuqlw5jJ2xnISmDvxV7gUYraNc/lf1xEVbmC1DNmCdxX8pKEr+M+eX1k9rf4w==
X-Received: by 2002:a17:903:288c:b0:19e:8bfe:7d70 with SMTP id ku12-20020a170903288c00b0019e8bfe7d70mr5751180plb.52.1679580825698;
        Thu, 23 Mar 2023 07:13:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.19.56])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709028d8900b001964c8164aasm12347036plo.129.2023.03.23.07.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 07:13:45 -0700 (PDT)
Message-ID: <641c5e99.170a0220.fc144.6d04@mx.google.com>
Date:   Thu, 23 Mar 2023 07:13:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1460903819382400527=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, raul.cheleguini@gmail.com
Subject: RE: Bluetooth: Add new quirk for broken extended create connection for ATS2851
In-Reply-To: <20230323135804.3962783-1-raul.cheleguini@gmail.com>
References: <20230323135804.3962783-1-raul.cheleguini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1460903819382400527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:4107
error: drivers/bluetooth/btusb.c: patch does not apply
error: patch failed: include/net/bluetooth/hci.h:309
error: include/net/bluetooth/hci.h: patch does not apply
error: patch failed: net/bluetooth/hci_sync.c:4534
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1460903819382400527==--

Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3783C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 20:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CBB20809
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 20:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK3gwl/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbgJZUec (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:34:32 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]:33178 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387570AbgJZUec (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 16:34:32 -0400
Received: by mail-qv1-f53.google.com with SMTP id w9so4997745qvj.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xrzz6aM/cLyYfw+bf5WSbsL0XFuCtnnwODvgZxhSPCI=;
        b=TK3gwl/ISr0naUfvVxYy7Pso6Y7QqApKMm8d5lzAzfyVeZNcna7zwuMAECFhOyp/Kw
         UQkFE/ub7Gn4NEmjWBzBkUd94iDQBTq65OsOwL4QEfa+onwoI6IPKFRhpLv1pHubFMtn
         iAAjoztyJyUAGpfwWvKrxTgITXO6EZ6xKwlrzpgW/vaU0lClMk525H8V2rLTUwu627tB
         +6ZYAhbku1clnLSL0UA0KU6CTPrEjc3+3QQb5o1BU2UQfjDtXEd9O7KP8HDbIYniEMBQ
         JCbwH+OfkNjVEiiiRezZLHvoNWHtf860Nh5zxegjsLKdMxPaDiok/VV0HyfYrDGBFBme
         G8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xrzz6aM/cLyYfw+bf5WSbsL0XFuCtnnwODvgZxhSPCI=;
        b=e1xZeWFWeSVPrPwg1Q9IeHrrkaKIFYbeJ6Sg74UlQMkhAGJbu7z6avMgSj5W9hOX1y
         xy/Biii1Okgd1WMPAnxfW3eOM/faLfQmjuI83llt1mEVyeTtzsfXMfX/3uKg1mqRcmVV
         Y2wYZp3Jn1z718PddFWZ2DnnxKK7H+E9lwP941u+FKDjD9D3OEbxKAt/oPST5Vs7CD9O
         ExDUOrLMNQl2Lw/OqVXQNjziVrNKWq+vO2ksdKkHK5vxp3C1xl6GDi1qxXmm2zX2jkFr
         RzT5LWtpRe89SzakC1y71+qhSjiWmeceLxDT6B2V7vjz5rsXgG52tP1iw9wnG8JQDuTj
         kUxA==
X-Gm-Message-State: AOAM5315CYYU8qtSdwALyOEhWPzUGg0hPjeCzr5Gn7GTZvxeH9ygNOjN
        vGFCKEp6VpSrZ39VOE+Uhpv4dQjx5y2TsQ==
X-Google-Smtp-Source: ABdhPJzhuqQWNTMls4tYeZxHP5Ut+etcIQ6mkeMXkxfzCCqXx3iFENHXhYwOoBtRnx+ULQxpuEWODQ==
X-Received: by 2002:a0c:8d4a:: with SMTP id s10mr4652598qvb.30.1603744470363;
        Mon, 26 Oct 2020 13:34:30 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.201.106])
        by smtp.gmail.com with ESMTPSA id 63sm7140681qkn.9.2020.10.26.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 13:34:29 -0700 (PDT)
Message-ID: <5f9732d5.1c69fb81.6ea0a.9bbf@mx.google.com>
Date:   Mon, 26 Oct 2020 13:34:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1294499703690383587=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijns95@gmail.com
Subject: RE: [BlueZ,v2] audio/media: Destroy transport if SetConfiguration fails
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201026195408.2528476-1-marijns95@gmail.com>
References: <20201026195408.2528476-1-marijns95@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1294499703690383587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=370879

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1294499703690383587==--

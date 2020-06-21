Return-Path: <SRS0=Pq0q=AC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3FDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Jun 2020 19:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FA625231
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Jun 2020 19:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiloR879"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgFUTIE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgFUTIE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Jun 2020 15:08:04 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0745C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2020 12:08:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z63so1673766qkb.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2020 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=qwngX6Tf8eXXLGqv5xhD8f+54fdRlHJlu8RtEvriV7I=;
        b=DiloR879oJGotO6XWUa2GBfna2G0v9vi1U/5YPzJ/rKSAxQTUogjy1NXS/fVlkrOWZ
         Kv+AjrMkzAC+lf0mZmh1bjGyHj9ba2bFgtwiHOU+eEQqWsow3VBHdVYuDG43oRbddm9i
         qnQeaiSO3Y4KGTuc/AD4eYcGqadKz8uU+2dAGrEH0zs/CfGxFpRGLseWVUSi9N69OaBR
         lfk6YBs55m49buahhUsWZWl3LYik6NySjk9KD2IWMtKzWqnnmnbNLpzj3o1XwtqdwJAi
         VVM5dueM4m9MD0r8w1r+k+kcKcp0CZjLe/IWFqfTaKX33jNBweeR3PhyKjSzC9rlgIXr
         GR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=qwngX6Tf8eXXLGqv5xhD8f+54fdRlHJlu8RtEvriV7I=;
        b=tD4shyNHcNZHB6HpHAiB97GkyV7YymduVHqrmp6WO7v4fuYEcDvNGL4Vjb3tftWGZp
         Q1brsJpiu/jiLn7ic0Q4l4IHzWCDwLlfjZaBHHOkShXiK8BrcbDNcr9kE4dAo+5+L2FN
         XQbehs5xStKB000XmxuDoESlhRiImo/EGYIlrIjnN3yMzYG4GLbEc0WlPdwXmiqfl9YS
         H764GjsEGJNAY+zD17v29UWkkiwMZaFJ+sTpFt9+O4+Xv1TucdvL+vdys4OQWzPq/XRL
         0FffUUFhfaCkL644pwYU5V/TjIE8yjIEN+rWqKXnDmm9bZ6oSQe06dzkMbqbmEjhyPE0
         4mEw==
X-Gm-Message-State: AOAM532hi/870ktU52GrovMsJBOlOOeevji3wh79czlC3fClDeo7sTCa
        /b+cFKAT6bLHG2m47O77SHOZE9cN9pM=
X-Google-Smtp-Source: ABdhPJxSfQi4Gm6L0e5OgJnp0pGWciYJya9U4UxnVmViyBnSJS6r7wUuOrrtWNamOY97VBJ+Uj0k/w==
X-Received: by 2002:a37:6589:: with SMTP id z131mr5440931qkb.235.1592766481751;
        Sun, 21 Jun 2020 12:08:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.155.207])
        by smtp.gmail.com with ESMTPSA id h8sm12852426qto.0.2020.06.21.12.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 12:08:01 -0700 (PDT)
Message-ID: <5eefb011.1c69fb81.9a90d.c39a@mx.google.com>
Date:   Sun, 21 Jun 2020 12:08:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8548379448607460851=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, noah.pendleton@gmail.com
Subject: RE: [BlueZ] src/shared: update uuid16_table to latest
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200621185618.214415-1-2538614+noahp@users.noreply.github.com>
References: <20200621185618.214415-1-2538614+noahp@users.noreply.github.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8548379448607460851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
6: B1 Line exceeds max length (83>80): "https://www.bluetooth.com/specifications/assigned-numbers/16-bit-uuids-for-members/"



---
Regards,
Linux Bluetooth

--===============8548379448607460851==--

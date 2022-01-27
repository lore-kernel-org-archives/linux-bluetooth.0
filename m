Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94178C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 20:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbiA0UzB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiA0UzA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 15:55:00 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E517C061714
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 12:55:00 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id m9so8267975oia.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 12:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=habets.se; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=TzO/pAHTFxUkBy/+D7GcuQ9gt24iddkHPcBvzyYhXps=;
        b=G2PwuD878DnBfAq+B71jYqWUfJTAgEaS+ET+/eaQFbH2RTDZIfxWs/7QT7NE6bTRYW
         sVJNmCtoCyERzR4N9HfBcAjisSfE0JjnvWESqH/HRUeGnQpzN6uKfRiT1r8iPsIgW2nl
         sxy0ltaz0lT264YpYE1t962K38OKQ2Z3rbTUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TzO/pAHTFxUkBy/+D7GcuQ9gt24iddkHPcBvzyYhXps=;
        b=ObzCZamTPUyqoA/WEzAkvU7bRjKPQChuqRWwUZvcRkSYlzD3oZkFJepIwUPCJiQtEX
         jKLfISMxRBxreslYDDcfB9YT4+p5B7mFoNw3h+yKetm2LlG4AeBOvQG7y3H9iOd6klU2
         AvT8WBUugYGdn3Jx5yjHh9V2Ju/kK2lWH3uq+C9fi9ppWZFq0Jk0/8MEVojJf9fE1v4w
         VpIAuBM0HwqH1nqlILPbwHM48KeBxVKanIkfWNtE+Bfbg9O2JFKrsyp54gaCqTsQ6TwG
         EJi9CAzitMA2twOqd+XmYDagxBIw/IVP5h/iszap989nVbG/4POB4c4wr7FRKF+Qy4kM
         x5/Q==
X-Gm-Message-State: AOAM530DkKkBa2L4n5GxpREuhKKYRGor7EF1t16v+AFwx4HE8ee4D2y0
        /oqDpwUT7TzPYxPGmrUtvLhqJFasFTeGWB9ZN5nDnDpagsw=
X-Google-Smtp-Source: ABdhPJwfy2onv0imZ6/+9/G70db2sU42MeeWDP1FWcB/mMw1r6903PVbCy/C2Fq3b1e32zBL/cwq7s/vMJmIria1Uvs=
X-Received: by 2002:a05:6808:238f:: with SMTP id bp15mr5100786oib.147.1643316899366;
 Thu, 27 Jan 2022 12:54:59 -0800 (PST)
Received: from 195210475306 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Jan 2022 12:54:59 -0800
MIME-Version: 1.0
From:   thomas@habets.se
Date:   Thu, 27 Jan 2022 12:54:59 -0800
Message-ID: <CA+kHd+e5-XoxCGwBSDh1W1L0nZ3tRoj5XZMbkOLFnd_8De7OkA@mail.gmail.com>
Subject: rfcomm watch busyloops taking 35% CPU on RPi4 (simple bug with fix)
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since forever[1] (2006) rfcomm watch has busylooped checking every
200ns for either SIGTERM or subprocess exit.

This doesn't need to be 200ns. It can easily be 1'000'000 for a full
millisecond.

On my raspberry pi 4 it takes 35% CPU as-is (doing nothing else), and
"basically nothing" when I set it to a ms or ten.

Line 248 of tools/rfcomm.c should be:
    ts.tv_nsec = 1000000;
(or more)

[1]
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=f64cc95873c872ad5a34abe6418a2e26570d5d02

--
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.se" };
  char kernel[]    = { "Linux" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "9907 8698 8A24 F52F 1C2E  87F6 39A4 9EEA 460A 0169" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

Return-Path: <SRS0=GZqV=NC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21900C004D3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Oct 2018 12:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363F32064E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Oct 2018 12:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="vAXShku8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363F32064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeJVVOL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:14:11 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:39080 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeJVVOL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Oct 2018 17:14:11 -0400
Received: by mail-lj1-f175.google.com with SMTP id p1-v6so36858061ljg.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Oct 2018 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XoJrgc6CfRQEyyu3nFAjsJ4lWvtZD58f849RpurW3U=;
        b=vAXShku8CjIXXXM/unVthUNiEYa9i6LvN1GYahHn5iX8UPZovtqA8iGW/o46Ns5i+s
         nOgfzz51mL4hcZdmYUv4DbdjmfItdH2rbKsdnlm5meY5NbsusFMLaApI6dpPc2hFLc3k
         eqe0/Bb0xGWiuaq0mHquErI1IG8RBOLF0wzn7AxkgaYtkHBB4QwIMQwnavLvCNMJaDbW
         pZ+XF1KZFZlzwBAfQLgI+oM9XHZhG7gcgXB3rNjBNUx3Gnbak/cUpMOFVcTVXX0XHMl/
         zuD3N+AVX00EK9s+aWE2VQXLjpe2PP3HZIdYdAuPiEVJ6PQ9qe9yWfKVu30t9iH1GOBU
         lz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3XoJrgc6CfRQEyyu3nFAjsJ4lWvtZD58f849RpurW3U=;
        b=mANfz5I/lOL1CLDDw1bKJWOtA7vgdYG6bVxw/lomRnAVcVjAt0f+pAHiyQvdZuKrEK
         x5HU9Ssp8tz1s2ARr/ZKxk4iFERixn+C5pz/PQJ8DdqdYv8z8MCOCa96zKixhUA0jl5R
         hOO/C6wWt1QmDAVv4YRFnLp1J76ApDUKZUkAwP3OQBZPDC940aytb17boE/lrm0H+7xJ
         Dc4PlnshjQq4xsj0+wsaeHN8N+QTMaNTmJYgTcqZxT6pWNPMJpJSsYyKHbocINqvvWq2
         qEPbSpcrKAIcKzDn6RzcjxjBUQa/NwPgmY224R9lOWlePEPCGU1EIPHfeob5+/iwtmIi
         x2BQ==
X-Gm-Message-State: ABuFfohBtUov0SmYn4hhWRNwPY1Lv/qqbY0HZDxNt+lA8rkwVeKM4z4X
        BPF0CdxtDLsevWKqA7fui9oNQWdWli8=
X-Google-Smtp-Source: ACcGV61lylzx4ZZDy9IcdrkedvUybAtJTrBAvmLATBc0meckhuoEyugxe54Bzow4HRyQVKrCySq03Q==
X-Received: by 2002:a2e:8884:: with SMTP id k4-v6mr29192782lji.145.1540212940916;
        Mon, 22 Oct 2018 05:55:40 -0700 (PDT)
Received: from ix.localnet (ftth-nat-91.ip4.greenlan.pl. [185.56.210.91])
        by smtp.gmail.com with ESMTPSA id y80-v6sm6894723lfd.78.2018.10.22.05.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 05:55:40 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     el es <lsharkey602@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: Connection to phone drops after a few seconds
Date:   Mon, 22 Oct 2018 14:55:38 +0200
Message-ID: <11670278.PMD1t7p2ff@ix>
Organization: CODECOUP
In-Reply-To: <CADC+9YC41FbhWCNF7Df3tKH7KAgxH0mXcQY5Xg3fAksJMz-9Rw@mail.gmail.com>
References: <CADC+9YC41FbhWCNF7Df3tKH7KAgxH0mXcQY5Xg3fAksJMz-9Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wednesday, 17 October 2018 21:26:57 CEST el es wrote:
> Hi,
> 
> I have been trying to connect to a phone with bluetooth to use dial-up
> networking.
> 
> Pairing is successful, but the connection drops after a few seconds.
> No mobile connection shows up on network-manager.
> 
> I have attached some output from syslog, and the main error seems to be:
> 
> Oct 16 17:37:47 luke-Satellite-L635 kernel: [  121.005940] Bluetooth:
> hci0: last event is not cmd complete (0x0f)
> Oct 16 17:37:47 luke-Satellite-L635 bluetoothd[809]:
> src/adapter.c:dev_disconnected() Device 00:19:2D:04:02:64
> disconnected, reason 2
> 
> The bluetooth adapter is recorded by lsusb as:
> Bus 002 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd
> Bluetooth Dongle (HCI mode)
> 
> Is there anything else I should do?
> 
> I am not sure what other logs I should attach, but I will happily do so if
> told.
> 
> Thank you,

Link is disconnected after few seconds when no profiles are connected.

-- 
pozdrawiam
Szymon Janc



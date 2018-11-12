Return-Path: <SRS0=dtqE=NX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B249C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 03:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013A9214DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 03:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihr2S0Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013A9214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeKLNek (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:34:40 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:33275 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKLNek (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Nov 2018 08:34:40 -0500
Received: by mail-ot1-f50.google.com with SMTP id i20so294566otl.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Nov 2018 19:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=x7TnNgZ9m1uypAdndP421igOFPDJilut3HQyljyvy6I=;
        b=Ihr2S0Syfm+++tKVeCktQ+1NScvD0ssm67CPCJ1rO/K3f+0cPmT2IRtmDgBm3EEQ0A
         oMfEnnKEJlyDAKMCxa7/Yrh7PwqkBM0DtR/ujf9nJ5Ay+BkIA7z7NhEZ3ejYDikegkSP
         uTU/5QlsFpSS7tNuNrAfjdBWGj/XDHRg4LUx26ruDhv+kj10TFHqTlq9ql+eLvGNT8X4
         57nBsvZSiTgyK78gA7XndogIe3aWoYBCy1Ume130foJDBy27/0Cdp/eWfBtmJUOE50HZ
         z6VeGulIf7JWjERDrQ889EQKHAoRBYhBquJMrIMxqQSwPRgaJAj+ZVsuqSAFYdv+KHEx
         +beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=x7TnNgZ9m1uypAdndP421igOFPDJilut3HQyljyvy6I=;
        b=RBGfD4FQZv1yjrbGzyS5dzv783ahYVMo2fT+B4/tMK/FT25Q/mDLZJpfzL00rrKYh3
         FVbOboNoYghOiIOQDmhLm/WpOKNvJpvUtPqeFKleDpbq6ET5JP3ZSyV0bVIeqov3Zm50
         A3/f+0envkN4F7tqDFuT5vU+LkIOmQkDGwFLYpY2vewGZlUUSjgF4MqyX2xjQyt+zOND
         7lzEAqHwr6scsgt70plNahcGHyPWKfKngcuDoXC29pA3M1CY0SdUM6Ylaa418ut4mjf6
         DMcB17JP+QpKp1v0CEVtm8c3maaIX7rJtVXI7AV5fCGYD6d9aW76T/yYQEmCyvyREKK6
         0BFw==
X-Gm-Message-State: AGRZ1gL8pMOdlTdunXmhEep+H3DqgXd3+ZAvoxTXKaeZLEpRinl+Y6Tj
        DzSL5WoLS62KkJS7b+ZHdo2xjMFwwPtSrlOmVahamqbP
X-Google-Smtp-Source: AJdET5cAi+xCKp1nojJq4rQUmAte/FQoGf1AhCHz9U8dRXjU8EkWR/jO75Y2aVXFxphzodEqtxbSH3YThHUAtiaUqaA=
X-Received: by 2002:a9d:4f0c:: with SMTP id d12mr11542127otl.302.1541994206184;
 Sun, 11 Nov 2018 19:43:26 -0800 (PST)
MIME-Version: 1.0
References: <CAKz1w-==yXd4EL39ULE6bcYU3fTpZB9D0EqdgRhq4L38kVzYEg@mail.gmail.com>
In-Reply-To: <CAKz1w-==yXd4EL39ULE6bcYU3fTpZB9D0EqdgRhq4L38kVzYEg@mail.gmail.com>
From:   Dylan Taft <dylanetaft@gmail.com>
Date:   Sun, 11 Nov 2018 22:43:15 -0500
Message-ID: <CAKz1w-kFDGH-zfYu1GjoJqfs+9uvHvxnG=qwgj8EscAidDNd1w@mail.gmail.com>
Subject: Re: Odd l2cap_sock.c Code?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sorry, I went cross-eyed looking at setsockopt\getsockopt.  Both the
new code and old code do not allow it if the socket is connected, but
the Bluetooth spec does it looks.  Is the only option on receiving an
MTU REQ to drop the connection and re-open with a lower MTU?
It looks like this in an hcidump, what I am referring to.  That MTU is
lower than the default of 672.  The spec says not dealing with it
could lead to problems.  Could the MTU specifically be allowed to be
set on an open socket to no ill effect in the kernel?

< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr 00:0B:57:7F:72:BF type 0
    interval 96 window 96 initiator_filter 0
    own_bdaddr_type 0 min_interval 24 max_interval 40
    latency 0 supervision_to 42 min_ce 0 max_ce 0
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 74, role master
      bdaddr 00:0B:57:7F:72:BF (Public)
> ACL data: handle 74 flags 0x02 dlen 7
    ATT: MTU req (0x02)
      client rx mtu 247

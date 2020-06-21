Return-Path: <SRS0=Pq0q=AC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB15C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Jun 2020 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAC025226
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Jun 2020 19:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXp4SvI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgFUTIB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgFUTIB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Jun 2020 15:08:01 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60D0C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2020 12:08:00 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z1so11135939qtn.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2020 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=cDHyAgBiLzCDSpxcuOp9to5hpXfNRPLhIQjFQaF79Yo=;
        b=aXp4SvI6Xqn8zRvT1wdwdagv5gfs7lrVDYRoPGWRBhJak9O7mTTXoc0QJz0w3H/v9o
         Rwb1BbyAa2Eq+YPDmCbiJxO5+wkGFF+zsS4b/aTSj6oUeLUjL+4AsBZzC/pQFIU2Dao3
         PTAFk66MU1Ms+cbSqlwaTtNkHdAt0x9V5lKQEYjIACWyH0W+nRWvvrirYnGeQ2h4uyrx
         hrR8z3v1/ZBd2KKT3D6+WlcFmg9Xzl7eOzl/ZoBI3BZAckAkSagUUePxcZHelzNM8NNx
         FRbGLdX+85isaRWr19QRC4VbkcGWLoJy7wQ3MFMS45TJlMa7gEJFIGEP6E8/qsf7o74V
         OrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=cDHyAgBiLzCDSpxcuOp9to5hpXfNRPLhIQjFQaF79Yo=;
        b=WqSrSiA/hw0NvZNNDco7iIC86CS5lUzU/x6YvAv655ZNkzETv4kh+4eeT0ee4B1Ex7
         Duh3JR/lwuYXN3XwlxVBQFJZsOyKq474AjwNVzxDNkpXshmlV5kQX6K7ZyZ+LQbGNIGv
         4B2T7n7J+o0xO0uckfDT+6ovkzA75MzPHwKk/N4tvPMXJgFZj05H31TF/BytT3puQcfE
         qEe86+2rn3oYabNTBuBwH3ZotvP0kLmzdQfftPwxYGobefsJmfpVJBmxBZhTbohRupVi
         UtxJQayf8LrsuWdUNqVojccWt2WRrVDjSXMxwaPGGbv9TFsF4N7dm6/WJNtoGfmjYqys
         TcCA==
X-Gm-Message-State: AOAM53028FJHZykjGdvPq25aRYUNTIG3Zv3OhbBU6k64mJL9FSHXMhCa
        41hcv1KbgojW+gXnk4TL3rPXhfWElaA=
X-Google-Smtp-Source: ABdhPJxb65gav5Mwq/Q0pR2uc13Yfr4W0eP852Cik7QXafWQASGiznjfjJH5FPqpXwuErIozy05m2Q==
X-Received: by 2002:ac8:4806:: with SMTP id g6mr11866000qtq.213.1592766479562;
        Sun, 21 Jun 2020 12:07:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.155.207])
        by smtp.gmail.com with ESMTPSA id p44sm14073235qta.12.2020.06.21.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 12:07:59 -0700 (PDT)
Message-ID: <5eefb00f.1c69fb81.9d779.1975@mx.google.com>
Date:   Sun, 21 Jun 2020 12:07:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2855206913963054636=="
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

--===============2855206913963054636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

ClRoaXMgaXMgYXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRoaXMg
ZW1haWwhCgpEZWFyIHN1Ym1pdHRlciwKClRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGUgcGF0
Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4KV2hpbGUgd2UgYXJlIHBy
ZXBhcmluZyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5n
Cmlzc3VlL3dhcm5pbmcuCgpUZXN0IFJlc3VsdDoKY2hlY2twYXRjaCBGYWlsZWQKCk91dHB1dHM6
CldBUk5JTkc6Q09NTUlUX0xPR19MT05HX0xJTkU6IFBvc3NpYmxlIHVud3JhcHBlZCBjb21taXQg
ZGVzY3JpcHRpb24gKHByZWZlciBhIG1heGltdW0gNzUgY2hhcnMgcGVyIGxpbmUpCiM5OiAKaHR0
cHM6Ly93d3cuYmx1ZXRvb3RoLmNvbS9zcGVjaWZpY2F0aW9ucy9hc3NpZ25lZC1udW1iZXJzLzE2
LWJpdC11dWlkcy1mb3ItbWVtYmVycy8KCldBUk5JTkc6TE9OR19MSU5FOiBsaW5lIG92ZXIgODAg
Y2hhcmFjdGVycwojMTMxOiBGSUxFOiBzcmMvc2hhcmVkL3V0aWwuYzo2NTI6CisJeyAweGZlODcs
ICJRaW5nZGFvIFllZWxpbmsgSW5mb3JtYXRpb24gVGVjaG5vbG9neSBDby4sIEx0ZC4gKCDpnZLl
spvkur/ogZTlrqLkv6Hmga/mioDmnK/mnInpmZDlhazlj7ggKSIgfSwKCldBUk5JTkc6TE9OR19M
SU5FOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTMyOiBGSUxFOiBzcmMvc2hhcmVkL3V0aWwu
Yzo2NTM6CisJeyAweGZlODYsICJIVUFXRUkgVGVjaG5vbG9naWVzIENvLiwgTHRkLiAoIOWNjuS4
uuaKgOacr+aciemZkOWFrOWPuCApIgl9LAoKLSB0b3RhbDogMCBlcnJvcnMsIDMgd2FybmluZ3Ms
IDQ1NSBsaW5lcyBjaGVja2VkCgpOT1RFOiBGb3Igc29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0
cywgY2hlY2twYXRjaCBtYXkgYmUgYWJsZSB0bwogICAgICBtZWNoYW5pY2FsbHkgY29udmVydCB0
byB0aGUgdHlwaWNhbCBzdHlsZSB1c2luZyAtLWZpeCBvciAtLWZpeC1pbnBsYWNlLgoKWW91ciBw
YXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuCgpOT1RFOiBJZ25vcmVkIG1l
c3NhZ2UgdHlwZXM6IENPTU1JVF9NRVNTQUdFIENPTVBMRVhfTUFDUk8gQ09OU1RfU1RSVUNUIEZJ
TEVfUEFUSF9DSEFOR0VTIE1JU1NJTkdfU0lHTl9PRkYgUFJFRkVSX1BBQ0tFRCBTUExJVF9TVFJJ
TkcKCk5PVEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFyZSBmYWxzZSBwb3NpdGl2ZXMsIHBsZWFz
ZSByZXBvcnQKICAgICAgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlIENIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK

--===============2855206913963054636==--

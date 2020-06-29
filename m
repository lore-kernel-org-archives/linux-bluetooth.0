Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F60C433E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C8E20776
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/ABWZqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgF2XT4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbgF2XTv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 19:19:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF7DC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:19:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b185so6356743qkg.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vLldCdJwvdLpnSWDwt6STIK/xZGjzsrb0svyCFh1Gqo=;
        b=I/ABWZqx4KSXrUWKq/I4LCQ8tY3Hb8IKxkUmHsTc/OGHxXIcECs2hhsPmWTrpL7PMe
         JP8ZLojatM90RkVkROLLOD0yKtxwHP7go17j+2NTcDNDM3B24grI9lRmgslqgeVTg/9r
         QNpBIFQ7nqbpMpp9xOoDNgtk5ztjYsVhMPxhL3FhMQROG42DUExnzQCUOpnxG+aoPJxJ
         0yM2qjiGuy3UfLq++Uq839mcPJlML3PQY3kUSnZ+7Ja086kwuyeLWdR3qahiDkIj7Xyd
         XxuAx3ejurbXa9h/Hq2kEDFEFTbN6FKHXn6BIQVRTLDIptn4hl5Sg2EbUtz/Yw0w7F5D
         AdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vLldCdJwvdLpnSWDwt6STIK/xZGjzsrb0svyCFh1Gqo=;
        b=F0JraZ4J7iC3kz3nPRY89e33Ng5W2kZZR6faLs5m1gM5MItTgGOpcYI9UqK+MthDWQ
         q29aMpi9EAFstyEtghSIsZyZy/nWsNiX6ueqTovqJjmZYfX5m39QYfhhXIps4Fk8aE2E
         QkJMqn9JcbjEPuu3AAUuJKW8HQ3z7R0mUgtZczlpZn5fjgK9zCPkG1QxqY/0nl7MhgT8
         C808OAmLTqxyrqJN7v9nmnZz/nR7PH5ZrDNC5BsKN175VPGafUye2Czeh2VQAqSDm+oK
         xegbyhBFzliKrmmauWrYLGjEB977gtuH3JpK/OqKEVEQS29jjAoyXa+TM2NHuGTwtuNV
         B6eA==
X-Gm-Message-State: AOAM5326ayzt0uHBAm46AwEE0nhnPWmNzHqOPJRfvAhHPg33RKDQxZZw
        D3jbCG5Put2qKUGXlsGsRSiYp4DQWEM=
X-Google-Smtp-Source: ABdhPJzV0PSOEMJq5LRWqy6wjW8VnOKLxv2etDRQmt2aaznAiA9KusVtfoq0HUAsF191Mhkz9v+VKA==
X-Received: by 2002:ae9:ed86:: with SMTP id c128mr17680338qkg.475.1593472790545;
        Mon, 29 Jun 2020 16:19:50 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.198.18])
        by smtp.gmail.com with ESMTPSA id o145sm1417086qke.2.2020.06.29.16.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:19:50 -0700 (PDT)
Message-ID: <5efa7716.1c69fb81.c56a8.6cbe@mx.google.com>
Date:   Mon, 29 Jun 2020 16:19:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0479134367170190409=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@chromium.org
Subject: RE: device: Allow devices to be marked as wake capable
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200629160206.BlueZ.v6.1.I3a6c238b09e1a0fad69e69cc2e6f4063af989b37@changeid>
References: <20200629160206.BlueZ.v6.1.I3a6c238b09e1a0fad69e69cc2e6f4063af989b37@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0479134367170190409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

ClRoaXMgaXMgYXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRoaXMg
ZW1haWwhCgpEZWFyIHN1Ym1pdHRlciwKClRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGUgcGF0
Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4KV2hpbGUgd2UgYXJlIHBy
ZXBhcmluZyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5n
Cmlzc3VlL3dhcm5pbmcuCgpUZXN0IFJlc3VsdDoKY2hlY2tidWlsZCBGYWlsZWQKCk91dHB1dHM6
CmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQgKHNlZSBg
VScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQgKHNl
ZSBgVScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQg
KHNlZSBgVScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1
bHQgKHNlZSBgVScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRl
ZmF1bHQgKHNlZSBgVScpCnNyYy9kZXZpY2UuYzoxMzQ4OjY6IGVycm9yOiBubyBwcmV2aW91cyBk
ZWNsYXJhdGlvbiBmb3Ig4oCYZGV2aWNlX2dldF93YWtlX3N1cHBvcnTigJkgWy1XZXJyb3I9bWlz
c2luZy1kZWNsYXJhdGlvbnNdCiAxMzQ4IHwgYm9vbCBkZXZpY2VfZ2V0X3dha2Vfc3VwcG9ydChz
dHJ1Y3QgYnRkX2RldmljZSAqZGV2aWNlKQogICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4Kc3JjL2RldmljZS5jOjEzNjY6NjogZXJyb3I6IG5vIHByZXZpb3VzIGRlY2xhcmF0aW9u
IGZvciDigJhkZXZpY2VfZ2V0X3dha2VfYWxsb3dlZOKAmSBbLVdlcnJvcj1taXNzaW5nLWRlY2xh
cmF0aW9uc10KIDEzNjYgfCBib29sIGRldmljZV9nZXRfd2FrZV9hbGxvd2VkKHN0cnVjdCBidGRf
ZGV2aWNlICpkZXZpY2UpCiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpzcmMv
ZGV2aWNlLmM6IEluIGZ1bmN0aW9uIOKAmGJ0ZF9kZXZpY2VfZmxhZ3NfY2hhbmdlZOKAmToKc3Jj
L2RldmljZS5jOjY3NDI6NjogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDigJhp4oCZIFstV2Vycm9y
PXVudXNlZC12YXJpYWJsZV0KIDY3NDIgfCAgaW50IGk7CiAgICAgIHwgICAgICBeCmNjMTogYWxs
IHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6
OTIyMzogc3JjL2JsdWV0b290aGQtZGV2aWNlLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmls
ZTo0MDEwOiBhbGxdIEVycm9yIDIKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAo=

--===============0479134367170190409==--

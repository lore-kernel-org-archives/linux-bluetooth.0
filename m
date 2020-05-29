Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B1EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F16E2073B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZkeUEWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgE2PLs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2PLr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:11:47 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7AC03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:11:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 205so2495114qkg.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=mnIVdYHraWlDOh6t/3GjoyvorhUbkvb5+wwZhrss4P4=;
        b=SZkeUEWNXV0q2RkrdbTY6JDc+GwT+TzkT46Ztop1Tu7/uTKsQaeltYupIfxBCNpH3H
         uBqeg4Ie9dMQjLHrjsA7+AKU4rtYG2HCJmjuB8Hx3OWeVi3hXrV98IKbgoTIekMrILWR
         6XIz8y+s4XXJ6JP63jMa/z3Prl5aQh9qQEUQ+m4OSJ8VE3ftH2Sb34EzEvPANaLd99UA
         S2vWqfotMc+QV2/1iYCvXIt0gGz6bk6XiCqvC0/4xZ+YOxu5kbcwF7LQliqsnS3qc35Y
         dlF3wcLfBT/vRlVGkYDhSI3vzbBnXWC94lQ9GZw/ZikF2KnU7xR5fH0ZgQDc+Pbkpb3i
         WXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=mnIVdYHraWlDOh6t/3GjoyvorhUbkvb5+wwZhrss4P4=;
        b=kBcnL6GEthShthvwCIo3JxKNSDgSdT5e9yWOb3rZg6F/nw7y1aw2JVMm43NnH+BtDC
         hhxC5jhrv1EQPkXWd5z08A/Xc5nb/BFsOeQewOS8WzHZm7Vb1mnWAwW3WmY1ZBXdRsyW
         LHVa0HoG9PWfruSoLrDgfNcEZf0aozMs1UpZ7RoUV+sgSdSXZbvyP9Ehyi2qY9WLFUgS
         8LLISQWph/WP7OeevrNfqbdxNPKiLmGQ0OD9pQ29/14kzs9DnN64346bVw4NyjWXmwTS
         x3oJB+Wvn8D99cgKIlIOM88Zr4Fu8xNKgLvJiUPY04uGmltZ2KLe6hGJiklEENSyPMzR
         ZzaA==
X-Gm-Message-State: AOAM532G6cjoprI8j+MVaIVkUdPLLo/7MDvztMKk48iZta+5MSAOgZDI
        kTBxWKsBwG3vGBkriJU6HEiGl8DL3/s=
X-Google-Smtp-Source: ABdhPJxIw1v7tmoJeWaPR54K5OcGs5W2m91okRTfomqkbWiRpnMKFAbv01T6Mp5abC/TQiJRTJVqgw==
X-Received: by 2002:a37:ec4:: with SMTP id 187mr6847062qko.124.1590765106408;
        Fri, 29 May 2020 08:11:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.58.192])
        by smtp.gmail.com with ESMTPSA id i3sm7660113qkf.39.2020.05.29.08.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:11:46 -0700 (PDT)
Message-ID: <5ed12632.1c69fb81.49c2b.d0a1@mx.google.com>
Date:   Fri, 29 May 2020 08:11:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3719385989422049495=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: Load default system configuration from file.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200529145007.198906-2-alainm@chromium.org>
References: <20200529145007.198906-2-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3719385989422049495==
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
ZmF1bHQgKHNlZSBgVScpCnNyYy9tYWluLmM6MTUzOjE4OiBlcnJvcjogaW5pdGlhbGl6YXRpb24g
ZGlzY2FyZHMg4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBb
LVdlcnJvcj1kaXNjYXJkZWQtcXVhbGlmaWVyc10KICAxNTMgfCAgeyAiQ29udHJvbGxlciIsIGNv
bnRyb2xsZXJfb3B0aW9ucyB9LAogICAgICB8ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06
ICoqKiBbTWFrZWZpbGU6ODkwMTogc3JjL2JsdWV0b290aGQtbWFpbi5vXSBFcnJvciAxCm1ha2U6
ICoqKiBbTWFrZWZpbGU6NDAxMDogYWxsXSBFcnJvciAyCgoKCi0tLQpSZWdhcmRzLApMaW51eCBC
bHVldG9vdGgK

--===============3719385989422049495==--

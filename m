Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B65220760
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NOta7Ln0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgFJUqU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJUqT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 16:46:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E10C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:46:18 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id a80so1880884ybg.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=imTvAOhXxKVRGugcNxcFffBWjqbY7N6t48KwCHBUVPo=;
        b=NOta7Ln0zXidtXYHMqtKBoimAd3g4ABjrYO9OwKCJ1DUNysBU0oGk+bmQksAyhC35o
         um7lcPHcdHmSPaijEYSp4WBnyXvx1d6+W74acPtEuL7yMATgXX2/YLiBHTFsZpc12GHX
         fwigy1+bezarUB8ZWDD/vDEasGAqFSaP8S3FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=imTvAOhXxKVRGugcNxcFffBWjqbY7N6t48KwCHBUVPo=;
        b=HpxCheu5fQxaB9lrsFdH477ZDwDXDe4UiblqxnAD+yuL9MhSxCbmhVIiS7s+iDzJ+X
         8YwHDgH3Eh25SYoUtTcdFOU0PIDKqSqy5HHIJ01EnuGrZLAHUD5iBHQHPanURqtYqRfA
         rlvOm+eIqYQQz58MXs6yuIo0+7D3mxJj/fZjcQ9ueWVDLaamXCrLeu+I1OJ1i9daEuJl
         /UNCjbY/BFdpBcoD2u8/pGaxvc9PuWTiTp32apgz+moOMN5BLi4WQhCUJM+1CsFdrqdW
         pDwyUqJpYXbQLQbkjnsgvt1hn485h9u9mXIhPoykbigMeEg0vJqnUyG1K6bazMdXZetY
         t+7g==
X-Gm-Message-State: AOAM531wOgh2OAyjPmhOet7yaaR6R0gwPgkSViJtKsOmfF6qdfykiAm6
        LBA8m3NQ5Iz31UhJCR//JiGeVPF+ZdOK1LQcMRIFArujso8=
X-Google-Smtp-Source: ABdhPJxG9es5oPb4MMLzuvDhcsauZvcw0v1F3OXx2JXtCteUfsiLyq5pGdYFvNZ5ThYNFil8RZ3MAMm3xzoevKRHmwU=
X-Received: by 2002:a25:49c4:: with SMTP id w187mr6486026yba.211.1591821977928;
 Wed, 10 Jun 2020 13:46:17 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Winkler <danielwinkler@chromium.org>
Date:   Wed, 10 Jun 2020 13:46:06 -0700
Message-ID: <CAKc116CHjs=hOLxz-76DxQpU-sSML1yxRnACuTCoOuCh3nFNog@mail.gmail.com>
Subject: Requested feedback for new advertising MGMT command
To:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Linux-bluetooth,

We are working on a feature to allow advertising clients to customize
both advertising intervals and requested tx power for each registered
advertising set. It is clear that the existing "add advertising" MGMT
command is not sufficient for these new features, so we have narrowed
it down to two options for the new interface, and hope for your
feedback:

Option 1 replicates existing MGMT command, and in addition provides
new interval and tx_power members.

#define MGMT_OP_ADD_EXT_ADVERTISING 0x00??
struct mgmt_cp_add_ext_advertising {
    uint8_t  instance;
    uint32_t flags;
    uint16_t timeout;
    uint16_t min_interval;
    uint16_t max_interval;
    int8_t tx_power;
    uint8_t  adv_data_len;
    uint8_t  scan_rsp_len;
    uint8_t  data[];
} __packed;

Option 2 packs the data into a flexible TLV data member. This allows
unused/unnecessary parameters to be omitted, and also allows for
future addition of functionality without redefining the MGMT
interface, for instance when more of the extended advertising features
are enabled in userspace.

#define MGMT_OP_ADD_EXT_ADVERTISING 0x00??
struct mgmt_cp_add_ext_advertising {
    uint8_t  instance;
    uint32_t flags;
    uint8_t  tlv_data[];
} __packed;

Feedback/comments/concerns are highly welcome, thanks in advance!

Best regards,
Daniel Winkler

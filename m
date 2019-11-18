Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAAEC432C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 20:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA07E222A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 20:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A4ZDm7gB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKRUPy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:15:54 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:36364 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfKRUPy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 15:15:54 -0500
Received: by mail-pg1-f171.google.com with SMTP id k13so10161725pgh.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vx04uAAhmTJ193O8Kcs44XNMxG/d0kDvX0+WooeKwRI=;
        b=A4ZDm7gBw3Oq2PHvF7Nu9Q65CzMLkadM55DVviUkin2bnPu8VlV3WUG8mOdt+I1CXH
         re+rNz0TNEpNOvvGUoPDuPAQlCh98ufSQKCtVHpTeW2UabRADBG0u1ZCjZP3kNXxMC4a
         LyjmdSOhzUpj4DWw+FQqcXEn/EyzlQjRQgI6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vx04uAAhmTJ193O8Kcs44XNMxG/d0kDvX0+WooeKwRI=;
        b=hqsIOQOaVPuo2+dzWI5JHjYhCTrbAHIpUUW2CTjha481lCSllFn5HEpKwHa9hTxQjZ
         PeBYWrfsRvofrSG2WpAUorgIXSFaHFG4L/pqsVStEViiFEz7dKEu+MRkKmEEFgOV60b8
         9UAN12J1Y7xMjeZMk3dxOpIBwjWxh1UREw7V5EHf6aVDo4k7FCY0QEWuXBXNx/CaenV+
         8PckVriXHddQZfD3Wct/SQm+ZlvzVCDfXYbvXFF04aJBkNJ5xYKkicdrsUr4JsHwog2Y
         yc94iHR7T2RnYxpe2lqaEv175we0FSnr0MEPWnb/lF9s4UZwl6njbW1I8bP/nnNylOdW
         GQLA==
X-Gm-Message-State: APjAAAUq4aGYuUcPXO14wh8UnQdvxK5XqcNnJOBjMeCnvKxF69aNR9Mq
        If3XhrXr+wP2S9SrV8TGbOQ8rf4fLEY=
X-Google-Smtp-Source: APXvYqzAvg4DvjlGJ6Ih/qGGLkG+hk97ybi3O0Pb3mgixYUgPUFExX4fNIP+OGOuXPpGvmzkmHv6nA==
X-Received: by 2002:a65:41cd:: with SMTP id b13mr1206869pgq.385.1574108153346;
        Mon, 18 Nov 2019 12:15:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id k103sm307468pje.16.2019.11.18.12.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 12:15:52 -0800 (PST)
Date:   Mon, 18 Nov 2019 12:15:51 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andre Heider <a.heider@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: "local-[bd|mac]-address" inconsistency?
Message-ID: <20191118201551.GJ27773@google.com>
References: <57775d51-7de2-a32c-8b23-aba611483f51@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57775d51-7de2-a32c-8b23-aba611483f51@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andre,

On Mon, Nov 18, 2019 at 09:20:35AM +0100, Andre Heider wrote:
> Hi,
> 
> when passing both addresses through device-tree in the same way:
> $ hexdump /proc/device-tree/soc/ethernet@5020000/local-mac-address
> 0000000 0702 3d96 53d4
> 
> $ hexdump /proc/device-tree/soc/serial@5000400/bluetooth/local-bd-address
> 0000000 0703 3d96 53d4
>
> I get this for eth (which is consistent with u-boot):
> link/ether 02:07:96:3d:d4:53
> 
> But for bt it's in reverse order:
> Controller 53:D4:3D:96:07:03
> 
> Is this intended?

Kind of.

In both cases the address is specified in the binary format used by BT/NW
stack.

When BT addresses are printed they are converted from LSB to MSB.

> Do I really have to pass the bdaddr from u-boot in another way?

One could make a case that we don't care what the 'internal' format is and
that the BD_ADDR should be specified in MSB format in the DT, and the kernel
would be in charge of converting it to LSB. However I fear it is too late to
consider a change at this point, since the binding has been in the kernel for
6 months with the current format and existing devices may rely on it.

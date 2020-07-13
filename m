Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8DFC433F2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 08:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BBD2073A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 08:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3xy2owN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgGMIBz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbgGMIBx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 04:01:53 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B301FC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 01:01:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id i3so9249778qtq.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EOALdvxiHqoaACfMtoifiqT35+z4bvJD1lbhLzO6lrk=;
        b=l3xy2owNKhdwuAQEGTjDc2IcKFjpt1PyHYnAb/ymiOucZj3241kOVkgdzsn6WZq6DN
         +dOfLXE8iHpPUJOAu2L8ckAEC/G2+ycz+IuHcvdOGCdatl6xbMllpa3lbZ7TkfO7+Hsi
         t3X945lVQt9CGdsHnllPFzKizYfuxGORPynlupx5Ys+lVY0VVy36thcU0EAwTi3oisIC
         3CDtIIMyVVWfJ3mz7lTEDRngVCwCFme/x3eOqyw5eG63ENpcfX1lzGKIHamTVrfcVAAL
         PIFD4/Tb3xM6wnhzQMnrf6LaDFj5hrevgf+RBfkAb8Rw36oaQiVAUO0JuDFZKBnbgKL+
         pY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EOALdvxiHqoaACfMtoifiqT35+z4bvJD1lbhLzO6lrk=;
        b=f5IG0OEjG1W1acVQx899MLHXN2G0MrLU7F94dGVCCv8mTDnAjVnj2OioQicj4/uX9M
         4Tg6H7EO6wL5CelcFsL5ikCy0ohBSYXqSXXPTsJLJOcDq/zykQ+aqfQ3Xoejki4i+gif
         H6LZP3bw49whBSujR1Fo9XsM0hgfJYeobBUrdwbQ1uZk+FVEspgMCFzpw3c82VTPBRig
         zbynz5FsBtsUGr6ldBpfvfPfORTdF+KveMlE1hSfrgvI7musVqmFRa82fvC8Wp61n9O5
         Zn6ACzum8wyQi2ys8gIJDO5Ii6OujeBvAxVBGXjcQ/t5/l+hzAf0lI1ughwlkNavNIZ4
         2/DA==
X-Gm-Message-State: AOAM531Z9gj+o4CktFoxPQqlX3KrkN/eVIxd4fGMg7QHzk+mhMUX/Ei0
        3UMfGpaIuFA5n14xOZ3+82KNBLS6
X-Google-Smtp-Source: ABdhPJxpSTpmzoC5F6sTNrOU/l318RqhIe8AUGSQaTKZfmsuZt7a7xFNTJQYUQN70vFnbFevCgD9IQ==
X-Received: by 2002:aed:2a36:: with SMTP id c51mr56496335qtd.264.1594627312638;
        Mon, 13 Jul 2020 01:01:52 -0700 (PDT)
Received: from meimei.greshko.com (2001-b030-112f-0000-0000-0000-0000-140e.hinet-ip6.hinet.net. [2001:b030:112f::140e])
        by smtp.gmail.com with ESMTPSA id x34sm17342960qtd.44.2020.07.13.01.01.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 01:01:52 -0700 (PDT)
From:   Ed Greshko <ed.greshko@gmail.com>
X-Google-Original-From: Ed Greshko <Ed.Greshko@gmail.com>
Subject: Re: Unsupported Adapter?
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
References: <5c552dc0-1ef8-ae35-b51a-b6889853d535@gmail.com>
Autocrypt: addr=Ed.Greshko@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <11921c7b-c498-38e8-c7cd-d79900803153@gmail.com>
Date:   Mon, 13 Jul 2020 16:01:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5c552dc0-1ef8-ae35-b51a-b6889853d535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2020-07-13 08:58, Ed Greshko wrote:
> I'm running the Fedora 32 disto and bluez-5.54-1.fc32 is installed.
>
> I have 2 bluetooth dongles.  One is recognized and the other isn't.
> The one not recognized is shown in lsusb.
>
> The info is as below.  It there a process to get an adapter supported?

If it helps, this is the end of the output from btmon when the device is inserted:

< HCI Command: LE Read White List... (0x08|0x000f) plen 0  #57 [hci0] 12.838744
> HCI Event: Command Complete (0x0e) plen 5                #58 [hci0] 12.839681
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 6
< HCI Command: LE Clear White List (0x08|0x0010) plen 0    #59 [hci0] 12.839696
> HCI Event: Command Complete (0x0e) plen 4                #60 [hci0] 12.840678
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: Delete Stored Link... (0x03|0x0012) plen 7  #61 [hci0] 12.840705
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6                #62 [hci0] 12.841706
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Unsupported Feature or Parameter Value (0x11)
        Num keys: 0
= Close Index: 00:1A:7D:DA:71:11                               [hci0] 12.841731

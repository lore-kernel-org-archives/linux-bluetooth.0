Return-Path: <SRS0=jKvG=Y4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BA4CA9ECF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Nov 2019 09:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D5721929
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Nov 2019 09:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWQCKSD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfKDJAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:00:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45967 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDJAb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Nov 2019 04:00:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so5686360pfn.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2019 01:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h9xQea+SV03Ln66aqyU47kkYiIt/H1x4XjCyGKRtAQg=;
        b=mWQCKSD6XCLzsZ/4MrvNyveiIs1ALOZKLjnowJFJvYX/Y08gplPnd1S0VUj6uuhuGu
         hAOVW7pkZgsMuoHcPuKvS1CKrvRlvbSuwu1mjyqN+JvI0x3LMPG2SkeKYbkOZHUF/EL8
         VUmUcPn7za8tAMBzuRU/BFW6DCead5B+9eJm7wzgJX+1+cGMqLQpEbzFM+E/hYMu4usH
         QKUPgjLVQMgbYyb2Ho8WLJ+TdwCK+GcsP/sJJ5MrAj9B4+wrswBi1nfl3Ha1AilKTrUq
         3KN7CfwzszyEY+H1XkbWUQ/8VoKvQdgZule81nF7ThFrRI3LABDe0biEFzJae6HL/XaK
         lrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=h9xQea+SV03Ln66aqyU47kkYiIt/H1x4XjCyGKRtAQg=;
        b=iHC9GDRRRnjWUIku6vvM0H3yZ88TMVQI7GidPsAOoTIkrTgnxq11T7hevPtkCNc3Vq
         /RddISDkG9dTKHRV6biMcFDLlRp8wnshNOaeGSR/u8b4YxAaiu/Fa28TrmrOOffwiUA3
         Ox9ClobNTXFqt4pc8HHTU2dXOg95scNTs+9jQO9YshqKUaR7cl80aFp8uof2GIGvCGS5
         ZjTuJGUoK65rQ46DKLHzkzn9pU8DFMPsUeFdrLmQ5tRi/NC2A9JdqQZlVjg0fHwi8ivq
         iFsdwEBm10SlOk7UVTzOgbJVrnbc2b2otrPM9FowmcT4dH2bRVO23fWTai/2dXF6/RRS
         LWiQ==
X-Gm-Message-State: APjAAAUQ6z5vTK/MqiAbqXg5pTfRMjiAZTUPnD2/ABdppX7QylnV6Kuz
        G5hTsOMNGdZaMx48YnNOkl4=
X-Google-Smtp-Source: APXvYqzjxBf0crSR5PZa70Ih2+8DR2ty1Hz/7OTDVO2gendUw4xvRLk3QrX00h9UgauMa2UYaMk8sA==
X-Received: by 2002:a63:595:: with SMTP id 143mr28915399pgf.45.1572858030788;
        Mon, 04 Nov 2019 01:00:30 -0800 (PST)
Received: from localhost ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id f30sm9125837pgn.50.2019.11.04.01.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 01:00:29 -0800 (PST)
Date:   Mon, 4 Nov 2019 11:00:26 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix advertising duplicated flags
Message-ID: <20191104090026.GA36897@aguefor-mobl1.ger.corp.intel.com>
Mail-Followup-To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20191103215815.5310-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103215815.5310-1-luiz.dentz@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Sun, Nov 03, 2019, Luiz Augusto von Dentz wrote:
> Instances may have flags set as part of its data in which case the code
> should not attempt to add it again otherwise it can cause duplication:
> 
> < HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 35
>         Handle: 0x00
>         Operation: Complete extended advertising data (0x03)
>         Fragment preference: Minimize fragmentation (0x01)
>         Data length: 0x06
>         Flags: 0x04
>           BR/EDR Not Supported
>         Flags: 0x06
>           LE General Discoverable Mode
>           BR/EDR Not Supported
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_request.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied to bluetooth-next. Thanks.

Johan

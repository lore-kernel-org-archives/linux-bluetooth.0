Return-Path: <SRS0=ktGh=2V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C8BC2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Dec 2019 17:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91C7206DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Dec 2019 17:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="W205/VOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLaRfm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Dec 2019 12:35:42 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46622 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaRfl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Dec 2019 12:35:41 -0500
Received: by mail-wr1-f53.google.com with SMTP id z7so35595433wrl.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Dec 2019 09:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:cc:references:to:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=080LC8i60JO9ETHTM8jcnTT8mihpAb1MOPKSH132ZgM=;
        b=W205/VOVIu8g4cGdZq8T6ruLVWWfIv/bCY2nOzrIAop0+5CPw1LrMlfC9aXHL3to8M
         9O+2MOK57sL/3rMfU6G9LoJ0V7eNP0AGByz9f0s//iSI0w7ZtLLE21/KDV1PJLvoDH4i
         oWhuTHLaPFcLuzaA4AsLAt/GgW9bHWgsFebrWj87oLuxdXofe6Fofay9Ta9T9JMHSkHO
         zxf4f/zYzLegV1Qz+QTuDd8hNs0XYbSaFg2ryS5/zTwHT+I5d+TvuT+YB2zftvMD8mDl
         jJGlDgDxGV7YA3W3gDDecwt1bidrW6LOYn1R0kkWqrBBPo7w1dPb7NuAKXCLAz+jHhY/
         Tl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:to:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=080LC8i60JO9ETHTM8jcnTT8mihpAb1MOPKSH132ZgM=;
        b=TOuFvgmS9hhhdTkNvU7IgornDekTj+bnQN6TVrNI6oQMOtT0evNcDVWXqLaYreDm/H
         cdEDijgjoY4uTDQq7OV8ZxlSsG+wwn+aLlxhhodieCTbybeZcNnVycbJs10nSMCD67VP
         09JkVUuYUITbzIZvObzjDBIhSornUavq/Dxxr0afFiDBQP6vJqJF98NAu3ievBlexr1f
         RdmY+AvV/dmF7JADASywKq9G+IEpxPSR0Yq5+mJQcUF4dZNKODx+QgPOZGreTwNZ/E3E
         DXE8U0vB6mRFUO12HkMDQNXEA12lXO2loAGvyXT0D9rUmbfzWdWuhVoRiPSQ1HG7/kat
         /aIg==
X-Gm-Message-State: APjAAAWoalGx1NgfiKNHjY9O4LNg5gUnioN4bC1mauzfXy4NPyQcwXN+
        IjZ78IIidihYg16zO16nHsZN9j0X
X-Google-Smtp-Source: APXvYqxTNAFewcNttH8UQVWIB94rNOxfQ5DcB5TafCbjHjmw5yC5nxfoLuSwUEMijShNiNqfHbrj3A==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr76526638wro.281.1577813739331;
        Tue, 31 Dec 2019 09:35:39 -0800 (PST)
Received: from [192.168.200.12] (p4FD25D76.dip0.t-ipconnect.de. [79.210.93.118])
        by smtp.gmail.com with ESMTPSA id v14sm49165148wrm.28.2019.12.31.09.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2019 09:35:38 -0800 (PST)
Subject: Re: deprecated tools: rfcomm, can we un-deprecate it?
Cc:     Marcel Holtmann <marcel@holtmann.org>
References: <0aad7250-65f9-3e4c-e5ca-434139a9ae64@message-id.googlemail.com>
 <2203E98B-B581-4C14-94DF-164D7E036234@holtmann.org>
To:     BlueZ devel list <linux-bluetooth@vger.kernel.org>
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
Autocrypt: addr=stefan.seyfried@googlemail.com; prefer-encrypt=mutual;
 keydata=
 mQGiBDqoB5ARBACZn/K+5V0uoo0Wr9cI9hw5vPioOmIbPv30x47j/w/XNECPSzos078v9Fr2
 Mlz0MG9Gnpl9S1o0OIh//K5xxj2/LRLO2nL9/nqlnwmJ6W5qrjjn6Ch3mxz5mxMeRMRMY1cZ
 EkSj7GH3ZLviZlzrnpuJd12HWsXhAwVxUyQnvsvNzwCgpIO6EfQT33o9illpG/AxIk2Uu0cD
 /A4cgKbm5VZW5DPTlLe8P92eEgj5cN51SUXHXYgWBI0Fx+QwSYm6ON0U03B4oR5zDWMHkJfZ
 WgXROdwY/NqouBoV7lXvHsyInPzExNixe+1vcrhDJ3ow6nlCW77aCFp22iwumC4ouzFtOMXK
 kih0WPrxPKq27Hw9fq9EaR2oV2tUBACN6ZC+G7J21ruG9slJ+bFcY5cW7M5Um6Czk08T+vtd
 7fAg+fEUcGCtIdVdHrXBut07K9y6iy5IuqwAV5fJsE+JQO+f+X1pymdRgdWHGEoMMdEW4k3W
 IGjrmmMUtpqzr30h4WFgA4+0nR3jpmcGCWBSa4selQecyyOlM7rcmKyQNrQkU3RlZmFuIFNl
 eWZyaWVkIDxzZWlmZUBvcGVuc3VzZS5vcmc+iGAEExECACAFAkx9Sb0CGyMGCwkIBwMCBBUC
 CAMEFgIDAQIeAQIXgAAKCRAx00vNNldAmFZuAJ9xLbFShKeTTDgfwMUmO37qw07npACgmLIK
 fbArokRryKixiliTvxAgFHG5AQ0EOqgHkhAEALGQaS9Hj25lKGsaTOMKMBBvjklv6brH8JdF
 WTA9dr37spc+PFFyc9686bcT+5nkbpjq3ndXUzGdGzfe0YwOlQh4fWXZT/oTXosIBqDWPShE
 ntDU8BX9JVqBBZwJ/ey+QF5tgYrICjCzp8S/mL6sqw8En4/AS84lulAoNJMJsUcDAAMFA/4p
 ik7hBklqJzYC7uNWZDL9dkYwIsUXM64kGenUhpgguLZvhuVeUeHU2iIsdTcNBbeBwvXgLnEu
 vVSdf4wtDwR7SjUYebymbGc/JLkXjqGntaWUr+wfHmAm3oXV2X+WFzZQJ+o8N5dJyBEUbrVX
 YvBD7wErgEuJAL+q/i28U9u7OYhGBBgRAgAGBQI6qAeSAAoJEDHTS802V0CYBL8An1gF2k4s
 UaMjAtoX/ixcOhAv44i4AJ9Yi+OgvhS8CbUp+XkI5Q352XU+BQ==
Message-ID: <fa70a57e-d5f0-a47d-f987-27b46d8275c4@message-id.googlemail.com>
Date:   Tue, 31 Dec 2019 18:35:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <2203E98B-B581-4C14-94DF-164D7E036234@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

thanks for the response.

Am 26.12.19 um 21:40 schrieb Marcel Holtmann:

>> So is there a way to set up a rfcomm device via bluetoothctl? I could
>> not find one, but maybe I did not look hard enough?
>>
>> If not, could we please un-deprecate rfcomm, because having everyone out
>> there reinvent the functionality in crazy ways probably is not a good idea.
>>
>> Or should I just continue to build the package with --enable-deprecated?
>> But that will ship tools with known unfixed security issues (hcidump).
> 
> have a look at doc/profile-api.txt.

This would be for creating a "rfcomm service" for other devices to
connect to, right? (The equivalent of "rfcomm listen...")

But how would I connect e.g. to my serial module (I got this for trying
it by myself instead of relying on bugreporters results...), so what's
the dbus equivalent of "rfcomm connect hci0 <bdaddr> <channel>"?

Some small example python script for this in test_scripts would be
really useful, as the knowledge on how to handle this seems
non-existent: all the various bluetooth codebases checked (e.g. blueman,
pybluez) just re-implement the code in tools/rfcomm.c's cmd_connect
(socket, bind, connect, ioctl RFCOMMCREATEDEV, ...).

Now from reading the kernel code, RFCOMMCREATEDEV seems to be the way to
create an rfcomm device.
The only place in bluez source code that uses RFCOMMCREATEDEV is...
tools/rfcomm.c.
So maybe the rfcomm tool is not as deprecated as we all thought? ;-)

Best regards,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman

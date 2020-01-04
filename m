Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99736C2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 12:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633A420656
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 12:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="W79VxUx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgADMpw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jan 2020 07:45:52 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54327 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgADMpv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jan 2020 07:45:51 -0500
Received: by mail-wm1-f47.google.com with SMTP id b19so10511330wmj.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jan 2020 04:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fe9MGgNbnNAc5QZVvJe2Ts8ghrNUQNxTK87IhR1DoCc=;
        b=W79VxUx6a4qlqdU8ULdc8PK1wGDBdl7HIyfMIkxo7IhGwDEoLph69vEg6E8l/17UmN
         oAYg9H7pu9CNby4hitK64q3/kLuh1MU1h2nmtNwZFYCp1fNMjtN9cXmowAB1V4ag4uhz
         9BM3msk3Q6U3nqc22/DjzVgzEluP1f/0X6I+ifonW0Es7OgCXb5aSGbr4CvIhSQS9DBn
         iP+pz2z+wDSVDDNC+zDBPBxjb1o3Yu2z3fMCtbqtAMkW69O7J4WtOK+tNWRUMWaTpnfN
         uu6kra4efMaOsrQQhRWdCoarE2EQW/UMXelGYNe1za8XAcEZ+mjGA/5jQAGJVqrybpYA
         dcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fe9MGgNbnNAc5QZVvJe2Ts8ghrNUQNxTK87IhR1DoCc=;
        b=pdo9Uz5CnTg4pYNwjsBCknl4aVX3zgDE3JBARbwA2mWxDJc1d8+w42K0y3Ucf9FfoX
         9Lh0O0mME4q7eVHQyfc/fz6laqZTv0AaPDFFBIMbjCjDSyzumVVHG2vThQ5Xjl0rihA0
         WmmGQv9ApdCM6/zWdxoq+xouFq93ulLxvJCbzkBYjhZV4wN288Lw7I8Ux+rZ2+W+hXNt
         3OxbXNtPX/dXJe1Jnsl+4PjvQvRhEmwOnhtaeguUXO/pWWXqzOkM57rKaf3bWlGROL+X
         Rb9FsqBfZZPV7XuDz74rPkyb4AmBpbWzuwi7pG2iji72ySsSWIV7MvzKEik7jLCz48S/
         6PVQ==
X-Gm-Message-State: APjAAAVuqBnO7INkrw9TC85ZHd90lhcKb3P+ugYdSbevcT6dUwRKTM/s
        zw+lDTzf/fCzTnePOTPoXvsf7uRA
X-Google-Smtp-Source: APXvYqya2xDhjPyA0sSzHLru83ywDkPw5plrzrComDuHUCm8UUmTGgvFLP6/Kkq48Y10ry+rCZNqsg==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr24238448wma.106.1578141949164;
        Sat, 04 Jan 2020 04:45:49 -0800 (PST)
Received: from [192.168.200.12] (p4FD25D76.dip0.t-ipconnect.de. [79.210.93.118])
        by smtp.gmail.com with ESMTPSA id g23sm15482812wmk.14.2020.01.04.04.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2020 04:45:48 -0800 (PST)
Subject: Re: deprecated tools: rfcomm, can we un-deprecate it?
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
To:     BlueZ devel list <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
References: <0aad7250-65f9-3e4c-e5ca-434139a9ae64@message-id.googlemail.com>
 <2203E98B-B581-4C14-94DF-164D7E036234@holtmann.org>
 <fa70a57e-d5f0-a47d-f987-27b46d8275c4@message-id.googlemail.com>
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
Message-ID: <cb73add2-cb8c-353a-5d10-134a13553cf4@message-id.googlemail.com>
Date:   Sat, 4 Jan 2020 13:45:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fa70a57e-d5f0-a47d-f987-27b46d8275c4@message-id.googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

Am 31.12.19 um 18:35 schrieb Stefan Seyfried:
> Hi Marcel,
> 
> thanks for the response.
> 
> Am 26.12.19 um 21:40 schrieb Marcel Holtmann:
> 
>>> So is there a way to set up a rfcomm device via bluetoothctl? I could
>>> not find one, but maybe I did not look hard enough?
>>>
>>> If not, could we please un-deprecate rfcomm, because having everyone out
>>> there reinvent the functionality in crazy ways probably is not a good idea.
>>>
>>> Or should I just continue to build the package with --enable-deprecated?
>>> But that will ship tools with known unfixed security issues (hcidump).
>>
>> have a look at doc/profile-api.txt.
> 
> This would be for creating a "rfcomm service" for other devices to
> connect to, right? (The equivalent of "rfcomm listen...")
> 
> But how would I connect e.g. to my serial module (I got this for trying
> it by myself instead of relying on bugreporters results...), so what's
> the dbus equivalent of "rfcomm connect hci0 <bdaddr> <channel>"?

OK, now I found https://github.com/tonyespy/bluez5-spp-example which
explains how to do this.

I'd still think an example in the bluez documentation would be useful,
because...

> the knowledge on how to handle this seems
> non-existent: all the various bluetooth codebases checked (e.g. blueman,
> pybluez) just re-implement the code in tools/rfcomm.c's cmd_connect
> (socket, bind, connect, ioctl RFCOMMCREATEDEV, ...).

Best regards,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman

Return-Path: <SRS0=Ie0I=2M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBC6C2D0C0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Dec 2019 10:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3196F206D3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Dec 2019 10:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ci38rKUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLVKEo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Dec 2019 05:04:44 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45964 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLVKEo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Dec 2019 05:04:44 -0500
Received: by mail-wr1-f46.google.com with SMTP id j42so13575814wrj.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Dec 2019 02:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/XMbngI3Gc1y9Q4glVybq4l09/64SIPxFMUry40f5Bw=;
        b=ci38rKUhpW4dnVc0jVla3Plz+QnMYlPfoTwJ+XU+GRq2rNLF+iUhI9gRNq1fXbKcGg
         mJB9ppQd2XIWIU6sy0AdS0XN+PchY6O2KDUmD8/ph4AcGCgksEjhc15JjyLsAZmhOKAf
         nPj4VjeIgUrEt0RLdliaCChajk3mwwSJ4441yElBJr3AV0H87GWc0NSPLCUvUu2NkDyh
         ajvAhMGfKdPvh1WE/8NhDEeKlouNS4fuUNrITSQVLukctckOGlleJSB6Hjvcw2rA8D3N
         4GytNYOrg6Cjj6OzRA12TG0zSHKW1rIT/9sX1VbNc5vW4ghPrOSL+68BxlzvcCLQGLz6
         d0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=/XMbngI3Gc1y9Q4glVybq4l09/64SIPxFMUry40f5Bw=;
        b=gUKlEMr9ay6K9tZk4Xh+ZS6g41heUb4ndgjETiM2ykNbxcE2WWJ0lOp54iNrmE6ia+
         zxPJT3Qn2FoADFB4nYzVDMlAVakrAqMpEk6rZiCDl92B5J0Qkaq6UF1R/akW6QDqHRq0
         9KYsVTEFtshCCz25YEl4euGoEONTVPdN0gxFgEfMMxKlB61YqI+oiLArg30WNiITw3Au
         3CBBa4fgSpFM8F7EN/7XuQZAmdkI1ow3gkp0VfFBCoHdxah8CzPQcDydVyk+uRokUrU3
         37S23yhzpfO3siO8GLLQMJYZbUcJ4QjgFDnm9QbuKxz/NbFfM8g2T7OwopzwhN2ku8lC
         pIkw==
X-Gm-Message-State: APjAAAXKNlnkPrPHIHpIMPjsGmYt2SVpDYnTiIJj67WBeXa/NytC+384
        8dGd5lu7jUAZE7Uu3MbvkZ/xc9iV
X-Google-Smtp-Source: APXvYqzr5dGQTr/HuhX0pQRqjTmUE7SWaoNjXohhLO6ZL3IrK731rhYf/m4W0m+qpQlvmOwQCKxh/A==
X-Received: by 2002:adf:a308:: with SMTP id c8mr24034194wrb.240.1577009081492;
        Sun, 22 Dec 2019 02:04:41 -0800 (PST)
Received: from [192.168.200.12] (p4FD2535C.dip0.t-ipconnect.de. [79.210.83.92])
        by smtp.gmail.com with ESMTPSA id f207sm18264986wme.9.2019.12.22.02.04.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 02:04:40 -0800 (PST)
To:     BlueZ devel list <linux-bluetooth@vger.kernel.org>
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: deprecated tools: rfcomm, can we un-deprecate it?
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
Message-ID: <0aad7250-65f9-3e4c-e5ca-434139a9ae64@message-id.googlemail.com>
Date:   Sun, 22 Dec 2019 11:04:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

as the bluez package maintainer for openSUSE, I'm trying to transition
the package to build without "--enable-deprecated".

Now the users started asking me what to use as a replacement for the
deprecated tools.

For many of the tools, the answer is "just use bluetoothctl and let
bluetoothd handle things" (hciconfig, hcitool, sdptool)

But for rfcomm, I have not been able to find a suitable replacement.

All the other implementations of rfcomm services that I could find in a
quick search (some python modules, blueman) just basically reimplement
the functionality of rfcomm (socket(), bind(), connect(), ioctl()...),
some of them in really odd / crazy ways, which is probably not the way
to go...

So is there a way to set up a rfcomm device via bluetoothctl? I could
not find one, but maybe I did not look hard enough?

If not, could we please un-deprecate rfcomm, because having everyone out
there reinvent the functionality in crazy ways probably is not a good idea.

Or should I just continue to build the package with --enable-deprecated?
But that will ship tools with known unfixed security issues (hcidump).

Have fun,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman

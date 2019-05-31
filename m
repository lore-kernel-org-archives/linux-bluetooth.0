Return-Path: <SRS0=aznX=T7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995C2C04AB6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 May 2019 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D5E268CC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 May 2019 12:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQnVZVlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfEaM0D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 May 2019 08:26:03 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46783 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaM0C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 May 2019 08:26:02 -0400
Received: by mail-ed1-f45.google.com with SMTP id n12so6323665edt.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2019 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aMbmxFRaYYw4ak2ZOoUZUfj7MueBcRf8sV1vSM6fuak=;
        b=nQnVZVlH+C6AJCjMQz4Mm6Ld9cgOYvGCbrlyX+LFfl0fIdnI+PK678/fSyhdEEfDb8
         JTrnnnNIA0+QA5bOsBC3nmR0gG3ccNSPpFrSFkEbQDiZNWFtjjEF19H77EeD1dxxpzRC
         ZAT74rWJCEbWgNDk5S8YtCE230JX+psy3EzkJpgVb/YWVbipPA60a8Kbe85x2V3vslow
         FccFhmEVWkWAu/0dz5SJmK0mrsvZRdcFjN9msRGjAfzeKQpqdtnGI/5xYcRQMUcGBMcx
         mVoE6rIGxMXOYKrlcyG1b4Erz5/+/upQuNQ52pPoth/3S/JNFMOkF1/brm+kGZN3uS2F
         VEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aMbmxFRaYYw4ak2ZOoUZUfj7MueBcRf8sV1vSM6fuak=;
        b=S9U+p68ob44MTaqbgOeNyfJSBSU4bQERfdAFrHWQWmL4H1PK6AQGDkDQcrNFHY80ew
         K/6lmOHToNB/iwBfuzClNxF7pDvHHCv0mLCwvpCkfWeCR60408dolqU0Nx7VptAemPIZ
         0cVaiH3vvTUdoFt/jyqjQtYwDoXl+yNVdZ9kObpuDbxEPoiwR2G2hdx7l3MdFQxAvJlM
         67vEs4gZZM1mZuk2OIB/OObqYmhCoOLje2cXrhTZb6lAaxDMYQzizB8hiRze5BRqN7fO
         NYTBpt/6df7CWn58CvtWfWPHPpF6qxJjVkGesozXw3J27NqJut/dKpRNJa6hoBKtvxer
         QxcA==
X-Gm-Message-State: APjAAAXYPnR8Q0FnYbwLUHy1ptkqq4+pbAOcuS6E3bBac+myeQm3BfTC
        YrWvG0eYIega6qa2cDBtHQcbclQt
X-Google-Smtp-Source: APXvYqzspGlVky0X+g0XmPTSzJglW5Y7wLKwUP6TLHllGIC0FHzoCce+V2YdG/LVIW9+4sSyPa7+5g==
X-Received: by 2002:a17:906:2e55:: with SMTP id r21mr8795668eji.88.1559305561212;
        Fri, 31 May 2019 05:26:01 -0700 (PDT)
Received: from griso ([212.129.72.108])
        by smtp.gmail.com with ESMTPSA id 44sm1588166eds.90.2019.05.31.05.26.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 05:26:00 -0700 (PDT)
Date:   Fri, 31 May 2019 13:25:58 +0100
From:   John Whitmore <arigead@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Different respones to BLE scan from a Peripheral device?
Message-ID: <20190531122557.GA3176@griso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello all,

I'm running on two identical embedded Linux Gateway devices, both on
Ubuntu 16.04 and Bluez 5.37. That's certainly an older version, but
it's part and parcel of that version of Ubuntu. I'm having an issue
where the two identical gateway devices are getting different
responses from a BLE scan, and can't figure out what would be the
cause. In both cases it's the same peripheral device, a TI CC2650
device. On one gateway I get a truncated response with just the MAC
address and in the other I get the MAC address plus the description
string "CC2650.."

[bluepy.btle:37] Got: 'rsp=$scan\x1eaddr=b546C0E530068\x1etype=h1\x1erssi=h43\x1eflag=h0\x1ed=b020105030280AA06FF0D0003000011094343323635302053656E736F72546167051208002003020A00\n'

[bluepy.btle:37] Got: 'rsp=$scan\x1eaddr=b546C0E530068\x1etype=h1\x1erssi=h28\x1eflag=h0\x1ed=b020105030280AA06FF0D00030000\n'

I'm probably going to have to get a Bluetooth sniffer device to trace
this issue, but if anybody had any idea what this would be the case,
I'd love to hear.

Perhaps even though the Gateways are running the same Hardware and
Software there might be a Hardware difference in the chipset used or
something. It's all I can think of. Hopefully get something to help
diagnose this issue.

In those two messages there is a difference in RSS, is that signal
strength and could that be the issue? Have to open things up.

Thanks in advance for any help, and apologies I'm at the wrong end of
a learning curve.

John

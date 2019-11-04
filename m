Return-Path: <SRS0=jKvG=Y4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2731CCA9EB5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Nov 2019 21:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB390206BA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Nov 2019 21:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="d8VOLul2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfKDVRC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:17:02 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38108 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfKDVRC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Nov 2019 16:17:02 -0500
Received: by mail-wr1-f53.google.com with SMTP id v9so18807643wrq.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2019 13:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fT9RDwZPcm/Kk3Ax5T0CywBojhX0MUCKnghxV5nKfxg=;
        b=d8VOLul2CAgH+Kuk9kdG9CXbZ/seypmb5a95p5SLiL/bcA0lyyu1k8pqx0Qa9XCLh5
         KxJLYH6ShTvBTYAOVLtdc6ZPPwjBmc5SYcn2ixjJ9jMaTA113V7NbyiSgUoc3fVzGeyC
         VDd9bXnpreP3c+/aflkNHMu0QhA5rwqCogsTrRAdfaU8nSynSH77Vuuk0jsd2jstBsLf
         WoYdeCootvu1UJYgvGtCymm1GWA5Ep5+KVxAlUlOx5M6qdV05M2uUBEKLE5rhdrP49ul
         mosxEOMm43jqXnVRdt00z8qgSq4su7zRMfgdA2+IoZrxMrRo8qjgphTYbHtRnxmeOoRA
         k9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=fT9RDwZPcm/Kk3Ax5T0CywBojhX0MUCKnghxV5nKfxg=;
        b=RWBcuP6XOS3atQC0Rea/yZQ/TBiDjdcFLfUClzLKyDlwRSezK4Kb5PrMPQ7rwHsGDp
         fgow5ial9vMP56uXT2ifd/GCygufFdMRqS4VtVlcoAEBqYnh9uyj1FwXHhuDXqvCQmtE
         hJ8nfpFeRyfXTCvO/cqLRf0XlxCg9K8vg8xOWuv/l49wcnvHPbvf1t5TIQsesOE+6ggH
         vkz1LupExJoDuA0KK5A5aJ6hnac4QngeleCQr6J6l3Fn1TVbE5S0HQTeLwqAFQJTmZmi
         3URGfk+gU3ncEIrbn+PIT/4f3uAQC4wMvWYWNtVNZhqZhUU8+0dWnoNS95jV9t3ce8fc
         OGFw==
X-Gm-Message-State: APjAAAWsLI0TZMEz/GSB/7Ff607XXXM4TKsUJ4WXEIOyTQblFychmu5j
        v297oSCNhYIxPGAP8GA7l++FGvjQ
X-Google-Smtp-Source: APXvYqxkTmicMBfvd8A9ey7vP8YSubVFDtUt9KivB4CPcWQe8lVMn3RUvk4GuU7MJtUWiJped72o8w==
X-Received: by 2002:adf:93e1:: with SMTP id 88mr24564535wrp.198.1572902220278;
        Mon, 04 Nov 2019 13:17:00 -0800 (PST)
Received: from [192.168.200.12] (p4FD25546.dip0.t-ipconnect.de. [79.210.85.70])
        by smtp.gmail.com with ESMTPSA id a206sm25670468wmf.15.2019.11.04.13.16.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:16:59 -0800 (PST)
To:     BlueZ devel list <linux-bluetooth@vger.kernel.org>
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: test-mesh-crypto segfaults
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
Message-ID: <5f75011d-a157-cab2-72df-0209f7a30f21@message-id.googlemail.com>
Date:   Mon, 4 Nov 2019 22:16:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

test-mesh-crypto segfaults for me.

abuild@strolchi:~/rpmbuild/BUILD/bluez-5.52> gdb unit/test-mesh-crypto

[....]

[8.6.2 Service Data using Node Identity]
ID Resolving Key     = 84396c435ac48560b5965385253e210c
                       84396c435ac48560b5965385253e210c => PASS
Hash Input           = 00000000000034ae608fbbc1f2c61201
                       00000000000034ae608fbbc1f2c61201 => PASS
Hash                 = 00861765aefcc57b
                       00861765aefcc57b => PASS
Mesh ID Beacon       = 0100861765aefcc57b34ae608fbbc1f2c6
                       0100861765aefcc57b34ae608fbbc1f2c6 => PASS


Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7e874ae in mem2chunk_check () from /lib64/libc.so.6
(gdb) bt
#0  0x00007ffff7e874ae in mem2chunk_check () from /lib64/libc.so.6
#1  0x00007ffff7e8b6af in free_check () from /lib64/libc.so.6
#2  0x0000555555557c98 in l_free (ptr=<optimized out>) at ell/util.c:136
#3  l_queue_clear (queue=0x55555556d010, destroy=0x555555557c60
<l_free>) at ell/queue.c:107
#4  0x0000555555557210 in _sub_D_65535_1.7021 () at ell/cipher.c:319
#5  0x00007ffff7fe2c13 in _dl_fini () from /lib64/ld-linux-x86-64.so.2
#6  0x00007ffff7e3f877 in __run_exit_handlers () from /lib64/libc.so.6
#7  0x00007ffff7e3fa2c in exit () from /lib64/libc.so.6
#8  0x00007ffff7e27e12 in __libc_start_main () from /lib64/libc.so.6
#9  0x0000555555557b8a in _start () at ../sysdeps/x86_64/start.S:120

this is reproducible here, I'm disabling this test for now in the
openSUSE package build.

Best regards
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman

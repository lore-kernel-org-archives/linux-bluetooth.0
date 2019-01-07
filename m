Return-Path: <SRS0=SaLm=PP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED61CC43387
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jan 2019 23:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA265206C0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jan 2019 23:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLSXaT1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfAGXNV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:13:21 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:41325 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGXNV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jan 2019 18:13:21 -0500
Received: by mail-pl1-f181.google.com with SMTP id u6so868015plm.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jan 2019 15:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ls+/EkkeeeabzFt4bmmnRO7q3pw+esmbTOanxMqmU5E=;
        b=lLSXaT1jIUC8SQz7TC/mwp7aVpWbugg8aA+3qcmWWoBGyVmPCI2kcqN1Mt3lMYqzIf
         bisKCtnj8lSFN5tYN4fIW32ZV/PbnB3vHLhjgNehQ9eTU0fjoq5RiYY38D+g9IJ06bzz
         /dWezX6goQvilJvCPcQ7XJP8xuhQGga5JGGLOwAOm9T2Nx9cxTcIP1ghyfl+f89LDyKW
         i2AtjPHTAoo+9kKIKlhHUvSRTNt/5YxWmn0QtLFlwGozBnW32Cuvbnn9u/sY6poDi/VL
         4H/EkZD8hEOpy/tQ3ovJoYSMlgmF6j+dicx7TX40kMHEQFnJGaPLXtXgh8wVwuTQC4CL
         HP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ls+/EkkeeeabzFt4bmmnRO7q3pw+esmbTOanxMqmU5E=;
        b=StVO5vtHs5myD1ztqouNhjnufeKgvzXqknlshnOUnYMugL2bPtsRPYRYLF/hZoBc6j
         RRNOhFMLEbuma77eqIpwI6chd9CVHpnqbhDker7opKiJZQ9l8IlcIV3DBZd9fVmO695k
         UBVkj84+YiGIXVmn6FBm6LiUGl6hUP2bGG4ktY34b8Lfpn0CQM21eCtnbcwhTk0Vjwzt
         cfx9yeirUV85V1soTEmA4UEzmmMufRWfe9Po95cOTk4kRtfKKMHX3yZRd2rS1a6DHPHW
         +jnyVp94ozXBjyaGwxYEhKxvHPD/r+SI30nVwqnT+i1kZOcqKISumQVi+zIY6dgq8QJS
         BMTQ==
X-Gm-Message-State: AJcUukeJRKjtMkFgpEgOl/U2Djl2dYD9MLB8bEC1wQh9R9tS7jOG7MiY
        WFDAf/Bv5jhD0YEmLT//9ejoFZNt0IVdXVcdbrYJhyR4cHOXAQ==
X-Google-Smtp-Source: ALg8bN7TDNXVhJA+kO04xQM4u87mkD865LHZUpV6Oj8lD+4KxzxdBgwAfFN6+y5Zvd5M60ucqXWf8lVapQ0UYimow2M=
X-Received: by 2002:a17:902:925:: with SMTP id 34mr60849569plm.14.1546902800088;
 Mon, 07 Jan 2019 15:13:20 -0800 (PST)
MIME-Version: 1.0
From:   Eric Cooper <coopereric@google.com>
Date:   Mon, 7 Jan 2019 15:13:09 -0800
Message-ID: <CAGp4ueerLhg2Ek=NhEGP6MS8_x48G2gF4EA3m7MWGq=jg44UfQ@mail.gmail.com>
Subject: Is exchange mtu request supported when bluez is central?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello, I am running bluez as a central and the peripheral sends an
Exchange MTU Request:
  ACL Data RX: Handle 0 flags 0x02 dlen 7
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 247

And bluez responds with not supported:
  ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Exchange MTU Request (0x02)
        Handle: 0x0000
        Error: Request Not Supported (0x06)


Is there a configuration change or otherwise I can use to enable this?

Thanks in advance and please let me know if there is more information
I can provide,
Eric

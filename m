Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6811C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BF7214D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 14:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv0ZSLJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfLKOkq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:40:46 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:34077 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfLKOkp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Dec 2019 09:40:45 -0500
Received: by mail-wr1-f42.google.com with SMTP id t2so24329854wrr.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2019 06:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A9wJjqvyVHJ83XiCb0oRXaVV+EGhE0/QpDLHXNVaatY=;
        b=Kv0ZSLJXvdPOIcLItls2ckOzaDplT/mbUfpMpkwZdXN4UnR0qA+Ve5RporYOotgO7a
         ew92pMRpbWMLkd4uVKTFj7PU84bQKC3IUuc2KdqbF+63kiPQqGxNYuSXxG/6Rb9a7DNP
         9ZQsLl+ck43tFSW0W6aXKhtstmugWYkDHtV0gJMDQkKN/bTj/CCeYrl/77MtL9EeQTUI
         u74Z7z9TvwZA2fK4/o5Bnn7k7rp+z1sRpiljK27pGcitVQxlN+IxSyfziYHj1xISbzBh
         KFaspJuOpjnBsXOPbpgE5jfWgT2eFiZ1rQ6QT7enASC3prY/C2OO4a0uHtg1PVyX8/RO
         0OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A9wJjqvyVHJ83XiCb0oRXaVV+EGhE0/QpDLHXNVaatY=;
        b=nUwUoN8MVqOaRLTfT9yVArJg9OLd+F9qNRJq4F/qyMJ9HCd7atuM3q9YQUaH9m0rZY
         2rD94L79tIR+jGcna8ETvKpy1tl+IUkHlrlnhS22fd/iO8EoC0vHQ+GwfybmyO0rcN/m
         3vD7q0lfGMp4s/ExAobbYsl+IQmsn8k/JkeSxEX9qOdGhYVrQJIxLKaKzTQZwYFZ2PeC
         X61JIkXqhxHW7+PF3di4UEmPxHXBZdLLb/bAhZRBCpW4ksrP4A2Law+FbTmAW7Ga6HVP
         RiWFZr4/w6vzaVNO/RFCgXLQ6U3buTRQvfNT/+9Y4Os8xjEfEBSoQQH563ONxSaf+to6
         KV7A==
X-Gm-Message-State: APjAAAWsuEOSEbLxIMVgnxhp7V14k0pT2B6Nok3GUB7rtcpznyEupsFE
        aFxiK2Y//ZT/fw+kjlKMJOk=
X-Google-Smtp-Source: APXvYqyHgZnCIG27Gl92Z3rJVoQM1sf71cjfwNJZv9isOduOi+lbDhhprXOB1HzSdidWFO1S5bkWwA==
X-Received: by 2002:a5d:6048:: with SMTP id j8mr118581wrt.41.1576075243862;
        Wed, 11 Dec 2019 06:40:43 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n8sm2508243wrx.42.2019.12.11.06.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 06:40:42 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:40:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191211144041.nu5tngwp25i6fjup@pali>
References: <20191121224455.orhslaa6zdmlwe43@pali>
 <390FC814-FBC2-4225-82C2-0CB866F01471@holtmann.org>
 <20191124111313.gaqjyxmmxigmwmpr@pali>
 <8A14D8FE-A2B1-437E-B7A8-FAE5B39ADC5E@holtmann.org>
 <20191126074610.wy5pgjgskv6rxr7y@pali>
 <5ED40B51-1909-46CC-B9BD-9903C18751E5@holtmann.org>
 <20191126080028.2gz43ragmi4zmk6h@pali>
 <CABBYNZK-C9sn-6VB73E_JnKmtzL5mFdgQ0o0VhMN0bTFgKm_ZQ@mail.gmail.com>
 <20191126095838.qd26pg7yvbutikyb@pali>
 <20191205092847.phvm3yf7rxq33637@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191205092847.phvm3yf7rxq33637@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Just a reminder for this email...

On Thursday 05 December 2019 10:28:47 Pali Rohár wrote:
> Hello, can we move forward in this problem? If above my proposed API for
> setting codecs settings is not suitable, could you please propose
> different which would provide needed functionality?
> 
> Because kernel is currently blocking usage of any other codec and
> therefore without fixing this issue it is not possible to use any other
> codec.
> 
> Also kernel is blocking usage of hardware mSBC encoder and decoder which
> is part of bluetooth adapters (e.g. in new Thinkpads) so it is still
> needed to do whole encoding / decoding in software...

-- 
Pali Rohár
pali.rohar@gmail.com

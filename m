Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68979C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 09:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A16960E78
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 09:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbhHDJIc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:08:32 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:58474
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236932AbhHDJIc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 05:08:32 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0B9093F0FE;
        Wed,  4 Aug 2021 09:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628068099;
        bh=tSe6fMxsTQhmdenjLw4Pb1nbkfq8Zif+0n9HdedEkqM=;
        h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type;
        b=M+WUpUGs/nc+Q/Zj7kux10GmntlDCfgsXSdARNqCQhV1YX8A4XgKIQHrnddISb1QK
         DVf5JIFntEyRoyo+8ULmvZxrHDKoKdRIGMqX2ndyHhwKaOj3e0MJLXfHf/BWA2jDsO
         a6h5z6I5iUBWTcDGp7EGLBWlnyWWL+qKmE1tq98/s1QDzhcBDk9q85UscFOcYA7+JN
         iFOcbW3/RWrTD96IaIXc1rMatQbdMOfOHzd21xMP7wlRL7pTCu26lT6sIwpZAk1uNL
         MT5QtPrfHXDrchCdRFUDKZByNiAsvgXNh2XUO9TsqhJ6dmmUUGhDXIOQnzDHzpq9M8
         RdGufDTOAV/oA==
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Colin Ian King <colin.king@canonical.com>
Subject: net/bluetooth/cmtp/core.c: potential buffer overrun in session->name
Message-ID: <2cfa6b86-da6a-207f-ec1a-e180e6275896@canonical.com>
Date:   Wed, 4 Aug 2021 10:08:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Static analysis with Coverity has detected a potential buffer overrun
with a sprintf into session->name in function cmtp_add_connection in
net/bluetooth/cmtp/core.c

The analysis is as follows:

Out-of-bounds write (OVERRUN)
sprintf_overrun: sprintf will overrun its first argument session->name
which can accommodate 18 bytes. The number of bytes written may be 21
bytes, including the terminating null.

363        sprintf(session->name, "%pMR", &session->bdaddr);

So, %pMR produces can potentially produce 0x............MR\0 (where . is
a hex digit) so this accounts for 21 chars. session->name is defined as:

char name[BTNAMSIZ];

and BTNAMSIZE is:

#define BTNAMSIZ 18

Although an obvious fix is to increase BTNAMSIZE to 21 I'm not sure if
this is actually the correct fix.

Colin

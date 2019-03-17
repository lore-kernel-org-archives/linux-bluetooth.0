Return-Path: <SRS0=QJP1=RU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B29FC43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 07:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E5521738
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 07:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=orcam.com header.i=@orcam.com header.b="YX2jplmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfCQHvi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Mar 2019 03:51:38 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:39593 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfCQHvi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Mar 2019 03:51:38 -0400
Received: by mail-io1-f51.google.com with SMTP id e13so1507201ioq.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2019 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orcam.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=D0A9V7uFugd/7tT3BucfcXXgQRCWIZR1pFsvx08aebM=;
        b=YX2jplmOWnS9NY/K4bFUPeOL4hDwYR4NS7Peg1kJOznqHFfvH/eYlL+o37wbyHtgdp
         Ei1a/SN68de3b6hvtUZeHzKVvTkW6hx/+/HmYPam8M0M3BXckqmucj9EcBFu+WhL0MyH
         K7huoky6EX2glTdxQ+iD4NqTWMCgIgsyQvPfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D0A9V7uFugd/7tT3BucfcXXgQRCWIZR1pFsvx08aebM=;
        b=IByQxxKibr0KJoOP6OZrib/uWmFql2CnXqPGSPBi1t9ex2WtCpIVQVfB+uH6lzDJSt
         UAr5qKZTCfYx7Y3EHZosjt/26RGtt1JqXUFYBoA2WZP4hHFSXpCAw2Y/CqReYzqX14DJ
         95nYl4IHQhemBddtfI16a37QUMhPfPjmQy6FSfxvbqCYzD6JMtcSkzRZonFeul0lvyKY
         lrH+0YUN5DN3d8zDzv7hVXLRv9/AEF5sEdEjgyQ5zBxRGNmlNu44hz5W7W5OLlwq3zTE
         2Tzbf7F5wFakHOIsd2UXwooW15px/tBoOzRC2h5zvYZ+lxtRPkearANa+BrjvmI7To0s
         7ybw==
X-Gm-Message-State: APjAAAXjwWD6w6dKD6R+nzkeYiFrZhocziTNnrhCUlP3sezNacpUB9zE
        I+TmCZsaCMiZgM3eOizDBOWMkMG4/9ASY8b65XJA4I2KZeY=
X-Google-Smtp-Source: APXvYqz27yrh3kNQgxczNaeBiNFxL+34HXj8waNN0Pyrb8zNmvvGbf1P52LBuiq8xS4JA+6BtIpzAzZdCIRFsAbQzJM=
X-Received: by 2002:a6b:e305:: with SMTP id u5mr7682521ioc.262.1552809097444;
 Sun, 17 Mar 2019 00:51:37 -0700 (PDT)
MIME-Version: 1.0
From:   Ordit Gross <ordit.gross@orcam.com>
Date:   Sun, 17 Mar 2019 09:51:26 +0200
Message-ID: <CAB+bgRZZxQBrX6-7a=atdN51UUqRdrVM-0Vfd5PbSEQHuCf_dQ@mail.gmail.com>
Subject: supporting both btgatt-client and btgatt-server in application
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hi all,
We have an application that should support both btgatt-client and
btgatt-server (connecting to different devices for different
workflows), using bluez.

1. Should I create a single mainloop that will be used by both or
should I create two different mainloop_run? (thought of have porting
the mainloop code to c++ and change it to be class element)

2. Regarding the btgatt-client, how can I initiate a disconnect? (I
looked in the btgatt-client.c test application and did not see an
initiation of disconnect).

thanks in advance! (hope I sent the message to right mailing list.. )

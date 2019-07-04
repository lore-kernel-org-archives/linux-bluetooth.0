Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA1FC46484
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34DF2085A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 13:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJHDW/oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfGDN5T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:57:19 -0400
Received: from mail-yw1-f46.google.com ([209.85.161.46]:39904 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfGDN5T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 09:57:19 -0400
Received: by mail-yw1-f46.google.com with SMTP id x74so672817ywx.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2019 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2LZzQ8p977rVt2eMT9pcF1umhYdPlZc1eXNN1GBVGWA=;
        b=FJHDW/oi7CFbxFmEZYANF70C+5gDC4pX8WQqAgB2mybKaGpR2gmjbgGCAfeByHpQc6
         kKpLrckBr5KF8tEcnFYE9B4PTNBJEubhGRIYwUdGGi5o1UxmnOp4pRWp2PGpEwyvELdW
         iU/bRQrbUoA/on2C/Z0+1ByurrvlceFf/W4JlD261+WBNT32h0gi5czlRt8hQQHdnSKH
         MdQ5FvkHHNxktFFg85gjbf+lYi28OLTmFCyylnf08E713TUN/wBcWTfKthgbyVHlueWF
         ICCsZJYK7UB6DdbsoymbQ2p9ppXjlO9hvkxT5HgfHUldMfbYHVFKbVmM/nTH0GxlxZpv
         t1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2LZzQ8p977rVt2eMT9pcF1umhYdPlZc1eXNN1GBVGWA=;
        b=rUhvOLuv5YPcG9i7HVmLOihmL6sAK7nDv9FVbf/D/vr6GvNdwTusljxbvvUsk0OsTq
         aeUrLi+w0WwpRMSDffui/4K7uYqW7ot+r46ygLNjIf4AEWe2T/HQsRu4AGeRuktXVbZ9
         JyS+XlZuGJJKtAXRWI2DqeVI7w0eUlOe3pIQ9f7T3doGaTRkAtiy1XOn+0PwsufvFBZC
         jkpczCciOHGn6BKOlHxSxt69PTNujuiPB5ShQ3fi1DJ7dD7YBs+ngIc9PW77U1DjuR2O
         egkiMxqMpd3yrvJA1u0gfzO5aFC7Y25gP3/AVFbBW1MdRC71eC8VIJDjhizAM8fkjZGz
         5bPg==
X-Gm-Message-State: APjAAAXNJKiHpxazA1dFYB5kwGp/W3hY2+EdKNsmu8R7PPW1NwJlW+6T
        ziYbOD4cBg10y9P0tZ2szvNxj62tcergnMh8J/Xjkg==
X-Google-Smtp-Source: APXvYqwhYnNXM0seXJFbF7TAfmCjKU+nyTHYc2UV15nxicU5CYYo/dtWUhr29rMTk8HBmOntbC/8jo4NG6ZbrtEwz8I=
X-Received: by 2002:a81:7bc4:: with SMTP id w187mr1482178ywc.211.1562248638047;
 Thu, 04 Jul 2019 06:57:18 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Thu, 4 Jul 2019 15:57:07 +0200
Message-ID: <CACna6rxtia9EchufR9otHZD73LEHGEbgWdUpwQbogBZc0aVQtg@mail.gmail.com>
Subject: Request for help on using BlueZ in C app for a custom GATT server
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I'm trying to figure out how to register a custom profile + service(s)
using BlueZ in my C app.

I found some posts mentioning gatt_service_add() and suggesting to
look at gatt-example.c. I checked that file and it seems to be part of
"plugins" with BLUETOOTH_PLUGIN_DEFINE in it.
In "Doing Bluetooth Low Energy on Linux" pdf I read that plugins are
deprecated and I should focus on D-Bus API.
Is that correct? Should I avoid gatt_service_add()?

Looking further I found
https://people.csail.mit.edu/albert/bluez-intro/c404.html
This example seems to be using hci_* functions (like hci_get_route()
and hci_inquiry()) from libbluetooth.so. I checked hci_lib.h and found
nothing related to registering profiles/services.
What exactly is libbluetooth? Is that for GATT client purposes only?

Finally I started looking for D-Bus API info.
In "Doing Bluetooth Low Energy on Linux" pdf there is a
RegisterApplication() mentioned. I can see that also in
doc/gatt-api.txt.
Is that the new D-Bus API I read about? Is there some tutorial/example
for it I could use?

--
Rafa=C5=82

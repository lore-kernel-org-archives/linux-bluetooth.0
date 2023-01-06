Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DFC3DA7A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 00:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjAFALp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Jan 2023 19:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjAFALo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Jan 2023 19:11:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABDC3C0D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jan 2023 16:11:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f34so57220967lfv.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jan 2023 16:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uNu0ILOzwlGDT8oO7nCLCfdhaN3mPgL/+wr/CPYVWQ=;
        b=eQhGWiMV7unhqVe88eoYbLWDxKdA2sjezvCDVj8gbwwN1ik075ndqTrywJODHVZBOo
         SPlrsHHcrJ85cXPcDwRSThksC637AHfFhr+5s9k5VvZyRqZm7BkNj6TzEbftLEGT9B3R
         KtCxRwc6JFtLDZLRxsbDRw/XxxpBFrOAYp+M4lxqDibWwR74BVhSsW09aD9Zpmh439ie
         MaZIqWQQD8Z0yDpGAO/DBi+6jwrDULwFYsSYXZgLYa+fDhEP/0zvIRd//cbEQdvdcH5a
         gRvkzRek1aSD9rDOZZHrNGPUEY9lDZHqQfOeDTj0AgdKdBZJyH2ponJPcAvgNjWI7rc7
         4V/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uNu0ILOzwlGDT8oO7nCLCfdhaN3mPgL/+wr/CPYVWQ=;
        b=xwfF0aSw8m15KUlHcuPUAEaE2kqBGA7KDUt1zzdn686ApcDCz4u3zOku5+zHXdZTro
         OiEjgxwBgk9kzRWUXtPs4ylTkqbjZI12ucCl+SHKtHyj58rCrdj68gtWZZ8HW3p5JlAO
         7CjziiW5oJdQ7wVHaGDstl+nsi6AkSxULdHXHYKQ1Qxf9y332s5lTn+5qMoy2eKCxxHE
         cR5BS9q7DeHhTjpQsA60IdIXNqTo58w/Y5yXnwn48SIbXZh4zdR1jWmbKEB3Qkb+eqYr
         0uxgbLgSRbebOpON+iUQI9cGXEO/IuxMe8VN6xYfXwa1dFYVy3B3E8ADopJQlhcYUgDu
         mFcg==
X-Gm-Message-State: AFqh2kpxmYEr/e3HtYMS6olMA0eb9eWELJ+S+y7VN1CutnwUgR+tdyKJ
        5ay5H69MaCWxdeMEPFBoj/VzTDyz8N/mUfBt/sxB1akj
X-Google-Smtp-Source: AMrXdXsawMtsf547xT741xZECt0Zg8HvLX9CwuaEd2guUnAnYVbpGVlnnkRp9DsvabuXK1VDgu5thpFMgNjRSIXmNfI=
X-Received: by 2002:ac2:597a:0:b0:4cb:22ab:ce08 with SMTP id
 h26-20020ac2597a000000b004cb22abce08mr900375lfp.251.1672963901020; Thu, 05
 Jan 2023 16:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20230105220944.2373424-1-luiz.dentz@gmail.com> <63b76559.050a0220.cbe75.dd46@mx.google.com>
In-Reply-To: <63b76559.050a0220.cbe75.dd46@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Jan 2023 16:11:29 -0800
Message-ID: <CABBYNZ+_PgENto6BgULY_O9kgpAAmSmigAwq2U=9tmo-2J2GJg@mail.gmail.com>
Subject: Re: [BlueZ,1/4] shared/gatt-client: Use parent debug_callback if not
 set on clone
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, Jan 5, 2023 at 4:03 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D709=
312
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.39 seconds
> GitLint                       PASS      1.39 seconds
> BuildEll                      PASS      33.02 seconds
> BluezMake                     PASS      998.52 seconds
> MakeCheck                     PASS      12.62 seconds
> MakeDistcheck                 PASS      178.17 seconds
> CheckValgrind                 PASS      289.84 seconds
> CheckSmatch                   WARNING   383.95 seconds
> bluezmakeextell               PASS      116.46 seconds
> IncrementalBuild              PASS      3284.64 seconds
> ScanBuild                     WARNING   1193.87 seconds
>
> Details
> ##############################
> Test: CheckSmatch - WARNING
> Desc: Run smatch tool with source
> Output:
> src/shared/gatt-client.c:2764:33: warning: Variable length array is used.=
src/shared/gatt-client.c:2994:23: warning: Variable length array is used.sr=
c/shared/gatt-client.c:3075:23: warning: Variable length array is used.src/=
shared/gatt-client.c:3514:23: warning: Variable length array is used.src/sh=
ared/gatt-client.c:2764:33: warning: Variable length array is used.src/shar=
ed/gatt-client.c:2994:23: warning: Variable length array is used.src/shared=
/gatt-client.c:3075:23: warning: Variable length array is used.src/shared/g=
att-client.c:3514:23: warning: Variable length array is used.src/shared/gat=
t-client.c:2764:33: warning: Variable length array is used.src/shared/gatt-=
client.c:2994:23: warning: Variable length array is used.src/shared/gatt-cl=
ient.c:3075:23: warning: Variable length array is used.src/shared/gatt-clie=
nt.c:3514:23: warning: Variable length array is used.src/shared/gatt-client=
.c:2764:33: warning: Variable length array is used.src/shared/gatt-client.c=
:2994:23: warning: Variable length array is used.src/shared/gatt-client.c:3=
075:23: warning: Variable length array is used.src/shared/gatt-client.c:351=
4:23: warning: Variable length array is used.src/shared/gatt-client.c:2764:=
33: warning: Variable length array is used.src/shared/gatt-client.c:2994:23=
: warning: Variable length array is used.src/shared/gatt-client.c:3075:23: =
warning: Variable length array is used.src/shared/gatt-client.c:3514:23: wa=
rning: Variable length array is used.src/shared/gatt-client.c:2764:33: warn=
ing: Variable length array is used.src/shared/gatt-client.c:2994:23: warnin=
g: Variable length array is used.src/shared/gatt-client.c:3075:23: warning:=
 Variable length array is used.src/shared/gatt-client.c:3514:23: warning: V=
ariable length array is used.

Looks like the output of smatch is not quite right, it is probably
missing new line or something.

> ##############################
> Test: ScanBuild - WARNING
> Desc: Run Scan Build
> Output:
> src/shared/gatt-client.c:401:21: warning: Use of memory after it is freed
>         gatt_db_unregister(op->client->db, op->db_id);
>                            ^~~~~~~~~~
> src/shared/gatt-client.c:646:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, false, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:943:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1049:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1241:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1306:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1577:6: warning: Use of memory after it is freed
>         if (read_db_hash(op)) {
>             ^~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1582:2: warning: Use of memory after it is freed
>         discover_all(op);
>         ^~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:2088:6: warning: Use of memory after it is freed
>         if (read_db_hash(op)) {
>             ^~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:2096:8: warning: Use of memory after it is freed
>                                                         discovery_op_ref(=
op),
>                                                         ^~~~~~~~~~~~~~~~~=
~~~
> src/shared/gatt-client.c:3182:2: warning: Use of memory after it is freed
>         complete_write_long_op(req, success, 0, false);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:3204:2: warning: Use of memory after it is freed
>         request_unref(req);
>         ^~~~~~~~~~~~~~~~~~
> 12 warnings generated.
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz

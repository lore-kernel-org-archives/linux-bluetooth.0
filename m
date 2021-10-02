Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Oct 2021 23:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D88B61A51
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Oct 2021 23:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhJBX7p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Oct 2021 19:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhJBX7o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Oct 2021 19:59:44 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E4C0613EC
        for <linux-bluetooth@vger.kernel.org>; Sat,  2 Oct 2021 16:57:58 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id f13so3654669uan.6
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Oct 2021 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BDzJdZcsF5202SoAzC2wAfhaNBhwsJJL0gAmFU/A9Ws=;
        b=IcNTmR6lUD44AWVNZX10dmItgVfB02R96DxggJgjivakJYjSqjhw1KLbMqVuezmCnk
         uiX2CXdwlUNUzMkQP8RKRS9yXzvKSU4O7OLkv3OW8guIbT4kCECcO1tdXA1C3YHoLAtg
         XlR7veQt7qc7SITckw16mI4H8f+ifRVEIoOCgndqO49voyqMymUIULdApJGHQmCmnm63
         86Lx7wmlKwH3Iu7+V7sqBZBTnPJ4/5nk/Oj0E+1bezQcDoJ74Prif+mkTTF+gbJvMDIJ
         bldIdHhau+7gcLfEL6cpuD3lj0tIVZc/a7+xkGotkWAXg2G4wlWkCOjvAiwFYJte7cHo
         MTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BDzJdZcsF5202SoAzC2wAfhaNBhwsJJL0gAmFU/A9Ws=;
        b=s0KwkEdat6whDHsy3hWtQ6qzsGpHLkYf03AWQHqea+VEIVv3THM2YXAh8pYpp967qT
         eQNYoTjjnuxb2glSCPsKTxAsdOaE0Ldjbn6kGmG2QuSSBOwQTYeIHlAfAfzsMmKPWk7z
         p571xR8bZWvj5CMP9mZeYxfQPqrkOvT/JjvJJfAy8Y0Rgyuyydw/PfcK9e993sNs8Cuu
         LSn07JVqYLWjoPk/50HdL3+7JstMsSwLZ/nPILvT8p4FspxLefRkarcDx91DjUEp1GDq
         GPQHGaQGzrkk4JAIaZGV42lsVligSAhwUntYwlhSreVBpLgu/j5xGLHwa1f3078fT97P
         gyVg==
X-Gm-Message-State: AOAM530KXEAou3yNMO/ef8I74cnAkqTkHbWIKTAgM1XhvMFKIRy8n05T
        JuGpLy5Xz5qQ1VyZ/++ozrLXmd+UMvR3o+i644S9ElAM
X-Google-Smtp-Source: ABdhPJy1xZTe32AACcLMr4U2YgP1rbjgnkFPaMcIiFZ3rQBhB+fiv5dXUqV60R/wm2SfQ9e5CG0BZvRGvQ3/CUdKiBo=
X-Received: by 2002:a05:6130:31b:: with SMTP id ay27mr3040052uab.135.1633219077289;
 Sat, 02 Oct 2021 16:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgPF1JLw40nRXyoXyuGd9hNLWCDeD4ONVM7S_CSE9wQg3gvyA@mail.gmail.com>
 <CAJgPF1JTyqom8YJSNPx5-5uecZZKwks1gnAotzwJUhz57nSpLw@mail.gmail.com>
 <CAO1O6sfBB53qMnB-K+ZLaGrrD3ZFy00Zn+u1GqTavNX7fZCzBw@mail.gmail.com>
 <CAJgPF1LG32ShzPsaPWC64VGRC+odvHYrUYXBiDkTdcZHH78sbQ@mail.gmail.com>
 <CAJgPF1+BJFyryVWzVYGp=qDHjruJWYq-eAHzm+QeR=BGNct+iw@mail.gmail.com>
 <CAO1O6seL0QJwHB6CRq56UitWUxQk4PaMC1a-22ggk6KjoD1F1Q@mail.gmail.com> <CAJgPF1KytH81jjezgfOVxrLZzgONqfC4tdTKUy+xPFmP=5f+cw@mail.gmail.com>
In-Reply-To: <CAJgPF1KytH81jjezgfOVxrLZzgONqfC4tdTKUy+xPFmP=5f+cw@mail.gmail.com>
From:   =?UTF-8?Q?Peter_H=C3=B6ller?= <drmedvet.hoeller@gmail.com>
Date:   Sun, 3 Oct 2021 01:57:43 +0200
Message-ID: <CAJgPF1Jw10=Y4UQc4QTd6GNbO5vchJK1V+PHS8EOUo-Op+Z=1g@mail.gmail.com>
Subject: Fwd: Instable BLE connection - MTU Request, Attribute not found -
 wireshark findings
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello to whom it may concern:

I finally switched to Kernel 5.13 and blues 5.53 wich was quite a bit
of work on my hardware.

however, the bluetooth system now seems to work more stable:

BUT:


1.) I am still suffering from unexpected disconnects, but tolerable. but

2.) when bluez disconnects it immediately deletes var/lib/bluetooth/
aa:dd:aa:pp:tt:ee:rr/ "paired-peroiferal-mac"  and
var/lib/bluetooth/ aa:dd:aa:pp:tt:ee:rr/cache/ "paired-peroiferal-mac"
all the time!
Which leads to make the central forget the paired device completely
and makes it unable to reconnect.

I cannnot avoid this absolutely strange behaviour, exept to make the
folders undeleteable and restart the bluetooth-service everytime this
happens.

Du you have an idea why bluez should delete the files/folders?

please help-

Peter

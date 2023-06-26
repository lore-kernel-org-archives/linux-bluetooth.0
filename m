Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FA9EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jun 2023 16:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjFZQoN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFZQoL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 12:44:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FCC18E
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 09:44:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b69a48368fso26936021fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687797848; x=1690389848;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S97iDdxXomin2hgt7Q7KQsGB2EbuZT6bm8fRUpHJMbI=;
        b=RivLTjPa0uyxXPTumYvPfVCDjZCKcsjSa1jGaNdB2ARoh2RyFMDeBalptJQbDU3lA1
         /nWQhpUKJwSKQpzgzpRtk5+LsrbEaetMaRA7SvF4qmvF7khzlddBa87+TJJ5sFNv7zkC
         2FQU5O7E6+U4CQUbLW7v6POxlmvVx4v/KmcFGmyi5Wc+GN0EEuAgNrKXj6NL/zZbSd5z
         PVnwpb9sCm3kFxkpFlQ8RBTbj2yo3NLGfnaRZro0RzwiVsfgMquh4vvnjxIUUXxMQBH7
         RFm/fT2inWDVtc0zuff9eU6TLJZnVmS5Nww90qB1GSaDJoCSKAayXlfdPVJ4RwpWdg50
         fYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797848; x=1690389848;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S97iDdxXomin2hgt7Q7KQsGB2EbuZT6bm8fRUpHJMbI=;
        b=lA45XpQwzBeBz4wRojBKt1l97UVgsHvzYJC0uitvFKagZ6RYseUtR9M7Z4/rU297zP
         g26Goda8L6L9Fdmh0Iv3SJErID2/STGTgf53mAg8/5bnqSODv8aursp3D9mtWmx+4iAW
         dAWqoIcbGTU5zTnXybYMKvj3gsqkkHz6zgKZOgSEAfw0uKnGZEOesCcD194iNVvhKjEh
         YoHpq0Svj7FJwErRA3kiiroAf1FQT+5Yx3EikVnExld6yMstIEOl+xqIqgipROcoIRw/
         2npPPXabJTGoFbExNlcvWxBXwNfNWpIZekvF9/EwlR3S/kT9/GdMQyOtblw/l9YMWAmk
         LmjA==
X-Gm-Message-State: AC+VfDz7Fqg1f6Uxxj5z+QLs+uC4gRmPiYjR7GbmqZ36wi1coEWal/Vd
        eMYkvVSE2hp8UbocLgB5rzQUZdmIs0qGlZ64BnoqfamIo7DWxA==
X-Google-Smtp-Source: ACHHUZ7D3hHHxcQsB4a0SRSR9ydPkLDGFUtHqpkWc55A3SiWEjW7ldQwobPO3EVo3O/kLjKa/BAAd5Gv48ZvFNfHA2Q=
X-Received: by 2002:a05:6512:39c4:b0:4f6:1b9e:d2fb with SMTP id
 k4-20020a05651239c400b004f61b9ed2fbmr17447434lfu.11.1687797847242; Mon, 26
 Jun 2023 09:44:07 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitriy <dms700@gmail.com>
Date:   Mon, 26 Jun 2023 12:42:25 -0400
Message-ID: <CAAdvvMdexKkhtNA3y1FQFQczDLrrJtZC=kT8VkXuqwt_5VQL+w@mail.gmail.com>
Subject: BlueZ-hid2hci package for android-x86
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello

Does the BlueZ-hid2hci package exist which can be installed on 32 bit
android-x86?

I have Dell E6400 laptop (Intel Core 2 Duo CPU) with Dell 370
Bluetooth mini PCI card (VID/PID 413c:8156), as far as I understand,
this card is based on Broadcom BCM2046 (VID/PID 0a5c:4500). In CentOS
I was able to make this Bluetooth card work by installing the
bluez-hid2hci package. I'm trying to make this card work in
Android-x86 4.19.110.

Thank you
Dmitriy

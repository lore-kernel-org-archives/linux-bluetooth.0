Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1874DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jul 2022 19:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiGLTyq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbiGLTyZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jul 2022 15:54:25 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16EE2DFD
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 12:52:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r9so7699390lfp.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yROFK4jI4+6AV7RIHB+FYCReHAB+j1nghwp6t7Uhvus=;
        b=pDL9jYYGn+srzQlaYSDgtdRGp/DCDPo9EB9lS14Xvv0kTtmHSn8DPGjURxtxwkb57D
         olQTpBnA9nL291pMP887YWPqc0mk1RYz22K/yAqZGh0gcmHf3qd/ulMf1gf6jsbT5yn7
         HMgo0IBEQ62LGGHfMmeIkPWYpCFz89sYh36LDo8lY0rbZ1veqa2JdapTYfkBZSsYiddO
         HlLXlroV0K4pkwFQexE7UcuOJqw/GHxlAaF/vRunarG3r0t5CRale53X+/UD0rfxJOpL
         zdfckKfSY93AuYoUz4rcrecbiDm0lXm+GJV6HCnXEd/Sro1/FA6ylbd1eAu4Df64HVs0
         bPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yROFK4jI4+6AV7RIHB+FYCReHAB+j1nghwp6t7Uhvus=;
        b=KsgX+dCf8iTX0bxirVutLv1RwFpekPho2novBJxeEJoo246mHdPpJp91odl2L8q0IT
         /90CghQ2+ER7FecNMQExWdtedUm9KDBuOIagcuwdOjczR6STWkOx6vIWXs+j0/3q2HYa
         CsXn3BdZUeoSuRrG0bhjjjv07rmJCAK98FVNGQizVK0E8kbxLVeur3+zijaUIPeNDO4l
         xZCBIgcd3ENl65UQekeWxKy6UNXXD81LBXYgWSQXuT05an2LC5p2826RjBgYM4DKJOyO
         IvHYU0sMGEyLaRxk4KPq8AEClWGiz3mwo1rAknULX/WQ/FL0IZkUl1nZm440maA1FB+z
         NL7g==
X-Gm-Message-State: AJIora/XOGRNXmO3sgaH9LKFToHKzPE7/IStQTMZmvF1kKR2WJe7YV3Z
        a51Wtg0q1ogUMv+haeTK2/w4r3JW8zWSr9AVFjR15YD1
X-Google-Smtp-Source: AGRyM1shAmqAxZ9KbHOa0xEEMEt4cHbbFv+rbmhHVRofxEDjR1h2ctGTUjUTLgYGD3tiFYCguEDi5PL70Apxs3Xptho=
X-Received: by 2002:a05:6512:2621:b0:47f:d228:bdeb with SMTP id
 bt33-20020a056512262100b0047fd228bdebmr15355508lfb.121.1657655576033; Tue, 12
 Jul 2022 12:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB5755315F09CF8B49984DE12FFE869@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZ+ei7=TXw_gP8keZaCyz5igABLxYxUnmBhAe35wAXoR0g@mail.gmail.com> <SJ0PR13MB57558B7A49D3A9C106C3C210FE869@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB57558B7A49D3A9C106C3C210FE869@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Jul 2022 12:52:44 -0700
Message-ID: <CABBYNZ+LytLtRwZBvZMgaiVnoR6AXeT7G4_n7DrZ_QgqZ8cTWw@mail.gmail.com>
Subject: Re: How does bluetoothctl work from the command line with gatt?
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Tue, Jul 12, 2022 at 11:56 AM John Klug <John.Klug@multitech.com> wrote:
>
> >You will probably need to wait for the daemon to resolve the services
> >which will then export the attributes as D-Bus objects that can be
>
> >accessed by bluetoothctl,
>
> How long would one have to wait?  The following was typed manually from the command line:
>
> >> # bluetoothctl gatt.select-attribute f000aa22-0451-4000-b000-000000000000
>
> >> # bluetoothctl gatt.acquire-write
>
> >> No attribute selected
>
> >> # bluetoothctl gatt.write 0x01
>
> >> No attribute selected
>
> I had no idea whether the above is the correct syntax or not. I merely guessed, since the procedure does not appear to be documented.

I think the problem is that you are issuing the select-attribute and
then exiting, instead you will need to enter all the commands at the
same time otherwise the next time you call bluetoothctl it doesn't
have any attribute selected.

>
>
>
>
>
> John Klug
>
>
>
>


-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A489C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 06:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiFVGO2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 02:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351041AbiFVGNk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635F111F
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 23:13:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c2so26076470lfk.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 23:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIgFc+BqRDl+KgYqLxVhkBlszhIdkNhAiyBTvU8dTJg=;
        b=ls4CAEC5d3in7jph9bo5MK4MBj/1kJfu4vOQiWUbA4P1gpKXt2AdXca8FrWWA82roP
         z48FHTL9CC8oIQRlhdKVfotIr+Y9jVIHx262vGUmZEKyIQ2CGjXTZx8sQYY3rPw6D2BQ
         77fGO/w0Rgal3JmDBmdIR8XLCyGQJWFjeCEhIRZBOTF88yzRiTAqFbcqKmlLS+vkNIX2
         FHhaiqxr3zyHhUinVWAGA0VvpHYmj1lD8q7Gkdca8QOL0JCrXv0OGSrTPMhGmMdHwSfm
         1qsa7VNQwgurKHP1ooCLWqks+f/NjCLK7PdHZVYDHH6+EFc8WV+OvQ1FzPtuZnf0c+HF
         bwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIgFc+BqRDl+KgYqLxVhkBlszhIdkNhAiyBTvU8dTJg=;
        b=LodHvuOCMH7Rrv6D7vNDMzaoAiBTjRPi7wdxkuqTr6BEIdA7uPwgOmWsq4TIRrbMg8
         0ulO57GVn/mDOgsVjORaX3N2RJo7mi05maPSQYyqcxK7dHAji+oKBjOv2hZfagP1KQz3
         46K8iX4PG1lP1MDnqv8xIQKV+JRH+HVhvr9M+KpSGhb/BWqW0HRIgGrGMMJ4Wjqz/Wvy
         qg61CB9vskN3fPZjTcR/cHNRQkxwrPeE7BnimuboJ91d0954MyMPKYHK19raWhdKOSVf
         HjGLrFIifFovFbNq/CBeCuzlb1PJ/697LQwVuBYqghFjcvF3H5u5r5ewplS5xlNtgurI
         dtQA==
X-Gm-Message-State: AJIora9wEj/Adj9PcfTMHvtRrJYvD0irV5Dd8Nk1La1teuCpxJfHN0/v
        Y0ngrsorbfeOW78zSkfRYL1YnrYH0qZjt+MLW6+OHycTbB4Mqw==
X-Google-Smtp-Source: AGRyM1tgdy0q+xYVpXe/wyNdB7YHXppwMEntpYmizzBr5RdBk5K0fEmsKNNIHEqxkhQpkNpa0A2IU2pSNOxdE/X0dI0=
X-Received: by 2002:a05:6512:3ca4:b0:47f:6e53:fb4 with SMTP id
 h36-20020a0565123ca400b0047f6e530fb4mr1194201lfv.57.1655878417593; Tue, 21
 Jun 2022 23:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB5755B778B99B396FF0FF6E55FEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZL=kGNjpR-E94tuTtU23PYn0d4qyxoDkc-O_EuxS6eZMA@mail.gmail.com> <SJ0PR13MB57552921E32DE0017E2584E7FEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB57552921E32DE0017E2584E7FEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Jun 2022 23:13:26 -0700
Message-ID: <CABBYNZJ3_U8jdT+Xqp-DuBj8vHq9UAu9Us=kqR66v=4VBfp5ww@mail.gmail.com>
Subject: Re: Is there an attribute for the name field in bluetoothctl?
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Tue, Jun 21, 2022 at 4:57 PM John Klug <John.Klug@multitech.com> wrote:
>
> The value from gatttool does not match the prompt ([CC2650 SensorTag]# )
>
> 2A00 is "SensorTag 2.0"
>
> This was defined by TI and is in their documentation with the value gatttool presents.
>
> How do I get the value "SensorTag 2.0" with bluetoothctl for the UUID 2A00?

Perhaps the name CC2650 SensorTag comes from the advertising? Anyway,
bluetoothd will read the name and update it on device information e.g.
info <address>

>
> John Klug
>
>
>
>
>
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Tuesday, June 21, 2022 6:40 PM
> To: John Klug <John.Klug@multitech.com>
> Cc: Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
> Subject: Re: Is there an attribute for the name field in bluetoothctl?
>
> Hi John,
>
> On Tue, Jun 21, 2022 at 4:05 PM John Klug <John.Klug@multitech.com> wrote:
> >
> > Gatttool Example:
> >
> >    [CC:78:AB:7E:87:07][LE]> char-read-uuid 2a00
> >    handle: 0x0003   value: 53 65 6e 73 6f 72 54 61 67 20 32 2e 30
> >    [CC:78:AB:7E:87:07][LE]> char-read-uuid 00002a00-0000-1000-8000-00805f9b34fb
> >    handle: 0x0003   value: 53 65 6e 73 6f 72 54 61 67 20 32 2e 30
> >
> > From Bluetoothctl:
> >
> >   [CC2650 SensorTag]# attribute-info 2a00
> >   Attribute 2a00 not available
> >   [CC2650 SensorTag]# attribute-info 00002a00-0000-1000-8000-00805f9b34fb
> >   Attribute 00002a00-0000-1000-8000-00805f9b34fb not available
>
> Certain attributes are controlled by the daemon so they are not
> exposed over D-Bus, this is not unique to BlueZ since I remember
> saying that on iOS it also don't allow applications to access some
> attributes directly.
>
> Anyway the name is actually parsed and you can even see it on your
> prompt and you can also give it an alias with set-alias command.
>
> > John Klug
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz

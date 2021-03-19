Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE02C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 06:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F2964F1C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 06:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhCSGH6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Mar 2021 02:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhCSGH5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Mar 2021 02:07:57 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80727C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 23:07:57 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r8so7058855ilo.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHMSmdMWfJgpRgLdS3+HxPjuM0d736RGr+p8SQtyz/A=;
        b=obCQ2gUamqaQ399ZAF/mkEh7IItfMxWP/o2jlI7WtOFpVFDhjupnnwyjCnB5dTP7En
         0jcKF3hLS5pt3ZVWEcXI3wt9SlSEGBp2wmLSwGzNCGPzUbQgNSt1l39HLj7W7KXYS4xA
         AVp+B8R2aOT0uHLYpUEwoLqcwlowgvrEfPfOhqIYzsEFK757eWJY41/Nt+RxbT/CMwnb
         /gGBdZ9DBBgQjOGmuQceNeqY4b+1JSJs8pUFRimhrcphjkBNu60rjHfduGf47t97aAzN
         +SrKJZlv8x4nBf0FuyvePNJOjVO2sbTTNZLT1pUHatVU14ZHuKY7v1tuxXQgjl0Sn14d
         51RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHMSmdMWfJgpRgLdS3+HxPjuM0d736RGr+p8SQtyz/A=;
        b=rMgO8Tv3puoBFHcBrhV7TntaiIWzAP5I45BhL9MWLCf05+S3qMB+BwXtC5wNRgJre8
         Ja2Ue52bpk2StaZk6dVgC8CgjjoJYnojiio17wAO5cg/n8au8uJEn3byV82jVpPlzl+f
         3Gl5llWPmX6feY2+F3HfsTpo5pydIkY04DRb2pSUeDSiXRv5J9Ma0m1l2RYvOrBfcIVn
         S/o+dtU4Kw1RQAoHZMqo5ENTzSuNoK/eBUFeZlx3HeoZ+CYEHLd2sPBcSC/kji2KlNEm
         uH2ne9/KiCj0K15fLFAiCXHxGU1bLGkPkxMy0vCktUj8ZyCwhvEggy/HtstkU+qKm5lM
         xEng==
X-Gm-Message-State: AOAM532uYoH7ej9fb5E3EwtoMBL9whF+R/G/cvYwj2Myg02dWIsqi/yG
        hLeXBw8sns5JRExnp5g8XK59+gzHwdJYl8W5OFTiTXWLBrWb
X-Google-Smtp-Source: ABdhPJw/WQ9BSklihVtPRZv0kz7GV/QU5Vd2AL0mUefWPdMIzhpn/0jaywMSH6lP1gEtUzSVoUVFBwNEMcuQIf7e0L4=
X-Received: by 2002:a92:7306:: with SMTP id o6mr1636019ilc.2.1616134076917;
 Thu, 18 Mar 2021 23:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NZrReFB-6_JwHFqJtLwqSuYGzKbZMvDeKYzh+Jof9iUjg@mail.gmail.com>
 <CABBYNZJJ5Jymk=51E-aeWE4VyXGvXsgSjftYRJY47_tNzzJWHA@mail.gmail.com>
 <CAC9s0Nb3eiZ29OSPQOSn9cWqf4DA22Q-D_RL-htXnq7gCcfSug@mail.gmail.com> <CABBYNZK_0wJtK2YpVt81suLmVVv6iEK6AEQGNxUG5Q1Ru+gm0w@mail.gmail.com>
In-Reply-To: <CABBYNZK_0wJtK2YpVt81suLmVVv6iEK6AEQGNxUG5Q1Ru+gm0w@mail.gmail.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Thu, 18 Mar 2021 23:07:48 -0700
Message-ID: <CAC9s0NZy7s_URDBU+cxJ7H+JX64FWx4LGZW4A=Ci5gzj8QnfqQ@mail.gmail.com>
Subject: Re: Have to delete "/var/lib/bluetooth" folder in order to get all
 service characteristics available
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thank you so much, Luiz. I appreciate it.

Yes, you're right. I counted the characteristics from the log. There
are exactly 9 services which include 92 characteristics. Do you think
it is "too many" by having 92 characteristics? Do you know if there is
any limit in BlueZ? It seems someone mentioned the number of
characteristics in this link:
https://devzone.nordicsemi.com/f/nordic-q-a/16233/nrf-connect-fails-when-using-many-characteristics

For the write request for the non-exist handle, I've asked our mobile
developer to check it on the mobile side.

Thanks again!

On Thu, Mar 18, 2021 at 9:30 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Kenny,
>
> On Wed, Mar 17, 2021 at 10:17 PM Kenny Bian <kennybian@gmail.com> wrote:
> >
> > Thank you so much for your reply, Luiz.
> >
> > We have a small device which runs a Linux system in it. In this
> > embedded Linux system, there is GATT server runs BLE service which
> > provides the services with the characteristics for reading and writing
> > from the mobile device such as iPhone. The folder "/var/lib/bluetooth"
> > is in the embedded Linux system. We call this embedded Linux as BLE
> > Server, and the iPhone as the BLE Client. During the testing a few
> > weeks ago, not only our mobile app crashed, but the nRF also crashed
> > as the service was changed. Since we have no way to tell whether the
> > ServiceChanged indication works or not. We disabled the bluetooth
> > cache. Then we have this new issue.
> >
> > I never saw the "[ServiceChanged]" section from the "info" file. I
> > tried to change the attributes of some characteristics. For example,
> > adding notification in some characteristics. Then restart the BlE
> > service from the Linux system. I did check the "info" file after that,
> > but I didn't see the "[ServiceChanged]" section. Is there another way
> > to have the "[ServiceChanged]" showing up?
> >
> > Today, I ran the testing again by doing the firmware upgrade. Right
> > after the firmware upgrade, I used the btmon to capture the
> > characteristics reading by using our mobile app. Please see the
> > attached log. As you can see, there are a lot of errors because there
> > are 5 services which only have the service itself listed(I checked it
> > by using nRF). For about 30 characteristics under those services can't
> > be seen. That's why there are errors when the mobile app tries to read
> > the data. I double checked, the BLE python files between these two
> > versions of the firmware are exactly the same. So there are no
> > ServiceChanged. As the reading didn't work, I had to remove the
> > "/var/lib/bluetooth" folder. Then this folder was recreated again. I
> > compared the file "attributes" and "info" before and after removal of
> > the "/var/lib/bluetooth" folder. The "attributes" files are exactly
> > the same. The "info" files are different. But it makes sense because
> > only the "[SlaveLongTermKey]" and "[LinkKey]" are different which is
> > caused by re-pairing from the mobile side, I guess.
> >
> > So in this case, the BLE service python code is exactly the same. The
> > "attributes" and "info" files are also the same or slightly different
> > because of the re-pairing. How come some characteristics cannot be
> > seen from nRF? As those characteristics are not listed in nRF, neither
> > nRF or our mobile app can read the data.
> >
> > Honestly, this situation is pretty much the same as there is no
> > firmware upgrade because the service file itself and those files under
> > "/var/lib/bluetooth" are almost the same. How come the normal reading
> > from the mobile app works fine? But after the firmware upgrade, some
> > characteristics can't be seen? Is there anything wrong about
> > advertisement? In fact, the firmware upgrade only copy over the
> > "/var/lib/bluetooth" in order to keep the pairing information. I have
> > no idea something went wrong. Are there anything else to look into?
>
> < ACL Data TX: Handle 64 flags 0x00 dlen 186
>       ATT: Read By Group Type Response (0x11) len 181
>         Attribute data length: 20
>         Attribute group list: 9 entries
>         Handle range: 0x000a-0x0013
>         UUID: Vendor specific (efb39360-a7e3-438f-a20d-e9f00e0e22b1)
>         Handle range: 0x0014-0x004c
>         UUID: Vendor specific (f57793c9-9544-46dc-bfa0-5fd149953c86)
>         Handle range: 0x004d-0x0061
>         UUID: Vendor specific (5040556b-340f-4c6f-b411-448089694628)
>         Handle range: 0x0062-0x00ac
>         UUID: Vendor specific (e05ad2ac-9a01-45f5-a56d-9c3c889d4dc6)
>         Handle range: 0x00ad-0x00ca
>         UUID: Vendor specific (51e16ff1-20d3-45ec-915c-f18290a893c5)
>         Handle range: 0x00cb-0x00fc
>         UUID: Vendor specific (e03d645c-3f2b-4693-a2fb-99840ee2581d)
>         Handle range: 0x00fd-0x0122
>         UUID: Vendor specific (5526a99e-7975-42ff-a27b-94d5a1ad9986)
>         Handle range: 0x0123-0x0144
>         UUID: Vendor specific (d72ce428-ba8c-4061-b6de-6f682736fe08)
>         Handle range: 0x0145-0x0151
>         UUID: Vendor specific (76a136d4-29fc-4217-b358-9bff4d6601ce
>
> So if I got you right you are saying that characteristics under the
> last 2 services are not listed? But they appeared on the logs:
>
> > ACL Data RX: Handle 64 flags 0x02 dlen 11
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0123-0x0144
>         Attribute type: Characteristic (0x2803)
> < ACL Data TX: Handle 64 flags 0x00 dlen 174
>       ATT: Read By Type Response (0x09) len 169
>         Attribute data length: 21
>         Attribute data list: 8 entries
>         Handle: 0x0124
>         Value: 8225012a7609433923a6925d42d5d4bf9307c4
>         Handle: 0x0127
>         Value: 82280181c6d99e78e5409a26411b1570c9c420
>         Handle: 0x012a
>         Value: 822b01d56926acbb8915bcad433323d6d170f4
>         Handle: 0x012d
>         Value: 822e01ba148cb7ef078a8406420e179ac55080
>         Handle: 0x0130
>         Value: 8231017715d4d9cd34078f004286be53568f03
>         Handle: 0x0133
>         Value: 8234012d4ead967eb781bb25442973c6247972
>         Handle: 0x0136
>         Value: 8237019997e76edb16c4b0b347be4445ee259c
>         Handle: 0x0139
>         Value: 823a01cdef05a932746f85b44aa6b0b1f07b6
> > ACL Data RX: Handle 64 flags 0x02 dlen 11
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x013b-0x0144
>         Attribute type: Characteristic (0x2803)
> < ACL Data TX: Handle 64 flags 0x00 dlen 69
>       ATT: Read By Type Response (0x09) len 64
>         Attribute data length: 21
>         Attribute data list: 3 entries
>         Handle: 0x013c
>         Value: 823d01f1406c52df184a929e44b967b5d5bba3
>         Handle: 0x013f
>         Value: 884001e85f5356a5e92a9a794cb5c0c68a90bd
>         Handle: 0x0142
>         Value: 8a430168db5fe9dcd35c8dec46efcb334ffa8
>
> So this informed the remote that there are a total of 11 (8+3)
> characteristics in the range of 0x0123-0x0144.
>
> > ACL Data RX: Handle 64 flags 0x02 dlen 11
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0145-0x0151
>         Attribute type: Characteristic (0x2803)
> < ACL Data TX: Handle 64 flags 0x00 dlen 90
>       ATT: Read By Type Response (0x09) len 85
>         Attribute data length: 21
>         Attribute data list: 4 entries
>         Handle: 0x0146
>         Value: 884701f09f9394856720a26047025b9ef90752
>         Handle: 0x0149
>         Value: 884a013fd59d9e09e280b95d4ef082b6251241
>         Handle: 0x014c
>         Value: 8a4d01f2b9f5d7d417f1bfb14fe66a4c9a476c
>         Handle: 0x014f
>         Value: 885001da299c6a9df1309f43421ece432e9233
>
> And there are 4 characteristics in the range of 0x0145-0x0151. In fact
> all the services seem to contain characteristics so if the remote
> cannot list them then the problem is on their side, also there are
> writes on the handles 0x04xx where there are no services whatsoever,
> so this tells me that the remote has a invalid cache even after
> performing a discovery and found out there are no services in the
> range 0x0152-0xffff:
>
> > ACL Data RX: Handle 64 flags 0x02 dlen 11
>       ATT: Read By Group Type Request (0x10) len 6
>         Handle range: 0x0152-0xffff
>         Attribute group type: Primary Service (0x2800)
> < ACL Data TX: Handle 64 flags 0x00 dlen 9
>       ATT: Error Response (0x01) len 4
>         Read By Group Type Request (0x10)
>         Handle: 0x0152
>         Error: Attribute Not Found (0x0a)

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E7C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 16:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D74264EB9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 16:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCRQae (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhCRQaB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 12:30:01 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84390C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 09:30:01 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so5721852otf.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLEu3r6NieVNGinXXeMP0BQjqOQDimpnQkCHGKjUqW8=;
        b=JpeKEwGSwC8QHMwA3FdcUOC1F4N1t1kdT8ZbSTCTgla4cRmdjxnza+MrSRZMVVSqiT
         cKIZtW8+lxkNAmSSG8NVwXC8SBlXxxmVD39wzEe9G/kr3MvNZncF8t8yBo2K6s2i9xp8
         VtWK872I4THp0hjAI8rfl7inUYFxrVug7EGIpbBCE7rIyXc7gLHI2kdGO358uMaulFM4
         tgjuohlFWh6wP+/M5/GnhVZV2KXSlPIIq/qiXcQVEuhMrhTUp78SGJAI4V9uK0IRJ/Mc
         yNT1Ht6izRO9+xDlG1/1EkEvz5NRv2v+752D5Y8p33w3cvyeviaFY9FcrZgTBpDao0pW
         q9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLEu3r6NieVNGinXXeMP0BQjqOQDimpnQkCHGKjUqW8=;
        b=IYYn1cWHIeqywpOD3R6Ai83AU3jrxjOMnWRPMdx0uod0U+h1RDsQeIPvPStjRXUUHa
         yoxeGPlF4Q2JLBi6OIuTfPTM7FRVGRfJjVXZ5hdrvfZeZZAv050YbdRe9VnhkwZ8pc0T
         x++Q/HTH43SRIV+AR7r7+FDpLrU+KgwW0MpIK+6R9dFOEYXN5E/34IVdkch/zB4B3FlG
         v8IWHSuyfa/ldwoy/poAbyNBLcmN054/lFKXzRgPC/8tnqOZCOJ+BWHCU3Tir5QtSKL8
         g3fuTVRhJHxGToQoFIMHie0IX4MQy43lcNG0oUkpk1rIDBSOEWZ2XmGECXCJP69f+NVk
         YTFQ==
X-Gm-Message-State: AOAM531w6Zy5NqTMSlAL+nTwKwcCHIY9uREjpV8otIuaMYv9wODn/KVH
        1ROL+HRM1lNNWwJolknjbzoA98X96MBzweJ3o4LnmlN6iNaN9Q==
X-Google-Smtp-Source: ABdhPJzJtSzBuXPttJIo5cKmqaphOu1Gu49gODAHeASDX/rkJRgZRyAPocBACww1WgwAhGvY7Jp6HYKTVc0PVEUqbDc=
X-Received: by 2002:a05:6830:619:: with SMTP id w25mr8058776oti.371.1616085000731;
 Thu, 18 Mar 2021 09:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NZrReFB-6_JwHFqJtLwqSuYGzKbZMvDeKYzh+Jof9iUjg@mail.gmail.com>
 <CABBYNZJJ5Jymk=51E-aeWE4VyXGvXsgSjftYRJY47_tNzzJWHA@mail.gmail.com> <CAC9s0Nb3eiZ29OSPQOSn9cWqf4DA22Q-D_RL-htXnq7gCcfSug@mail.gmail.com>
In-Reply-To: <CAC9s0Nb3eiZ29OSPQOSn9cWqf4DA22Q-D_RL-htXnq7gCcfSug@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 Mar 2021 09:29:49 -0700
Message-ID: <CABBYNZK_0wJtK2YpVt81suLmVVv6iEK6AEQGNxUG5Q1Ru+gm0w@mail.gmail.com>
Subject: Re: Have to delete "/var/lib/bluetooth" folder in order to get all
 service characteristics available
To:     Kenny Bian <kennybian@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kenny,

On Wed, Mar 17, 2021 at 10:17 PM Kenny Bian <kennybian@gmail.com> wrote:
>
> Thank you so much for your reply, Luiz.
>
> We have a small device which runs a Linux system in it. In this
> embedded Linux system, there is GATT server runs BLE service which
> provides the services with the characteristics for reading and writing
> from the mobile device such as iPhone. The folder "/var/lib/bluetooth"
> is in the embedded Linux system. We call this embedded Linux as BLE
> Server, and the iPhone as the BLE Client. During the testing a few
> weeks ago, not only our mobile app crashed, but the nRF also crashed
> as the service was changed. Since we have no way to tell whether the
> ServiceChanged indication works or not. We disabled the bluetooth
> cache. Then we have this new issue.
>
> I never saw the "[ServiceChanged]" section from the "info" file. I
> tried to change the attributes of some characteristics. For example,
> adding notification in some characteristics. Then restart the BlE
> service from the Linux system. I did check the "info" file after that,
> but I didn't see the "[ServiceChanged]" section. Is there another way
> to have the "[ServiceChanged]" showing up?
>
> Today, I ran the testing again by doing the firmware upgrade. Right
> after the firmware upgrade, I used the btmon to capture the
> characteristics reading by using our mobile app. Please see the
> attached log. As you can see, there are a lot of errors because there
> are 5 services which only have the service itself listed(I checked it
> by using nRF). For about 30 characteristics under those services can't
> be seen. That's why there are errors when the mobile app tries to read
> the data. I double checked, the BLE python files between these two
> versions of the firmware are exactly the same. So there are no
> ServiceChanged. As the reading didn't work, I had to remove the
> "/var/lib/bluetooth" folder. Then this folder was recreated again. I
> compared the file "attributes" and "info" before and after removal of
> the "/var/lib/bluetooth" folder. The "attributes" files are exactly
> the same. The "info" files are different. But it makes sense because
> only the "[SlaveLongTermKey]" and "[LinkKey]" are different which is
> caused by re-pairing from the mobile side, I guess.
>
> So in this case, the BLE service python code is exactly the same. The
> "attributes" and "info" files are also the same or slightly different
> because of the re-pairing. How come some characteristics cannot be
> seen from nRF? As those characteristics are not listed in nRF, neither
> nRF or our mobile app can read the data.
>
> Honestly, this situation is pretty much the same as there is no
> firmware upgrade because the service file itself and those files under
> "/var/lib/bluetooth" are almost the same. How come the normal reading
> from the mobile app works fine? But after the firmware upgrade, some
> characteristics can't be seen? Is there anything wrong about
> advertisement? In fact, the firmware upgrade only copy over the
> "/var/lib/bluetooth" in order to keep the pairing information. I have
> no idea something went wrong. Are there anything else to look into?

< ACL Data TX: Handle 64 flags 0x00 dlen 186
      ATT: Read By Group Type Response (0x11) len 181
        Attribute data length: 20
        Attribute group list: 9 entries
        Handle range: 0x000a-0x0013
        UUID: Vendor specific (efb39360-a7e3-438f-a20d-e9f00e0e22b1)
        Handle range: 0x0014-0x004c
        UUID: Vendor specific (f57793c9-9544-46dc-bfa0-5fd149953c86)
        Handle range: 0x004d-0x0061
        UUID: Vendor specific (5040556b-340f-4c6f-b411-448089694628)
        Handle range: 0x0062-0x00ac
        UUID: Vendor specific (e05ad2ac-9a01-45f5-a56d-9c3c889d4dc6)
        Handle range: 0x00ad-0x00ca
        UUID: Vendor specific (51e16ff1-20d3-45ec-915c-f18290a893c5)
        Handle range: 0x00cb-0x00fc
        UUID: Vendor specific (e03d645c-3f2b-4693-a2fb-99840ee2581d)
        Handle range: 0x00fd-0x0122
        UUID: Vendor specific (5526a99e-7975-42ff-a27b-94d5a1ad9986)
        Handle range: 0x0123-0x0144
        UUID: Vendor specific (d72ce428-ba8c-4061-b6de-6f682736fe08)
        Handle range: 0x0145-0x0151
        UUID: Vendor specific (76a136d4-29fc-4217-b358-9bff4d6601ce

So if I got you right you are saying that characteristics under the
last 2 services are not listed? But they appeared on the logs:

> ACL Data RX: Handle 64 flags 0x02 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0123-0x0144
        Attribute type: Characteristic (0x2803)
< ACL Data TX: Handle 64 flags 0x00 dlen 174
      ATT: Read By Type Response (0x09) len 169
        Attribute data length: 21
        Attribute data list: 8 entries
        Handle: 0x0124
        Value: 8225012a7609433923a6925d42d5d4bf9307c4
        Handle: 0x0127
        Value: 82280181c6d99e78e5409a26411b1570c9c420
        Handle: 0x012a
        Value: 822b01d56926acbb8915bcad433323d6d170f4
        Handle: 0x012d
        Value: 822e01ba148cb7ef078a8406420e179ac55080
        Handle: 0x0130
        Value: 8231017715d4d9cd34078f004286be53568f03
        Handle: 0x0133
        Value: 8234012d4ead967eb781bb25442973c6247972
        Handle: 0x0136
        Value: 8237019997e76edb16c4b0b347be4445ee259c
        Handle: 0x0139
        Value: 823a01cdef05a932746f85b44aa6b0b1f07b6
> ACL Data RX: Handle 64 flags 0x02 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x013b-0x0144
        Attribute type: Characteristic (0x2803)
< ACL Data TX: Handle 64 flags 0x00 dlen 69
      ATT: Read By Type Response (0x09) len 64
        Attribute data length: 21
        Attribute data list: 3 entries
        Handle: 0x013c
        Value: 823d01f1406c52df184a929e44b967b5d5bba3
        Handle: 0x013f
        Value: 884001e85f5356a5e92a9a794cb5c0c68a90bd
        Handle: 0x0142
        Value: 8a430168db5fe9dcd35c8dec46efcb334ffa8

So this informed the remote that there are a total of 11 (8+3)
characteristics in the range of 0x0123-0x0144.

> ACL Data RX: Handle 64 flags 0x02 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0145-0x0151
        Attribute type: Characteristic (0x2803)
< ACL Data TX: Handle 64 flags 0x00 dlen 90
      ATT: Read By Type Response (0x09) len 85
        Attribute data length: 21
        Attribute data list: 4 entries
        Handle: 0x0146
        Value: 884701f09f9394856720a26047025b9ef90752
        Handle: 0x0149
        Value: 884a013fd59d9e09e280b95d4ef082b6251241
        Handle: 0x014c
        Value: 8a4d01f2b9f5d7d417f1bfb14fe66a4c9a476c
        Handle: 0x014f
        Value: 885001da299c6a9df1309f43421ece432e9233

And there are 4 characteristics in the range of 0x0145-0x0151. In fact
all the services seem to contain characteristics so if the remote
cannot list them then the problem is on their side, also there are
writes on the handles 0x04xx where there are no services whatsoever,
so this tells me that the remote has a invalid cache even after
performing a discovery and found out there are no services in the
range 0x0152-0xffff:

> ACL Data RX: Handle 64 flags 0x02 dlen 11
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0152-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0152
        Error: Attribute Not Found (0x0a)

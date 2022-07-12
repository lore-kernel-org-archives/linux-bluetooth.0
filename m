Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561E9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jul 2022 20:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiGLUEX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiGLUEV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jul 2022 16:04:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D012752
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 13:04:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bp17so7904460lfb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 13:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AqHAo9pvYnfNw6xrZPZZtcKWkzYr6rHrx3YGG3sMiRI=;
        b=QwPHuMHgzu8Gdkt/2PMnqd0GnbMh7Wu7KZpCsNQ2lhDN8IVhBRdVsDXb7Dz2DPuCqp
         ByEL5hSyb1bZ62mmjwQ9bNTZZ6UZR8+jR5qy1bU62gIpVPiqxsQhNqU9uMs+QfMLWUS2
         kU0e7CNlgVgNTwrJM5d7YuVXqC5UhuYpwPNclDeGB2c/UXbjk2UuoTKUHUHJ6R4bKJZT
         pZ3MhChdO+h7XHmjhSOk2PXTdrtdr+YdmjEjaZzzowAY9GJBOb/FZ7FhLZBD+fSu5I/C
         f65cb71RaD39EK+WsrmxZ+eRXgkdVaseH+QAFEBm/Q7zex3GI8XxQ35ctiA0zcN7JREH
         2N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AqHAo9pvYnfNw6xrZPZZtcKWkzYr6rHrx3YGG3sMiRI=;
        b=EjPQ3/zp1ZCFlYSYA5AEOCQPnoLUIhCrXg2j4qzBagqLogHr1s++/cqGBNTJzzHUnr
         kG9+y19pGdBAzJEJs2yf5y/fS4BFJvmBjgpE+mkU6Jd4JWfGptPKtz0Y0vM9wbz7WChl
         072oFwdHtzMmo3VM+cK0htR+YNxnzGZWmkN2umiHNdaj87EN6oQFXIeXZbZWn+3yRP+E
         P1bcfy3bmyoNb+gmH/h0P8gdjVc4Ux4/aYWcDf/jLNfb+X4iBCqOBICNPunipAvRn6uO
         GAnS43RilkQQKn/epRXwBYbZFsaYDZdAU8UI2G1UaSeeDPXcoe0e+F4UJQK+TcNNiuIK
         /G4g==
X-Gm-Message-State: AJIora96uwd0IwwEbzpYio8bTGsZSilRqWVCSg6YwgiK6UkH1nnX4pJU
        HdceJgmtdBSpAoq4RXPIzDFO18y8fiRKfcgapz3YnzGW
X-Google-Smtp-Source: AGRyM1twFtG3QC304ABXLcVv+OLWX87Vvvo8WxnCAz9srAq+g9058iPYPWjEIaeLPTqLHJTOuQZiixQG/4dT21uYc8g=
X-Received: by 2002:a05:6512:31d0:b0:47f:92c6:99f1 with SMTP id
 j16-20020a05651231d000b0047f92c699f1mr17047738lfe.198.1657656258423; Tue, 12
 Jul 2022 13:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220709183524.13900-1-shwoseph@gmail.com> <CABBYNZKPmGza6LUyq=izDiGUBYOnY6BhF_GxxB-TPHRL4QeXMQ@mail.gmail.com>
 <CAL2otiWQ-6GpUeB_jd2HV6zwou-Oh04nQjFQU2u_MBaB80F5qA@mail.gmail.com>
In-Reply-To: <CAL2otiWQ-6GpUeB_jd2HV6zwou-Oh04nQjFQU2u_MBaB80F5qA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Jul 2022 13:04:07 -0700
Message-ID: <CABBYNZ+fMt7vXAWNua_NQDZ4BP1TTv0FR8DZCeAPx8-70enjaA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/1] [v2] ExcludeAdapter configuration setting for
 input plugin
To:     Shawn J <shwoseph@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Shawn,

On Tue, Jul 12, 2022 at 12:35 PM Shawn J <shwoseph@gmail.com> wrote:
>
> I could see going that route, but doesn=E2=80=99t the input plugin regist=
er the hid profile on startup? Would RegisterProfile be able to seize the h=
id profile from the plugin at that point? If it can, I think this would sol=
ve the problem as long as it works with sdp. I=E2=80=99m still a little fuz=
zy on gatt/sdp and I thought profiles were more of a gatt thing.

We may need to do some changes, for instance it is probably better to
make input plugin register its profiles within src/profile.c like we
do with externa profiles, in fact this would probably be a nice thing
to do for every profile actually, so we have a src/profile.c managing
all our sockets instead of each plugin doing its own thing. Regarding
profiles, LE and Classic use the same term but they mean different
things, in LE there are GATT Services (which include attributes, etc)
and then a profile which normally consist of client procedures, on the
other hand in Classic the term Profile is used for both client and
server and uses SDP to declare it, RegisterProfile is actually meant
for Classic/SDP registration while in LE we have RegisterApplication
which has its own object tree to represent GATT services and
attributes.

> On Tue, Jul 12, 2022 at 14:18 Luiz Augusto von Dentz <luiz.dentz@gmail.co=
m> wrote:
>>
>> Hi,
>>
>> On Sat, Jul 9, 2022 at 11:38 AM shwoseph <shwoseph@gmail.com> wrote:
>> >
>> > As a bluez user I have run into cases where the input plugin can be pr=
oblematic because it binds both HID PSMs on all bluetooth adapters. Simply =
disabling the plugin is not an ideal solution if you want to, for example, =
run an application that binds PSMs 17 and 19 on adapterA while using a blue=
tooth input device on adapterB. This proposed feature would allow users to =
determine which of their adapters can be engaged by the input plugin. Using=
 the ExcludeAdapters key in input.conf a comma separated list of bdaddrs ca=
n be specified that the input plugin will not start a server on.
>> >
>> > shwoseph (1):
>> >   ExcludeAdapter configuration setting for input profile
>> >
>> >  profiles/input/device.c   | 22 ++++++++++++++++++++++
>> >  profiles/input/device.h   |  4 ++++
>> >  profiles/input/input.conf |  4 ++++
>> >  profiles/input/manager.c  | 34 +++++++++++++++++++++++++++++++++-
>> >  4 files changed, 63 insertions(+), 1 deletion(-)
>> >
>> > --
>> > 2.32.0
>>
>> Well those PSM would require root to bind anyway so if the intention
>> is to allow implementing something like an HID device perhaps we would
>> better off allowing RegisterProfile with HID UUID that way the daemon
>> still have control of these PSMs but it can dispatch the connections
>> to an application that has registered:
>>
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.=
txt
>>
>> On the plus side you can register an SDP record for it, but we may
>> need to do some changes if we want profile to be registered only to a
>> specific adapter.
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

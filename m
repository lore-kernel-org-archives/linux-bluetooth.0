Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F58C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 20:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbiEaUXO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 16:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346033AbiEaUXJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 16:23:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2605643E
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:23:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 187so2650502pfu.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gfi7G+CP6roGIfnxieabnQUANo43iJCEu/CjN+F8eA=;
        b=nuO1ZPddwNMO7IB5hIbI1NPz3rZuzkGZOZzId4iqWqq5uxFbo7xIxQ7sPzyK/ePyy1
         X60/3hZyVfaEyBq/7/w10soauIUJkI49Q3pjpwubdQeXdLhhzvFdHF6sjHGeBhfVnBcL
         QvU4ODUsNmycPntFp6Hj9uO3YE6evOu6ZaDoRo1baeAQNVZBG2B2yHl8QV+spRJP20vT
         N1EbHmjhP2ubn7hdinYFZni72mh7/OtuYPg0kKHyWMIVkZsvjAQ5eRL1gPAuaPn1BjO6
         tek7DOVO3Gd78H/NmFq8PDcq2Q4ThyOVVnPoXUluogHqVvvOtQzsT7XJGXsZI5gV1suL
         c6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gfi7G+CP6roGIfnxieabnQUANo43iJCEu/CjN+F8eA=;
        b=r47MIXLYTla5MSoDN4bjRW4bq4PuHoy/YI/d9esL0ydZyy91nHdzFyf6rG7BR2nwDe
         aYeOtK30evv2sET9ICV6Rp4NzEsoDrIKRKPgd3UGBRRON1fpDFTEg20DJfDZrClIxWP/
         C0pakOcMqSOFi/dKyGaEmnrUHbegC9Qo25MkyntUEWMSrVySUsyNKhJvVfw4kF0QlnHS
         8OUOkL50hwZaQ/rlkRyGumMz8dy53dOJiBLFQ7CvJgdN6raA+1E1tsST+Ee/OXB0iZgI
         Emukv+Q3ieknTFU++GzCjpD0w2H1oWE8tFfTprBiVisEUDqFgM5ot1zc86EL4GIUGZ5d
         FNGw==
X-Gm-Message-State: AOAM532JZacGuk5UE36KYczjS72ENnE8JirLYA6A2J12IY77rRV1XhXJ
        yYzyTYcjcgPSjNmi4DAyDEFH0wwrpFp0zAibaRU=
X-Google-Smtp-Source: ABdhPJzxkv94vqF3jZOQRNBKip/XO+uVRIm9B/mz4eL4KmbOXtAFCaWm+2kkXrm3+FTzaW3e7FXB1Gl6YvM8c8NgAcI=
X-Received: by 2002:a63:8349:0:b0:3fc:6ca7:d417 with SMTP id
 h70-20020a638349000000b003fc6ca7d417mr2958505pge.591.1654028587039; Tue, 31
 May 2022 13:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com> <20220531074117.610321-11-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220531074117.610321-11-gopalkrishna.tiwari@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 31 May 2022 13:22:55 -0700
Message-ID: <CABBYNZJqnj0x-7wheW8WG9p6oP2DqLh9PBuoqT6K0QmhW5g5uw@mail.gmail.com>
Subject: Re: [Bluez V2 10/13] Fixing use after free in src/device.c
To:     Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Gopal Tiwari <gtiwari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gopal,

On Tue, May 31, 2022 at 12:42 AM Gopal Tiwari
<gopalkrishna.tiwari@gmail.com> wrote:
>
> From: Gopal Tiwari <gtiwari@redhat.com>
>
> Following traces reported by covirty tool
>
> Error: USE_AFTER_FREE (CWE-416):
> bluez-5.64/src/device.c:2962: path: Condition
> "!dbus_message_get_args(msg, NULL, 0 /* (int)0 */)", taking false branch.
>
> bluez-5.64/src/device.c:2965: path:
> Condition "device->bonding", taking false branch.
>
> bluez-5.64/src/device.c:2968: path:
> Condition "device->bredr_state.bonded", taking true branch.
>
> bluez-5.64/src/device.c:2969: path: Falling through to end of
> if statement.
>
> bluez-5.64/src/device.c:2977: path: Condition "state->bonded",
> taking false branch.
>
> bluez-5.64/src/device.c:2983: path: Condition "agent", taking
> true branch.
>
> bluez-5.64/src/device.c:2984: path: Falling through to end of
> if statement.
>
> bluez-5.64/src/device.c:2990: path: Condition "agent", taking
> true branch.
>
> bluez-5.64/src/device.c:3005: path: Condition "bdaddr_type != 0",
> taking true branch.
>
> bluez-5.64/src/device.c:3006: path:
>
> Condition "!state->connected", taking true branch.
>
> bluez-5.64/src/device.c:3006: path:
> Condition "btd_le_connect_before_pairing()", taking true branch.
> bluez-5.64/src/device.c:3007: freed_arg: "device_connect_le" frees
> "device->bonding".
>
> bluez-5.64/src/device.c:3007: path: Falling through to end of
> if statement.
>
> bluez-5.64/src/device.c:3012: path: Falling through to end of
> if statement.
>
> bluez-5.64/src/device.c:3017: path: Condition "err < 0",
> taking true branch.
>
> bluez-5.64/src/device.c:3018: double_free: Calling "bonding_request_free"
> frees pointer "device->bonding" which has already been freed.
>
> Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
> ---
>  src/device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/device.c b/src/device.c
> index 8dc12d026..a0e5d40db 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2942,6 +2942,7 @@ static void bonding_request_free(struct bonding_req *bonding)
>                 bonding->device->bonding = NULL;
>
>         g_free(bonding);
> +       bonding = NULL;

I don't think this fixes anything really, since bonding variable goes
out of scope this won't change anything, in fact this seems to be a
false positive since device->bonding shall be set to NULL in the if
statement just above any other call to bonding_request_free will bail
out when checking !bonding, it would be a problem if and only if the
code was using bonding pointer directly instead of device->bonding
with bonding_request_free.

>  }
>
>  static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz

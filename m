Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68692C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 00:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiCVAp2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiCVAp1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 20:45:27 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1A41AF23
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 17:44:00 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2e5969bdf31so174000537b3.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVaMGVlds19YrsWteoVtE2Im5WbGxwrWJran1awjGjI=;
        b=ZM0dLz8hcH8XHPbABvDG/SMZs3483N6v4lu3d+dqhOLF9x/IBb0VYgI66n7FFB5NCs
         SR/ia+cWKEWtLAew9pna+veE8Rm0u2YXYWTTAclCsHIoIBKUjpKFVV3t+gfr5aG9wwY7
         bmyl6+P1d0ZalZzjGJLbCQ3wgJvKRTMxQjBgVhqaAkMeK0pXEsyJa/Y9F4KBIrUnbJ4F
         z2vHsv8rgYq5JAxvbEOqrJD5/mIwE7L4GU8D1Okp9svi/hdYUf5FQjoLZZwK9BYVpo/J
         nQD1jEXOtEncj7/MQoFIXJFnWYEDpAk5+xaMHdJzGaesO6BnVy4ifiuXAf/me17TJM9q
         izaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVaMGVlds19YrsWteoVtE2Im5WbGxwrWJran1awjGjI=;
        b=yr4UwZlXR2vD8McvPcKV+r6SBxRXBFBC7sdi+k6mQTb3Jn7XSQ/jaGA7PDvEWoxw+v
         T+f5eBcF54ERQtUbUHJDRjticlDKn8dAOiKqzuPEEPRf2AI57W33tLLxreaxjWzyJDdg
         /YZMUCuBCyK1ODf0JmfjFSirFoyDS0ARqZwItsLFRXgQi8cKHDD2HWn0ViOx1jY5chi2
         rXtw1mI1qtFaEPzGpH5lCVpDqiZEX8s5LzLkIjzrILOWoPr+Ne1hC7TEsBGqENwfwlPJ
         3XAUwJqUlFWbgjT1ouImg5QufUbp6zdlFCv1pazVNUYLG9xsqSQnHAvMaRmT/67U6vrT
         A/Pg==
X-Gm-Message-State: AOAM532i/Ib/arcEg92ezbaGzqP7XiBU4vbMLGaxy4d9tbLn0z5ACV4s
        xD0VhW6ITae9o4bGIA8DJXpv3XINAhR4oFsEkiXW/Mam
X-Google-Smtp-Source: ABdhPJwRN+NeuyILQmoWn+7o2QVCznQM2Vu9chtwjjp6LqeJifVq9UQWJAzaqW6PUBn97QL9Mhvkd1F3vNLEYjD7bC8=
X-Received: by 2002:a0d:dd8f:0:b0:2e5:b961:4098 with SMTP id
 g137-20020a0ddd8f000000b002e5b9614098mr25914331ywe.233.1647909839379; Mon, 21
 Mar 2022 17:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
In-Reply-To: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Mar 2022 17:43:48 -0700
Message-ID: <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Adam Pigg <adam@piggz.co.uk>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Adam,

On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
>
> Hi
>
> A bit of background, I write a linux desktop/mobile app called
> Amazfish which interfaces with several watches over BLE using their
> GATT services.  To do this, I use the bluez dbus api (technically a
> thin wrapper around it I wrote called qble
> https://github.com/piggz/qble)
>
> All has been good so far, I support several generations of
> Huami/Amazfit watches, as well as the open source Pinetime and
> Bangle.js.  For the Amazfit watches, i have implementations for older
> devies such as the Bip, and newer ones such as the GTS.
>
> Much of the reverse engineering comes from the Android Gadget Bridge
> project, which supports many more devices.
>
> My community of users donated to buy me a newer device called a GTR2,
> which, according to the GB devs uses the same protocol as the slightly
> older GTS, and the packet captures I have from Android would support
> this.
>
> But this is where my trouble starts with Bluez, my existing
> implementation doesnt work at all.  Normally, after a connection, I
> would wait for the ServicesResolved signal, which happens pretty fast
> on all other devices, but on the GTR2, it takes about 30 seconds, by
> which time, the watch has disconnected. (i get a disconnected signal
> immediately after the ServicesResolved signal)
>
> To rule out my code, I have tried several things:
> Gatttool
> With gattool, i can connect, get the services, enable a notification,
> write a value and get the expected results seemingly fine
>
> Python-gatt (using the bluez dbus api)
> Im unable to iterate the services, like my app, it takes 30 seconds to
> get the signal and then swiftly disconnects
>
> Gattlib (https://github.com/labapart/gattlib)
> Gattlib is interesting as it appears to have "borrowed" much of its
> code directly from bluez.  When built against the system bluez, if the
> version is > 5.42, it will use the dbus api.  When I do this, again im
> unable to list services on the watch.  However, if I edit the build to
> force it to use its internal gatt implementation, which appears to be
> the same one used by gatttool, then, it IS able to interrogate the
> watch.
>
> I have attached 3 files
> 1. test python program which should print services, and associated btmon
> 2. btmon output while using gatttool
> 3. btmon output running gattlib discover example
>
> Note, other than discovery, I havnt been able to get gattlib to
> read/write/notify!
>
> It seems as though I may be triggering a bug in the bluez dbus api?
> Can anyone suggest anything?

What version are you using? I would first try with the latest to see
if that something already fixed.


-- 
Luiz Augusto von Dentz

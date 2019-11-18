Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB3C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 18:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296BF222C2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 18:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVDvwbLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKRS14 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:27:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33813 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfKRS14 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 13:27:56 -0500
Received: by mail-ot1-f66.google.com with SMTP id 19so5491759otz.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 10:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KQjg9dZFnOPjlCsPXH0h3KUnXY8byYuGWlVq4QGXwY=;
        b=jVDvwbLiN5W+060wQHLYpP9yUzZqGj5ejEIczvuQ1EJ2LRNniDy5pDhVx3+VAAeKch
         Nj9QrHfvJ3RnjWogKNq86lqXgY0BZlECPT0/hpzmvGwjKGfdlz/qgM1bF1VU3+2LQ9iP
         M2NZE9rJFKKtEK0/zX8FFhGVXJNtZe+u67s/POH7URblkiSZjnwrmbL9WKljNPW9jX92
         UPY/Y4ET76UXUlmWbW4nEnD4ztlZbriMbTdNdJtROxNw03Izz7sb0hRc+5IFjV9YH5ae
         Q7NjkEiGzPifycLkgXR4Oan6bJbl2OPAtNI/e5kRiZTv9q+Qhp1+WfzuV1aSl3+q7xOs
         /rmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KQjg9dZFnOPjlCsPXH0h3KUnXY8byYuGWlVq4QGXwY=;
        b=Btbmh44SFrbwvOKWcbL5QCwS/RbBl9bXrcyPgPlyNog3ytkiCG7ExIm/KnvRGU0Cc1
         WoWm26MPpd3Ixz7x64WGn469TwNOo4JuDHkz577Fetnqge9+K0Tg3et8ponSsTX396kb
         9FoPM9rZUhf3r2gomms7hVfV9XITZPSprOMRe6DGIn8zuBHyGRVyZ9gwT/SI2qjiBLZW
         +ixdIwsb3ZlUJdJjQxegVEuDrP+2lD4oqOBedxzlJJki2uqECh6+yPgmTssDxK1u3uPe
         yYNoVSCmM8nhyyRmKbFkBZWViggPlq+0NM9FCn7iQTfb53QBJThlJPeir7mqIUc4XMU/
         2osw==
X-Gm-Message-State: APjAAAXWpk7ZKo5lPZKgPP2ePeMbZogEbsY6pUwCJkt0EM/oXi4L2TQu
        MeHiTJew74qk1UePA/ogrqysYabBk2L5mzGqNLrrwTtD
X-Google-Smtp-Source: APXvYqzpvvn6GOQxwgD5O0sBP9vSQ8wCPFzRJRV1mYJ3scJTu77Imd0phbNVAF6QKmC3hY/RHqvVKThl1zAjK8OZAzs=
X-Received: by 2002:a9d:5507:: with SMTP id l7mr474316oth.146.1574101675468;
 Mon, 18 Nov 2019 10:27:55 -0800 (PST)
MIME-Version: 1.0
References: <CAGssATiS=dpA=WOSfLek385o2g=C5sb0z+z=V7CDswn9_5Eu-g@mail.gmail.com>
In-Reply-To: <CAGssATiS=dpA=WOSfLek385o2g=C5sb0z+z=V7CDswn9_5Eu-g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 18 Nov 2019 20:27:42 +0200
Message-ID: <CABBYNZ+VfyOeWjfdE64bVQM0eAJE789NRBjy+wgKa_Dka2ZZJg@mail.gmail.com>
Subject: Re: Bluetooth disconnect event / Link layer monitoring
To:     Guy Morand <g.morand@scewo.ch>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Guy,

On Mon, Nov 18, 2019 at 7:19 PM Guy Morand <g.morand@scewo.ch> wrote:
>
> Hello bluetooth developers,
>
> We are developing a wheelchair that we can controle with a bluetooth
> gamepad, the XBOX 360 controller to be more precise. It basically works
> fine but when I remove the battery, I get the disconnect event in the
> user space around 10 seconds later. That is not acceptable since the
> wheelchair will keep rolling to potentially dangerous places!
>
> I tried to implement a ping mechanism on the bluetooth layer, inspired
> from bluez sources somewhere:
>   int _socket_fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP);
>   // bind on AF_BLUETOOTH
>   // connect with AF_BLUETOOTH
>
>   send_cmd->ident = PING_IDENT;
>   send_cmd->len = htobs(PING_DATA_SIZE);
>   send_cmd->code = L2CAP_ECHO_REQ;
>   if (send(_socket_fd, send_buffer, PING_PACKET_SIZE, 0) <= 0) {
>     // ...
>   }
>
> It basically works fine except when the signal gets bad. This will get
> printed by the kernel:
> [  859.629431] Bluetooth: hci0 link tx timeout
> [  859.635482] Bluetooth: hci0 killing stalled connection 9c:aa:1b:6b:51:c9
>
> In that case, I don't get event from the /dev/jsX device but the gamepad
> seems to still answer to pings??!!
>
> Since I haven't found any acceptable workaround and always find the same
> pages again and again, I'm asking here:
> * Is it possible to achieve what I want?
> * Does it make sense that the ping work but the HID layer seems dead?
> * Any recommendation, pointers?

Id look into adjusting the link supervision timeout instead of
creating a raw socket, you can use hcitool to do that, neither is
really great since it require root but at least the supervision
timeout is something a lot more reliable for this.

-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D12C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 20:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBAF206FB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 20:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c56GQOss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKKUyH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKKUyH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 15:54:07 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803DEC0613D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 12:54:07 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id l36so3472177ota.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 12:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvVEtENWUjU7P7iXetNisSLy1mYp3fhEH69QMRzl4zk=;
        b=c56GQOssDfS5BuvaWZVRC4HsL0vfgi5vXx+Z73d1eY3dHWZJFoadh+K0ssfTM756Yi
         N0Enl1TWYFOrMiT8dI2IyNzyztFrVOe/IdAOeCBj3cD7CYxK0n4WJGq90WOSSpk+btQs
         zk+R0atdT4eqo+OkhQCcYtGi59Y0UTbWri7Cnspl3EiNUwnUFHAhP6yURzy7tAepPflq
         fs4izvNPQXmtcm3BUt24mqqo4VEw8xMC1PZ86LgIbS3hoIR4I+8V2vTNYIWTAb4tgew2
         BaQuUngV9vIry1cQ20CFKNgvE1zCk1oZ5c9x4j9T4G9iQVOquAWsAcKKRN7fZ6N+gDTs
         6qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvVEtENWUjU7P7iXetNisSLy1mYp3fhEH69QMRzl4zk=;
        b=FE0GUw/B0hHsIXyn11JGov/dJ7DSkdzzxQulOEwb/GcoGLIRYgNwWNgQOgVXm37zlD
         Pz8q3CNRoA0VQBfkTrj7ADFmbf/0ai7rqeh3O5clx5kC3IP0+4safEtRRTjBf4a5kng5
         DXXoxnqVpxzMVjyxREiCfiMNpOncg44CvgHkKQSyAUZVFa2UaFY4cs53O2TZk5n1xGty
         sMc4ELjeqmMHSMFOkbM0TccVezZgBSCdhugEOluIh8v0TlmAbHw6YwoW7DCdjMAQqraP
         W+p219DeHd+ahgJqiQNZImiNSxa2Ez9hKbyL3Pb5i+FmhQ0ulVVd3p/pO54TEV+IVqOr
         Ld8Q==
X-Gm-Message-State: AOAM530I9rsVoi/ALjc1BzYzlolKZOhHcI14TrieueagSW5wjV8JH1IV
        U593JD7c/Wylvm0g5oYQB+lKophDqkdOYd7Juti6K7njtBp8bw==
X-Google-Smtp-Source: ABdhPJzXVZ+FzdlGfBh2L38dbZS0HrB+jFwIesN35tXWgyOTH7hfYYSjKUAWh6oGRSrRcwa8dbRmOtNa8vXeNYwiSm4=
X-Received: by 2002:a9d:4b81:: with SMTP id k1mr16272299otf.371.1605128045671;
 Wed, 11 Nov 2020 12:54:05 -0800 (PST)
MIME-Version: 1.0
References: <d343e320-b368-e85b-d428-d5c000eb69df@doubly.so>
 <b86e5449-d784-deee-87d8-4bcf1b4b6308@mnmoran.org> <d2ebb802-3bb6-63ed-de42-e1a2b0c38f36@doubly.so>
In-Reply-To: <d2ebb802-3bb6-63ed-de42-e1a2b0c38f36@doubly.so>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 11 Nov 2020 12:53:54 -0800
Message-ID: <CABBYNZKh2FBwVamTqznqaEO=1ksuhY=K9D4pQTbDszneLg1dag@mail.gmail.com>
Subject: Re: LE Advertising: Command Disallowed
To:     Devin Bayer <dev@doubly.so>
Cc:     "Michael N. Moran" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Devin,

On Wed, Nov 11, 2020 at 12:13 PM Devin Bayer <dev@doubly.so> wrote:
>
> On 11/11/2020 21.04, Michael N. Moran wrote:
> > Hi Devin,
> >
> > If I recall correctly, you get this if advertising is already enabled.
>
> For the first error (Advertise Enable), this makes sense. I also saw that on
> another host which seemed to be working.
>
> But the following seem to prevent advertisements from being sent:
>
> >> HCI Event: Command Complete (0x0e) plen 4      #16 [hci0] 3.407380
> >       LE Set Advertising Parameters (0x08|0x0006) ncmd 1
> >         Status: Command Disallowed (0x0c)
>
> >> HCI Event: Command Complete (0x0e) plen 4      #20 [hci0] 1.613980
> >       LE Set Advertising Data (0x08|0x0008) ncmd 1
> >         Status: Command Disallowed (0x0c)
>

You also need to ensure you are not mixing with extended advertisement
commands, iirc if the stack does send
BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS it would already prevent the
legacy version to work. Bottom line here is, either use entire stack
or switch to user-channel with a proper stack, mixed handling won't
cut anymore, and for the most part we should be covering all the
advertisement features over D-Bus if we don't please let us know if
there are still gaps.


-- 
Luiz Augusto von Dentz

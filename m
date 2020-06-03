Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399B7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCCB20659
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HeNgxm1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgFCQ3Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgFCQ3Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 12:29:16 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCEDC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 09:29:16 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id m23so633375vko.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXBGl8z8QxzbFhXV+S9O13cVVo+SarAnao+mzxQfHUc=;
        b=HeNgxm1MDyEqjMHgNFy5JnibZvlELZalnDv9lt+xQIw6OYUe7vACDQdQiSAU3nRMWJ
         tzqwVc8mMQIlp4NIbJDg5MFZVGCEOld2wzfGr7x4kM2ERM7Ip9LljvWibAm4W4RIykNy
         ads09s96FkcTauvSGEuSsfK0jL5CrMt9LOjek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXBGl8z8QxzbFhXV+S9O13cVVo+SarAnao+mzxQfHUc=;
        b=F7lYlaTidkPPcxT/Dnyz5BTdIVTz431ad8GtOtB00DgHW1QqxhfXVxHddh5IBmo92i
         0ojjJDpucM2AZu1lclSri5VfTgHa641ex9TEQ0ct8PhrfZYkHUOVHroRi9Qjl2abng4C
         Z3ZSPgAz5jfbvnmePc6WrzKpzcs6IYnfK0hEkWLdXHxpv4Son5Bx9j1+lrIYDUEqi2VM
         7Jxvv+HL5svASsyvQomRFeZ8VyKCEqsQrGn7/mJSglivma4YdzO5CFdTeXficV4l7Paw
         jHXO1JAxjG20+BkVnqaMTfKuHipsfoVX4towC6nf2OXKhBEzt4755e+WUHcU5dKR/LKO
         VLSg==
X-Gm-Message-State: AOAM533+d1QJ6M4DtLq/vZaym/0sORRBQJ+62jrTbcHLLXsVj6jmTdoM
        ft7tvxCpT9r/pmH90rJqO1ykFMOdRdkxnyOGs18skDUv1SDKUQ==
X-Google-Smtp-Source: ABdhPJzf+iUZGQ+omtCmOX5/rk/WWAcJ27O7UE6dKf6uMajRcPZA9n/hDWShNMn3RtTLP2dNEE4/ORFewvQ9iKcPYvU=
X-Received: by 2002:a1f:9189:: with SMTP id t131mr437669vkd.88.1591201755154;
 Wed, 03 Jun 2020 09:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0gA9Egmff0y4yTm2UH=ge+jJH1nMbLhTsRbUtP=+m8OLg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gA9Egmff0y4yTm2UH=ge+jJH1nMbLhTsRbUtP=+m8OLg@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 3 Jun 2020 09:29:01 -0700
Message-ID: <CANFp7mWTk9qFqUhvwhxZY97_J=MwwWV-8ctJYFGT8_QJw_bPmA@mail.gmail.com>
Subject: Re: Problematic BT commit in Linux 5.7
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Rafael,

I left a comment on the bugzilla post as well but I agree with you now
that it's probably bad to fail suspend when this occurs.

At https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_core.c#n3363,
we try to recover from a failed suspend by restoring running state and
returning an -EBUSY.
I think if we change this logic to not attempt to restore until
resume, log the error and allow suspend, that would probably be
preferable from a suspend perspective.
I will make this change, test it out and send the patch today.

Thanks
Abhishek

On Wed, Jun 3, 2020 at 9:16 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi Marcel,
>
> Unfortunately, we are observing system suspend failures on multiple
> lab machines as reported in the BZ entry at
>
> https://bugzilla.kernel.org/show_bug.cgi?id=207629
>
> which is due to the following commit:
>
> commit dd522a7429b07e4441871ae75ebbfcf53635bdd4
> Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Date:   Wed Mar 11 08:54:02 2020 -0700
>
>     Bluetooth: Handle LE devices during suspend
>
> Ostensibly, this is because the BT firmware on the machines in
> question does not match the new kernel code, but the firmware update
> requirement is not entirely obvious to the users and the steps to take
> in order to upgrade the firmware are not clear.
>
> Apart from the above, failing system suspend for a reason like a
> protocol timeout isn't really user-friendly, because the user may just
> have closed the lid of a laptop and is expecting the system to be
> suspended (so it may go into a backpack or similar).  Yes, the driver
> may not be able to suspend its device gracefully, but failing the
> entire system suspend really is a big deal and should be treated as a
> last-resort type of action.
>
> As stated in the BZ above, reverting the above commit along with
> "Bluetooth: Pause discovery and advertising during suspend"
> (4867bd007d25a8dfd4ffc558534f7aec8b361789) makes the issue go away, so
> can you please consider doing that?
>
> Alternatively, would it be possible to address the issue in a way that
> would not require many users to update firmware on their systems?
>
> Cheers,
> Rafael

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E27C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Nov 2022 17:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiKWRGK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Nov 2022 12:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbiKWRGJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Nov 2022 12:06:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF666D481;
        Wed, 23 Nov 2022 09:06:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669223167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3suul+1WiPGqw/3Olh9Iqz0TaLAlIdZ9odbSxdL1Q4M=;
        b=rnBo0Myc2Gjm6q/jpnyflSc8oIGL5i6WyHEarFGWBwRWD/QQMoDbOHMaXBTh9RyQjh88+w
        asPdF79F0YZELl1Y6dlHvNpRmA5fv5uLH6MPGBfrI9Ejh1S87AE0+nqlb+JslZa4WNfoGt
        klx1mJJE1xSapPwT94C7duVBg7GXXCJqP7b7MToNqY6asSt0A9Xzc3Q48ZfsI3cXe6X2G2
        qWidx0ga3PmGSsIKa1zzgWclgOQWo3Y+UStcCGkp5QIAkc3KgUlHxecwYIgZ1w3S3/0GzZ
        jtZLW9AZIgtXv0QmkKJcc5fs4FHJ7iUjJ4YPY0ZEY37fFyZ86OYvP1M2n41Ibw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669223167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3suul+1WiPGqw/3Olh9Iqz0TaLAlIdZ9odbSxdL1Q4M=;
        b=wH98igTiSxrUIz+HH4ZvhHQGAjBEGgLlg+9Zda3gyemIFAYGyzcppO6V/aVc8ojRimjt6u
        /VBvutQLk/TMJqDA==
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [patch V2 15/17] timers: Provide timer_shutdown[_sync]()
In-Reply-To: <3779da12-6da5-8f6b-ec93-f8d52e38a40@linutronix.de>
References: <20221122171312.191765396@linutronix.de>
 <20221122173648.962476045@linutronix.de>
 <3779da12-6da5-8f6b-ec93-f8d52e38a40@linutronix.de>
Date:   Wed, 23 Nov 2022 18:06:06 +0100
Message-ID: <87h6ypeh35.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 23 2022 at 13:02, Anna-Maria Behnsen wrote:
>> + * This obviously requires that the timer is not required to be functional
>> + * for the rest of the shutdown operation.
>
> NIT... Maybe the first requires could be replaced by
> assumes/expects/presupposes to prevent double use of required?

Yes.

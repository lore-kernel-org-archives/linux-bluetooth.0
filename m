Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7151BC43603
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4BC20717
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 19:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwBvDkMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLPTRb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:17:31 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:45303 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLPTRb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 14:17:31 -0500
Received: by mail-pj1-f68.google.com with SMTP id r11so3406733pjp.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2019 11:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=unwqCziusuUsP9xh5yy5iHlg3lJ/dD+s33+iBsCpLJg=;
        b=HwBvDkMCxjnr4unOFya4kPwgBL9BvCWvb634pMWorlHI/bFSR3JTuwMzi6L91OnNM6
         AUXjCtvpPL/pHsl2M42GOiFqwVMenQ9rT9NdlTG+p7tqIIOSgqz75YZzqyao5qScmDK6
         1Zj4J6GXI+zFgh2PKg53fYKrauXsLETtb0oPPjRNwohbiVebhs6//QLeWAqm8N/AxLtH
         kZ0SAMNxVzDlLgFsMh9pLHGAOCUaCrOw5EPPowMpTN8CpwudefS+OMe1vnwaMDgYenbY
         pM8kdIGfh1Z/i2wTNak5Rl73y/3luBjaTLEugYg02zsFmccFTKs+VIyZzjIQohiCmClg
         ZC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=unwqCziusuUsP9xh5yy5iHlg3lJ/dD+s33+iBsCpLJg=;
        b=ONx9IPrSX+fViAT0exfvZFtxdp9NwwY+Jr49Ghh8WkJu24hKKf3R/vIrPoeRsvOqp8
         /5maR+DKirTl2BirbU184SGjH48c043v+vCpnlhiLhg4aoVPr1fkHQdKeT+OKrPvLhvv
         e46tAukXUKGci0unSigJFifpKENr/gERwvSrcV3kZgRYEhyQAb3wo90BCcqOT12f6qk8
         ZvDtlILo2GjQYfGDxN6ZoMDtvUtIlhkL3efyCiyWsoLez0x11lUGbGvvngOR2YVotbdT
         LdahHaX/1AZpUGPA7BaBh2o+GItO/06UsGy008eGrosxSSi8/INkcCkwpS9Z5AcFsHae
         Z0Iw==
X-Gm-Message-State: APjAAAWtwMzLbQpUDkF5gIkNVk/Rci7tYrZeirOZP6zZ/11bIGwagDIL
        TVsCQxmxRa0WT5SSRz+w8PCxx/nm1og=
X-Google-Smtp-Source: APXvYqyRusv8gW8C8xlijOFaAIQVt7sJLcAP1DqgUY2TaV6KmPbBBxU5W57zeLCbGuFVFAqtm0yZVA==
X-Received: by 2002:a17:90a:366e:: with SMTP id s101mr921887pjb.18.1576523850831;
        Mon, 16 Dec 2019 11:17:30 -0800 (PST)
Received: from vudentzs-t460s ([192.102.209.32])
        by smtp.gmail.com with ESMTPSA id m101sm259886pje.13.2019.12.16.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 11:17:30 -0800 (PST)
Message-ID: <8b0d837bcb492dfb86b13e08e11ff3840aae78b5.camel@gmail.com>
Subject: Re: [PATCH BlueZ] shared/mainloop: Use connect() instead of bind()
 for sd_notify
From:   luiz.dentz@gmail.com
To:     Guillem Jover <guillem@hadrons.org>,
        linux-bluetooth@vger.kernel.org
Date:   Mon, 16 Dec 2019 11:17:28 -0800
In-Reply-To: <20191214094052.GA363763@thunder.hadrons.org>
References: <20191214094052.GA363763@thunder.hadrons.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Guillem,

On Sat, 2019-12-14 at 10:40 +0100, Guillem Jover wrote:
> We are the client, so we should be using connect(2) instead of
> bind(2),
> otherwise when using non-abstract Unix sockets we will get an error
> that
> the address is already in use.
> 
> This breaks the notify support in dpkg's start-stop-daemon.
> ---
>  src/shared/mainloop-notify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-
> notify.c
> index 89a880006..1de714a0e 100644
> --- a/src/shared/mainloop-notify.c
> +++ b/src/shared/mainloop-notify.c
> @@ -91,7 +91,7 @@ void mainloop_notify_init(void)
>  	if (addr.sun_path[0] == '@')
>  		addr.sun_path[0] = '\0';
>  
> -	if (bind(notify_fd, (struct sockaddr *) &addr, sizeof(addr)) <
> 0) {
> +	if (connect(notify_fd, (struct sockaddr *) &addr, sizeof(addr))
> < 0) {
>  		close(notify_fd);
>  		notify_fd = -1;
>  		return;

Applied, thanks.


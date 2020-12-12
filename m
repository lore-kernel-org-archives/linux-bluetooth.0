Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F5FC2BB48
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22244230FF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439847AbgLLTUT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Dec 2020 14:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLLTUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Dec 2020 14:20:19 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029BBC061793
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Dec 2020 11:19:39 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y8so6453498plp.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Dec 2020 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qWel/g88vR7UrKMxr6LbiJv1bUH/gB8/c1SSFhxW8Cc=;
        b=KXvgabqLpOZx2sjjYujUvZDTj1DpXiazekvGElhwjKD6Qk7sUbfh1F7pp96EYWLbDa
         q5cxTjT8bTMzZNyio//sOh0rnXVEaSz5aE+UrBEjhD9OZGvLbUu/4B48U52go+6H83Uj
         WPvAfyxlM7OZwVXyIYe4OyczlMmPOakkCT3fmdE1+pj1u5ihLLAeTJaA/z5qnIldydVE
         7fzchiwS9wsJ5ioa0jvfnlalvj/3lxwyFjZVtx+74q7agR62EGEFfX/Ny+HvwGfrmK/0
         B649i1xRbZ/1v6HVDLq9bvZSTegPT0k2rZOVLXXPlK8xI4zee7Icpo/KVrKgDHLmu/9c
         kFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWel/g88vR7UrKMxr6LbiJv1bUH/gB8/c1SSFhxW8Cc=;
        b=X0xfdla28Evc5I68ght94wkZcvOjhNu2I4Sq7hrwrVTUf/8Uto0rysro7dfY7ePbXt
         8ndAB+t/33g69/vWr9xqMnJq4tvb/my2Zqmu9uXRsCnNPNGcICK3OYGGZmeJBRj61pq1
         lAnUkqEZPqTGd6NTvKSIF8TjAoLg0/YdPgFNFB+MugSb6Yslkm2cYHQUFrWj/8kLMemj
         SwZx9Gl3k5OftXG2WtXU3n7Fd+TwMqkLW7LhyekGB74VzCS8PRtEi9jVqHMeN26JTIIT
         J7hY3J+kmf4yrw5hNUUW8nDSAZlacs2OkT06VrM1k5/ZAX6KIawBYeuofjqOpeAUHUKX
         8UfQ==
X-Gm-Message-State: AOAM533eKDyP1Zi5S+20lZmzaUS0+urWZOCMO3KjmclhR2osGAGLmf78
        btbcUd7svJ+qpuNjnmY9s7X3NJVkgyc1LQ==
X-Google-Smtp-Source: ABdhPJwN2Yi1aanOQKAusksAx5fb0/NtPMYgrrGmD7mK8jIbEddQiqBMHl4H8FWG4Zi5zN42ykUAFQ==
X-Received: by 2002:a17:902:9a88:b029:d8:dd93:5846 with SMTP id w8-20020a1709029a88b02900d8dd935846mr6781426plp.28.1607800777668;
        Sat, 12 Dec 2020 11:19:37 -0800 (PST)
Received: from 04042b9c6998 (d66-183-16-58.bchsia.telus.net. [66.183.16.58])
        by smtp.gmail.com with ESMTPSA id x12sm14777281pgf.13.2020.12.12.11.19.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 11:19:36 -0800 (PST)
Date:   Sat, 12 Dec 2020 19:19:34 +0000
From:   Abe Kohandel <abe.kohandel@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: BlueZ Header Files
Message-ID: <20201212191934.GA8@04042b9c6998>
References: <20201212091747.GA16@a267d509f080>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212091747.GA16@a267d509f080>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I realized what I wanted to achieve is well encapsulated under a
BTPROTO_L2CAP socket and there is no need to expose these commands to
the user space.

Sorry for the premature question, I had confused myself with some
addressing issues and was unable to get the L2CAP socket to work
previously.

Thanks,
Abe

On Sat, Dec 12, 2020 at 09:17:47AM +0000, Abe Kohandel wrote:
> Hello,
> 
> I would like to preface this question by saying that I am very new to both BlueZ and linux application development.
> 
> I have a question regarding the differences between the BlueZ header files and bluetooth subsystem header files in the linux kernel. I have been specifically looking at the case of establishing a L2CAP LE connection for the Object Transfer Service and I can see that the linux kernel bluetooth header files have the definitions for L2CAP_LE_CONN_REQ (0x14) and the associated l2cap_le_conn_req structure but the BlueZ header files do not. I have been able to establish my connection by manually introducing these definitions in my application but I would like to compile my application against the BlueZ library and I cannot do that without these definitions. I would be happy to submit a patch to add the definitions but first wanted to understand if there was a reason for their absence.
> 
> Thanks,
> Abe

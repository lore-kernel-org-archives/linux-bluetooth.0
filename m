Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694C9C432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 14:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3557A20656
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 14:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+n8iBTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUOlo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:41:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37530 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfKUOlo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 09:41:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id b10so1704096pgd.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2019 06:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v3HAeKTDuYmzuUaQeHubT3yslGYo+k+ZzrAxM1aVtS8=;
        b=i+n8iBTpBDyR7d1J6RtX8F5T4vMMF7N4HmEspmZj3advGjog/V50F9QptSF0+XQKqx
         08qEAs1AEWkO2pQrNWz1q5FvDK1tBXeU75RwsQkuAKSFLnLVr1M8P7T1Lwn4nMvgWNBc
         dPzZ2QdqMShypk+VuXSamMvK10C/3Gq9nnsWtmJQ/9OuXEdaJMYVMhaAAGgjtanIAT3y
         iMlmC/geLgks3LIExOHzkiOP9ficC5yvuN6TVDj7Jk9gxQXW+tR63bqhNrel8+k1BG65
         HzIU4TX+iP4t8cPyRdW+LnZWlCPSBqcmy1MWsdw4NxkhfMHeYKsGUk5rOfLxpI2SCEXi
         RRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=v3HAeKTDuYmzuUaQeHubT3yslGYo+k+ZzrAxM1aVtS8=;
        b=F3Dn/nrTo7JHJD3Ym2s0WcPAC47zmimDMcqCJdwfsgwZTxOulIiPLlprONPBHRqLul
         aEwSTIfxLQzwICSquEsnDpbSMHl/9KsFIL+8K7XWy389CfpWcA2xFoBquaN8qmmVWi9P
         7/tIGCbuxjL3mt0dw0Fj2ZPe7KeTYoS13IM5iUrKODh07/CX+xyhsgwZVK2NhPnKAgf0
         ZaBmJ26xGN5xp+cV3TIccXRG08SM2GVw5Ae72cSKHiTVGsWNc3Vx9tlwvDTzctmoCAZV
         gQO52lneu7UUvnY+CBcE/tsglPVkYI47dtdjVgQD9rfcIeqhefsjYoirWTQgOqiaJ7hK
         EZwA==
X-Gm-Message-State: APjAAAUw7+pJa6Q8/1chm6xRqrwUFSsw3JNOiOmTFI3EIgDya2WSLKPn
        d+ERjaroR+H+HZPga5LDmgZ3EjmZE8s=
X-Google-Smtp-Source: APXvYqxGTOS8Qjz/Ajtx8lq8LeTYK3WaWBc5b4rrVS4gJCPE3fHGDQ5XA4M01XSas29SE+2oNI/ksA==
X-Received: by 2002:a62:e316:: with SMTP id g22mr11262246pfh.19.1574347303782;
        Thu, 21 Nov 2019 06:41:43 -0800 (PST)
Received: from localhost (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id f19sm4117170pfk.109.2019.11.21.06.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:41:42 -0800 (PST)
Date:   Thu, 21 Nov 2019 16:41:38 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Move error check into the right if-clause
Message-ID: <20191121144138.GA70662@vaespino-mobl1.amr.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20191121075130.92705-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121075130.92705-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Nov 21, 2019, Marcel Holtmann wrote:
> The if-clause for hdev->setup should also include the error handling
> since that is where the error really comes from. The code currently
> works correctly since ret=0 is assigned early on, but it is a lot
> harder to read and understand.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Both patches in this set have been applied to bluetooth-next. Thanks.

Johan

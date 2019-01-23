Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D690C282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 11:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2888E20870
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 11:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFzRBb/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfAWLea (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:34:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46023 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfAWLea (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 06:34:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so940550pgc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 03:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9axYZ7/8onrf5sAiiOI5QbsAjGDVxhi2CqQ563fvilQ=;
        b=WFzRBb/q1k4rwt1+5oxhJQqVxLk1sOjschVoY8Voq/NF8zFp0Kp8m7IqB8SGHPSac/
         Sonoh63Vgt2FMbsu1rOyviA3npiC4TS4hN5Rx0toF/Pd04sFeWCKW5pknNz4s5IF8nwB
         ivMhNKEmU7MZ0yILIDe2Am8eWTkuRv+hkEcy6f2ZWovGV9TrpwDncWKpVzgbs2AZk8sI
         N2qhTBVntfSYoZumLCc3O2gGjWUBYKOwYuRWSnJ2OqjSwEBuxG802w2QfMfATmyYis1g
         l3PRZIp0+Ik7boLySkNOUpHyLGXuvXB7Co9Cb/fUVmq1vNuL1OjLt8GEno6+NhRSoEDh
         Uw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9axYZ7/8onrf5sAiiOI5QbsAjGDVxhi2CqQ563fvilQ=;
        b=M/bXeyBWY8KQlDIO+a82mRQN/jq6P3JIH0i13U9SfPBHrl2rU6kIkBQiZRNffgBu63
         tKmgcsxd6SDhZV195arT89V8IQDLtuP+pCSUIONkq7marObs18sUp8DUvtfMdJqSgKI4
         DZvxOF6w+RbAKAbVmwUEU3jsFDp58tujAnw9tVgLr+3rAare4tyNUjbdDuU5SYmd7XFz
         HJgLvIleIfxmAmnEvfty106B+iM354V5v5r0PVj43pPLNcFOQMUbxA1PwDsMkALpYgjJ
         ZCtw0mkJ0LASzuFrEDaguG/JLBT03mq6Fl8jaGNUCAAhFYW+rDubktptubXO9EhzpL4G
         taxg==
X-Gm-Message-State: AJcUukdBUaaUpGTgtwn5/3De1k11JcFmdpXc2QJ29Mvg8gtjcJe4fi/P
        bA6QWeOw1FruOL+Rn5mKrrQ=
X-Google-Smtp-Source: ALg8bN5u5TBYfSBZKJ1vGqBo90/lO2OeELD0H7XSMvgOP96q9FjbjnD4++OOz9FrhzX326l0zprUCg==
X-Received: by 2002:a62:da5a:: with SMTP id w26mr1724973pfl.106.1548243269397;
        Wed, 23 Jan 2019 03:34:29 -0800 (PST)
Received: from localhost ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id l64sm26256922pge.73.2019.01.23.03.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 03:34:28 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:34:24 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] Bluetooth: Check L2CAP option sizes returned from
 l2cap_get_conf_opt
Message-ID: <20190123113424.GA11718@fcahill-mobl1.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org
References: <20190118115620.7562-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118115620.7562-1-marcel@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Jan 18, 2019, Marcel Holtmann wrote:
> When doing option parsing for standard type values of 1, 2 or 4 octets,
> the value is converted directly into a variable instead of a pointer. To
> avoid being tricked into being a pointer, check that for these option
> types that sizes actually match. In L2CAP every option is fixed size and
> thus it is prudent anyway to ensure that the remote side sends us the
> right option size along with option paramters.
> 
> If the option size is not matching the option type, then that option is
> silently ignored. It is a protocol violation and instead of trying to
> give the remote attacker any further hints just pretend that option is
> not present and proceed with the default values. Implementation
> following the specification and its qualification procedures will always
> use the correct size and thus not being impacted here.
> 
> To keep the code readable and consistent accross all options, a few
> cosmetic changes were also required.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 77 +++++++++++++++++++++++---------------
>  1 file changed, 46 insertions(+), 31 deletions(-)

Applied to bluetooth-next. Thanks.

Johan

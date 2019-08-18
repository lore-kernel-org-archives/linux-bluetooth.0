Return-Path: <SRS0=e9K0=WO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5B5C3A59B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Aug 2019 00:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F8821773
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Aug 2019 00:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo9GjyhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfHRA5h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Aug 2019 20:57:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34274 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHRA5h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Aug 2019 20:57:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so4864003pgc.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Aug 2019 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:in-reply-to:date:subject:from:to
         :message-id;
        bh=vqMlNy0504OWxfFQw0tpGTFGMP3xq9pNZgj0Of4lQkU=;
        b=lo9GjyhCqHK5I/4av7NMXezZZtL4Q8bwR+/m5X6SYt311IoDvJRN9egtWmbsJAUtdo
         oqtlwMHLEYtRSWrSMT0U7n2TwunogaVF58/dQYjjFiAFE98NxtsOQqYumsEWH3Bbzsf+
         Wzv04Yh/A01ibu5wbTkCiJt2mgJshnlUu42zA0XHr+9WuC6Os4RRoSuMQUvB1991tSHo
         gFLvJwnpBjA1OtN1i8PP8enQNhgYLhD1eup07XvsyQigOQY89wTQapGx+vbFsGcC/oOw
         iFpHzy0Fr6GN+mUN4IXz9u5wARUKSUDrwtxESuOjxabcONSqyL+9n3zngyRiExh9CdNq
         FY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:in-reply-to:date
         :subject:from:to:message-id;
        bh=vqMlNy0504OWxfFQw0tpGTFGMP3xq9pNZgj0Of4lQkU=;
        b=WXPqlFD87pPZmhY65yXTlxTCOoBUx1um1wwvEUy/gcucoCHFOmD+3BuUUo+Dw+QYqV
         X1IvM2aOb2tZbB+vnrsED7B2TU1rRJ3coy+IdYxLXrB8VLQjsGyxcazjMCyFQypYCUkV
         4rjAKib1GvHGCdKCgwSdiWOHnwn6pK1d47Q1TX3jRbpzoUWY4924mPtv6c7/DwF182eO
         x4hacGMWbZ7NOAGBI1LqGjWVWcICiQJGsl4ilLM2nAu0Vdynr+2sDr92EZPpVjJOtpG3
         rBjxqQ6ft6bY3c8q21OGTaqeu6xh49/sJAolwPzex/DRq2BXuHjyw4q26Hy1bJkyu+dc
         qS1w==
X-Gm-Message-State: APjAAAUSyjttMCerkzkpoQ0Z9/OzYSFmybEQfnHF6sxu1CGoP1w3vW9z
        rRb1FSMY7SbiSWPdCkba4A==
X-Google-Smtp-Source: APXvYqyfFLd47t/8sj720IoJUaTlJxMAk0pezdnhJklxGWSPNSeOTC2F25DnxRsez0Hg6PZR++5ZXg==
X-Received: by 2002:a62:6045:: with SMTP id u66mr12708419pfb.261.1566089856534;
        Sat, 17 Aug 2019 17:57:36 -0700 (PDT)
Received: from localhost ([2600:8800:1e00:242:d82f:f17f:4a1d:b94b])
        by smtp.gmail.com with ESMTPSA id z28sm11801998pfj.74.2019.08.17.17.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2019 17:57:35 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20190817063452.23273-4-rpigott@berkeley.edu>
Date:   Sat, 17 Aug 2019 17:57:34 -0700
Subject: Re: [PATCH BlueZ v2 3/4] completion: add bluetoothctl zsh
 completions
From:   "Ronan Pigott" <rpigott314@gmail.com>
To:     "Ronan Pigott" <rpigott314@gmail.com>,
        <linux-bluetooth@vger.kernel.org>
Message-Id: <BWCCIR3EQSA6.378E7TPHIWLQ0@rxps>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri Aug 16, 2019 at 11:34 PM Ronan Pigott wrote:
> +	_arguments -C \
> +		+ '(info)' \
> +		{-h,--help}'[Show help message and exit]' \
> +		{-v,--version}'--version[Show version info and exit]' \
> +		+ 'mod' \
> +		'(info)'{-a+,--agent=3D}'[Register agent handler]:agent:_bluezcomp_age=
ntcap' \
> +		'(info)'{-t,--timeout}'[Timeout in seconds for non-interactive mode]' =
\
> +		'(info)'{-m,--monitor}'[Enable monitor output]' \

An error: the -t,--timeout option is missing the required parameter.
There are no interesting completions to offer here, but it should stop
completing command words where an argument is required.

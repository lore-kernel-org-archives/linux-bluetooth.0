Return-Path: <SRS0=OdH+=QI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFA7C282D8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Feb 2019 09:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6342086C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Feb 2019 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549013810;
	bh=HBxNv72O0js9RJEXSDPhrPoa2U1a12rgs8cyhfsN4GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QPfjQ0CWisqgLcLG3Hu2LeT/9fijE7y0r3p+dBiK9bzQ3ftqnLUmG2uoD+cPZlmkn
	 /fB8OiwuXgALuH3pH7SFMyNL9Qr+P+GEUNcBZKMUBuIJpssDkQ1NSsTEbwTyJ5TYWz
	 nJZVv12igS4uGojAmv7xfmNr6RpIAhjGpytd5ar4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfBAJgp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:36:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33413 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfBAJgp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Feb 2019 04:36:45 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so4582910lfc.0;
        Fri, 01 Feb 2019 01:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8IB2BDebhshhuHGrtV8cFXrWZvhkoVLeu5q3TfM6jQ=;
        b=JI+tF5ATPlrOBsB9JMAGNAV5kXnvnqjNAhtYQ03fwhAhm78wOtDttEbt+0fc+7MfCE
         WsM1gPXoGdm9vCb8sNp3Jq5Bec4NC7ngXIVeEQQH+j8YIiqgM0607haOmBXeqv4WVVp3
         F/ElSW2hILJK4BQAbi5dhp0+o/x52VfX4i3AbYRljFDzf4Ci2wuKxLCREelbDKGYA0Ox
         IHDVYB9qnIoHepKimBeCaM0xY7hHSWnWKw/SHPM6ZSvXwEDeKaQyjqMCbCsRMrkoHJLR
         yeo7uJazTCBgiMABlamfFHPgHfh5GRA8MsScUeXgkdY4mOkxlw4j1HLMXZQ15hgoKs1k
         BUZQ==
X-Gm-Message-State: AHQUAuY/qZZiStWl+sZDgSw+QzLumYgfpGwPAvQVY4Z1dafgtrELobKs
        a4TEs3OkiuBHEW5pf2IA+SZZlyss
X-Google-Smtp-Source: AHgI3IYJAcABmBK5mCN/hgl07naObvBZ9JDJuwa3GwVQgfsA/1a7pUuIGomrlbx2uZnaWSQZB34IFA==
X-Received: by 2002:a19:f718:: with SMTP id z24mr10691236lfe.97.1549013802765;
        Fri, 01 Feb 2019 01:36:42 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id k13-v6sm1195452lje.89.2019.02.01.01.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:36:41 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gpVFX-0003TP-I6; Fri, 01 Feb 2019 10:36:39 +0100
Date:   Fri, 1 Feb 2019 10:36:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: Fix WARNING in tty_set_termios()
Message-ID: <20190201093639.GB3691@localhost>
References: <20190131232359.27948-1-shuah@kernel.org>
 <20190201092843.GA3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201092843.GA3691@localhost>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Feb 01, 2019 at 10:28:43AM +0100, Johan Hovold wrote:
> On Thu, Jan 31, 2019 at 04:23:59PM -0700, Shuah Khan wrote:
> > tty_set_termios() has the following WARN_ON which can be triggered with a
> > syscall to invoke TIOCSETD __NR_ioctl.
> 
> That's the only way to set the hci line discipline. And it's the
> consequent ioctl that sets the uart protocol that triggers the warning,

I meant *subsequent* ioctl, of course.

> but only if the tty is a pty master, as I mentioned before.

Johan

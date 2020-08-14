Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E2C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 20:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BD820771
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 20:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6BxVt3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgHNUMV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgHNUMV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 16:12:21 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A48AC061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 13:12:21 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j7so9173833oij.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGEIRApH5/p8VsQhcxbCoWl1EO+fqrquJVhKDliJ+14=;
        b=T6BxVt3vew1+fIyQb/pbzntGpUJesqiMxNhyvtCqSK33JYbAaKXfRyeOdgXWF71kGQ
         IOKPRWG1np+dSUKIdN+NhEXbHwEYuB8CXXchsiDN3sBvwVfiW5DePh7RFZ6mk6rysmPc
         PpYkEttRc2qfqr6bb8qVnGpcHzZHlCGEYtKA1Fz4i22nD/OnfLoM9jlehgyuDKAf80HW
         D0lrs57VKYOxI8nzikRL/EF+hg7hHncXIIiNaeiD4p/lZyT7YW5NOCdoqUUAVaYI2znw
         SAZNPM2CFp+zPkNRUaMQ0a/4SRUEP/sH58Ds5sYRVswCfJldvdWaVY+lb3yfHV90xtPH
         itPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGEIRApH5/p8VsQhcxbCoWl1EO+fqrquJVhKDliJ+14=;
        b=LA2ASTrDvkQCuYM/hWzME96U6tXBz0E6gdvZ8RhF/xOR2xwSfAxgBk3Ir4nV47v15y
         1mzt+Ghbf+bXzf5skXykiG6peNTO3vE9xdOJdhXoF/cYhv6V4p6KgDbIBPrs9GqTiVYC
         W/xnYlnCpMjS2AJP7z1ZJZXj3Jr5TwnvGev1pwfaEk/qt19d/8Fcyln/nSw7MtMkpLPw
         wn0VdcKV6ORQfTlvVznvmxsr5s00djx9Fsm4GeDRPIxJ3EWx/3D6qUmnGNYnsV7vrriO
         gFmyyAMfdHvfzkyG+98uB2bHOnXUurromaEji2dC23drORBboEWaSSgzfjofkcfwq17x
         X1iA==
X-Gm-Message-State: AOAM533WdahyDv2dNvvydFF0tN3lHIVsJGsOF/8cEZerD/4FS4iXFKrJ
        ZdmKmoDOAQi2HQm/1F9HroWjbnmSa+x/bOvAwWzEcXCa
X-Google-Smtp-Source: ABdhPJxYJToXsXo2RhBzxWCjVCXfkAtP9ZwDqDsVvZ0aWOcsmv+I32TgiZtzC5B/Q9tf4U2kbpLp1LNXXpc71dhZtlc=
X-Received: by 2002:aca:5703:: with SMTP id l3mr2487285oib.48.1597435940117;
 Fri, 14 Aug 2020 13:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200812204932.25627-2-tedd.an@linux.intel.com> <5f345e19.1c69fb81.cce10.d6f2@mx.google.com>
In-Reply-To: <5f345e19.1c69fb81.cce10.d6f2@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Aug 2020 13:12:10 -0700
Message-ID: <CABBYNZ+xikP5s1dBzyHGhJg4JE-Aj8faQtvjUCQJaV1RUnVvrg@mail.gmail.com>
Subject: Re: [V2,2/3] tools/btpclientctl: Add btpclient test application
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd, Marcel,

On Wed, Aug 12, 2020 at 2:27 PM <bluez.test.bot@gmail.com> wrote:
>
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While we are preparing for reviewing the patches, we found the following
> issue/warning.
>
> Test Result:
> checkpatch Failed
>
> Outputs:
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #49: FILE: tools/btpclientctl.c:1:
> +/*

It might be a good idea to start using SPDX license identifiers
though, @Marcel any thoughts on that?

> ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
> #67: FILE: tools/btpclientctl.c:19:
> + *  along with this program; if not, write to the Free Software$
>
> ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
> #68: FILE: tools/btpclientctl.c:20:
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA$
>
> WARNING:TYPO_SPELLING: 'arguement' may be misspelled - perhaps 'argument'?
> #215: FILE: tools/btpclientctl.c:167:
> +       bt_shell_printf("Invalid arguement %s\n", argv[1]);
>
> WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
> #2124: FILE: tools/btpclientctl.c:2076:
> +static const char *help[] = {
>
> - total: 2 errors, 3 warnings, 2175 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> Your patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
>
> ---
> Regards,
> Linux Bluetooth



-- 
Luiz Augusto von Dentz

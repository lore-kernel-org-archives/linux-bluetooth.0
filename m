Return-Path: <SRS0=nJmK=NN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727E0C65C22
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Nov 2018 11:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382A320657
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Nov 2018 11:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs22uzup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382A320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeKBUS4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:18:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41483 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUS4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Nov 2018 16:18:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id c32so1338264otb.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Nov 2018 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjISakEAgDGBrXMaj3dRnC6zNM87Io2tOczcayFWRDk=;
        b=cs22uzupVwHxrAhCIOxs+X0pVIGRjDEuTnJ5bO9Qc2VV48c3ou3D88z0gkUoOdGTgi
         hYk8NzM1YutDABogpE0DZhwR4uXavmJ1vDQn5O33aOZyNEX6unkbZZCVrbKGHwSkAwqU
         AA87ALUsPFgGuppVBUSeKYEOFAIeiHL2A9EX72PBQZ0aSOskvaN/ajEJSUE6fIu38Oks
         YUJPQrUMCJE4XupWaN/0hk1midY0aYc5oRs9NshrqQu6Ag3R8vi2pT6kfy+0gDysH4Wl
         QLHxmtupv4bYR4jdPEMcshLOiixXjb8Gad32IO6b2FkWZwKeodHnGz3sVQN+lOW5Idms
         EfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjISakEAgDGBrXMaj3dRnC6zNM87Io2tOczcayFWRDk=;
        b=qavoGeo5XL9G0cn3ePJH99qlaN/pWVB+XwmXaVo3IhreuKY+PRCuj7/wAMjBihF2dV
         x8dxqbq6dclUW/kMSbeLtNkEFmqVHNpNo2cYLKspAVg+F7BWEccimWy8jCxjfMJmq1mI
         lXY3TlImEisHlxt7A+jZsfNeW2baMskoFNPJYQtMEt2dvfmtl0pCdGVfVODvDie5dyBs
         9rBp6S6Ho7DqOfkySl+/DCzpJgNQ3KF+jhWoZSyRF9OEiwYxfamWu1xcUNq02W4xK6ca
         DCfM6AuPDI14KXasf4p/PAS+TmAFf3t8+fQ3OkgEpTdnP6IJVM3baBGJICh4iYohAyG/
         Odqg==
X-Gm-Message-State: AGRZ1gLriWH04eMlFlf4eZN8SfLXzIMa5US1XenZg4pEnFncI/lY3ZjJ
        nrBjl5zpBor64EihMPdbAG1oUMEy3hCrPpYxcvg=
X-Google-Smtp-Source: AJdET5fWvbQtimCr24xW7vSS/WSFxSuWzfVgCSn1Bq7E54hJFyEwr1QyxcA1LCMdy51+BlcThRaCfrXe/EdHD+eo9zg=
X-Received: by 2002:a9d:4a22:: with SMTP id h31mr6511544otf.254.1541157128340;
 Fri, 02 Nov 2018 04:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181031081508.25927-1-acho@suse.com> <20181031081508.25927-3-acho@suse.com>
In-Reply-To: <20181031081508.25927-3-acho@suse.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 2 Nov 2018 13:11:56 +0200
Message-ID: <CABBYNZLVcAnnuPmr7YbWAnifMCa+Q8RW=jPh0sXHn9WC7ekk-w@mail.gmail.com>
Subject: Re: [PATCH 2/3 BlueZ] hcidump:fixed hci frame dump stack-buffer-overflow
To:     "Cho, Yu-Chen" <acho@suse.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        jlee@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Wed, Oct 31, 2018 at 10:39 AM Cho, Yu-Chen <acho@suse.com> wrote:
>
> hci_dump() didn't check the length of frame, and it would be
> a stack-buffer-overflow error.
>
> Signed-off-by: Cho, Yu-Chen <acho@suse.com>
> ---
>  tools/parser/hci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/parser/hci.c b/tools/parser/hci.c
> index 8c7bd2581..4e6c36040 100644
> --- a/tools/parser/hci.c
> +++ b/tools/parser/hci.c
> @@ -4107,6 +4107,9 @@ void hci_dump(int level, struct frame *frm)
>
>         frm->ptr++; frm->len--;
>
> +       if (frm->len == 0)
> +               return;
> +
>         switch (type) {
>         case HCI_COMMAND_PKT:
>                 command_dump(level, frm);
> --
> 2.19.1

Applied.

-- 
Luiz Augusto von Dentz

Return-Path: <SRS0=nJmK=NN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FCCC65C22
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Nov 2018 11:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DC220657
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Nov 2018 11:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8yL7fgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DC220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeKBUTO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:19:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40336 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUTO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Nov 2018 16:19:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id u130-v6so1262161oie.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Nov 2018 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWHNp20dNsNQGtnISjbyyetIM9tcX690l0qKgdk5mC0=;
        b=N8yL7fgcLMd19FP+0cAJZfMDYZvJzi0Pp8hUFe4M37g2HObhiuIxSOPUaLG0Tx8QQy
         YvjJ+DOz9ezrmMRgB1arXXykdP478VBKivPhsaR01eqZq0uHtrTI9MuRzkXTixLIFd0s
         G9jlLgjG84lmcy1thPXxx7D9KJJ4RiSZxMpz1rCabqoLLMc1XB64Muu5bz4+98aVJ1ZT
         redEi9xu/IYqxBDfOFIADMZMHdRj2IkxsFLPWXYkgx5GdTMjeRjGlqmakmA1MVpAE3Nv
         gZv2dC4lm6xvN2OVHXat5TwNsimvR2fdp8Jbj0L8CfeFQjrmCvdyQwqeOKBEK3DUoBu+
         z24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWHNp20dNsNQGtnISjbyyetIM9tcX690l0qKgdk5mC0=;
        b=CaBJKnqDpJlrAhG5IbvmayvUWikSzsDcq29PAvmO5X1U4RrXhl5KTE7KgA1TxXbtG3
         HYRtxvAGHI95NALOCd3XrLIYBOBdfYcyAVgHPFz/cTyf8iB3nsDG5Nrbmrx6ElW91n9n
         DAuXcvi4MScdhUYOZQhrfdwSag64X8J/oxD+uBE7dAiWGwWjMUOBbuAvQAcR1fkbBs7r
         +EDQf0mg/sZEu7VJOxkq3eFMmTQomM9JOj1Dtx6vTKVO9JHznwaoLa5ePHEXGfnwjXpX
         db/gAnCFPhkeIcD9gvqkSPeY3x7cOGaAT0cGDGqiP8P8FFqvvJSVEWZEB5jqPFQ+Csrx
         F5Bw==
X-Gm-Message-State: AGRZ1gKTxuKxD09nnf2pw52js8RKveQ0qwJm98Mhrhs8TEjoIAPREgTM
        sa/1J+TLyQ9WHQXQFGpQ4oS3In9S5xAcWmtTbYg=
X-Google-Smtp-Source: AJdET5dOsc6ZFPjE09VLgVXykNnHzngnO2bztIu2BUiDSxE1F1JktSEVKQTyWjV/CBFtODdOpq5tLz84RE5kAK7ttP0=
X-Received: by 2002:aca:bb54:: with SMTP id l81-v6mr5971622oif.153.1541157146624;
 Fri, 02 Nov 2018 04:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181031081508.25927-1-acho@suse.com> <20181031081508.25927-4-acho@suse.com>
In-Reply-To: <20181031081508.25927-4-acho@suse.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 2 Nov 2018 13:12:15 +0200
Message-ID: <CABBYNZL+1aGZtxAW+uOErYaAs=EhxZTCUd-L4V-C46ovsBW9BA@mail.gmail.com>
Subject: Re: [PATCH 3/3 BlueZ] hcidump: Fix set_ext_ctrl() global buffer overflow
To:     "Cho, Yu-Chen" <acho@suse.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        jlee@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Wed, Oct 31, 2018 at 10:38 AM Cho, Yu-Chen <acho@suse.com> wrote:
>
> Fix set_ext_ctrl() global buffer overflow.
>
> Signed-off-by: Cho, Yu-Chen <acho@suse.com>
> ---
>  tools/parser/l2cap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
> index a05796482..5daefcbaa 100644
> --- a/tools/parser/l2cap.c
> +++ b/tools/parser/l2cap.c
> @@ -56,7 +56,7 @@ typedef struct {
>         uint8_t mode;
>         uint8_t ext_ctrl;
>  } cid_info;
> -#define CID_TABLE_SIZE 20
> +#define CID_TABLE_SIZE 32
>
>  static cid_info cid_table[2][CID_TABLE_SIZE];
>
> --
> 2.19.1

Applied, thanks.

-- 
Luiz Augusto von Dentz

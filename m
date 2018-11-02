Return-Path: <SRS0=nJmK=NN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E72C32789
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Nov 2018 11:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216022082E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Nov 2018 11:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+TYitVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216022082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeKBUTu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:19:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35853 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBUTu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Nov 2018 16:19:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id r127-v6so1277379oie.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Nov 2018 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JQLYpX+yl41Xco0c9Yd65F4oz7ZWKFjmn/CW09iS5M0=;
        b=E+TYitVg9yD42ZjIxwXCbXhEp+Vu/9jt1XfU6wWCEhfdSkKgIzGMz9Xmpa9gt0tu47
         q0BFOFTc5M8zUXMXd5QMEfMbmVo9QqGDLjFa2C+g4pMDJuG6OEHEkfyRMnzgyUXqqbcA
         lZjcgvqIMvVE0QRWBV4UYdlaBEa0jm4ydVPwzxlp/kxOW3xeIBYLjM7+sRmWKPcWT4Zz
         oHfrYDnK/FI6xlRdx5tZcQhpMm5IJ7p5IeugHBt27gKjkaUOGIFCR3Jr5STudkiTlQYR
         8x30slTws0Xp8PyGnRJBztBskq2lgfibNpcV0v4bAXs71+UfrK1Fp6qXCLGEOKlS8Y4e
         d2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JQLYpX+yl41Xco0c9Yd65F4oz7ZWKFjmn/CW09iS5M0=;
        b=bYysg2b2IQZBVWdi8A/YMhlpMCUND4GaxK4uKQslbxvw8KhAlM3g0CBHFs/ECblWLQ
         vuhCT6f5MLHYruaLndNC0NTBPynXogIKkEbuRMT+DHuAhVlcL6QlU8m4zUuBnfmWPip+
         /7ebCtIGo7m6tNBys1ktWfnBd85ix7aP1C+zuFCAoKuz9VTHufvPEAbg2iLSnk7FKqoL
         eU/70es+FbwVNedEUqPyZZEUyd2WZVlFm+YXvOxoK5VYxxRB2kP4yPNQmP09FhBL4hDt
         Dztko59Hp8DW4e5OvjarKvlBVD9aaFIAQeTRRjCLlhaLD+sNatjAcoB1dMTvbYNyIqrm
         SGmQ==
X-Gm-Message-State: AGRZ1gJOg9blfkzohQ9NMhNCJRw8VVjaQRLvq4tyt1Hv4V+A969T/Nhi
        B9BkMJPYS/v8UvPhZ2up4c9auYey5CsePvF1VjEKcQ==
X-Google-Smtp-Source: AJdET5eIkv+P0UJlXLcFaIM261pPTO5k+mPYzTLUhyv5upY61i20DHIgLOKW9qR2CooYxKhWrXoDN0pxmMO3kjNamWE=
X-Received: by 2002:aca:4083:: with SMTP id n125-v6mr6771326oia.108.1541157181180;
 Fri, 02 Nov 2018 04:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181101141741.11449-1-luiz.dentz@gmail.com>
In-Reply-To: <20181101141741.11449-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 2 Nov 2018 13:12:49 +0200
Message-ID: <CABBYNZLMrmVe3fFODe1agimqf4k+Mzg8xwqFX3FRgCvbgWBa0Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] monitor: Decode error response
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Thu, Nov 1, 2018 at 4:17 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds decoding for the error code in the error response:
>
> > test-sdp: User Data RX
>       Channel: 0 len 7 [PSM 1 mode 0] {chan 0}
>       SDP: Error Response (0x01) tid 2 len 2
>         Error code: Invalid Continuation State (0x0005)
> ---
>  monitor/sdp.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/sdp.c b/monitor/sdp.c
> index 36708f426..1df26a0ca 100644
> --- a/monitor/sdp.c
> +++ b/monitor/sdp.c
> @@ -532,6 +532,24 @@ static uint16_t common_rsp(const struct l2cap_frame *frame,
>         return bytes;
>  }
>
> +static const char *error_str(uint16_t code)
> +{
> +       switch (code) {
> +       case 0x0001:
> +               return "Invalid Version";
> +       case 0x0002:
> +               return "Invalid Record Handle";
> +       case 0x0003:
> +               return "Invalid Syntax";
> +       case 0x0004:
> +               return "Invalid PDU Size";
> +       case 0x0005:
> +               return "Invalid Continuation State";
> +       default:
> +               return "Unknown";
> +       }
> +}
> +
>  static void error_rsp(const struct l2cap_frame *frame, struct tid_data *tid)
>  {
>         uint16_t error;
> @@ -546,7 +564,7 @@ static void error_rsp(const struct l2cap_frame *frame, struct tid_data *tid)
>
>         error = get_be16(frame->data);
>
> -       print_field("Error code: 0x%2.2x", error);
> +       print_field("Error code: %s (0x%4.4x)", error_str(error), error);
>  }
>
>  static void service_req(const struct l2cap_frame *frame, struct tid_data *tid)
> --
> 2.17.2

Applied.

-- 
Luiz Augusto von Dentz

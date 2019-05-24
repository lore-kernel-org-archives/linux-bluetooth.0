Return-Path: <SRS0=vizm=TY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A58C072B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 May 2019 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548D12184B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 May 2019 08:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3ell6Z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390147AbfEXIye (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43814 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390133AbfEXIyd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 May 2019 04:54:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id t187so6469876oie.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2019 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQW1kg5UqdPQfFK40DGboFHsz/O+cXpJyEk5Yh4NqVs=;
        b=p3ell6Z9pJ4FijDd741/G6nrayGfD3z4jkAp2xU2ZAxoz1BDzoNYVP0qXmDG/gvqIE
         LGmEQs52O1sPDZHJ+q1hkoJZcYfnuTf00muRlZqgMA3SN3uo+8kK8+mskf0Ne5yRhudo
         O9U+ehgaQ8I0TAelkOf6PC0wQr9wAzfOPU4rhWEFe/9VnCYn0BHe5jBDaveFTW3hDWuD
         79vEjSpL2VI1HZTCJuYXBBpVoyHSmdUw8yHqhns8bRuN4fK8fBBtz+bZxWioG7Ic97Ae
         bNohrbxivj0Zv9TnwnC2pz8zGCzjPgy4MTaW35sqkVG+Dex4UWZ9WRvf0fwlSD6sUaps
         BdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQW1kg5UqdPQfFK40DGboFHsz/O+cXpJyEk5Yh4NqVs=;
        b=MN5QKUkHA7duX+JTKYxltHXRtYTqgBp1Ih/JqW4mvpJx1WgFFCnUPVWEZHtDGvgGv2
         GChgAy9goC7t5B8ArBaqmfADyQP9mlPaNlJcmMrwaYt9EydJEFIpZyQ3J9fpoNPKgTYh
         p5VpNPCxe4ybBKcAH0NU/2NLA+167FJ07dFsOpq6BXXZeqSWQFnKWLhy/g3Z34QBCReb
         2y67MWVJmej5rZ/yf3UcFayqnKbaUhv1EF+xGGQ7g8xw6kyatpidk58f2D0/GXEhuCaL
         MX7tXTmo0GK8obG9GPsnrv2ShHPJHa5Vg2uHklrY0IkzaykDSaNLsLBIr/yQrTdx8DYn
         12WQ==
X-Gm-Message-State: APjAAAXjuAsSvid9S7X5Cv9M7F5bl7jJUDCGlAQe89dCBJv5RzrLpS1s
        cq+KyPjuYgIVcHHAqb/XAQSss6ix9vXxETeLNxk=
X-Google-Smtp-Source: APXvYqwz7XwzDEMYCePknXUpps0eP3SpAz4EA3gHq68nNC+P/KQDy6cRHVbf861ONUYnYa8FMOKY/XLwUWpNCSfsivQ=
X-Received: by 2002:aca:5704:: with SMTP id l4mr5492965oib.21.1558688072084;
 Fri, 24 May 2019 01:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190522013216.22493-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190522013216.22493-1-andrew.smirnov@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 May 2019 11:54:19 +0300
Message-ID: <CABBYNZLVqkZStKJUYAZrcr-U4dTob+HjBx6qekJ0FTnGkf3MtA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Add unknown options decoding for Configure Response
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Wed, May 22, 2019 at 4:34 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Unknown options respose for Configure Respose packet has a different
> layout than that of unaccepted options, so it needs special code to
> handle it.
>
> Before:
>
> > ACL Data RX: Handle 12 flags 0x02 dlen 15
>       L2CAP: Configure Response (0x05) ident 2 len 7
>         Source CID: 64
>         Flags: 0x0000
>         Result: Failure - unknown options (0x0003)
>         04
>
> After:
>
> > ACL Data RX: Handle 12 flags 0x02 dlen 15
>       L2CAP: Configure Response (0x05) ident 3 len 7
>         Source CID: 65
>         Flags: 0x0000
>         Result: Failure - unknown options (0x0003)
>         Option: Retransmission and Flow Control (0x04)
> ---
>  monitor/l2cap.c | 56 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 12 deletions(-)
>
> diff --git a/monitor/l2cap.c b/monitor/l2cap.c
> index 26719ac5e..6983f80f0 100644
> --- a/monitor/l2cap.c
> +++ b/monitor/l2cap.c
> @@ -705,6 +705,42 @@ static struct {
>          { }
>  };
>
> +static void lookup_option_by_type(uint8_t type, const char **str,
> +                                 uint8_t *expect_len)
> +{
> +       int i;
> +
> +       for (i = 0; options_table[i].str; i++) {
> +               if (options_table[i].type == type) {
> +                       *str = options_table[i].str;
> +                       if (expect_len)
> +                               *expect_len = options_table[i].len;
> +                       return;
> +               }
> +       }
> +
> +       *str = "Unknown";
> +       if (expect_len)
> +               *expect_len = 0;
> +}
> +
> +static void print_unknown_options(const struct l2cap_frame *frame,
> +                                 uint8_t offset)
> +{
> +       const uint8_t *data = frame->data + offset;
> +       uint16_t size = frame->size - offset;
> +       uint16_t consumed = 0;
> +
> +       while (size--) {

Id expected this to use l2cap_frame_get_u8 for fetching the type so
you don't have to create a custom code to iterate into the frame, the
offset can be handled with l2cap_frame_pull.

> +               const char *str;
> +               uint8_t type = data[consumed++] & 0x7f;
> +
> +               lookup_option_by_type(type, &str, NULL);
> +
> +               print_field("Option: %s (0x%2.2x)", str, type);
> +       }
> +}
> +
>  static void print_config_options(const struct l2cap_frame *frame,
>                                 uint8_t offset, uint16_t cid, bool response)
>  {
> @@ -713,24 +749,16 @@ static void print_config_options(const struct l2cap_frame *frame,
>         uint16_t consumed = 0;
>
>         while (consumed < size - 2) {
> -               const char *str = "Unknown";
> +               const char *str;
>                 uint8_t type = data[consumed] & 0x7f;
>                 uint8_t hint = data[consumed] & 0x80;
>                 uint8_t len = data[consumed + 1];
> -               uint8_t expect_len = 0;
> -               int i;
> +               uint8_t expect_len;
>
> -               for (i = 0; options_table[i].str; i++) {
> -                       if (options_table[i].type == type) {
> -                               str = options_table[i].str;
> -                               expect_len = options_table[i].len;
> -                               break;
> -                       }
> -               }
> +               lookup_option_by_type(type, &str, &expect_len);
>
>                 print_field("Option: %s (0x%2.2x) [%s]", str, type,
>                                                 hint ? "hint" : "mandatory");
> -
>                 if (expect_len == 0) {
>                         consumed += 2;
>                         break;
> @@ -1122,7 +1150,11 @@ static void sig_config_rsp(const struct l2cap_frame *frame)
>         print_cid("Source", pdu->scid);
>         print_config_flags(pdu->flags);
>         print_config_result(pdu->result);
> -       print_config_options(frame, 6, le16_to_cpu(pdu->scid), true);
> +       if (pdu->result == 0x0003)
> +               print_unknown_options(frame, 6);
> +       else
> +               print_config_options(frame, 6, le16_to_cpu(pdu->scid), true);
> +
>  }
>
>  static void sig_disconn_req(const struct l2cap_frame *frame)
> --
> 2.21.0
>


-- 
Luiz Augusto von Dentz

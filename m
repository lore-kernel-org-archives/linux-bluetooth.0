Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ABDC2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 17:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD50206BE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 17:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWZpK7a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDGR4J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:56:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34034 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGR4J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 13:56:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id d3so2308998oic.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvBZBeg+UAICc4TnwVAchLwbaRuVxAEhqftshhBGr5A=;
        b=dWZpK7a9mp3GPEmXiQf7BdhdisaEMBypiJYf8f6C/VGOnIb27wlzLXhIhIE291tjQJ
         6fGpk0kESh797k8mjPHhZhNY7TyNbk2SGuK26yBmLJoYrM4XSxQQYbZXJljtTZ8Uk9aa
         hOZ/Ke7e5lDvhqHPeqRNexT6yRWpwSxpVtvBk+/5t0lAX/cXqSPxkNGO/Qqd+o/152NB
         vUqEgDk/IVyBNsEyRF46MNcPgyDJP+AAr4HD6XYBp/7br2La+6yB+2OHLddo+97jujTp
         VmAqjvJAxFC59gZ11fYmrrZngQhiJOKuH8j3zdx3yAe17F8F1EUQ3AaKFPp+E5QrEe/O
         BarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvBZBeg+UAICc4TnwVAchLwbaRuVxAEhqftshhBGr5A=;
        b=mXF0WkZsf1DITxJ/BFeLqkMIFLSJAKcM/WqqC8l5B/HHBqDYVLMBpnEGT/+0ptyrKb
         pb9o3jhUJAyaHzaRRkxWrP4JU3G85z2yoAvqck5i5wWSLtckG6q4XbgkjANsgb95jgbH
         BmiJL7hLVZcujcX1TiZU68lIwgXL7Gte7WqD5cCei1unmT3nIDCVO3/9yk+CC8Nnfci4
         uefVXul5hRoFN2cFl+UKjvNZAdUMiDXsjql4/FXPfTXDOZC358QhnnobHrsh5NO8mmHg
         L9DFRb3Oz6NoXDsaghH1ruPeR9fVIseLohcnlzUC7X83q1g7yfyqV5Du7fWayTe7jQLh
         lLNQ==
X-Gm-Message-State: AGi0PuZ7LXJGtfJsWWLC3u4sdyqTTcHEMSBMgFh2/0hPwYu2A3lI1/F/
        yieORQweeK0p6JC+yHAJYNKvB0Y7H7J7HrS5dZs=
X-Google-Smtp-Source: APiQypLYhz64uYFSoqWz9hkMv+sWT+ccvZyFsT3cYsNqBemT+ayW/5pSDwQWh72vkwxp5r7Wze4LRy4CsaWBDfYmvQI=
X-Received: by 2002:a54:4e13:: with SMTP id a19mr39053oiy.108.1586282168065;
 Tue, 07 Apr 2020 10:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200407085610.231013-1-apusaka@google.com> <20200407165521.Bluez.v4.4.I6813a39e5d8499d24471d7b575c7ef6c493a046c@changeid>
In-Reply-To: <20200407165521.Bluez.v4.4.I6813a39e5d8499d24471d7b575c7ef6c493a046c@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Apr 2020 10:55:56 -0700
Message-ID: <CABBYNZ++tW29c2DSjuJCp_F2NjLfSVUXkPL228hkEAR0Uxzbtg@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 4/4] unit/test-gatt: Fix unknown request with
 signed bit
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Apr 7, 2020 at 1:56 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> The BT spec doesn't make it explicit of what should happen when
> receiving a bad signed att request packet.
>
> According to BT core spec Vol 3, Part C, Sec 10.4.2:
> A device receiving signed data shall authenticate it by performing
> the Signing Algorithm. If the MAC computed by the Signing Algorithm
> does not match the received MAC, the verification fails and the Host
> shall ignore the received Data PDU.

In my interpretation 'ignore the received Data PDU' may not supersed
the followin statement:

> According to BT core spec Vol 3, Part F, Sec 3.3
> If a server receives a request that it does not support, then the
> server shall respond with the ATT_ERROR_RSP PDU with the error code
> Request Not Supported.

So what I think we should be doing is to ignore the received data,
meaning it should not even be processed as a signed data since we
don't understand the command, _and_ respond with ATT_ERROR_RSP,
otherwise we risk having the 30 seconds timeout and disconnecting
since the request is no responded.

> This patch does this two things:
> (1) Removing the signed bit to the existing tests so they are not
>     in a conflicting state within the bluetooth spec, while still
>     keeping the original intent of the test.
> (2) Add another test that purposely fall within this grey area
>     with some comments.
> ---
>
> Changes in v4:
> - Fixing test-gatt.c
>
> Changes in v3: None
> Changes in v2: None
>
>  unit/test-gatt.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 36dd2847c..139a6fc72 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -4473,16 +4473,38 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x18, 0x01),
>                         raw_pdu(0x01, 0x18, 0x25, 0x00, 0x06));
>
> -       define_test_server("/robustness/unkown-request",
> +       define_test_server("/robustness/unknown-request",
>                         test_server, service_db_1, NULL,
>                         raw_pdu(0x03, 0x00, 0x02),
> -                       raw_pdu(0xbf, 0x00),
> -                       raw_pdu(0x01, 0xbf, 0x00, 0x00, 0x06));
> +                       raw_pdu(0x3f, 0x00),
> +                       raw_pdu(0x01, 0x3f, 0x00, 0x00, 0x06));

Afaik we used 0xbf because that was what PTS was using.

> +       define_test_server("/robustness/unknown-command",
> +                       test_server, service_db_1, NULL,
> +                       raw_pdu(0x03, 0x00, 0x02),
> +                       raw_pdu(0x7f, 0x00),
> +                       raw_pdu());
>
> -       define_test_server("/robustness/unkown-command",
> +       /*
> +        * According to BT core spec Vol 3, Part C, Sec 10.4.2:
> +        * A device receiving signed data shall authenticate it by performing
> +        * the Signing Algorithm. If the MAC computed by the Signing Algorithm
> +        * does not match the received MAC, the verification fails and the Host
> +        * shall ignore the received Data PDU.
> +        *
> +        * However, according to BT core spec Vol 3, Part F, Sec 3.3
> +        * If a server receives a request that it does not support, then the
> +        * server shall respond with the ATT_ERROR_RSP PDU with the error code
> +        * Request Not Supported.
> +        *
> +        * Since there is no explicit instruction on what should be done in
> +        * case the server receives a bad signed unsupported request, here
> +        * we just ignore the received PDU.
> +        */
> +       define_test_server("/robustness/signed-unknown-request",
>                         test_server, service_db_1, NULL,
>                         raw_pdu(0x03, 0x00, 0x02),
> -                       raw_pdu(0xff, 0x00),
> +                       raw_pdu(0xbf, 0x00),
>                         raw_pdu());
>
>         return tester_run();
> --
> 2.26.0.292.g33ef6b2f38-goog
>


-- 
Luiz Augusto von Dentz

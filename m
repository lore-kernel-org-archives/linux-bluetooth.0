Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A277FC2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 20:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FE12074B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 20:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQsdKEsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgDGUHl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:07:41 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44801 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgDGUHk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 16:07:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id r21so2640416oij.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ep9fWO3BRQ0KpfAHRqbaVFsVeXfnPNyel0pmxBcb53c=;
        b=KQsdKEsRv5k9lujY2/y3cENR3rNUB014DxQnIbG1ozH2SeQ0dg7yZl7rlsGastnmBZ
         TJnDhaWqgjcJGJWLKubnhYYCG3KaiUhMAWIvKihI0Vm/wJHUXrpTqt7lCw54+EhUSNE8
         T1jxUeCJlkzy5Hbmb94YIeN060/KzJMLsN7dn9jyuv1R15p7JM2kaq4rg7QdrtiUyyHx
         YRlUnG2zBlaX6eBr9xzOuG/TCyXlpUgKxXbKcGJ4IKHE0j97bj1DLxN06uVoiRyv5P1k
         GDvVWjxxh2wHN2VnL0MTNDlOfJE/qoe6JJaJniDyaTMj3hOJUYT8cK0h8MHao4/oprjo
         6L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ep9fWO3BRQ0KpfAHRqbaVFsVeXfnPNyel0pmxBcb53c=;
        b=rFNj+f76RsBvQI8rAjS50AtYhKKMSXqOvmMYi1mMEWltcOlHolzLJiRHMLrtyccWrS
         v5rwFVl7ueDZBs5wyLo+cIAQEET3xdA2SFdVVA0ad31AIHn1X/sUAsu5GiNaSskN4DzS
         5ZOxHvup1O3wAjhlIv3ugkIRPKIkUzVghxrJI/XV7U5JdUxfpf5LAJdqP0/0QVEWMh70
         /jAdLiT1umrC1eEwo0nD9mAC5lLDn+U++tC++XxRZxhZM4HygFkSaV8uXP+1/a9u03lK
         I2OrTxGpQis/OmuNN17fNpfafwg0ueMS7p1J6KkBjxCUAmKzbhoLCKydkrUX98orEOIS
         PnJw==
X-Gm-Message-State: AGi0PuZiW7Or0jGbr+HPumUMpKygIIicpgeDXtP2u9AGP3E2qebtfkUJ
        BW7EUNZrM7DMcNP+Ps4Pp9KxZs5+X+hK8jaj4G8f8zqv
X-Google-Smtp-Source: APiQypJb/hDQxlHtM/Aegv/eom0jDGJ7brDarg7ZOUT8+loUu5PoyJwAwBZULLhop1jDsvDoXKls8IKw9kL2+/JpT7g=
X-Received: by 2002:a54:4e13:: with SMTP id a19mr491486oiy.108.1586290059673;
 Tue, 07 Apr 2020 13:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200407085610.231013-1-apusaka@google.com>
In-Reply-To: <20200407085610.231013-1-apusaka@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Apr 2020 13:07:28 -0700
Message-ID: <CABBYNZ+3SUbZbO+BJ7BX3uj5dds=KzWpe316SghncrOE8ikLBw@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 0/4] Check the signature of att packets
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
> According to bluetooth spec Ver 5.1, Vol 3, Part C (GAP), 10.4.2
> A device receiving signed data shall authenticate it by performing
> the Signing Algorithm. The signed data shall be authenticated by
> performing the Signing Algorithm where m is the Data PDU to be
> authenticated, k is the stored CSRK and the SignCounter is the
> received counter value. If the MAC computed by the Signing
> Algorithm does not match the received MAC, the verification fails
> and the Host shall ignore the received Data PDU.
>
> Currently bluez ignore the signature of received signed att
> packets, as the function bt_crypto_sign_att() only generates the
> signature, and not actually make any check about the genuineness
> of the signature itself.
>
> This patch also fix a wrong boolean condition which prevents
> handle_signed() to be called.
>
> Tested to pass these BT certification test
> SM/MAS/SIGN/BV-03-C
> SM/MAS/SIGN/BI-01-C
>
> Changes in v4:
> - Fix wrong variable assignment
> - Fixing test-gatt.c
>
> Changes in v3:
> - Add check for the case where pdu_len < ATT_SIGN_LEN
> - Add unit test
> - Separate into three patches
>
> Changes in v2:
> - Move the signature verification part to crypto.c
> - Attempt not to copy the whole pdu while verifying the signature
>   by not separating the opcode from the rest of pdu too early, so
>   we don't have to rejoin them later.
>
> Archie Pusaka (4):
>   shared/crypto: Add bt_crypto_verify_att_sign
>   unit/test-crypto: test for bt_crypto_verify_att_sign
>   shared/att: Check the signature of att packets
>   unit/test-gatt: Fix unknown request with signed bit
>
>  src/shared/att.c    | 25 +++++++++----------
>  src/shared/crypto.c | 28 +++++++++++++++++++--
>  src/shared/crypto.h |  2 ++
>  unit/test-crypto.c  | 59 +++++++++++++++++++++++++++++++++++++++++++++
>  unit/test-gatt.c    | 32 ++++++++++++++++++++----
>  5 files changed, 126 insertions(+), 20 deletions(-)
>
> --
> 2.26.0.292.g33ef6b2f38-goog

Ive applied 1-3 and reworked a little bit the third patch so we
actually attempt to find a handler before we attempt to check the
signature.

-- 
Luiz Augusto von Dentz

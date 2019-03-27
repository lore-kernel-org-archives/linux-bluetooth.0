Return-Path: <SRS0=dIIZ=R6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA85AC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 17:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F62206B7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 17:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+PL7sF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfC0R3y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:29:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46401 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfC0R3x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Mar 2019 13:29:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so3642530pll.13;
        Wed, 27 Mar 2019 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ea37q5/WEELVBODUr5amsQMBusFYPsUwbRc4D8n2YhU=;
        b=d+PL7sF0F8fHvXY9H4shGsrsq42svaVVwQ2btOiF77Znehfwo6knr1LyE0xIIsgoiB
         xQvPfMu4jKufylVjYU5IVvii9myi9m+jflWAZPqfFhotCEG61AeKjkwVDBGxkGwUFsAO
         iAaJrhErAZeJH9xM5AwdHqFbtAGCgz5ueVgHBY/bsTTfKIZl/dytgpXKwU5MHBvxtnLw
         fQvCv9SAYyEs6/g/L4xLLT3Ud9v9JaKui0dCovzryxJzWKqBnKnDdB6qrHQr1Fw6jcB8
         Txg+nyiSzjXBkgOm+4ADR7ErWHrp/y80vsnEFyImmc3MSWCQ8zThS9EY3pJW+ibaG9if
         0YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ea37q5/WEELVBODUr5amsQMBusFYPsUwbRc4D8n2YhU=;
        b=H8Aq0EEcs0v5U9CmIy10qWQ8LwA7b7kaQIosLmQqLum4dE6ynp2cPaBPgnl0WMGfu2
         rYS6nPaMqwv4qyxUgvbeVcVfxrS2bpXD48F/nUT2a7Xd4ZiJJjmEXLsbVVwX5meugVr2
         rUkRC6sRVVdo1NzXYioQAAgcaXYNu5QPL0fZgf79d9Bh1N4sKFKgeJbCJRTDxj9XSxUu
         rU5y/nx69S01nbIoeeZ+9MnnV1DNpAEHgwSjhmd/tYP1IlF+I671luNECoqZ7sQw/FJM
         bjagsiHYvfGdQhHzkxv+AggaiGocpq6PtQM72ARfaw7dUDzB+KcNV8416aUSjUJpSnQe
         jR8Q==
X-Gm-Message-State: APjAAAXsIkECpOHjNDF2hnfZMooqEm3RA+KOUmoWW7L9aE2cpetoFn0R
        XLtriTj9lZlV3i+cmjniclI4bTH3A4zo5w==
X-Google-Smtp-Source: APXvYqzr66U7a04tHZL6IJBO8zUl9LsjYFSyeO171aV3rHqoprtCmVv7db3NDqm+qn5yugp9+uHoCQ==
X-Received: by 2002:a17:902:8692:: with SMTP id g18mr37117967plo.149.1553707793034;
        Wed, 27 Mar 2019 10:29:53 -0700 (PDT)
Received: from kkajrew-mobl1.ger.corp.intel.com ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id q86sm65962628pfi.171.2019.03.27.10.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:29:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] Add Support for LE Ping feature
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <1553661793-10304-1-git-send-email-spoorthix.k@intel.com>
Date:   Wed, 27 Mar 2019 18:29:47 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        linux-bluetooth-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7F336FF-1D53-4DC9-94ED-392011649A5E@gmail.com>
References: <1553661793-10304-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Spoorthi,

On 27 Mar 2019, at 5.43, SpoorthiX K <spoorthix.k@intel.com> wrote:
> +#define HCI_OP_WRITE_AUTH_PAYLOAD_TO    0x0c7c
> +struct hci_cp_write_auth_payload_to {
> +	__le16	handle;
> +	__u16	timeout;

As Marcel (and now also the build test robot) pointed out this should be =
__le16.

> #if IS_ENABLED(CONFIG_BT_LEDS)
> 	struct led_trigger	*power_led;
> @@ -500,6 +501,7 @@ struct hci_conn {
> 	__u8		remote_id;
>=20
> 	unsigned int	sent;
> +	bool		auth_payload_timeout_set;

Would it make sense to add this to the flags instead of increasing the =
hci_conn struct size?

> +	/* Set the default Authenticated Payload Timeout after
> +	 * an LE Link is established.

The test further below also includes BR/EDR links, i.e. the above =
comment doesn=E2=80=99t match that.

> +	 * Section 3.3, the HCI command WRITE_AUTH_PAYLOAD_TIMEOUT =
should be
> +	 * sent when the link is active and Encryption is enabled, the =
conn
> +	 * type can be either LE or ACL and controller must support LMP =
Ping.
> +	 * Ensure for AES-CCM encryption as well.
> +	 */
> +	if ((conn->type =3D=3D LE_LINK || conn->type =3D=3D ACL_LINK) &

That =E2=80=98&=E2=80=99 the end should probably be a =E2=80=98&&=E2=80=99=
, shouldn=E2=80=99t it?

> +	} else {
> +		conn->state =3D BT_CONNECTED;
> +		hci_connect_cfm(conn, ev->status);
> +	}

Why is this being added? Such a transition to BT_CONNECTED state at this =
point in the code didn=E2=80=99t exist previously, and this doesn=E2=80=99=
t seem to be related to the new feature.

Johan=

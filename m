Return-Path: <SRS0=UGHn=TS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA79C04AAF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 17:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE1D2087B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW1dGc8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfERRJT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 May 2019 13:09:19 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:37152 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbfERRJT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 May 2019 13:09:19 -0400
Received: by mail-pf1-f172.google.com with SMTP id g3so5187407pfi.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2019 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AcH32R2+XwdcmEdGzVUghv5WD+H26+Qq++0OlyLVNPE=;
        b=eW1dGc8+0ryH5+sfMK0ksgWbA6HpJ0rLvXJw60UqdUQ5qZ0cFhe50zTnMxGP1HOAbd
         Ok1b9V/KZWAonF/G6IRLJcTKcTP8QsrjErKVrEYb1vgW0nCKRxBiIBlrcS4WCmHOc7mC
         mYB7wUngxbCnOXr6YGO8xjH1L5AE4Ec+klBPOFuVpn1RB1E/L9HGb7kw4Uy8FYixh+bW
         uEX8UnErQU6Mvp9Bc+moCS4gYj9z4WyLCl6bSRatp3MRFqmaAKA2OKjpXL3tr6E5x1dw
         tMCwOOGnvi/2038CIfzLkiJhQkwkKl/93VyBpxspvP69AMO0aj1qKA3uXm38gQ44dVTl
         dH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AcH32R2+XwdcmEdGzVUghv5WD+H26+Qq++0OlyLVNPE=;
        b=Os5rvy6D7m36cBvZUe3ZcGTIneW/E2Fy3/eCrkFC5E6KW7dOsp876knBzeQuwWfFcT
         YoEjIxAdWcRZ6N6kW6Mdo9xt20bsXwGjEr7cJzwBNUA1q0wLszJJSBq6W7f4e+7uTBvY
         WBnpJ1GQ/MdhZofuteWdEfOd9s8F3wVcb7FPpqXQHiiMHk4AJ48PPtCY8RkVkQb1LZ48
         Rf/9K+v9tcs2/0AeCNWTpWXXN0Q6t1q/hdKukqok3rPAttsvH809VIa/F75XKMFexnrC
         Gyl+3ukCitJy7X7I69roG5E0Thn9fio8zbHInf/+BqWP3nngeLEtY1JseW82wReSKner
         Nxvg==
X-Gm-Message-State: APjAAAXkOLGacNaTS7srDLSaHpeWqX5cJ8JkLsqN4cQ90fPvkHw0Cqia
        ugliv+oPB9beip5qavP7MZAtjN3yaDIvqg==
X-Google-Smtp-Source: APXvYqwzkSHHj12fWDgchhueeYVczhtCHtdY+wp7LFPnUVct1MmCYwZWczqpvogD3YOL770qpkejkQ==
X-Received: by 2002:a62:7689:: with SMTP id r131mr70445452pfc.181.1558199358274;
        Sat, 18 May 2019 10:09:18 -0700 (PDT)
Received: from canella-mobl.ger.corp.intel.com ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id d88sm297458pfm.42.2019.05.18.10.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 10:09:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: After kernel update: connect/disconnect forever while attempting
 to auto-reconnect
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <20190518170557.GA79055@canella-mobl.ger.corp.intel.com>
Date:   Sat, 18 May 2019 20:09:12 +0300
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8765116-CAEE-4CD4-90F6-249BB82C496C@gmail.com>
References: <CAELgYhdqAxTGA98RsUEOSEA5WfhxGaVn7C_DegAfU13sHx817A@mail.gmail.com>
 <CANxMttCx4uFeVpM9EsYmfg9VoXG45ihpzw=phJcx0Uy53cGD_A@mail.gmail.com>
 <CABBYNZLGgUL6W=-v+stoaukpN5kvt1AHFBQ_vEdh=sqU9JO0LQ@mail.gmail.com>
 <CAELgYhcCBAUr6oQxTnmjBjQfkc8JeTbkXHea64PN+7cWQSqQ=Q@mail.gmail.com>
 <CANxMttCqEYDZOwTriLqC-q39+JhEJ9KCOsPhRqkjZwE1h-64Gg@mail.gmail.com>
 <20190518170557.GA79055@canella-mobl.ger.corp.intel.com>
To:     Alexandre Pereira Nunes <alexandre.nunes@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Slight clarification to my earlier mail:

On 18 May 2019, at 20.05, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> =46rom the above it looks like the mouse is initiating an L2CAP =
Connection
> Request to a non-SDP PSM (17 in this case), which is prohibited by the
> spec whenever both sides support Secure Simple Pairing (SSP)

.. *before encryption is enabled*. As can be seen from the log the =
connection starts unencrypted and does not get encrypted by the time of =
the L2CAP Connection Request.

Johan=

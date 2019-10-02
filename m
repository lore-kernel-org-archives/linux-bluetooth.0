Return-Path: <SRS0=2Aeq=X3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07336C352AA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Oct 2019 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D244D20700
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Oct 2019 11:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVhVL92I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfJBLGD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:06:03 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:43195 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJBLGD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Oct 2019 07:06:03 -0400
Received: by mail-pl1-f181.google.com with SMTP id f21so6914524plj.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2019 04:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JSRKZ3Uqsovd3niTV5/0GcpXZ5MVd3wSW9+/wDZCtFU=;
        b=mVhVL92I5sbrunGrpGbqUoF3nG3nsMwKNBlmFCvFRocXmvvxo29z+EpNneGnoaG0hp
         Z+NwB6tyThTBp4ppqvde1rR4VL7lbdV2rFaT9obTOoF8fEOBDG23EMo5jFDRJu6exYPL
         N7CqlBHiXNJ51XtPR9Dc/d9EhvYOzoMK0bVhbSafM6b2WuXOmJ1Q5Mpr+Upj7uZdrRGR
         NLhw2mKuBOqptQhEzTB+YPXJ30mp213UzYU8U9wMEZzxIUHV2PYEiV8v0Uvr2YdFymit
         9W9Gce5XZeIMM7DlXdxK8HhpUIzgFAOuFI+kd0Qrm/evK2nF0vZx1R/I/w8iDiarOihx
         kltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JSRKZ3Uqsovd3niTV5/0GcpXZ5MVd3wSW9+/wDZCtFU=;
        b=Z9NmqMrEikgfGVOxwaQVAVad+Q1rlVa48H7nsxJsPJXk8NxZEyqm3UUESNfSEStsps
         b3ipJ/hi3xKwLl3sbzIxMQjU95v1GrvTW0P95vkjBpmKBsaeNnUj7zbWLnNTceOB+SDP
         nzLPPj6+9CgkGbDHd4w4zXHRs1bVfHr84nhck7BNig0jymMY0E36cKK6bR8QPmF5GNC3
         0sDavx7yRKIgx5ByUsIPuIPQVyMBmCUEOXrdFAQyBmVTFaohWJ7Q5vkihF8Ih6ua2O+t
         Go9d9wVyUK9oa3unzG8Y7ovpKTKUOpGLi2uNH4254Qix7gIheaV8XyOCMNPIyCeR2RXE
         vnXA==
X-Gm-Message-State: APjAAAU1BkSFyPQRzRiUQCItJ2n1A0KN9/w96Uc4VhFJ438ISgfwvt4f
        a+LOTAeMdxeGPc5KeTt9PC4Hj9jPxyhnLA==
X-Google-Smtp-Source: APXvYqxDlMGECxc06NHoMBokW/PDvqAwX3oBNIe4fdCiMLi3JZRINKxtJtL4aEUaRgC6dn/D+V/W5A==
X-Received: by 2002:a17:902:14f:: with SMTP id 73mr3167700plb.57.1570014362171;
        Wed, 02 Oct 2019 04:06:02 -0700 (PDT)
Received: from jhedberg-mac01.fi.intel.com ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id g24sm18712176pfi.81.2019.10.02.04.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 04:06:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: recommended way to register on bluetooth event
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <CAB+bgRaH+Vw1xDNQdOuG26v=QPvnporuo9waBeoxi7NTUE+8YA@mail.gmail.com>
Date:   Wed, 2 Oct 2019 14:05:56 +0300
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0CC58AE-90B5-4299-B9CB-0D40A14685DE@gmail.com>
References: <CAB+bgRaH+Vw1xDNQdOuG26v=QPvnporuo9waBeoxi7NTUE+8YA@mail.gmail.com>
To:     Ordit Gross <ordit.gross@orcam.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ordit,

On 1 Oct 2019, at 16.36, Ordit Gross <ordit.gross@orcam.com> wrote:
> I would like to register on encryption changed event.
> As far as I could tell mgmt-api does not consist of such capability.
> I think that reading from an HCI socket may enable me to read all
> events (and the needed one as well).
> is there a better way of registering on encryption changed event?
>=20
> The reason I need this capability in the first place is that I want to
> enable repairing if BLE Peripheral Removes Pairing keys.
> currently, when the peripheral deletes his side of keys and attempt to
> connect to master, the master will get  encryption changed event with
> error  "PIN or Key Missing".
> that's why I want to be notified on application that we got this
> event, so I can delete my side of keys as well..

Looking at the kernel code (hci_event.c) a =E2=80=9CPIN or Key =
missing=E2=80=9D encryption error should cause a unique =
MGMT_DEV_DISCONN_AUTH_FAILURE disconnection reason to be presented in =
the mgmt Device Disconnected event. So that could be one way to identify =
this in user space. That said, I think a better way would be to add some =
configurable policy to the kernel to decide what to do in such a case. =
This is also a security sensitive scenario, since the reason you get =
=E2=80=9CPIN or Key missing=E2=80=9D could be because someone is =
pretending to be the real device, i.e. they could force you to drop the =
keys for the real device without any authentication. So to be safe, the =
old keys should only be discarded when the new pairing has been =
successful, and the security level of the new pairing should be at least =
as strong as the old one. I don=E2=80=99t think this is doable in user =
space with the current design.

Johan


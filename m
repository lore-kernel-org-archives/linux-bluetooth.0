Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC2BC2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 13:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D78D2464E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 13:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1gEjlBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgADNSJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jan 2020 08:18:09 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:35275 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgADNSJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jan 2020 08:18:09 -0500
Received: by mail-pg1-f172.google.com with SMTP id l24so24694488pgk.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jan 2020 05:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=al8pd8ExtQq9t6BystREaSUFF8BJYov7Zjf4FfVocFQ=;
        b=a1gEjlBqe5gteXR8HA3GxDKP6K7FKbqB8zsBuBp3NKQu8RTrOzn1jVcFANQfi+39qo
         IdCM4eWJ+PgucD4OKj2dCYxkMOTVDQsJDf6vOLJQw2iHjLV/fdmiIaIOBNw71Y9TR5k5
         4qI8o+kztTW7Qz7ej8bDtnV9eLYH2xm3urSAJt9Fyef5CRcAS4iAD9aDJV2wbxJyNP/J
         mli5hqcVPhPEFFKBIjwAACHSgin8/bcTQ1yTIZfCKP7yAeTCnXvEzqQxL2YmXJxOCEEC
         mBjoGX+RvW0By4Ng5hYpJSxTU6JoneGWBefh/yzZoXGRy271iVKtj6F0DVS/SX8kbGz5
         Y/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=al8pd8ExtQq9t6BystREaSUFF8BJYov7Zjf4FfVocFQ=;
        b=ATETXT3Qh5kESBOll3fnfpPk2I4AIEZ8L/Tm+nEgSOhC2ooPuDdt9RQGqExio09P7t
         QPVxve8QMTs9TF9lev6hGC3acefhUrJ5BaBxa684o/6vOIKzd7d0NFa3RCaQG4ZB+D7L
         IOJ0uz9iKCRkMJuhkhlP3Z5jv3JI83c4aAf2c5zAula2JbY1HaK382IcUN1L7j60siNN
         H57BbMabKRQdWLy1cNxLDpFJRMepX3jU9VCEjJtaIcIS99IOBPD1/y4caEPQXyakwBNN
         0UpmhJlETlrhZuScLG5qjIWp+DHymHxjQFYgWFCF/K+ow8zaOB17mf4EdrKk4IjCldnT
         p5Uw==
X-Gm-Message-State: APjAAAWiQGKdD/UndS1RY/EIzE2N2eGVwQBEPmYXiAeQd9nwGcZ4A/P7
        diTRF1qRuNYcgknUHyWZhrpcLj4Wa/epdg==
X-Google-Smtp-Source: APXvYqxkh5tLopD2c5gP+2wn6gXycWDSa3BSEZu7esTqvBnVmuvJgRB9oCthmhMZ/bAIg/3yBwZgYg==
X-Received: by 2002:a63:5920:: with SMTP id n32mr100005205pgb.443.1578143888653;
        Sat, 04 Jan 2020 05:18:08 -0800 (PST)
Received: from djofarre-mobl1.ger.corp.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id u127sm73211406pfc.95.2020.01.04.05.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jan 2020 05:18:07 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: deprecated tools: rfcomm, can we un-deprecate it?
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <cb73add2-cb8c-353a-5d10-134a13553cf4@message-id.googlemail.com>
Date:   Sat, 4 Jan 2020 14:18:03 +0100
Cc:     BlueZ devel list <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7192C77E-BFF5-4507-A004-3684EDE489AC@gmail.com>
References: <0aad7250-65f9-3e4c-e5ca-434139a9ae64@message-id.googlemail.com>
 <2203E98B-B581-4C14-94DF-164D7E036234@holtmann.org>
 <fa70a57e-d5f0-a47d-f987-27b46d8275c4@message-id.googlemail.com>
 <cb73add2-cb8c-353a-5d10-134a13553cf4@message-id.googlemail.com>
To:     Stefan Seyfried <stefan.seyfried@googlemail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stefan,

On 4. Jan 2020, at 13.45, Stefan Seyfried =
<stefan.seyfried@googlemail.com> wrote:
>> This would be for creating a "rfcomm service" for other devices to
>> connect to, right? (The equivalent of "rfcomm listen...")
>>=20
>> But how would I connect e.g. to my serial module (I got this for =
trying
>> it by myself instead of relying on bugreporters results...), so =
what's
>> the dbus equivalent of "rfcomm connect hci0 <bdaddr> <channel>"?
>=20
> OK, now I found https://github.com/tonyespy/bluez5-spp-example which
> explains how to do this.
>=20
> I'd still think an example in the bluez documentation would be useful,
> because=E2=80=A6

Doesn=E2=80=99t test/test-profile give a pretty good overview of both =
server- and client-role usage of the Profile D-Bus API? The main =
difference to the RFCOMM ioctls is that instead of a TTY you get a file =
descriptor (which I guess you could convert to a TTY using a pty). For =
client, another difference is that it=E2=80=99s a two-step process, i.e. =
first you register the client role profile and then you call e.g. =
ConnectProfile (which test-profile doesn=E2=80=99t cover).

Johan


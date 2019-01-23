Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBCAC282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 10:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB252183F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 10:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV+Fhu2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfAWKhR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:37:17 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:46129 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfAWKhR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 05:37:17 -0500
Received: by mail-pl1-f173.google.com with SMTP id t13so956879ply.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 02:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qOvvDQBXVanKhs+0KKdJpeClMIf0HO/VmdZh1ztKt4I=;
        b=XV+Fhu2vheuRTXO5pfo7NbTk6mM40USBDBIlLuP4DzgAnyyHCvgUglhiH8vD8Es/M4
         6vMjjytMdNBquyMpgwlU8z40jZiYZTSv7Vk33UCM577nTP8LgDNyzzDWdSWvkPLJfhGM
         dzKJKUn5B2KNdZqEyevDlYk1mbjAHc7+WDZtGngVyv5+ZwULai0izxR3rJkasX637Dwb
         ASfmhM4lXWpvY1qkMW0LgP7U6iI5QgdiWy9zfhL/FDji5q5i6Lvg3FjTB4fQIg2tJaX2
         MqnT4ioh3feQy6XhQplC/oeKKhPFJvGR4PqQMeEVHBa9i9eEP6pRhEb6MHuF3+DHfptU
         A46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qOvvDQBXVanKhs+0KKdJpeClMIf0HO/VmdZh1ztKt4I=;
        b=ssaOiPYGDaDyFs4EeFFOr086P3wGPwOHkb0QBYwStVJHsj0QwrgCasfNDYcq5C0KEe
         6DMGpKfdPj/3AXxkYXQaCDwftnHpIY7tKpUu9tXALjgCSqVeEZyXeC2iQFo8HNj5rUDJ
         K1wqgwgrgR0YQMqfnosIBoS4vJZtimjeLUAJc23RODSAFM8mmmUVjsAR02TVnVZI7PaT
         U+6Ko0T7bN8+tbf7cNImPuckg5NyMwXVxwWzn97WZdeWWrHKU8R6wFH0smjgShPVIQKM
         lw8/QgONxWZbOkiqRlMW4CYv/RoTeMmFw59CzraOGdsPty1k+Y/r6s6f43iZGdmMAret
         U9Hg==
X-Gm-Message-State: AJcUukcQAMax9eItuDlVOn/lmcOSPBCuugm/vOQ/H57yUR11baENzXgA
        cjt7RXn8ak7my99mA1OkTvRBmnrtIHU=
X-Google-Smtp-Source: ALg8bN7gEQxR/FnwggSQml72zGwtt0V6NKwlG0zcKZjOvIYVNfmS3h1jsv9LsdAfvyf6xH9xvHHeaA==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr1665190plx.231.1548239836240;
        Wed, 23 Jan 2019 02:37:16 -0800 (PST)
Received: from fcahill-mobl1.ger.corp.intel.com ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id c7sm26257294pfh.18.2019.01.23.02.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:37:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Format of HCI LE Advertising Report Event
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <20190123102452.o5xvunjcsx57pdwl@scytale>
Date:   Wed, 23 Jan 2019 12:37:10 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <282271E8-D3D1-4AEC-8B57-BA03F3FF7D36@gmail.com>
References: <20190123102452.o5xvunjcsx57pdwl@scytale>
To:     =?utf-8?Q?Micha=C5=82_Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Micha=C5=82,


> On 23 Jan 2019, at 12.24, Micha=C5=82 Lowas-Rzechonek =
<michal.lowas-rzechonek@silvair.com> wrote:
> I've been reading Bluetooth Core spec v5.0, looking for a way to
> optimize sending LE Advertising Report events through HCI.
>=20
> It turns out that spec allows concatenating a few reports into a =
single
> HCI frame: 7.7.65.2 says that "The Controller may queue these
> advertising reports and send information from multiple devices in one =
LE
> Advertising Report event. So far, so good.
>=20
> The question I have is about the exact format of this event. Wording =
and
> tables in the spec suggest that fields from concatenated reports =
should
> be interleaved in the HCI frame, that is for num_reports =3D 2, fields
> should be ordered as follows:
>=20
> event_type[0]
> event_type[1]
> address_type[0]
> address_type[1]
> address[0]
> address[1]
> length[0]
> length[1]
> data[0]
> data[1]
> rssi[0]
> rssi[1]
>=20
> I don't this format is "natural", if I were to choose I would rather
> simply concatenate a few reports.

See Vol 2, Part E, section 5.2 (page 728 in the pdf):
=E2=80=9C
=E2=80=A2 Arrayed parameters are specified using the following notation: =
ParameterA[i]. If more than one set of arrayed parameters are specified =
(e.g. ParameterA[i], ParameterB[i]), then, unless noted otherwise, the =
order of the parameters are as follows: ParameterA[0], ParameterB[0], =
ParameterA[1], ParameterB[1], ParameterA[2], ParameterB[2], ... =
ParameterA[n], ParameterB[n]
=E2=80=9C

Johan=

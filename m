Return-Path: <SRS0=LpJm=NT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0C0C46465
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Nov 2018 10:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2266E2089A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Nov 2018 10:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFPJIPEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2266E2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeKHUT5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:19:57 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:43307 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeKHUT4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Nov 2018 15:19:56 -0500
Received: by mail-lj1-f182.google.com with SMTP id g26-v6so17529127lja.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Nov 2018 02:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eoaBG4NWESUtM1vZtQDCd1TRPzWIfgpt49PPFULCXTQ=;
        b=JFPJIPEk9auCNXKr2pfcUdWEjxIVm8w799E76aDjeoW9ZmPvH73rJmaVrbXLDjCqqs
         m/utmfAQJz+Jhu27rnVfrFV87/nr7JQ2EKv9DGI/M4J7h7r5jGcaTC+A1/0M4ahKbYoR
         WTUIBk2Se3huaBC63nleRHesimLTbesD6GtxbU3oBE5ws/14d/6U2oFtEc8On9UK5GN/
         vdym4He2ZU4RIc6NaBkFAwjjBzTPHEDLILayE7buzlNOgtKWJH+L48SMdUPvGB5qsLsf
         EVYG66/q2qRWn/gdsIqjK0LXl2cF1wrH5KolfTMa/+vyehV8+K9esaPH+BADhexIqT87
         r9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eoaBG4NWESUtM1vZtQDCd1TRPzWIfgpt49PPFULCXTQ=;
        b=lT/PEMclpb7K+qbwuJrdOU/bov4Hrtdeq/6BnsR+aHBujBg+0cxx5tiZTfDM01BOy9
         l/rdILyD79133Nm08qumLrtNDeoBsskATFsetuVP3CF53PEwVWJe0AwVV5gb2vbQK9tw
         fzRtH91fMZbAFETv6kInpZV9JsmHyQs6tYeH4bIE9GFP7LIURrD5k8kER2hJNuwnGiiz
         9dTVSsyZ57i71HLv4FTyLlCytwH/ET6wMc2Vp/3m3HbbDudsA5sMBokEDxUhvPhWvTg/
         D2rm3A4WPu8SovtgEAf0ZJn5rpPqhlzGzJpBCMwmRi8jakREZOp4baaGwQ+Qa84Wh3Hy
         7wMw==
X-Gm-Message-State: AGRZ1gJ5fAD952deAdwk5cuFt8VoVW/7nYcqf4ipLh4Qc8v3V83xsf+/
        So5AYt6qSLiKewhP+8LyVRo=
X-Google-Smtp-Source: AJdET5fKY+E7WFUquwEhBozUUXkdpBhqq6dxFchY9FjNRQ/vHxNUj9uN/yF5Qu2Mj3tzjWvC2ExnWQ==
X-Received: by 2002:a2e:81a:: with SMTP id 26-v6mr1222202lji.14.1541673902729;
        Thu, 08 Nov 2018 02:45:02 -0800 (PST)
Received: from jhedberg-mac01.lan (85-76-97-76-nat.elisa-mobile.fi. [85.76.97.76])
        by smtp.gmail.com with ESMTPSA id v5-v6sm615921lje.78.2018.11.08.02.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 02:45:01 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ] doc: Initial Bluetooth Mesh API
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <20181107004950.9153-1-inga.stotland@intel.com>
Date:   Thu, 8 Nov 2018 12:45:00 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>, brian.gix@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DBB63ED-41C4-4F27-B2BC-1ADB090B1656@gmail.com>
References: <20181107004950.9153-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

At first glance this looks quite good to me, just some cosmetic =
comments:

> On 7 Nov 2018, at 2.49, Inga Stotland <inga.stotland@intel.com> wrote:
> +Service	org.bluez.mesh1

I don=E2=80=99t think we=E2=80=99ve had the habit of versioning =
well-known bus names so far. Or did you see this somewhere? So I=E2=80=99d=
 just leave away the version here.

> +Interface	org.bluez.mesh1.Network

The way the existing interfaces do versioning is to have the version at =
the very end, so this should be org.bluez.mesh.Network1

> +Object path	/org/bluez/mesh1

I don=E2=80=99t think we have the habit of versioning object paths =
either. They=E2=80=99re anyway (for the most part) irrelevant - it=E2=80=99=
s the interfaces an object has that defines its type.


> +			PossibleErrors:
> +				org.bluez.mesh1.Error.Failed,
> +				org.bluez.mesh1.Error.Canceled,
> +				org.bluez.mesh1.Error.InvalidArguments
> +				org.bluez.mesh1.Error.Timeout

We=E2=80=99ve never versioned errors either, or did you see this done =
somewhere? So just leave it out from here.

> +		(object node, array{byte, array{(uint16, dict}} =
configuration) Attach(
> +									=
object app_defined_root, uint64 token)
>=20

This is a bit hard to read due to the long & complex return value. I=E2=80=
=99d suggest doing the line break before =E2=80=9CAttatch=E2=80=9D (a =
common C coding-style as well).

> +		void Send(object element_path, uint16_t destination, =
uint16 key_index,
> +								=
array{byte} data)

Minor inconsistency: should be uint16 instead of uint16_t

Johan=

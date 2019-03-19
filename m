Return-Path: <SRS0=3ySR=RW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0499C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 20:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFB62146E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 20:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onv4hHGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfCSUWC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:22:02 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:42908 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCSUWB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Mar 2019 16:22:01 -0400
Received: by mail-oi1-f174.google.com with SMTP id w139so8313739oie.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2019 13:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYk0s5Sj7sQXseKBM1+uowJxiZm2tu+cPO4JGFBCCb0=;
        b=onv4hHGv8IurcYlBjQlfMbCuOXwJct/DCabf3gio6IuhFuDEyowAGqJ5TPsLoEpMem
         HSBS1sBF/ZMNHUiD9NsMJu0BzfajfygXf0l++yGNAjKwqowJl4Kj45xG+yq9WUsiHYJF
         OJl09Bk46lMTP1yEd3+iZ+1i29dGEoVawWYCv5rwp2FMiHZFslSn8G0VZ2IzVFh08gqu
         UffBuwaT7EXoow5fAawoVZ0nl/kBx/Ldxg3snFAlhmx+SlYFyNTShM98BBgCoKsQ0/iM
         0JjFDhtzh41BDjz9pRQBBy/AQFhbf0iLCCR1cxr14q35oSNGcg1ndu8+jDPS5rGJTjJ4
         Z2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYk0s5Sj7sQXseKBM1+uowJxiZm2tu+cPO4JGFBCCb0=;
        b=Cpc//ljqBzknMXmRDih861tdaP0Vl6BSdwl/zEkFUdDyKLfLLcmYaKHZWYTli/QLbl
         FXqXSl7kVUzVrnTnEKhUo9gdhhOmzceO/27Wagy9N+xKbfvEc4fhnneo2FCokwCqC2MY
         /ujFC7R843oQ7HQedscONt1fi4k5OUX+1mXtW4SAlOyZFVAQSWLGfg5n/q/inT7/QhwW
         M9XhFLV4nZ74HwCENr7WWG0fY5JJmNioncppdxFwx51AvAeBD5M8uV9klWAexpNiNtsu
         sJqVELFCvPFOma697abYu8b7D2insKwiU+ZzykyCsenwY/h+T3g1JtajYfu00zd34IlV
         Myxw==
X-Gm-Message-State: APjAAAUBlAseUVP3+/SVhOs1j5GD79jUdK4qMl7ylj4nxSC0Uahz/HR+
        gwXEpPRzYkVvxwC+uX6rwUuja8E8eNuaq+RLv7/3yTKTKkM=
X-Google-Smtp-Source: APXvYqxYJB1UW7q6b6brTQvXXZ6pV8nvxcOLzMEKCQklLhv2KQADaLCKtDYVCFimu5dEt1Hr2bNM9xxDQXZGA9hj7eE=
X-Received: by 2002:aca:da83:: with SMTP id r125mr2745893oig.8.1553026921065;
 Tue, 19 Mar 2019 13:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAKWEGV6aTNGcOcfO5xL+H0P95xh=6dOTdCnvNMrGCxpR1G-aJw@mail.gmail.com>
In-Reply-To: <CAKWEGV6aTNGcOcfO5xL+H0P95xh=6dOTdCnvNMrGCxpR1G-aJw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 Mar 2019 22:21:50 +0200
Message-ID: <CABBYNZJC8RuGb5sKCDznAZimmVmg9LFhg=gN9T4eUUBLrMUikg@mail.gmail.com>
Subject: Re: bluez: Disable GATT client at non-initiator side?
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yauhen,

On Tue, Mar 19, 2019 at 5:07 PM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>
> Hello,
>
> I am trying to implement GATT services with bluez API.
>
> If external device initiated LE connection to device with bluez
> running, bluez start to discover services at initiator and, if one of
> characteristics required pairing, request pairing. This is not
> intended behaviour for some reason in my case, so I need to disable
> GATT client if bluez is not initiator side of the connection, similar
> to ReverseServiceDiscovery config option for non-LE.
>
> Is it possible by any way? As i see code, device_attach_att() function
> in src/device.c initializes GATT client unconditionally in both cases.
> For debug, I disabled client initializing and this seems works for
> external-initiated connections.

We could perhaps reuse the same logic to disable the GATT service
discovery, though the should not cause any pairing request since the
discovery don't actually read any value, apart from characteristic
declaration which shall not require authentication.


-- 
Luiz Augusto von Dentz

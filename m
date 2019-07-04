Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91264C0651F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 21:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571DE21852
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 21:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3gy4VOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfGDV0v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:26:51 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45694 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfGDV0v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 17:26:51 -0400
Received: by mail-ed1-f49.google.com with SMTP id a14so6443242edv.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2019 14:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=38sKwFrZr198N56iXuEja6PBV05qSzotWTQhGkeOY5g=;
        b=j3gy4VOHfsDVaf7G9SzktMVasM/fxWD9pAphP+qrzrbmMV+TuwtTUWaC+bUPXnlVIX
         9TPfcG1MBrdarSDDsbDSk9DlRVzdX9sJw4lPmEjAUfMurZrs+nlWV2j+z7vMi5hDwjh5
         CvtGfL4Wy1T4zp0qdy37B5nYNH2U0jG79vfrnzJV6PvGssHgkNmFXEzuLvXYN6i59o82
         vTOGO3wnylcfsRfUcg7fxE2hC7ASn9j6uXFy/+4miE90YVV60lwniF6iU4Vz1UvNEGka
         4QDsBTdmpU9ol0HshWAVjZQNh+8GuWCBilzmliEP0ElVtviarUh0YDu0WYgPwCLRTer0
         +ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=38sKwFrZr198N56iXuEja6PBV05qSzotWTQhGkeOY5g=;
        b=LcF6+ZSOTbBJCnvVw1IToC0cDLr5a3f1FfJ7EuFaOtb0VAoktquhM52aUXaHyUj6Zj
         ZdVIrNsJ0LEIWFq8163FEPkLT1Tstqn7IonpmpFdCNkmy4armeE5vkTl+efR/uaBvnAp
         2fkRWkjRqiLjsDCzrrVhDZSvKrLjcFiyyc6MHBvjNGJl0a5K34t3MlHrySTE/HATD0rV
         gBKCpyb3Nx13S9ySSOMg+h2fyiISDiMaxyziUogG9RioSTe76BEVpW//OdODvlPelWk4
         Xq1f7aohd45XkPXvfTCoTvJyt/eKxcTRVwmzQyQoUJFcck/zVK0FxEnUeW0gSMr1R4Xh
         znZg==
X-Gm-Message-State: APjAAAX9yYqOFJdfwobcki0XS6mmwUfhq//jsCmRGFvRBewcUzC6oOpI
        tz5ETVTYLKleGPdpQ3/vbKvThT6I
X-Google-Smtp-Source: APXvYqwgEN6Gnh52UO6EOfHyXjRAWSguBpuTsd7Ml5VZdtqZR1QnfKs7Jc+gS9r71Pm3VIAURDjUxg==
X-Received: by 2002:a50:b617:: with SMTP id b23mr736616ede.135.1562275609475;
        Thu, 04 Jul 2019 14:26:49 -0700 (PDT)
Received: from n14xzu ([2a02:8084:4e61:6700:7281:f2b:5966:fd05])
        by smtp.gmail.com with ESMTPSA id q56sm1966728eda.28.2019.07.04.14.26.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 14:26:48 -0700 (PDT)
Date:   Thu, 4 Jul 2019 22:26:45 +0100
From:   John Whitmore <arigead@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Missing manual? - GAP Central connecting to multiple peripherals.
Message-ID: <20190704212644.GA13491@n14xzu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BLE at the wrong end of a learning curve and trying to piece things together.

Perhaps I could just give a rough outline of the project. I want a Linux
device to listen for advertisements from a particular BLE sensor and connect
to those sensors, as and when they appear. Once connected, the Linux device
can send commands to the sensor, to turn on/off an LED or request sensor data
from each of the connected sensors.

The Linux kernel is 4.15 is an Ubuntu 16.04 based system.

I was looking at the latest bluez-5.50 doc directory but didn't see a file for
gap.txt, but adapter-api.txt looks like the API I'm looking for.

I'm trying to do this from Python, so currently thinking of using DBus
interface, another learning curve to address.

So after all that a specific bluex questions. I'm missing things, and possibly
incorrectly assuming that I need a certain kernel specified for bluez5.50, but
can't see any mention of versions of bluez relating to versions of kernel.

Secondly bluez-5.50 appears to be building an applicaiton, so I assume that
application has to be running to interface to Linux Kernel bluetooth stack and
handle the DBus API. So bluez should be a system service just started on
powerup?

Thanks for any help, I get the impression that this list is predominately for
guts of the Linux Kernel's bluetooth stack, but user side list is hard to
find.

Thanks again

John

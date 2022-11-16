Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356E7C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 15:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiKPPh3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 10:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiKPPh1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 10:37:27 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 07:37:26 PST
Received: from b224-1.smtp-out.eu-central-1.amazonses.com (b224-1.smtp-out.eu-central-1.amazonses.com [69.169.224.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB814D0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 07:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=b4y2oqd7fm2lugxzudc3kdvc4wctgrpv; d=ubports.com; t=1668612739;
        h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:Content-Transfer-Encoding;
        bh=Prcl+dF4wD4bKTzA61WwEGzktbMoMarSZGc6Xm0sKDk=;
        b=CNmQdjl7FLRs4WeU2amZMwnkb+rP2We670UUB4Aymzin+kefMjr+u9RDNQ1aGpzF
        pNUuGzFVaEkv4Vc1ZOOuO62hs5YS/PErM5OJ/tjq5RMcI8frygOYV+LAh9emZsBOfHh
        gNS4N2Q887G9U2kE305EbI5Pj1qxE8+QfxBxz89guLMs/fJh4iPEMmlQ5+Px3Xc98Xn
        m4EqIPayM+47O6g53vePxyNaPCod0NDAWYn/xtA6/2wLsrrVdyljtmafJzmgSEiQQn4
        RqNsrNSMBHND1O5ZA6he6xd87jie0ZwMI+0LD48cfZJSnq+krlxVkWc6Iml8XUwZtPH
        uIcVEj1SeQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sokbgaaqhfgd6qjht2wmdajpuuanpimv; d=amazonses.com; t=1668612739;
        h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=Prcl+dF4wD4bKTzA61WwEGzktbMoMarSZGc6Xm0sKDk=;
        b=l2Bd5bwDNX6qfY0dyT3sSH7c7eBfaY2SaNUyvC3lDMaDVb9js6IwchtdNtZwDoqs
        IdgjM1gxdFTuJI3D6tTnakRN9qJsqpL+biOybWDDZo+P6Ua0vLri+W9m23LRRQUzqXH
        I02+prHa2dxfZOijFa+f6zntfkUdHqLWm12azmVI=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ubports.com; s=mail;
        t=1668612739; bh=Prcl+dF4wD4bKTzA61WwEGzktbMoMarSZGc6Xm0sKDk=;
        h=Date:To:From:Subject:From;
        b=pXdFVRf3+Mtwe2WFlOyJGFCGoeLBqwEpnUkr7VcBhtbHVIh/YmTCtQE3hgIyuAl+M
         Ulzum1340aA5gThu/M0qBvG+5aq7rrQsSjqkMkc7MP2mkWr/UYDieLLX2WHWnSFll8
         dmi5Gkj5TZCVQghRueSspDwFjCjF85n48vPXgEfLPkpiKGPypRDyMRzPTsN1OMXOsR
         kR4eLNZ7Nq/LBgzVd7e5fi4NEtvHReMzMSEywKClqV0JcinJrTRReQ+ebJLZ/UkA4A
         b78ExRgsD9nuq2DNYald73Xwh7gMf0s5dvZes6tTEfWY+P53AbzwaVp4cxXUC0Plor
         4Mpi1O9dXzJ0w==
Message-ID: <010701848111d140-5dd1752f-c89a-47a1-9472-2e5a5a8a740a-000000@eu-central-1.amazonses.com>
Date:   Wed, 16 Nov 2022 15:32:19 +0000
MIME-Version: 1.0
To:     linux-bluetooth@vger.kernel.org
Content-Language: de-DE
From:   Florian Leeber <florian@ubports.com>
Subject: Bluez <> Pebble smartwatch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-central-1.U71sxic/3tmi0U3T+Ze2hDyqoN46zyPgdCO+zEPT6YQ=:AmazonSES
X-SES-Outgoing: 2022.11.16-69.169.224.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello All,

does anyone have any experience pairing a Pebble smartwatch with Bluez? 
It was working kinda well in an Bluez 5.41, but now with 5.53 to which 
we are upgrading in Ubuntu Touch the pairing process is unsucessful. As 
I do not own the device debugging is difficult, but some users try now 
to get a btmon trace.

BR Florian


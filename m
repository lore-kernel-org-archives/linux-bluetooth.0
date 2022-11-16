Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiKPUn4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 15:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPUnz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 15:43:55 -0500
X-Greylist: delayed 247 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 12:43:54 PST
Received: from b224-6.smtp-out.eu-central-1.amazonses.com (b224-6.smtp-out.eu-central-1.amazonses.com [69.169.224.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F242EF28
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=b4y2oqd7fm2lugxzudc3kdvc4wctgrpv; d=ubports.com; t=1668631185;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=x68CGsDXkRJ6cHWKkWRI3KQ8v+86ryZ6l5wEEdA4wR8=;
        b=iVKqutnxdPgIWREZmnAMTF4wTOo9zzj9IIRUjZKBojBNNxup1M6Q2BCR4AoUWIbh
        tUEEK09J0aR6jHe+H/fyfQXL/gIBwpqy+4csuW+Mj8TsfdkLN5pXIpJpikKd/n+IODZ
        QXxImCULa7tSN2bMpFfl3p8MAoBrRaCv0BF4RXgndMdIa/gVuEgsOYZVXo46fs/UrAK
        DB0cX9fgYKkG4zb5rte+JXfmPhdjgOT7OXsEATi2Zbo+83qP+2od0V2ae/TFc1+ICEI
        CIMoX5GIZfjGV1ZRgGnJyMm97+8gVCqub0C+WXaVDR3UAFKp1PF5wijlTDgEnET/H40
        5HCrzp/J3g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sokbgaaqhfgd6qjht2wmdajpuuanpimv; d=amazonses.com; t=1668631185;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=x68CGsDXkRJ6cHWKkWRI3KQ8v+86ryZ6l5wEEdA4wR8=;
        b=HmsOb6+8JL11diq2oJBFJcntyzy3Xa08VUg4tiHewIBf2FTdGhX+HyNWxtlmGHgl
        OYmBH2twNh9NnpBC1BJdExzVyo7OOUiQiRX5aiIQUn+mE+hSVAUTIzaWZQV/j4qjZ74
        AJvOZ65ZRTUqd03bwbxGTADUTTPJBPVSjoWBjZgI=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ubports.com; s=mail;
        t=1668631185; bh=x68CGsDXkRJ6cHWKkWRI3KQ8v+86ryZ6l5wEEdA4wR8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BEqezfuqeVdRwki6ToqETNcHcPo+PTeAeN8pRWVicQ1CEifCMpCFRvKRQ0JIUV7wf
         SZbLpZyJvc5Bx3pKZYqmSXEENt7AOR9P1PoQa1w5fmsY8hHrdrUasCKbQJMUzbrBPb
         /cBioBkSrVm5BDSJInQ5XhSf5tragIlfaoteBGqQE0mBuFn9qSbEdQ5X5Zhf9tqn/m
         CG2GMzsIN8sR1zQTw0jgUUQvs1Tr8+MYjWgCnV5vfIXT1qDfCFNFLYFMOArBIhUOTc
         /a5qdizyCWV5y/0Ko0p6tRYRbxz4YjiXNYQdaGqjyS6Eg9zidyE5Gzs7Gfoifxhm4o
         nhLR7tc82vWGg==
Message-ID: <01070184822b48a4-e211e97b-6c3b-4cd2-8f39-38ed6bb6608b-000000@eu-central-1.amazonses.com>
Date:   Wed, 16 Nov 2022 20:39:45 +0000
MIME-Version: 1.0
Subject: Re: Bluez <> Pebble smartwatch
Content-Language: de-DE
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <010701848111d140-5dd1752f-c89a-47a1-9472-2e5a5a8a740a-000000@eu-central-1.amazonses.com>
 <CABBYNZJaS8fTuXBm7hEvA_3jYqCpcjBdHbR6f2Zz-zBZF4TEvw@mail.gmail.com>
From:   Florian Leeber <florian@ubports.com>
In-Reply-To: <CABBYNZJaS8fTuXBm7hEvA_3jYqCpcjBdHbR6f2Zz-zBZF4TEvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-central-1.U71sxic/3tmi0U3T+Ze2hDyqoN46zyPgdCO+zEPT6YQ=:AmazonSES
X-SES-Outgoing: 2022.11.16-69.169.224.6
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey, will a btmon trace be enough? Or also Bluez daemon log?

Am 16.11.2022 um 21:36 schrieb Luiz Augusto von Dentz:
> Hi Florian,
>
> On Wed, Nov 16, 2022 at 7:38 AM Florian Leeber <florian@ubports.com> wrote:
>> Hello All,
>>
>> does anyone have any experience pairing a Pebble smartwatch with Bluez?
>> It was working kinda well in an Bluez 5.41, but now with 5.53 to which
>> we are upgrading in Ubuntu Touch the pairing process is unsucessful. As
>> I do not own the device debugging is difficult, but some users try now
>> to get a btmon trace.
> Getting the traces is essential to discover why it is failing, we also
> need the information of the kernel version as well.
>


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC7C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 22:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiKAWi7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiKAWid (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 18:38:33 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69902BCE
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 15:38:17 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7BB2684F2C;
        Tue,  1 Nov 2022 23:38:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667342295;
        bh=KloE77MpBLTtItNMo9dwRGx9I8lhNIQMhsgSbNegE5o=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=rauk0N2mdOZgcFz16Lm9nPXs8HjPK3Sd0pSV4xWQiPnCXEAfzko1tr/wf0pNcRJ+D
         zFlfx7vOAK+DRuXteZERFmpCZJbUGMIrvyX+1GczOFz71aBFLnBgZOsKXlrhc/gc4N
         lbHQnHakrW7vS9PkaG0L9TggUxlInG3tDz5tvvmecw9WpS0rC5/z0dogX5fUUAJODV
         JTlZ2i2/InPTiYkVH40lPyJnpaMN37Bi8rp4DnhkzvwsAP0aFJLDrXLEiOMyryuFq/
         KWGT1wY1IPYCGOx2fLziPYBbFzuYjQ9fbBJM7/IlRCKlbbTJf00VPgt+iPxcfgW4LH
         WNBSJz2QrGq/w==
Message-ID: <a7485b76-b4aa-a6d6-b509-c6f370380926@denx.de>
Date:   Tue, 1 Nov 2022 23:38:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0 DT
 binding
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20221031204804.195267-1-marex@denx.de>
 <6360471e.4a0a0220.4aceb.91b7@mx.google.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <6360471e.4a0a0220.4aceb.91b7@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 10/31/22 23:07, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690631
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      2.99 seconds
> GitLint                       PASS      1.48 seconds
> SubjectPrefix                 FAIL      0.58 seconds

Should the DT bindings really have Bluetooth: prefix/tag too ?
git log on prior art indicates they shouldn't .

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC26C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Dec 2021 00:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhLMAmo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Dec 2021 19:42:44 -0500
Received: from relay.wiredblade.com ([168.235.105.136]:57123 "EHLO
        relay.wiredblade.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhLMAmo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Dec 2021 19:42:44 -0500
dkim-signature: v=1; a=rsa-sha256; d=relay.compata.com; s=mail;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type:In-Reply-To:References;
        bh=l50TCTh7U6hy91SO4JRbZh+FHUZ9WC7yRuJXluk6zfY=;
        b=wtPEf5N2QYfKyGSgWiG/OURM0Rg62r0K/MLY1WNPoEnqet3IQJuyEzu+3vnbFIlUefM4lpwYDovBU0+zY9qw1ZpEmpwpCWtQOrIPZ/BSHgDO6TaZUIef+nXhpWcqqBR6Bm9WM3OKLP7r9Uwe6329QLVZYKp/oBgl4jHKjPdb2gIPl+7nu8TClmU2/I1kau/przTP2Bd7fFitxiXxUWzPyyHS5+rpGvkn7/bAx9Rtty+b2EYqJAw39N0vjU
        i7tR6FwFtdDzf1QQXGXqbASiAjPQCD4nAnr/RlZHwZx2tsqlCVyA7eeH3wS7/8iwUdEZvOHBR1SVgG7d+kvkOc1FJrAw==
Received: from compata.com (ip68-5-142-19.oc.oc.cox.net [68.5.142.19]) by relay.wiredblade.com
 with ESMTPSA (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
 ; Mon, 13 Dec 2021 00:42:43 +0000
Received: from d7010.compata.com ([192.168.44.19]) by compata.com (8.16.1/8.16.1) with
 ESMTP id 1BD0gguB780693 for <linux-bluetooth@vger.kernel.org>; Sun, 12 Dec
 2021 16:42:42 -0800
Received: from d7010 (localhost [127.0.0.1]) by d7010.compata.com (8.16.1/8.15.2) with
 ESMTP id 1BD0ggg43001872 for <linux-bluetooth@vger.kernel.org>; Sun, 12
 Dec 2021 16:42:42 -0800
Message-Id: <202112130042.1BD0ggg43001872@d7010.compata.com>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7.1
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Reconciling hcidump output with btmon
In-reply-to: Your message of "Sun, 12 Dec 2021 15:49:54 +0100."
 <506218C2-CFDA-4DD9-A55B-14C8A8E3D5C2@holtmann.org>
References: <202112120540.1BC5evj82621220@d7010.compata.com>  <506218C2-CFDA-4DD9-A55B-14C8A8E3D5C2@holtmann.org>
From:   Dave Close <dave@compata.com>
X-Face: $?&5f7w4GjUJOb-[FmngebA}V`5Dv)QEdHg|d%mytVRm]'o}*{J6:PP%(LfN
 LmOcb#>"^wDF*|ZzuS??S*vLH[.miV(<v!QArMJG;~Mx<jl!LQ3)Gy9xw7w!EBQx9H~*[
 *XF#\wyQK,dciSN=F_gd#{`rb43?hn5C9I&@Q2C+epIAS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 12 Dec 2021 16:42:42 -0800
X-Scanned-By: MIMEDefang 2.85 on 192.168.44.23
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I wrote:

> I understand that "hcidump" has been deprecated for several years. Yet
> the output of "btmon" seems to imply that it is calling "hcidump". That
> doesn't make sense to me. For example,
> 
>  @ RAW Open: hcidump (privileged) version 2.22 {0x0002} [hci0] 1.894682
>  @ RAW Open: hcidump (privileged) version 2.22 {0x0003} 1.894702
>  @ RAW Close: hcidump                          {0x0003} 1.894708
>  @ RAW Close: hcidump                          {0x0002} [hci0] 1.894718

Marcel Holtmann answered:

>I don't know what that is, but it seems that something else in your system is 
>calling hcidump binary. However it is for sure not btmon calling the hcidump b
>inary and you can verify that in the btmon source code.

The lines I quoted are from the stdout of btmon. How would something else
get output mixed into that? Is the Fedora version of btmon modified?

>The hcidump -R functionality is rather useless. If you really want it, then yo
>u can get it by opening the monitor socket directly. I really don't know what 
>you wanted it for.

I wanted to see the actual data stream from my devices. So far as I can
tell, I can't get that from any of the undeprecated Bluez tools.
-- 
         Dave Close, Compata, Irvine CA       +1 714 434 7359
       dave@compata.com              dhclose@alumni.caltech.edu
         "I don't need bodyguards." -- Jimmy Hoffa, June 1975



Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08457C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 01:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhLIB1q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:27:46 -0500
Received: from relay.wiredblade.com ([168.235.105.136]:53644 "EHLO
        relay.wiredblade.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbhLIB1q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 20:27:46 -0500
dkim-signature: v=1; a=rsa-sha256; d=relay.compata.com; s=mail;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type:In-Reply-To;
        bh=3OVMQ1YxKF3pYeVGBQA9UFWTfN3bT9abkMdXy3hv0mU=;
        b=ePwi2FdVixGaSV3B1LY4i6qnlyKQ5ihlpoMV0+pvxo9OfQLIfrSbV72MwPJwK3skyyLWSufl8JDLq7yxYAN6qfFctHj4HJX6uejL8phxWC6MZKY7HvDtezSCxj0IXoxFlBRk1gUftdAIBcDhY6FH4sG/nAo5/+fTWLx8sLTDuwkLt5n8z6ldGIlnt1KLIZWWyl1jgN3TjrtByZWSzDy/u5uBsXiFO9lEIEYzKv1WPXK2Yz9i0gc581buue
        DRlPBs9v+aqEsMpLCH4P/JJ8yTxzZxsPuQmtwVFDE0Vwtk2rjHlDxRys5uVhEdG/TLgIDvTmgfpoe4rfKdSvi8wxHbvQ==
Received: from compata.com (ip68-5-142-19.oc.oc.cox.net [68.5.142.19]) by relay.wiredblade.com
 with ESMTPSA (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
 ; Thu, 9 Dec 2021 01:24:13 +0000
Received: from d7010.compata.com ([192.168.44.19]) by compata.com (8.16.1/8.16.1) with
 ESMTP id 1B91OBgo418801 for <linux-bluetooth@vger.kernel.org>; Wed, 8 Dec
 2021 17:24:11 -0800
Received: from d7010 (localhost [127.0.0.1]) by d7010.compata.com (8.16.1/8.15.2) with
 ESMTP id 1B91OBBV1054228 for <linux-bluetooth@vger.kernel.org>; Wed, 8 Dec
 2021 17:24:11 -0800
Message-Id: <202112090124.1B91OBBV1054228@d7010.compata.com>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7.1
to:     linux-bluetooth@vger.kernel.org
Subject: Re: hcidump replacement
In-reply-to: Your message of "Wed, 08 Dec 2021 13:10:46 -0800."
 <CABBYNZJBnFAxt+97w804gWpYca+f-Tn8Pq6gr5bUnx5kcwJDpw@mail.gmail.com>
From:   Dave Close <dave@compata.com>
X-Face: $?&5f7w4GjUJOb-[FmngebA}V`5Dv)QEdHg|d%mytVRm]'o}*{J6:PP%(LfN
 LmOcb#>"^wDF*|ZzuS??S*vLH[.miV(<v!QArMJG;~Mx<jl!LQ3)Gy9xw7w!EBQx9H~*[
 *XF#\wyQK,dciSN=F_gd#{`rb43?hn5C9I&@Q2C+epIAS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 08 Dec 2021 17:24:11 -0800
X-Scanned-By: MIMEDefang 2.85 on 192.168.44.23
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>Hi Dave,
>
I wrote:

>I've been recording data from a sensor using a script like this --
>
>  while read a; do
>    grep <pattern> $a
>    # do my stuff
>  done < <( hcidump -R )
>
>Reading tons of web pages and mailing list entries, I still haven't
>found anything equivalent that doesn't use the deprecated hcidump.
>Suggestions appreciated.

Luiz Augusto von Dentz answered:

>Check out btmon.

Yes, I had done that. But at least the default output is much more
complex than what I see from hcidump. Are there any options you can
suggest that can get me closer to the older output? Is there any way
to get something more easily parsable, perhaps XML?




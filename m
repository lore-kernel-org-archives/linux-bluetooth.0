Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98668C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 06:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbhLHGEw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 01:04:52 -0500
Received: from relay.wiredblade.com ([168.235.105.136]:64467 "EHLO
        relay.wiredblade.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhLHGEv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 01:04:51 -0500
dkim-signature: v=1; a=rsa-sha256; d=relay.compata.com; s=mail;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type:In-Reply-To;
        bh=55b6WmOvj6wIgal6IzTGjlbD/Y8MooZSQBcewGv8uug=;
        b=mOOPNnMzS+EH5VqMsPDIv+Re9q2DEn8cY9OIlH8+DIncNrKQ+FqWmCj63o2k0yvZRRiTsVrd/xyPBpG0r6gaCjYoxp5RMzHVlGttzLf/bdvAOpjLdTNt9iw1A1qOnqZgUC3f+Erw86jnNut6Oas7XZJjrOPGChTi/orqv43QU6SCfe6qR/mNmZ1EThsPvA5j4YA+ejtfSmh2K0H5mcOH2+heR6DKuRJtE0L9k1iLwCoRDsO47agSmTxN3k
        sn1GDE21+8jDvN5fjyKQjFqrYFk0dlYYN4KfsrBUHTZv38ISDkMAFzR4YtweBF0BKTT5cERv+cVzeqTsFu7KcidioyTQ==
Received: from compata.com (ip68-5-142-19.oc.oc.cox.net [68.5.142.19]) by relay.wiredblade.com
 with ESMTPSA (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
 ; Wed, 8 Dec 2021 06:01:19 +0000
Received: from d7010.compata.com ([192.168.44.19]) by compata.com (8.16.1/8.16.1) with
 ESMTP id 1B861H9o349275 for <linux-bluetooth@vger.kernel.org>; Tue, 7 Dec
 2021 22:01:17 -0800
Received: from d7010 (localhost [127.0.0.1]) by d7010.compata.com (8.16.1/8.15.2) with
 ESMTP id 1B861HZC669128 for <linux-bluetooth@vger.kernel.org>; Tue, 7 Dec
 2021 22:01:17 -0800
Message-Id: <202112080601.1B861HZC669128@d7010.compata.com>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7.1
Subject: Re: hcidump replacement
To:     linux-bluetooth@vger.kernel.org
In-reply-to: Your message of "Mon, 06 Dec 2021 14:57:19 -0800."
 <202112062257.1B6MvJMT374832@d7010.compata.com>
From:   Dave Close <dave@compata.com>
X-Face: $?&5f7w4GjUJOb-[FmngebA}V`5Dv)QEdHg|d%mytVRm]'o}*{J6:PP%(LfN
 LmOcb#>"^wDF*|ZzuS??S*vLH[.miV(<v!QArMJG;~Mx<jl!LQ3)Gy9xw7w!EBQx9H~*[
 *XF#\wyQK,dciSN=F_gd#{`rb43?hn5C9I&@Q2C+epIAS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 07 Dec 2021 22:01:17 -0800
X-Scanned-By: MIMEDefang 2.85 on 192.168.44.23
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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

Is this the wrong list for my question?




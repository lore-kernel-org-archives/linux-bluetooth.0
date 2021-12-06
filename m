Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583ECC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 23:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377156AbhLFXQG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 18:16:06 -0500
Received: from relay.wiredblade.com ([168.235.105.136]:55974 "EHLO
        relay.wiredblade.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376764AbhLFXQG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 18:16:06 -0500
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 18:16:06 EST
dkim-signature: v=1; a=rsa-sha256; d=relay.compata.com; s=mail; c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type; bh=evaNGIz+WwxHfB20pl9BnTVGMHklvEJYF/Jgm1EIoxI=;
 b=zRlf3S9reZrAdWJ3UGaGnG9iF/0iqD1qI5ZDG4S/izkMPZFTxA8XsM2jDkqStFarRmdyJ7rFYVvh5TA3/SDTQFayfm2mN+IYyB0Ox/shq1yGkosQZq6+Ar78oBnBIvkX32YBSmtWQLuO7jZuC0BWisurKhUgs2egDpapfkf9pL+QBdJ73fl6JwTPKzGRFbC7te4FETUHXhx1z8Z1w+P3NzMrhXGGDPolt2tLvjbf5ZJNRtofHtwBy8udk/
 JrVxUG1ySvhNkrwJMvj3K409y1WSDTbpHITlKkr0NVivRdWiagFMUvft936Vpm413d8aoHef1u/CBJta3hdWzi5bgRHQ==
Received: from compata.com (ip68-5-142-19.oc.oc.cox.net [68.5.142.19]) by relay.wiredblade.com
 with ESMTPSA (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
 ; Mon, 6 Dec 2021 22:57:21 +0000
Received: from d7010.compata.com ([192.168.44.19]) by compata.com (8.16.1/8.16.1) with
 ESMTP id 1B6MvJ2B239278 for <linux-bluetooth@vger.kernel.org>; Mon, 6 Dec
 2021 14:57:19 -0800
Received: from d7010 (localhost [127.0.0.1]) by d7010.compata.com (8.16.1/8.15.2) with
 ESMTP id 1B6MvJMT374832 for <linux-bluetooth@vger.kernel.org>; Mon, 6 Dec
 2021 14:57:19 -0800
Message-Id: <202112062257.1B6MvJMT374832@d7010.compata.com>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7.1
To:     linux-bluetooth@vger.kernel.org
Subject: hcidump replacement
From:   Dave Close <dave@compata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Mon, 06 Dec 2021 14:57:19 -0800
X-Scanned-By: MIMEDefang 2.85 on 192.168.44.23
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I've been recording data from a sensor using a script like this --

  while read a; do
    grep <pattern> $a
    # do my stuff
  done < <( hcidump -R )

Reading tons of web pages and mailing list entries, I still haven't
found anything equivalent that doesn't use the deprecated hcidump.
Suggestions appreciated.




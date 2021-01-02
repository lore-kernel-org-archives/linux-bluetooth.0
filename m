Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F09C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 21:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988EB20799
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 21:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhABVI4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Jan 2021 16:08:56 -0500
Received: from hoster906.com ([192.252.156.27]:37672 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbhABVI4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Jan 2021 16:08:56 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jan 2021 16:08:56 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=to:cc
        :from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=dkim; bh=K8q68xQQSXiYwsSP43gMggwEN
        j8BGJGBq82V1Izl4DU=; b=D7/HLt71fMNNNeoTSt/pU+u/QS7A/ZL5y26yEUZbA
        Idl91XWWxUuO/ixH7s3i8SVnpy6vvhVe8VF1oN+hjLs2Xa5VCwXrEuhuWGzlzkpr
        YXai/hYoFw/dMOR05wdSWbetmLlnwXmgbAbKo6oOOfDrmbiedSDsbmw6JIRddiKt
        ig=
Received: (qmail 35826 invoked by uid 503); 2 Jan 2021 21:01:34 -0000
Received: from unknown (HELO ?192.168.254.79?) (mike@mnmoran.org@40.134.89.129)
  by hoster906.com with ESMTPA; 2 Jan 2021 21:01:34 -0000
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
From:   "Michael N. Moran" <mike@mnmoran.org>
Subject: mesh: Key Refresh procedure does not finalize AppKeys
Message-ID: <1a29717a-5c89-37d3-7fdb-dceeae33bee5@mnmoran.org>
Date:   Sat, 2 Jan 2021 16:01:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Greetings meshers,

I am testing a BlueZ mesh configuration client that performs the Key Refresh procedure.

Key Refresh works splendidly for NetKeys.

Key Refresh also works well for AppKeys located on actual remote nodes.

However, when updating the AppKeys for (what I will call) "virtual"[1] (those nodes that execute on the same host as the configuration client), the final transition back to Phase 0 doesn't take effect after returning to Phase 0 unless I restart bluetooth-meshd.

Apparently, the persistence/data-base is updated correctly since the proper state is restored after a restart of the daemon.

I suspect that somewhere in the path that begins in mesh/net.c with the function key_refresh_finish() there should be a place where the app_keys are iterated, updating the state of those AppKeys that belong to the subnet and have been updated. The update would involve copying the new_key to the "old" key field.

I am using a relatively new version of BlueZ, and the lastest version of key_refresh_finish() looks unchanged.

Am I missing something?

Thanks,
mike

[1] I use the term "virtual" to avoid confusion with the term "local" that is used in the documentation to refer to something else that is not clearly defined to me.


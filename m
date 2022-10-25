Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12945C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 07:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiJYHC5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 03:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJYHCz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 03:02:55 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9957CB3B02
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 00:02:53 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeef3.dynamic.kabel-deutschland.de [95.90.238.243])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3408061EA1931;
        Tue, 25 Oct 2022 09:02:50 +0200 (CEST)
Message-ID: <ab082d3c-9ba6-b1bd-a895-65ea58cec926@molgen.mpg.de>
Date:   Tue, 25 Oct 2022 09:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
 unusable again with kernel 6.0
To:     Jack <ostroffjh@users.sourceforge.net>
References: <RJ4W7HKW.X5Y4H63W.RFY63IY6@7AFBARQQ.HKEIB7DO.6ME2HPJY>
Content-Language: en-US
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <RJ4W7HKW.X5Y4H63W.RFY63IY6@7AFBARQQ.HKEIB7DO.6ME2HPJY>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Jack,


Thank you for your work on this driver.


Am 24.10.22 um 23:11 schrieb Jack:
> Cheap USB BT dongles that are bad clones of CSR  "ID 0a12:0001 Cambridge 
> Silicon Radio, Ltd Bluetooth Dongle (HCI mode)" have had historic 
> problems, due to various bad behaviors.  See [Bug 60824] 
> [PATCH][regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle 
> unusable (https://bugzilla.kernel.org/show_bug.cgi) for more details and 
> background.  The patch in that bug was initially mainlined in 5.9, and 
> underwent several revisions since then.  It has continued to work 
> through all of the 5.19 series, but it does not work with any of the 6.0 
> kernels.
> 
> I have made three unsuccessful attempts to git bisect using vanilla 
> sources.  All settled on totally irrelevant commits.  These have all 
> used v6.0-rc1 and v5.19 as the starting bad and good commits.

Thank you for trying to bisect the issue. Too bad, it’s inconclusive. 
Did you or can you please test the commits below, relating to the merges 
of the Bluetooth trees.

1.  b8c3bf0ed2edf2deaedba5f0bf0bb54c76dee71d
2.  1d1ab5d39be7590bb2400418877bff43da9e75ec
3.  2e64fe4624d19bc71212aae434c54874e5c49c5a
4.  4a934eca7b39df35569f97a070701d6846ce46df
5.  14202eff214e1e941fefa0366d4c3bc4b1a0d500
6.  c69ecb0ea4c96b8b191cbaa0b420222a37867655
7.  6e0e846ee2ab01bc44254e6a0a6a6a0db1cba16d
8.  5588d628027092e66195097bdf6835ddf64418b3

> Having read all the pages on filing a [REGRESSION} bug, I'm a bit 
> intimidated to file something without sufficient information to be taken 
> seriously, but will do so using this information, if that seems the best 
> course of action.

Having the regression documented is the most important thing, and it 
will be taken seriously even if the reporter has not fully analyzed or 
solved it.

[…]


Kind regards,

Paul

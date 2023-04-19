Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802D2C77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 10:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjDSK1b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 06:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDSK1a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 06:27:30 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEAC4EE6
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 03:27:28 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CA83961E4052B;
        Wed, 19 Apr 2023 12:27:25 +0200 (CEST)
Message-ID: <a99a95ac-b2b2-6a9d-5289-24d10ce6480a@molgen.mpg.de>
Date:   Wed, 19 Apr 2023 12:27:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH BlueZ v3] obexd: support to reply folder name to store
 file
Content-Language: en-US
To:     Guiting Shen <aarongt.shen@gmail.com>
References: <20230419101954.56002-1-aarongt.shen@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230419101954.56002-1-aarongt.shen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Guiting


Am 19.04.23 um 12:19 schrieb Guiting Shen:
> From: Aaron_shen <aarongt.shen@gmail.com>

The old name is still documented as the author for the commit. Did you 
execute the second command?

     git commit --amend --author="Aaron Shen <aarongt.shen@gmail.com>"

Or with your real name:

     git commit --amend --author="Guiting Shen <aarongt.shen@gmail.com>"

You can verify the success with `git show` and look at the meta data.

> The obex agent usually reply the filename by getting the default filename

s/reply/replies/

Do you mean *returns* instead of *replies*?

> from the filename property of the transfer object which is not convenient.
> The patch helps that the obex agent can reply folder name or new filename
> or null which will use the default filename if new_name is NULL and the
> default folder if the new_folder is NULL in opp_chkput().

[…]


Kind regards,

Paul

Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE28AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 14:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0C0206E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 14:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGGONZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:13:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45755 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGGONZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 10:13:25 -0400
Received: from [192.168.1.91] (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id C68AFCECEC;
        Tue,  7 Jul 2020 16:23:19 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1] Bluetooth: create CONFIG_BT_DEBUG_FUNC_NAME
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_Vq7t-6sX9UWravhcb64K_2LpsD-xGZsZec__2VcYwBgw@mail.gmail.com>
Date:   Tue, 7 Jul 2020 16:12:52 +0200
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <67720527-0A53-4B5B-A1CB-D53AE162A82C@holtmann.org>
References: <20200707003937.187125-1-alainm@chromium.org>
 <4B0E4627-26D8-4D70-ABE9-6CB7A9E86D35@holtmann.org>
 <CALWDO_Vq7t-6sX9UWravhcb64K_2LpsD-xGZsZec__2VcYwBgw@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> Creates a CONFIG_BT_DEBUG_FUNC_NAME option to include function names in
>>> debug statements.
>>> 
>>> Unlike other platforms __func__ isn't a string literal so it cannot be
>>> automatically concatenated by the pre-processor.  As a result, the
>>> function name is passed as a parameter to the tracing function.  Since
>>> pr_debug is a function like macro, the normal expansion of BT_PREFIX_PARAM
>>> does not work as it gets processed within the first parameter as well,
>>> for this reason, BT_DBG is split into two versions.
>>> 
>>> This patch was built tested with all 4 possible combinations of
>>> CONFIG_BT_DEBUG_FUNC_NAME and CONFIG_BT_FEATURE_DEBUG configurations.
>> 
>> can we please limit this to FEATURE_DEBUG since dynamic debug doesn’t need it. It can switch on function name debugging on a per debug statement. And even for FEATURE_DEBUG I would rather have it optional that can be enabled when needed via the experimental feature itself.
> I agree on making this dependent on FEATURE_DEBUG as it may simplify
> the configuration, but I don't think I like having this enabled via an
> experimental feature as it complicates the tracing macros quite a bit
> for no good reason.  I don't see a scenario where someone would turn
> on CONFIG_DEBUG_FUNC_NAME but not want it enabled.

I left the Set Experimental Feature command flexible and so you could add an extra flags/settings bitmask additionally to choose how to format the debug strings. Similar to what dynamic debug is doing.

An alternative is that you have two debug features, one for with function names and one without. If you turn on both, then the one with function names supersedes.

Regards

Marcel


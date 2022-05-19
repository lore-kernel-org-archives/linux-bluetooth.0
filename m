Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB73BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 18:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbiESSJK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243654AbiESSJE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 14:09:04 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 259B7DE31F
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 11:09:02 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fb9d.dip0.t-ipconnect.de [79.249.251.157])
        by mail.holtmann.org (Postfix) with ESMTPSA id 27214CECFA;
        Thu, 19 May 2022 20:09:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] Bluetooth: MGMT: Fix uses of bitmap_from_u64
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220516203539.1708251-1-luiz.dentz@gmail.com>
Date:   Thu, 19 May 2022 20:09:01 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4A5486C7-C1E8-41A3-9E7F-E627BBA79503@holtmann.org>
References: <20220516203539.1708251-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> bitmap_from_u64 expects at least 8 bytes to be declared since it doesn't
> take any parameter regarding the number of bits causing the following
> warnings:
> 
> In file included from include/linux/cpumask.h:12,
>                 from include/linux/mm_types_task.h:14,
>                 from include/linux/mm_types.h:5,
>                 from include/linux/buildid.h:5,
>                 from include/linux/module.h:14,
>                 from net/bluetooth/mgmt.c:27:
> In function 'bitmap_copy',
>    inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:270:2,
>    inlined from 'bitmap_from_u64' at include/linux/bitmap.h:622:2,
>    inlined from 'set_device_flags' at net/bluetooth/mgmt.c:4534:4:
> include/linux/bitmap.h:261:9: warning: 'memcpy' forming offset [4, 7] is
> out of the bounds [0, 4] of object 'flags' with type
> 'long unsigned int[1]' [-Warray-bounds]
>  261 |         memcpy(dst, src, len);
>      |         ^~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/kasan-checks.h:5,
>                 from include/asm-generic/rwonce.h:26,
>                 from ./arch/arm/include/generated/asm/rwonce.h:1,
>                 from include/linux/compiler.h:248,
>                 from include/linux/build_bug.h:5,
>                 from include/linux/container_of.h:5,
>                 from include/linux/list.h:5,
>                 from include/linux/module.h:12,
>                 from net/bluetooth/mgmt.c:27:
> net/bluetooth/mgmt.c: In function 'set_device_flags':
> net/bluetooth/mgmt.c:4532:40: note: 'flags' declared here
> 4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
>      |                                        ^~~~~
> include/linux/types.h:11:23: note: in definition of macro 'DECLARE_BITMAP'
>   11 |         unsigned long name[BITS_TO_LONGS(bits)]
>      |                       ^~~~
> 
> In order to fix the above this initializes a variable using
> DECLARE_BITMAP with the current_flags and then uses bitmap_subset to
> check if the flags being set are a subset of hdev->conn_flags that way
> all the checks are performed using bitmap APIs and conversion to u32
> only happen when really needed.
> 
> Fixes: a9a347655d22 ("Bluetooth: MGMT: Add conditions for setting HCI_CONN_FLAG_REMOTE_WAKEUP")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/mgmt.c | 43 ++++++++++++++++++-------------------------
> 1 file changed, 18 insertions(+), 25 deletions(-)

what is up with the kbot issues?

Regards

Marcel


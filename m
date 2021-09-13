Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4555C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D4E610CE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245270AbhIMVA6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 17:00:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38647 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbhIMVAy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 17:00:54 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id D30BBCECCB;
        Mon, 13 Sep 2021 22:59:37 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [Bluez PATCH v3 00/12] Inclusive language changes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210902104938.824737-1-apusaka@google.com>
Date:   Mon, 13 Sep 2021 22:59:37 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <9E326EA9-BCF3-4374-ACF5-D492B9473497@holtmann.org>
References: <20210902104938.824737-1-apusaka@google.com>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> This series of patches promotes the usage of the more inclusive terms
> such as central/peripheral, accept list/reject list, or their
> equivalent where appropriate.
> 
> This is also reflected on the changes to Core spec v5.3 and the
> appropriate language mapping table by Bluetooth SIG
> https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
> 
> As you suggested, I dropped the Android changes and merge patches
> which belong to the same directory into one patch.
> 
> Note that the following terms are not replaced:
> (1) those involving storage format (i.e. storing LTK)
> (2) those which belong to the libbluetooth API
> 
> Thanks,
> Archie
> 
> Changes in v3:
> * Not replacing some terms which belong to libluetooth API
> 
> Changes in v2:
> * Merging several patches from the same directory into one
> 
> Archie Pusaka (12):
>  lib: Inclusive language changes
>  btio: Inclusive language changes
>  monitor: Inclusive language changes
>  emulator: Inclusive language changes
>  tools: Inclusive language changes
>  plugins/sixaxis: Inclusive language changes
>  profiles: Inclusive language changes
>  src: Inclusive language changes
>  client: Inclusive language changes
>  mesh: Inclusive language changes
>  unit/mesh: Inclusive language changes
>  doc: Inclusive language update

so besides the parameter issue for the tools, this looks fine. However I rather apply a whole set of patches instead of cherry-picking. You can even send them into two or three batches so we can apply them quicker.

Regards

Marcel


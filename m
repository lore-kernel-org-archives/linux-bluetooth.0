Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED887C54E94
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 15:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjAZPNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 10:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjAZPNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 10:13:54 -0500
Received: from smtp-out-07.comm2000.it (smtp-out-07.comm2000.it [212.97.32.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD05A270
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 07:13:51 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-07.comm2000.it (Postfix) with ESMTPSA id 6B9153C5E2E;
        Thu, 26 Jan 2023 16:13:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1674746028;
        bh=+Ci9ZYvs07uEomnWhLmCEpADdWv/Nx5U/weDav72cSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=tU+oalp1zDYRgKe1aYDYtgRdUMGQ+HxIrAzmsVkO53m4kPZ8+mXBiXdSIvKPNTZXI
         hgIGapQY2XiKhImU/nLfa24kMaKz7Jqs8hcRKiE4wdqdm3tOH07WLaXVHSlwACSXZM
         pqc6mqfM9ZTd0x9pEJHiUrAlInzIYFzQmLMpogvdlJQaYKAZBaRDUMGQw1OVug9rkb
         /Sgq02Uy9yWT8NOLQj1XfJRN6GI0HmmXoNNQ0kWViH6F8KfUOwuwcHbbWMxQ+k4InP
         u1pD+/esz0NFU8tZ10GAn/nsAuox4iarsQSAvtwrBYB6TK3aJKKCz86GP+crsOr3Gb
         9LnFBufBY3Czw==
Date:   Thu, 26 Jan 2023 16:13:43 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-bluetooth@vger.kernel.org
Cc:     francesco@dolcini.it
Subject: Re: Bluetooth: hci_mrvl: Add serdev support for 88W8997
Message-ID: <Y9KYpw+V1e7wLiT/@francesco-nb.int.toradex.com>
References: <20230126074356.431306-2-francesco@dolcini.it>
 <63d23c50.170a0220.124e7.0ce5@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d23c50.170a0220.124e7.0ce5@mx.google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jan 26, 2023 at 12:39:44AM -0800, bluez.test.bot@gmail.com wrote:
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=715765
[snip]
> Test: SubjectPrefix - FAIL
> Desc: Check subject contains "Bluetooth" prefix
> Output:
> "Bluetooth: " prefix is not specified in the subject
> "Bluetooth: " prefix is not specified in the subject
> "Bluetooth: " prefix is not specified in the subject

These warning are bogus, the reason is that the series include a couple
dts/binding changes that have a different rule on the commit message
prefix.

> ##############################
> Test: CheckSparse - WARNING
> Desc: Run sparse tool with linux kernel
> Output:
> drivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16 degrades to integer
This sparse warning was not introduced by this series.

Francesco


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5269C38142
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 09:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjA0Ja4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 04:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjA0Jay (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 04:30:54 -0500
Received: from smtp-out-04.comm2000.it (smtp-out-04.comm2000.it [212.97.32.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0E7BE40
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 01:30:31 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-04.comm2000.it (Postfix) with ESMTPSA id E5C26BC66B6;
        Fri, 27 Jan 2023 10:30:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1674811828;
        bh=LecWo0t3gNR6fmC3JLS/id77wMIEJD+4ricxkYB0teY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Xyxivf4m672GFIBh/3lS3hT20SgCObBrlrPJm2iBrgoO3+dsYDhaL52n2t9Ec47Pp
         0+B0YhV+IyQ3sJEQyy5LywX+v45jj2RX5S8C5T687/lydQMO5/XBSBcw647bZ7NSEJ
         z/t5dAs2Ipvs6oYZPv0F4mZon6UaVbc2uGUzhsVSprUnsIMuwOBJh8QQ3tzFCLU4Zz
         CgeQ8gQAJgfRKbsdD+N/WITa59S9qVSPmlqjp197DO8LKEB+T/U6J5FWOpqnTqfJct
         1HmklVI4n1A8GtHNaOsIbHkyBqdkC2u93zAYNEEXq554KWGmyp449HkVCIjka7gIwE
         EuZhScDTKeUlA==
Date:   Fri, 27 Jan 2023 10:30:23 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: hci_mrvl: Add serdev support for 88W8997
Message-ID: <Y9OZrx2fpjjLYLxx@francesco-nb.int.toradex.com>
References: <20230126074356.431306-2-francesco@dolcini.it>
 <63d23c50.170a0220.124e7.0ce5@mx.google.com>
 <Y9KYpw+V1e7wLiT/@francesco-nb.int.toradex.com>
 <CABBYNZKsD1FAXz1y+8=ogWLmrN0OhctcoRJJXEz=dorv8H8nfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZKsD1FAXz1y+8=ogWLmrN0OhctcoRJJXEz=dorv8H8nfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

On Thu, Jan 26, 2023 at 12:59:36PM -0800, Luiz Augusto von Dentz wrote:
> On Thu, Jan 26, 2023 at 7:15 AM Francesco Dolcini <francesco@dolcini.it> wrote:
> > On Thu, Jan 26, 2023 at 12:39:44AM -0800, bluez.test.bot@gmail.com wrote:
> > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=715765
> > [snip]
> > > Test: SubjectPrefix - FAIL
> > > Desc: Check subject contains "Bluetooth" prefix
> > > Output:
> > > "Bluetooth: " prefix is not specified in the subject
> > > "Bluetooth: " prefix is not specified in the subject
> > > "Bluetooth: " prefix is not specified in the subject
> >
> > These warning are bogus, the reason is that the series include a couple
> > dts/binding changes that have a different rule on the commit message
> > prefix.
> 
> Or CI only expects patches to Bluetooth subsystem or drivers, so
> perhaps the dt-bindings changes shouldn't actually be send here if
> there are not meant to be applied to bluetooth-next? Or we need some
From what I saw bindings changes
(Documentation/devicetree/bindings/net/) on bluetooth goes through you
once they are acked by the DT maintainer.

Last patch ([PATCH v2 5/5] arm64: dts: imx8mp-verdin: add 88W8997 serdev to uart4)
needs to go through Shawn and the SOC/i.MX tree, but it makes sense to
have it part of this whole series (at least to me). No reason to apply
it until the rest of the series is deemed fine.

Anyway, all good from my point of view, I replied to the CI email just
to let people know that I checked at the CI results and I believe is
all good on the series on this regard, not planning any change because
of it and that IMO it should not be a reason to hold on any review.
Just speak-up if I'm wrong here :-)

Thanks,
Francesco


Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 20:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85392075B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 20:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591303428;
	bh=v7d0ty4zgWvBTr+3hwbL3wZMvdeMKI1Lx6Mt6skwufE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=s2RWc5nGjya1KtFkitz7YA6pbie+HVLria1tsdps2QblGGtx1ylD515/U+nZu2/ih
	 I2faTc8rhDilItDX80FEQtxAveEaLtDgUeUCbt0xbSmGz0BcC1ktjQ3dBqFEJIPrC7
	 nKPaAITNidi3PAj5DwB3rTFCgL02ZWu4WsBINNFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgFDUns (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbgFDUnr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 16:43:47 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 649CD206E6;
        Thu,  4 Jun 2020 20:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591303426;
        bh=v7d0ty4zgWvBTr+3hwbL3wZMvdeMKI1Lx6Mt6skwufE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=k1jmYxvvTYfv8jmdayh4Ysmz9PpN8sXxR68CK+xzhiay3x+fkJhum4YPIphkG0ksq
         tfPZtQiT2uy6x0ajUsl2DDXa7qTHoTbY7wmqVfy2eTmqPBQh1MreXLmwtfkQ31JOEG
         Q6qP2/A9s4AqjzubBUFxt9lXP3TFpRIW1ZHygbMg=
Received: by pali.im (Postfix)
        id 191E9F88; Thu,  4 Jun 2020 22:43:44 +0200 (CEST)
Date:   Thu, 4 Jun 2020 22:43:43 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ujjwal Sharma <ryzokuken@igalia.com>,
        Andrew Fuller <mactalla.obair@gmail.com>,
        Aleksandar Kostadinov <akostadi@redhat.com>,
        David Heidelberg <david@ixit.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, usharma@chromium.org
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
Message-ID: <20200604204343.eor47oe3fbzf6rbv@pali>
References: <20200419234937.4zozkqgpt557m3o6@pali>
 <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
 <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
 <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
 <20200516075340.3z37ejs3fuhctunl@pali>
 <CABBYNZLWsYHeOo3_+hcq4r+gY_0sLBQhftW7My7Y4D1n9o5jxg@mail.gmail.com>
 <20200518165011.jfarrp5mtqoy3mqz@pali>
 <6da08b42-34d5-9d20-bfc1-161cc8d0f2ea@igalia.com>
 <CABBYNZ+myxfFmobLuzGeYfP_G5tM_ptKgCQCmpQCiUkPZYemuQ@mail.gmail.com>
 <aff611bb-4b38-7614-ce61-fc3e7c012615@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aff611bb-4b38-7614-ce61-fc3e7c012615@igalia.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 27 May 2020 21:54:18 Ujjwal Sharma wrote:
> Hi Luiz!
> 
> Thanks for your response.
> 
> On 5/27/20 9:18 PM, Luiz Augusto von Dentz wrote:
> > Hi Ujjwal,
> > ...
> > Testing is one thing but for production we would need a qualifyable
> > solution, that said I wouldn't oppose to have the socket option behind
> > a module options (runtime) or Kconfig (build-time) so people willing
> > to run this code can do on their own.
> 
> 1. What do you think is lacking in this solution that would make it
> qualifyable for production? I believe there are multiple people in this
> thread including Pali who are willing to put in the extra effort.
> 
> 2. I'd be happy with a runtime option which would allow me to test this
> as well.

Have I missed something? setsockopt() solution which I described in
<20200419234937.4zozkqgpt557m3o6@pali> email is already runtime option.

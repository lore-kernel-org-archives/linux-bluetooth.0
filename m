Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4C3C169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 16:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468122080D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 16:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monadnock.ca header.i=@monadnock.ca header.b="bUaUPu9T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImmGOaIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfBFQBC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:01:02 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57487 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727062AbfBFQBB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 11:01:01 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9939721F60
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Feb 2019 11:01:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 06 Feb 2019 11:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monadnock.ca; h=
        references:from:to:subject:in-reply-to:date:message-id
        :mime-version:content-type; s=fm3; bh=kyQZn+mmuwm///3dAIo2Eq9gqj
        NQIex00vdYzt+nw6s=; b=bUaUPu9TV6OrfwFivpnt1REJl1kqiZQt+vz+APDG8e
        uey/z/HbTmLDlLEiBiGh659Isl8nCPWRawKvOvme0wrkVOPVbphNcCRVbvH8QsW1
        teV3FA9p7C8W32cxQKgnH8UPRWjfrrwy9YKlkvOjxLplL7jq58eP5pbuH8DJbjf9
        xQDIdEi+dH+4vEmvOJ3hztubbR8ySRnoDb/s4Z4HAgo/yhyThOo6bdU7dECCi8DI
        FH7gTQhBI9cKUIhDmE9+oTI0rSdvhVOZNaNsKLpcx81HbcUlreI0o5HKaXCkV+Tq
        E/PxqKt2gTM+B/5YUOITeVhP9P8wFEk/pIoMGXh1uvbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kyQZn+
        mmuwm///3dAIo2Eq9gqjNQIex00vdYzt+nw6s=; b=ImmGOaIctV6FObODm/zYzG
        ocZYRPTAR6/nq7ch9DRDpffuICT0IOH91qKEGuj/4l55mHmNAiRkCp4DU9o1dNq0
        sqTcHQMYVEOZx+IAQ9w6o3pQ4NTFnHQIN/pezYCqnKBXWlNkSetOGoJcwgSTu2NE
        UWWTLlljIxOsIQZf9DeCMgbrHVbqYrbIXTt8xDT/znVzIeiZ/gIyACVYs13lpWcn
        DqaXwhLVo22Bb8jrd++KwryL140EUyhDVZaKBR5iMxS18Fk6XPK2G6xu22aridUF
        hgVcGdTT2iAmI2pUgOsf3LlwAMoBMvsTUiddYwdwCMF+TNrinjSALlG+Ilzj/MDw
        ==
X-ME-Sender: <xms:vARbXPWpo4R_eDatUsoNr5kFSK6yc7n25I5JtUC0UdQ2bZnxINHrpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeekgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucenucfjughrpehffgfhvffujgffkfggtgesthdtredttdertdenucfhrhhomhepuf
    hhrgifnhcupfhotghkuceoshhhrgifnhesmhhonhgrughnohgtkhdrtggrqeenucfkphep
    vdegrdehgedrkeeirdduheenucfrrghrrghmpehmrghilhhfrhhomhepshhhrgifnhesmh
    honhgrughnohgtkhdrtggrnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:vARbXM_YT0MU9PKPszhouz3zZQBUusnlxv_FOSK4N-2Gf3QxcbeOhQ>
    <xmx:vARbXH1MwZlqqGqetja_N2HJNlH667YlI50n4CxGACJETL_nhh7S4g>
    <xmx:vARbXPdwgi9hVcGexLkFqJFQxJ6RI3y1EkcmYMQ4hYQ9dIDa5I7tgw>
    <xmx:vARbXGZ35qDeUN_h4y3JZqQN3xNZz2fhz_hfeA3wB8nPv9DnSKsCiA>
Received: from mobile.monadnock.ca (ip-24-54-86-15.user.start.ca [24.54.86.15])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A21F10310
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Feb 2019 11:00:59 -0500 (EST)
References: <20190206153045.14788-1-shawn@monadnock.ca> <5B669D65-754A-4DA6-8ECD-2BD0797551A8@holtmann.org>
User-agent: mu4e 1.0; emacs 26.1
From:   Shawn Nock <shawn@monadnock.ca>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] shared/io-libevent2: Add support for libevent2 based IO handing
In-reply-to: <5B669D65-754A-4DA6-8ECD-2BD0797551A8@holtmann.org>
Date:   Wed, 06 Feb 2019 11:00:58 -0500
Message-ID: <87h8dgucsl.fsf@mobile.monadnock.ca>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Marcel Holtmann writes:

> why?

I'm converting a sizable libevent codebase from HCI to the management
API. This makes integration with the existing event loop seemless
(almost, see io_set_context).

It may be useful for anyone wanting to use the managment api in
combination with libevent.

S


--
Shawn Nock
Engineer, Monadnock Systems Ltd.

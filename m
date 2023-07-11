Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26634EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 01:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGKBVK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 21:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGKBVJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 21:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D4BE73
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 18:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55F5C61142
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 01:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB3EFC433C8
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 01:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689038329;
        bh=f3sPdvx04+OKRVgd3Lpj2RCNjOoq5iaCHnGE8ZQHW3c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Bq+r7srhIz34d8t+dRs3w36XD3vy5sDuAxYybgNgHyAqmG/p3vt35wrBWHa6X8z11
         VZGIUaIuc8OxX3SO0jOlWbg1ISoSkX1q/KcFKMQNzISQ0G90RNXChjSzftQ66HjPup
         GOl9kAoyBJl5A6UFSQbRgZruROgdGp81kiu+ngiVk66OXyXR6bazxiGXePfTZeqs/e
         q/PE+GWQGV06DhwONFL7tqeDOpuKEvYRswmKIo94IKHNH9dUvXNKFaZYYjE00fjDd7
         PwL1FTAN37oF8ZuaOj7y02gicgVBzvIrKXy8EsIOagOwsTLIEHTY7kF7wH0Da/sUII
         i7DFtl8XOhwPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9D14CC53BD0; Tue, 11 Jul 2023 01:18:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Tue, 11 Jul 2023 01:18:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217651-62941-aCRfECH0jq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

--- Comment #11 from Bagas Sanjaya (bagasdotme@gmail.com) ---
On 7/11/23 01:50, John Holland wrote:
> Since I recently retired, I have some time to put into this. I have built
> 6.3.12 and 6.4.0-rc1 from kernel.org sources and tested, the 6.3.12 works=
 and
> the 6.4.0-rc1 does not (in terms of the bluetooth issue). Looking at the =
git
> log of 6.4.0 there was a lot of bluetooth related activity. I've chosen a
> commit from before that and am trying to build that and test it. If it bo=
ots
> and the bluetooth works, I guess 6.4.0-rc1 and that starting point could =
be
> initial points to use in bisecting? This is somewhat new territory for me=
 but
> so far it's been pretty straightforward.=C2=A0 The kernel builds take a l=
ong time
> on this macbook pro from 2014.

tl;dr:

> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>=20
> A: No.
> Q: Should I include quotations after my reply?
>=20
> http://daringfireball.net/2007/07/on_top

Please see Documentation/admin-guide/quickly-build-trimmed-linux.rst
for how to quickly compile your own kernel.

Bye!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

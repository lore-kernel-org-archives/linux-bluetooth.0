Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0026C38A02
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 12:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJaM42 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 08:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaM41 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 08:56:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D46DFD3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 05:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EE0FB81617
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 12:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF55FC433B5
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667220984;
        bh=/X8MFlbRQgANfUcSuuYwS0d/9Mc5hoofT6bSLNF7v0A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nXwXn3eh8hgDrjXqJSvhHldBmBXaLv74QU+yRacdBN9j8jtXDTFEuxkzaIEdXZlXO
         n1xSoHR0O4H8muhdga41dGU/IrH0+dQe2Uj50lp4qsiE28c4cA+Heo+nkzhJnf/3wI
         j7E9rHILu/H48wysvWQZsfE8mibuBNclYJCTJYIDIJtigeIK310EyGj051M7vNoJuC
         zTEKdgCP9VzvvzX9i97Mz74aYPokPjTDg8B/KTAkK83IB3lCpYYQ2etCJ9RzkPMAXV
         5TZuIwt5lyvuIwg7tfhUW1WDsP2jnxYfXBfb+7kPoQY0W5Uf2sI0A5Z/z85cqSccNm
         CXl0LjEUQEmYQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DE24EC433E9; Mon, 31 Oct 2022 12:56:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 31 Oct 2022 12:56:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-5EUk23KazR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #252 from Swyter (swyterzone@gmail.com) ---
Here are full `btmon` dumps for three different fake CSR dongles, you can s=
ee
where the controller goes bananas at the end and stops responding:
https://gist.github.com/Swyter/34b93e3abda433a742e024e3a6ec8e69

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

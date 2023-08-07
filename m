Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71CDEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 05:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjHGFl1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 01:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjHGFlZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 01:41:25 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC910F0
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 22:41:21 -0700 (PDT)
Date:   Mon, 07 Aug 2023 05:41:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1691386879; x=1691646079;
        bh=VN9JcRm/SkqObHEFU9NTmzwJJ59i48Jm0xKgNaP2MWU=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=gY7arDM7VT9FXAWuGlMAvreikO2iTuqxzsGSsInT/zHvhMWSTXjMWejkKRVnjNV8X
         i5qklnvMc9XGeurL/ij/pbmTuOY+Oeva89L6rkcv6R52XpkuBq6QFsqpeixjmLYc/3
         4YuyD1wRIW6wbGNKPO/+n1jAOT4yYQs2++qcAFDcEPLvOsckuZd6CIAs8mviOs3Wfx
         akWLW4pKPCDczBetccFwj0ls8twZkwkkFpS0KDskcbgio0QqlumNGv2qWnslY8MGOf
         2Tsiri7PsunMekfbqOxOdtkVTBBN5i6otxilL8kRdNcVDYRam69xvDyJXhNW2XQGLc
         l94UMWjwNhU8w==
To:     linux-bluetooth@vger.kernel.org
From:   Karl Bieber <karl.bieber@proton.me>
Cc:     Karl Bieber <karl.bieber@proton.me>
Subject: [PATCH BlueZ 0/1] main: Fix missing comma
Message-ID: <20230807054108.234233-1-karl.bieber@proton.me>
Feedback-ID: 51085399:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I think this is a missing comma which could lead to bugs.

Karl Bieber (1):
  main: Fix missing comma

 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.41.0



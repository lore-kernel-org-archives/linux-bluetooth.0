Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA5C34047
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 12:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD86E20658
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 12:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgBSMPW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:15:22 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:35384 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgBSMPW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 07:15:22 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Feb 2020 07:15:21 EST
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 675232014A;
        Wed, 19 Feb 2020 13:10:01 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        luiz.dentz@gmail.com, pali.rohar@gmail.com, pavel@ucw.cz
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Date:   Wed, 19 Feb 2020 13:09:40 +0100
Message-Id: <20200219120940.1509224-1-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
References: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Marcel,

first thank you for reviewing Pali's work.

As I understood you'd like more minimal interface, but since Pali has been
working on bluetooth stack for really long and there is no better option,
would you be willing accept this code?

I know it may sounds like compromise, but no-one came with better solution
in given time.

In my opinion upstream can benefit from already (well) designed
and tested solution, than waiting for messaiah with possibly perfect solution
which doesn't exist yet (may never shows up).

Best regards
David Heidelberg

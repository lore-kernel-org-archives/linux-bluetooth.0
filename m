Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F09BC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 21:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjDYVOp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 17:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjDYVOo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 17:14:44 -0400
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B84121
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 14:14:41 -0700 (PDT)
Received: from github.com (hubbernetes-node-6e6be63.ac4-iad.github.net [10.52.144.33])
        by smtp.github.com (Postfix) with ESMTPA id 5ED9560059D
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1682457281;
        bh=KnRLaIza441fg+wI+82Ym0aoB8CT1XYIT+KlZ0BZT10=;
        h=Date:From:To:Subject:From;
        b=a6Ifh4gpNDS/nZucmceIMXbl68P8get3V0aD+XQelKbIBoIun7E5lS/BbCUdoMg50
         nBXvaQwT2mP5rByo/2sUzimzyDaLTqCufpkDop9gEFXPwlxkZiCefGKbPNU/M+vomF
         kQAY1ylfL/+f+LhbFt2oZ7BhbvM82GAA36xbF/8Y=
Date:   Tue, 25 Apr 2023 14:14:41 -0700
From:   Pauli Virtanen <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9a0acc-2f88c5@github.com>
Subject: [bluez/bluez] 5910b7: shared/bap: add function to get location from
 PAC
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5910b78528010b654a82367bb2e95f70dd7877ce
      https://github.com/bluez/bluez/commit/5910b78528010b654a82367bb2e95f70dd7877ce
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-04-25 (Tue, 25 Apr 2023)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: add function to get location from PAC

Add function to get the PACS Sink/Source Audio Locations field relevant
for a given PAC.


  Commit: 2f88c59391b8717055557f6634f92d76d9fd0001
      https://github.com/bluez/bluez/commit/2f88c59391b8717055557f6634f92d76d9fd0001
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-04-25 (Tue, 25 Apr 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  bap: add Location parameter to SelectProperties

Add relevant PACS Location field as a parameter to SelectProperties.

SelectProperties may set Audio_Channel_Allocation, which shall be chosen
from the bits set in Sink/Source Audio Locations (BAP v1.0.1 Sec. 4.4.1,
Sec 4.4.2). Hence, audio server needs to know the supported values,
which it previously could not.


Compare: https://github.com/bluez/bluez/compare/9a0acc7984ef...2f88c59391b8

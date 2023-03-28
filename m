Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109F9C76196
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 21:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC1VPC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjC1VO7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 17:14:59 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083A1BCE
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 14:14:50 -0700 (PDT)
Received: from github.com (hubbernetes-node-4a94bc4.ac4-iad.github.net [10.52.14.50])
        by smtp.github.com (Postfix) with ESMTPA id 90F065205B8
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1680038089;
        bh=lmg8LE1ojOawdZv+tmUWTJoE4DgocHsDkFXQNiWUmBY=;
        h=Date:From:To:Subject:From;
        b=B7rSLyuhf5dMnywOOJBLba8VJcKsj8lv8ISZOp62JrY6niZtBJGKkDJ7Bl0G3wWA3
         pB+ujtY+JN3r1/mGf5FbFZrJ0JCGJIyQk8/B7CKWYKFT4+Oj1mgELFEWcaEvLE0RK2
         QY9tuy+kH5eMn8SiWhGpnfpS5fgfRLGRpdUCP1+M=
Date:   Tue, 28 Mar 2023 14:14:49 -0700
From:   =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/011e56-54601c@github.com>
Subject: [bluez/bluez] cedace: l2test: Enable hex input for PSM
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
  Commit: cedace72c3f71d356fc1895787569c7412ee94b2
      https://github.com/bluez/bluez/commit/cedace72c3f71d356fc1895787569c7412ee94b2
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-03-28 (Tue, 28 Mar 2023)

  Changed paths:
    M tools/l2test.c

  Log Message:
  -----------
  l2test: Enable hex input for PSM


  Commit: 54601cbcf283468ecb867d3db14ddbd1badbe858
      https://github.com/bluez/bluez/commit/54601cbcf283468ecb867d3db14ddbd1badbe858
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-03-28 (Tue, 28 Mar 2023)

  Changed paths:
    M lib/l2cap.h
    M tools/l2test.c

  Log Message:
  -----------
  l2test: Fix setting mode for BR/EDR l2cap socket

BT_MODE_* enums are used only for socket SOL_BLUETOOTH, option BT_MODE
Otherwise we should use L2CAP_MODE_* enums.


Compare: https://github.com/bluez/bluez/compare/011e562a98a8...54601cbcf283

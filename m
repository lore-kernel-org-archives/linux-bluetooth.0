Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E1C3DA6F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 17:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbjHXRJv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 13:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbjHXRJq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 13:09:46 -0400
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18AF19A3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 10:09:44 -0700 (PDT)
Received: from github.com (hubbernetes-node-1ca4720.va3-iad.github.net [10.48.221.45])
        by smtp.github.com (Postfix) with ESMTPA id 225749406A8
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1692896984;
        bh=dZLh10MFPPfP1nnP+e3hLh2FTBvmbmQls4L15xgwlhw=;
        h=Date:From:To:Subject:From;
        b=O3SkBgoQs8Zovz6Po9E9bxJ/cNhE1g2JsjD7CN5g4oCatqLZFZz2eMoSeNz7zJKij
         VLd9z01Zsj0p175+HWYdBxj/3mSpSOzTCWkBkixmNpcRSza4ipn9ml2Qz4BQZ4Efze
         MZZhcXLbnIwjGlZtlocfB+KNy2zVYL5MwRAyQc+k=
Date:   Thu, 24 Aug 2023 10:09:44 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.69/000000-bbe411@github.com>
Subject: [bluez/bluez]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/tags/5.69
  Home:   https://github.com/bluez/bluez

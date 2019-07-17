Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D534C7618F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 19:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4712173E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 19:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="NbRN3keU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfGQTxg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:53:36 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:39950 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQTxg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 15:53:36 -0400
Received: by mail-lf1-f47.google.com with SMTP id b17so17419709lff.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aBrxeytKOurZQ+nCGd8l34FcDLimTqnxqGL9K+vrwnQ=;
        b=NbRN3keUi93ecBfT0n444K69uHp+cz7V0/qwgdB3FcNIOBFiRNjA0DtAu5OOhj4kxB
         +b85YaR/2BlDgXtdi0jl/OSOQcjH9fqYjmhG2KRkmsUNgYq5Mzz5ALkxVENsjsB6tBgW
         SneXQgHnVgJIlJuH5bis6Ty1J/Fu2TabOtiAzps0vUlE+6hqJZx0vMywichk7diGk0zR
         dF/ZjFPbFw0f1tbBfuZ8S7UTLsW757HfV7p7f/5TA6MdQ5alEh9OYQtfN5nzt+rJ+gu8
         5DI2UzSi9UgCbq+9lmHX/LnbF/DSRDPQVhNGPHSutROJwgRwuuJeW+DzboP5nr8VDVT3
         cKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aBrxeytKOurZQ+nCGd8l34FcDLimTqnxqGL9K+vrwnQ=;
        b=Je/EYVsW6HkhOC7kWCvxLqZPLskwsdPO/Q3KAGjU6E6q7YA1a+SPkzbH/FbfGOha49
         Zr095HCRuGx27lira7VXUOZAsY+nagxwe8SMH0mzTkAAvre0EJOUzL/2wAW6fu3tZ1Mm
         O1lJ1G/a1S/9+dNKDHOWsOYDQoUVgYe0gTFoWY22Ms/noaPMuBe6ZMUUteHH0zAEWtOT
         2PD6uWCACVl/yStGpJUUuKvhoQMisrwMEhM7Tg26/ERsAjVjz/JBMl4O3A1eom33W5yk
         g2zb4DkOqHq8ND6UHy+oaNxjVJNNEBFKTxKpBXDXpURytbJeqS05isBTPU8Qr19LD8bc
         7EJw==
X-Gm-Message-State: APjAAAW2gOTudl3OO4rnMbs1kObdeVc1RuSYt4S4NM/+OhP/FxNr9/g4
        RED+4qv333OqBNpl4LJz5FEa7s3lzGk=
X-Google-Smtp-Source: APXvYqxLTgtk9Paue8tGnDYlclfhR8paSAkbbOA0QAQhhmqWFo74sug+W1krgawuVv/9V6Ee9sVR3w==
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr18450054lff.95.1563393214329;
        Wed, 17 Jul 2019 12:53:34 -0700 (PDT)
Received: from kynes.internet.domowy (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id 2sm4643181lji.94.2019.07.17.12.53.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 12:53:33 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 0/2] Use composition data to validate app against the node
Date:   Wed, 17 Jul 2019 21:53:26 +0200
Message-Id: <20190717195328.16322-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset streamlines app validation by creating a temporary node
during Join, CreateNetwork and ImportLocalNode calls and then
comparing temporary composition data with one generated for already
existing node.

In case of Attach call, the temporary node is simply added to the list.

TODO: Composition data generation needs to validate node structure,
checking that:
 - primary element exists
 - mandatory models are where they should be
 - there are no gaps in element indexes
 - ... possibly a few more things

Michał Lowas-Rzechonek (2):
  mesh: Keep model list sorted and unique
  mesh: Validate application by comparing composition data

 mesh/cfgmod-server.c |  14 +-
 mesh/mesh-defs.h     |   2 +
 mesh/node.c          | 453 ++++++++++++++++++-------------------------
 3 files changed, 198 insertions(+), 271 deletions(-)

-- 
2.22.0


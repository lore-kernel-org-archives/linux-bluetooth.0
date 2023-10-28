Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E67C27C47
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Oct 2023 11:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJ1LyJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Oct 2023 07:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1LyJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Oct 2023 07:54:09 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5934E1
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Oct 2023 04:54:05 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-582a82e6d10so405981eaf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Oct 2023 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1698494044; x=1699098844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5uchiWxMjh6aGd+eR7A/2NmXcZyz/rZ5MrLW9O2AB8=;
        b=W7+7IUa7piU+wnlwk6IE3cUaCUtWuf/NvAe8DiiDOrdaNViJnnEUOTWSYCSJkpO5F+
         Ki5b+5P3NWYK3j42JGkbRdTXXsZrf7kE3kyrLP9KTaUGUEQQuWHwb+npKpe+oTcN4X5U
         qUdteNkZzVDASKaVzgyliGe35VwD9pCU2w0KBInzC2Q6ToyxZfokijERyk2wu4oeVSB5
         5Zr/syjT6nfu3VcYf3JOmqGqY9KfL2Wu68nWjNaH43szpEUZW3+R8BZIjnzT0K/6VTwo
         ZksjxOWeoKLhHYxTxSOwOfQWfj1kh5JBsIveIdNl740ByEj6L6Y9egnPibGrHCFehuW3
         RuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698494044; x=1699098844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5uchiWxMjh6aGd+eR7A/2NmXcZyz/rZ5MrLW9O2AB8=;
        b=S+7XpNd+AOSjPDc8Pj/RgZQ4Li2VYeGUpY1lVP+qSBZfDJrHJLTy5vweGeZXxtcvqH
         IVLJ8/H7CKt7GnfmyAzgMcIavRFb+T0dxZtWqZ3rf4gW/YoC+ylxLpx0DmSxuBrEpZTr
         GSAI0rhQma0JloaptKRoAPpM+0UnYB1JrmIKMtzFD3BbRL5cOxJU+OHno5y7jZ2dNcrC
         bTm5u+Ka/9FsTJj/gl6AMvYkzvGIMYKhbyozfu8Qvb9StmV8j6d5Q88tWsqVgn/Ai4QK
         15FOJhNBqiv1g+I7RXnSqtG7RRg/ph/kvllrITz7bCv5LofmEB5GPoGCPIp3GWh/N5jN
         6PvA==
X-Gm-Message-State: AOJu0Yy5qG4j+i0usPWE/uKsoEEGAXvcx14gVmFdAkhBevM6qjG651q1
        2MZ7kAGV+n0opdmDpjOghh0p7oK2cdB1GimwB6q+aUKYytXw/f3bvuR80aQMItGpG0lfMWcWC8k
        B8dV0s01Bewd40ayPfQSZ9y1YEHbWaTChgJozihR6FDhadTJm/MeznJnQJLWdEMn7++sRWdKQPz
        Ls
X-Google-Smtp-Source: AGHT+IFxHg/5XLjws72VkQh9pfjqNZR23gjcQbknUYNeTlePjYR8r5QbjSOVUnljeXUYjbcxMec2/A==
X-Received: by 2002:a05:6358:3493:b0:169:4b1f:a82d with SMTP id w19-20020a056358349300b001694b1fa82dmr6307004rwd.3.1698494044156;
        Sat, 28 Oct 2023 04:54:04 -0700 (PDT)
Received: from debian.localdomain (c-73-177-243-39.hsd1.va.comcast.net. [73.177.243.39])
        by smtp.gmail.com with ESMTPSA id bj38-20020a05620a192600b00770f2a690a8sm1484553qkb.53.2023.10.28.04.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 04:54:03 -0700 (PDT)
From:   Paul Otto <potto@vt.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Paul Otto <potto@vt.edu>
Subject: [PATCH BlueZ 0/1] Update bluetoothctl documentation
Date:   Sat, 28 Oct 2023 07:53:41 -0400
Message-Id: <20231028115342.62489-1-potto@vt.edu>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Updated bluetoothctl to add important details about feature usage.

Paul Otto (1):
  Updated bluetoothctl documentation.

 client/bluetoothctl-admin.rst     |  98 ++++++++
 client/bluetoothctl-advertise.rst | 243 ++++++++++++++++++++
 client/bluetoothctl-endpoint.rst  | 121 ++++++++++
 client/bluetoothctl-gatt.rst      | 212 +++++++++++++++++
 client/bluetoothctl-player.rst    | 200 ++++++++++++++++
 client/bluetoothctl-scan.rst      | 146 ++++++++++++
 client/bluetoothctl-transport.rst | 128 +++++++++++
 client/bluetoothctl.rst           | 366 ++++++++++++++++++++++++++++++
 8 files changed, 1514 insertions(+)
 create mode 100644 client/bluetoothctl-admin.rst
 create mode 100644 client/bluetoothctl-advertise.rst
 create mode 100644 client/bluetoothctl-endpoint.rst
 create mode 100644 client/bluetoothctl-gatt.rst
 create mode 100644 client/bluetoothctl-player.rst
 create mode 100644 client/bluetoothctl-scan.rst
 create mode 100644 client/bluetoothctl-transport.rst
 create mode 100644 client/bluetoothctl.rst

-- 
2.30.2


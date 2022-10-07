Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405FFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 17:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJGR1N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJGR1M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 13:27:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E161E3B711
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665163631; x=1696699631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IXy2rqf+uTE1KXWp0Cwx7ozdB1m1zV+d8nPQNIbZBzg=;
  b=Dtpvo/OkqmgpsdjzjL2nQSkCGPG9GnVludPIxEVJ8daccHTviwX2PEu1
   pW6TQROsKI4bpWu6DaBA3ysu3XGeST9MKSlzR2WP0awUfZjnGCtZAy/6T
   2z0Z1LjYjhCaASk0e0Wi1jixXZJyVu/0t22bLeQc41nXMlPKSq0Jymhjs
   zt9r0YKELBFp+B9uZRxhIxHKzE9l9MHRjFQcR1uhDnpBAuTgFqzwqKBJf
   PTDTyaCORWzDzcD4i8JgkYKZkYaKqMWMCmPts6L51DmYQmALiw+g7D9EV
   Tzbtr09MuRHhrHUuq/r0xYwcSUByO1iTf748g/w9U9IF6QQ/OP+cC7sW8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="301388880"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="301388880"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 10:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="658410228"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="658410228"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.120])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2022 10:27:09 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ v2 0/1] Bug Fix for Memory overwrite
Date:   Fri,  7 Oct 2022 23:15:15 +0530
Message-Id: <20221007174516.22335-1-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix to avoid memory overwrite during ASE stream enable operation.

Abhay Maheta (1):
  shared/bap: Fixing memory overwrite during ASE Enable Operation

 src/shared/bap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1


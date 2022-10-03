Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB4AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 23:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJCXG6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 19:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJCXG5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 19:06:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF1322BDB
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 16:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664838415; x=1696374415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=31GESXC9UmXessR+lmiKAdakzgJC3ijJ+JD3a2fvA5U=;
  b=LFxZ2oITH/VGaNX7Hxs7F1rRtiVK92PN+YxfDXexfFj1QkwDfrCPS9oc
   LHE7wjRHVzrEYhGx89AfoLO+7oTS8tIGbKsLm1En/yPVLuRNtW0cgfMSd
   dr957M55Kz1dkqFCaGBF0DxSc6a9sbzHucoYUo+KwdbF4U88iEH+wCbaM
   tD1K2gu/Aqe4WLTe3XwIrvT/NJBtHfgEqVwFEUHI1kacAOpQ0NKdBNSvv
   KuK9owPD5yhK0JjUC3OLkvN1mXU3LasaRbFc0n+h8NlPP36ZFijMzzQVz
   esOW0BSRbAc4JdEUdhMvyybcWWD4O6zJbsLnCCnwtwyz/ZP3LkA95DWXK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="302759131"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="302759131"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 16:06:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="654557920"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="654557920"
Received: from sadhana1-mobl3.amr.corp.intel.com (HELO istotlan-mobl1.intel.com) ([10.212.232.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 16:06:52 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, brian.gix@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] build: Deprecate meshctl tool
Date:   Mon,  3 Oct 2022 16:06:42 -0700
Message-Id: <20221003230642.164327-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This marks meshctl tool as deprecated since it is not longer
maintained.
---
 Makefile.tools | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index a99d768dc..4bc355c34 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -348,6 +348,8 @@ man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1
 endif
 
 if MESH
+
+if DEPRECATED
 bin_PROGRAMS += tools/meshctl
 
 tools_meshctl_SOURCES = tools/meshctl.c \
@@ -372,6 +374,9 @@ tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
 
+EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
+endif
+
 bin_PROGRAMS +=  tools/mesh-cfgclient
 
 tools_mesh_cfgclient_SOURCES = tools/mesh-cfgclient.c \
@@ -395,8 +400,6 @@ tools_mesh_cfgtest_LDADD = lib/libbluetooth-internal.la src/libshared-ell.la \
 						$(ell_ldadd)
 endif
 
-EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
-
 if DEPRECATED
 bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
 			tools/rfcomm tools/sdptool tools/ciptool
-- 
2.37.3


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E013C830
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715239958; cv=none; b=utsqWpImqsmZEVDHvRaGgniZAlet1KyzG8nYIb7goxOjYShQiXpr318y7L/NkosfXDPKg/+vnrpPyCbGONrNCP8cOwaOEM4xGDi+tPvv/q66BpgC9mvEG5T+2lqX1INxapiBdtQHItR0+2+Z9HyqRmwWdM3t4VAjyKGsy+Kp240=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715239958; c=relaxed/simple;
	bh=c7NCC9QMsDwIMd2mr2vTyeQQ947gHy0DbErCBUdNe+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NBODLlchVbu/xPKhABPHmiZt05dfAcmxUaYTqXUCA+XHfmnjIE+Bf0VP65rLU2o3sejGyxx5CeCWi3UgYbWGwmNA8oJ7zrjZealHcMeglEVudnpR/BdjlrYZNVERi5zI/+0T302bodQM08mqSogpKb74s68k81AodFa4N8+RG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNJVsSeH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNJVsSeH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715239956; x=1746775956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c7NCC9QMsDwIMd2mr2vTyeQQ947gHy0DbErCBUdNe+E=;
  b=ZNJVsSeHs7L9Na7VAL/0v5N/Iw1YaAAH1sAGzFONLgYzm8BTjezUNA8N
   RY/DPcbZv9qft03xkESplORJix0WHxiNalT40a2a+Pti+R431NysbSeq0
   k6TMEgmHhnjBqsvZVYVo/5JM9aWKiBeoF/ajbgE0Kis2Uly2aBcqIIYf5
   FWDShPbHom9uMZgCuh/xFuY9fm+aSfmxAI4hdXmdPtPeAVULUJQcNPF1r
   AOgLhgKhUOJlYAthEt/+zL4OUVHeUoo2h/C6zArzIepYcF12NwQ0gs2ZK
   gJMSIiX+SDWpxUugEST6bfnuoDk9XqYm4eA1KGWAsnOs2aqQXZ5HMxD6R
   g==;
X-CSE-ConnectionGUID: AWT07e6wRSSDi0lMlThgAA==
X-CSE-MsgGUID: fhZ8S9WYSi+jmnB4K4m7Ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14952342"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="14952342"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 00:32:36 -0700
X-CSE-ConnectionGUID: P6/b3BtcStaOYA427NUzYA==
X-CSE-MsgGUID: FzsLw4/SRIK/KnlcyuTfrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="33691067"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by fmviesa003.fm.intel.com with ESMTP; 09 May 2024 00:32:33 -0700
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH BlueZ v3 1/2] doc/ccpTest: Add document support for CCP test interface
Date: Thu,  9 May 2024 15:58:54 +0300
Message-Id: <20240509125855.2585411-1-ajay.k.v@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

call control profile interface has been documented with
man page added.
---
 Makefile.am               |  3 +-
 doc/org.bluez.CcpTest.5   | 82 +++++++++++++++++++++++++++++++++++++++
 doc/org.bluez.CcpTest.rst | 50 ++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 doc/org.bluez.CcpTest.5
 create mode 100644 doc/org.bluez.CcpTest.rst

diff --git a/Makefile.am b/Makefile.am
index 05d02932f205..2c44fb52c78b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -377,7 +377,8 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.PhonebookAccess.5 \
 		doc/org.bluez.obex.MessageAccess.5 \
 		doc/org.bluez.obex.Message.5 \
-		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5
+		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
+		doc/org.bluez.CcpTest.5
 endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
diff --git a/doc/org.bluez.CcpTest.5 b/doc/org.bluez.CcpTest.5
new file mode 100644
index 000000000000..b16097d08270
--- /dev/null
+++ b/doc/org.bluez.CcpTest.5
@@ -0,0 +1,82 @@
+.\" Man page generated from reStructuredText.
+.
+.
+.nr rst2man-indent-level 0
+.
+.de1 rstReportMargin
+\\$1 \\n[an-margin]
+level \\n[rst2man-indent-level]
+level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
+-
+\\n[rst2man-indent0]
+\\n[rst2man-indent1]
+\\n[rst2man-indent2]
+..
+.de1 INDENT
+.\" .rstReportMargin pre:
+. RS \\$1
+. nr rst2man-indent\\n[rst2man-indent-level] \\n[an-margin]
+. nr rst2man-indent-level +1
+.\" .rstReportMargin post:
+..
+.de UNINDENT
+. RE
+.\" indent \\n[an-margin]
+.\" old: \\n[rst2man-indent\\n[rst2man-indent-level]]
+.nr rst2man-indent-level -1
+.\" new: \\n[rst2man-indent\\n[rst2man-indent-level]]
+.in \\n[rst2man-indent\\n[rst2man-indent-level]]u
+..
+.TH "ORG.BLUEZ.CCPTEST" 5 "May 2024" "BlueZ" "Linux System Administration"
+.SH NAME
+org.bluez.CCPTest \- BlueZ D-Bus CCPTest API documentation
+.SH INTERFACE
+.INDENT 0.0
+.TP
+.B Service
+org.bluez
+.TP
+.B Interface
+org.bluez.CCPTest1
+.TP
+.B Object path
+[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/CallerX
+.UNINDENT
+.SS Methods
+.SS void Answer()
+.INDENT 0.0
+.INDENT 3.5
+This method can be called to answer an incoming call in progress.
+.sp
+Possible errors:
+.INDENT 0.0
+.TP
+.B org.bluez.Error.Failed
+.TP
+.B org.bluez.Error.NotConnected
+.UNINDENT
+.UNINDENT
+.UNINDENT
+.SS void Reject()
+.INDENT 0.0
+.INDENT 3.5
+This Method can be called to reject a call, which can be an active call or a call on hold state.
+.sp
+Possible errors:
+.INDENT 0.0
+.TP
+.B org.bluez.Error.Failed
+.TP
+.B org.bluez.Error.NotConnected
+.UNINDENT
+.UNINDENT
+.UNINDENT
+.SS Properties
+.SS uint32 CallState [readonly]
+.INDENT 0.0
+.INDENT 3.5
+call index defined by CCP profile to denote the active call.
+.UNINDENT
+.UNINDENT
+.\" Generated by docutils manpage writer.
+.
diff --git a/doc/org.bluez.CcpTest.rst b/doc/org.bluez.CcpTest.rst
new file mode 100644
index 000000000000..79ead19ad538
--- /dev/null
+++ b/doc/org.bluez.CcpTest.rst
@@ -0,0 +1,50 @@
+=================
+org.bluez.CCPTest
+=================
+
+-------------------------------------
+BlueZ D-Bus CCPTest API documentation
+-------------------------------------
+
+:Version: BlueZ
+:Date: May 2024
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.CCPTest1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/CallerX
+
+Methods
+-------
+
+void Answer()
+``````````````
+
+	This method can be called to answer an incoming call in progress.
+
+	Possible errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.NotConnected:
+
+void Reject()
+`````````````````
+
+	This Method can be called to reject a call, which can be an active call or a call on hold state.
+
+	Possible errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.NotConnected:
+
+Properties
+----------
+
+uint32 CallState [readonly]
+```````````````````````````
+
+	call index defined by CCP profile to denote the active call.
-- 
2.34.1


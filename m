Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBFF2A1D6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277142; cv=none; b=sulRXTTm4i9VNbYd/LeOHgTMNnZqjTeYwnGRg5yfLJjGbSVNSVHqD7AVEdckEalPkClBUxXa8LkCnwkKZl2hCX48NjMinAYcmlS3mRFB44HzOMHDaHIiyNjnKVrKtr5dY0ofVNBuBTl2Xm8a/i5YEfAgMjUSM6e8an8z4BvkrQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277142; c=relaxed/simple;
	bh=t3Tng6u08nKzNs9twMZdWxw5GGXhSqq2NCV0+HNdfJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jcX8+DPWYlPZ7qPJYk4u1VgGxK+mdI11UMBbULw7ofyOiy2fL5xFto4wOUd6aLR+HXCxsswBma/nn1qhoCS8bdo/knG+g2CtbskydOE8b5JQGjknSPtnrGZW42M4DPSQBbGUcJnkbBmB0LUW8S0u16YR21fjg20EOvgz62RU3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHOUb8lv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHOUb8lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715277140; x=1746813140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t3Tng6u08nKzNs9twMZdWxw5GGXhSqq2NCV0+HNdfJ0=;
  b=mHOUb8lvnJ6aObz3aI9JLba0RYV0fTrNRk3raAXy/X+xAE3CnKy+cVKo
   zoepsSGcCKFexjs0LLqn28GsgIWKTVKSQLD2HjGIYmFapM5hFcNzCS+7o
   nqmuTqzigZXu/EK5wYjEH+HODgYPBtASzDGctyGrDCLs/V9TB2CaFx/eM
   vxY0FuJ/A/1v2rr+zPYfBhm/lQrJ+KZbRY77fdPzUpAPhrVpySj+QEDvX
   uX3O7zZA/qej4MiHdSND2bAg+p5zBGazOWIOHxAAIlWJ9gF452WypOo6L
   cOXBxLeWx+rrUyYFHdrCf6KpVwdt3XqA18/I015DyfU5r/paFLEHbQAPi
   A==;
X-CSE-ConnectionGUID: kI5xyJrPRaCxAmTklCre8A==
X-CSE-MsgGUID: xA1HGD2rTp2dy63RBJX/+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28727806"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="28727806"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 10:52:19 -0700
X-CSE-ConnectionGUID: VloiBZ2OTqq5Bu3nVUTHaw==
X-CSE-MsgGUID: V19fKaSgRK6hT2xSJHKmKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="29268242"
Received: from weba0535.iind.intel.com ([10.224.186.30])
  by fmviesa008.fm.intel.com with ESMTP; 09 May 2024 10:52:18 -0700
From: Ajay KV <ajay.k.v@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ajay KV <ajay.k.v@intel.com>
Subject: [PATCH v4 1/2] doc/ccpTest: Add document support for CCP test interface
Date: Fri, 10 May 2024 02:18:38 +0300
Message-Id: <20240509231839.3005270-1-ajay.k.v@intel.com>
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
 Makefile.am               |  6 ++-
 doc/org.bluez.CcpTest.5   | 82 +++++++++++++++++++++++++++++++++++++++
 doc/org.bluez.CcpTest.rst | 50 ++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 doc/org.bluez.CcpTest.5
 create mode 100644 doc/org.bluez.CcpTest.rst

diff --git a/Makefile.am b/Makefile.am
index 05d02932f205..07019f4e1628 100644
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
@@ -465,7 +466,8 @@ EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 		doc/org.bluez.BatteryProviderManager.rst \
 		doc/org.bluez.BatteryProvider.rst doc/org.bluez.Battery.rst \
 		doc/org.bluez.AdminPolicySet.rst \
-		doc/org.bluez.AdminPolicyStatus.rst
+		doc/org.bluez.AdminPolicyStatus.rst\
+		doc/org.bluez.CcpTest.rst
 
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
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


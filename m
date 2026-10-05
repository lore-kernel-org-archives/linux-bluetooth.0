Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com [74.125.226.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1C4C33D2
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213684; cv=none; b=uJ1GxLWkg4C4hVENLIWGceeMbGROoUjwod24PIzif0tJUR9JIlFHIrPV5t7BkOw6tWuKWMvhL1MHoWdGqOuTDfUhnxLqEMMu38pMbWW8amxRID6z26wENt6XgCfIK47V07THgEBrCtkKXh6tgc0Cws44MhnTUD+rKNA+bFqR74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213684; c=relaxed/simple;
	bh=mncynWtNY2D5v+ODOmhzx8xUCu6sIq6IrJdpDhITpGU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e9ueuX1LOUyjukOXPbvXfq9vp2MLLSQxaIc6iZ506gcx8keusSzddlzkwfAVfoAbY9A1ScDcKEf7aHael3I8zzCfRQn+rP6KxKvzM1gRo9SQn1shv0DFUSB8r3ruqj0Wggxry0qDnlypI8YXr70G5Yhhdg5ogQd+0RxkwjviYj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InDXahZ/; arc=none smtp.client-ip=74.125.226.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InDXahZ/"
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-988ce00f22dso374394241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791213681; x=1791818481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+CNmjHL2vOLCnvcK1au7xOFwWD4AZs+YJ/iWE64mX3I=;
        b=InDXahZ/rYWY3ArhdDJ5BN9BrU8+YB8pspiyYYeHa8Lo9lreVYw9S3b/vQrDxUSSHw
         9p1QvHioIwjDSiZtENc/N77AppFOsUaC8klGhtuUMLWZR2osuE2ECkQBDSY7KgzrAb7P
         VaUo9b2/zxuaLw0ezac7DwIWwSp57hWnW/96cc9ICGyrsrdah9XWq5en7W9YBG4V0p5s
         yrb8bk4s6mOTs9Wmi/Dwcit6xkwMnVSCMbg3WVPNI6ZWRnj3qipy+R/ftvezM/IR0eRS
         zDCjbVfnZbG951slQvY+CYZfmm1ZAk0aRITbH3LXi3pQBokLUmbpmOz/9SyVDAk5cWaO
         VxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213681; x=1791818481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+CNmjHL2vOLCnvcK1au7xOFwWD4AZs+YJ/iWE64mX3I=;
        b=XBfzu6dzzoeEnE4bWd5hLTlTKUwFZEHMRRf3n1L3e+0Alx7JP8l9GX+6OQMR259Nbs
         eOB8tzD3zCPiKPtEO+/P/QDjLEQovEQc/TSDNG7JZWVGIKlgZO22439DyAksY89zVVpt
         vl9eSnFoLXZijo52Rkc8vIijNw7bykwu+4PxezZ6UyRkoTuaRDol/8nr+cej3XbxvEMc
         2Q/L9pcdLI4eKMRRUKwhnYq4s0WeACWOO2s+3oPaVAQUW7+zAsgfhC4L+5l8G7ShgBdh
         9RZ8ka7FcYrTCkVXJe/lNlUPBsVwXeUmSHOP/kCP4vq7oWnhky0nOlz5J3JTd39kefIE
         aB0A==
X-Gm-Message-State: AFq9FYKgzbjcozug+Mnf/G2IiTryyqKZPhdMtqkyuqt3ABa2Xrug5PSp
	Db7A6QsrmSu/Eu9VIv8Cazz7uiWZSqzTzlUiG2xB8p5LVprmcF/ADL6l1wb9K7HS
X-Gm-Gg: AYBFou0Ao+hvwrOHneT3QjERhw9hD4rLyQoLrSvc0aALqSl9tTjFaWACN2vsthgUUKI
	luMz9V6fnREbgeohlyYBa9krh+rOCF17g8IaVzAMdOqM88TLsIhIScuH3YUMPFAvkjkqsqIB0rD
	iswhLKhr5bOqlXIwRhno7ay7USM5LUeWftGXmqrhveL7n1xUYA12sxDE5xam5jxN+7FNlWwwg/T
	8kouoXMHTlzb471Twoq8yYPYb+5HKcQYLJcYaF9Pdjbp3RCD/w4+IPV1aAdQIJLzCi5rQzxiFlZ
	PVbaVyKMOrgQFrTYZWdmGY46PebbMxDLPVAyDMU1B46mkhBQ0FUtDlejj9KhP++FO3PJ+uktlOc
	G53TreqRgmnVUSSnXIbpgEhUUWIBb80P5n9nzUkywLujp+MTBpGchPZjsQ2fTg7a104TSDn3hso
	wlmLa/Ht5VBVbMXJIZV2CLkLLFKBJjNqKTCwL70x2WwPWZbXFqNlMi/RbZ5sZyAtos3JvsOswKo
	ssyzDxXN3076eW9dsCocMuXjJ7fKJHiSH1H2+FacZ9vFuLVjkgbwkviFhMaEQtg
X-Received: by 2002:a05:6122:8005:b0:5c9:a60d:3277 with SMTP id 71dfb90a1353d-5dab1481fa4mr2670568e0c.11.1791213681291;
        Mon, 05 Oct 2026 08:21:21 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5da62d10534sm14429707e0c.13.2026.10.05.08.21.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:21:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] doc/mgmt: Document Advertising setting as Global Advertising
Date: Mon,  5 Oct 2026 11:21:10 -0400
Message-ID: <20261005152111.3419786-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The Advertising setting always uses instance 0, and with extended
advertising it has a dedicated advertising set, so only instances
sharing that set are overridden by it; the others are advertised
concurrently and removing instances never disables it.

Assisted-by: OpenCode:claude-opus-5.5
---
 doc/mgmt-protocol.rst | 70 +++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/doc/mgmt-protocol.rst b/doc/mgmt-protocol.rst
index f4c6822bfec1..ed2bd3349f25 100644
--- a/doc/mgmt-protocol.rst
+++ b/doc/mgmt-protocol.rst
@@ -306,7 +306,7 @@ following available bits:
     7, Basic Rate/Enhanced Data Rate
     8, High Speed
     9, Low Energy
-    10, Advertising
+    10, Advertising (Global Advertising - instance 0)
     11, Secure Connections
     12, Debug Keys
     13, Privacy
@@ -1714,6 +1714,12 @@ Set Advertising (since 1.4)
 :Return Parameters:	Current_Settings (4 Octets)
 
 This command is used to enable LE advertising on a controller that supports it.
+This is referred to as Global Advertising and it always uses advertising
+instance 0, its advertising data is generated by the kernel based on the
+current settings (e.g. Flags, TX Power, Local Name and Appearance) and is not
+related to the advertising instances added with Add Advertising or Add
+Extended Advertising Parameters/Data commands, which start at instance 1.
+
 The allowed values for the Advertising command parameter are:
 
 .. csv-table::
@@ -1742,10 +1748,20 @@ The value 0x02 should be the preferred mode of operation when implementing
 peripheral mode.
 
 Using this command will temporarily deactivate any configuration made by the Add
-Advertising command. This command takes precedence. Once a Set Advertising
-command with value 0x00 is issued any previously made configurations via
-Add/Remove Advertising, including such changes made while Set Advertising was
-active, will be re-enabled.
+Advertising command that shares the same advertising set as Global Advertising.
+This command takes precedence. Once a Set Advertising command with value 0x00
+is issued any previously made configurations via Add/Remove Advertising,
+including such changes made while Set Advertising was active, will be
+re-enabled.
+
+If the controller does not support extended advertising, there is only a single
+advertising set, so all instances are deactivated while Global Advertising is
+enabled. If the controller supports extended advertising, Global Advertising
+uses a dedicated advertising set (handle 0x00) so instances using other
+advertising sets continue to be advertised concurrently and are not affected
+by this command. Only an instance that would need to share the advertising
+set of Global Advertising (e.g. when the controller supports a single
+advertising set) is deactivated.
 
 A pre-requisite is that LE is already enabled, otherwise this command will
 return a "rejected" response.
@@ -2757,10 +2773,12 @@ This command is used to configure an advertising instance that can be used to
 switch a Bluetooth Low Energy controller into advertising mode.
 
 Added advertising information with this command will not be visible immediately
-if advertising is enabled via the Set Advertising command. The usage of the Set
-Advertising command takes precedence over this command. Instance information is
-stored and will be advertised once advertising via Set Advertising has been
-disabled.
+if Global Advertising is enabled via the Set Advertising command and the
+instance shares the same advertising set (see Set Advertising command). The
+usage of the Set Advertising command takes precedence over this command.
+Instance information is stored and will be advertised once advertising via Set
+Advertising has been disabled. If the controller supports extended advertising
+the instance is advertised concurrently with Global Advertising.
 
 The Instance identifier is a value between 1 and the number of supported
 instances. The value 0 is reserved.
@@ -2880,10 +2898,12 @@ When the Instance parameter is zero, then all previously added advertising
 Instances will be removed.
 
 Removing advertising information with this command will not be visible as long
-as advertising is enabled via the Set Advertising command. The usage of the Set
-Advertising command takes precedence over this command. Changes to Instance
-information are stored and will be advertised once advertising via Set
-Advertising has been disabled.
+as Global Advertising is enabled via the Set Advertising command and the
+instance shares the same advertising set (see Set Advertising command). The
+usage of the Set Advertising command takes precedence over this command.
+Changes to Instance information are stored and will be advertised once
+advertising via Set Advertising has been disabled. Removing instances never
+disables Global Advertising.
 
 Removing an instance while it is being advertised will immediately cancel the
 instance, even when it has been advertised less then its configured Timeout or
@@ -3048,7 +3068,7 @@ currently the following available bits:
 	7, Basic Rate/Enhanced Data Rate
 	8, High Speed
 	9, Low Energy
-	10, Advertising
+	10, Advertising (Global Advertising - instance 0)
 	11, Secure Connections
 	12, Debug Keys
 	13, Privacy
@@ -3779,10 +3799,12 @@ advertising instance. This command is expected to be followed by an Add Extended
 Advertising Data command to complete and enable the advertising instance.
 
 Added advertising information with this command will not be visible immediately
-if advertising is enabled via the Set Advertising command. The usage of the Set
-Advertising command takes precedence over this command. Instance information is
-stored and will be advertised once advertising via Set Advertising has been
-disabled.
+if Global Advertising is enabled via the Set Advertising command and the
+instance shares the same advertising set (see Set Advertising command). The
+usage of the Set Advertising command takes precedence over this command.
+Instance information is stored and will be advertised once advertising via Set
+Advertising has been disabled. If the controller supports extended advertising
+the instance is advertised concurrently with Global Advertising.
 
 The Instance identifier is a value between 1 and the number of supported
 instances. The value 0 is reserved.
@@ -3936,11 +3958,13 @@ advertisement registration process.
 
 If extended advertising is available, this call will initiate HCI commands to
 set the instance's advertising data, set scan response data, and then enable the
-instance. If extended advertising is unavailable, the advertising instance
-structure maintained in kernel will have its advertising data and scan response
-updated, and the instance will either be scheduled immediately or left in the
-queue for later advertisement as part of round-robin advertisement rotation in
-software.
+instance, regardless of Global Advertising being enabled via Set Advertising
+command, unless the instance shares the same advertising set (see Set
+Advertising command). If extended advertising is unavailable, the advertising
+instance structure maintained in kernel will have its advertising data and scan
+response updated, and the instance will either be scheduled immediately or left
+in the queue for later advertisement as part of round-robin advertisement
+rotation in software, or until Global Advertising is disabled.
 
 If Scan_Rsp_Len is zero and the flags defined in Add Extended Advertising
 Parameters command do not have connectable flag set and the global connectable
-- 
2.55.0


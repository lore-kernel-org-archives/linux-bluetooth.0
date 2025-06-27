Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E176F2E92B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035920; cv=none; b=u0FsR9NTEvhIK71p5E6/7Vsl9/3NtI+uIs5HRTOeE0aQLwHW23EQPGCdaxiA0a/a15FiyWbJUYMb1U7P9gfb1scfpRW+UZFAHS8s/qpADPEvRio0nvKDFyKS7DIJLf3TbhXuyVnimR+kMIhuFIOW9o2y5+GgB7HQByvE++28UoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035920; c=relaxed/simple;
	bh=ZfUCA97frxNAdyqHtV2vkgrU3fu/LAhdl1ay0sEFePA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+5FnjMhoW+y5ZEzqQDWBiYTF5IVPH9q67VLsIC3VkIwH1cnB72SiDZ3vAsadVRMjZ3xtPjHxgMQghmwnGgCR4x4+Z30W4cgqWLEuW+FfwzU9izZH/jVA6ek7EIul4TxFhFs2uIzi+eEGaO9YCp8fyjsWbcX86EHmE/7ZFTeLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TIBYgCY1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TIBYgCY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035906;
	bh=ZfUCA97frxNAdyqHtV2vkgrU3fu/LAhdl1ay0sEFePA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TIBYgCY17DM1YVJIISJaowH5yOFlMOfPQJ8EOq610qfcgOJyhpPRWBqS71JZD6dB+
	 rkatxmTVghjaJKDA8b5fDtGBbPcohJcG7rX0PTrO3Zutz+Fph+5K17tW5Mkx9F52o3
	 gHOxuFq2WLFehewZqOlepJw+b70gcFZZTiJ4/2zkpMn2OQFtGFi4MKU7ImX3KweYJh
	 jAzD0K47w37HKzDjojcykXDYALZfCF1WxPK/16fZdEjLR7X3cMksRbX1dJRFm1oNlQ
	 YTLjHCd3Ls8Fc53Zi39lvRJEbSfk571tlLx3hsGNk/Zq03UL7ijCyvVUgYyscKi94H
	 9UsRTEl2+n51g==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B089317E0B0D
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:46 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 16/27] doc: Make telephony docs more generic
Date: Fri, 27 Jun 2025 16:51:25 +0200
Message-ID: <20250627145136.421853-17-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627145136.421853-1-frederic.danis@collabora.com>
References: <20250627145136.421853-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Remove HFP specific parts or explicitly point it.
---
 doc/org.bluez.Call.rst        | 37 ++++-------------------------------
 doc/org.bluez.TelephonyAg.rst |  3 +--
 2 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/doc/org.bluez.Call.rst b/doc/org.bluez.Call.rst
index 3fcd6f6ea..f4ff37c05 100644
--- a/doc/org.bluez.Call.rst
+++ b/doc/org.bluez.Call.rst
@@ -35,23 +35,9 @@ void Hangup()
 
 Hangs up the call.
 
-For an incoming call, the call is hung up using ATH or equivalent. For a
-waiting call, the remote party is notified by using the User Determined User
-Busy (UDUB) condition. This is generally implemented using CHLD=0.
-
-Please note that the GSM specification does not allow the release of a held
-call when a waiting call exists. This is because 27.007 allows CHLD=1X to
-operate only on active calls. Hence a held call cannot be hung up without
-affecting the state of the incoming call (e.g. using other CHLD alternatives).
-Most manufacturers provide vendor extensions that do allow the state of the
-held call to be modified using CHLD=1X or equivalent. It should be noted that
-Bluetooth HFP specifies the classic 27.007 behavior and does not allow CHLD=1X
-to modify the state of held calls.
-
-Based on the discussion above, it should also be noted that releasing a
-particular party of a held multiparty call might not be possible on some
-implementations. It is recommended for the applications to structure their UI
-accordingly.
+For an incoming call, the call is hung up.
+For a waiting call, the remote party is notified. For HFP by using the User
+Determined User Busy (UDUB) condition.
 
 NOTE: Releasing active calls does not produce side-effects. That is the state
 of held or waiting calls is not affected. As an exception, in the case where a
@@ -69,22 +55,7 @@ string LineIdentification [readonly]
 ````````````````````````````````````
 
 Contains the Line Identification information returned by the network, if
-present. For incoming calls this is effectively the CLIP. For outgoing calls
-this attribute will hold the dialed number, or the COLP if received by the
-audio gateway.
-
-Please note that COLP may be different from the dialed number. A special
-"withheld" value means the remote party refused to provide caller ID and the
-"override category" option was not provisioned for the current subscriber.
-
-string IncomingLine [readonly, optional]
-````````````````````````````````````````
-
-Contains the Called Line Identification information returned by the network.
-This is only available for incoming calls and indicates the local subscriber
-number which was dialed by the remote party. This is useful for subscribers
-which have a multiple line service with their network provider and would like
-to know what line the call is coming in on.
+present.
 
 string Name [readonly]
 ``````````````````````
diff --git a/doc/org.bluez.TelephonyAg.rst b/doc/org.bluez.TelephonyAg.rst
index ddb5eec0f..ad217a6dd 100644
--- a/doc/org.bluez.TelephonyAg.rst
+++ b/doc/org.bluez.TelephonyAg.rst
@@ -24,11 +24,10 @@ Methods
 object Dial(string number)
 ``````````````````````````
 
-Call number, if number is void try to call last dialed number.
 Initiates a new outgoing call. Returns the object path to the newly created
 call.
 
-The number must be a string containing the following characters:
+For HFP, the number must be a string containing the following characters:
 `[0-9+*#,ABCD]{1,80}` The character set can contain numbers, `+`, `*`, `#`,
 `,` and the letters `A` to `D`. Besides this sanity checking no further number
 validation is performed. It is assumed that the gateway and/or the network
-- 
2.43.0


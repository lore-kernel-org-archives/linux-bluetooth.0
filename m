Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="C5lRo8Ft"
X-Greylist: delayed 1672 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 05:07:38 PST
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038EF10CB
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 05:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=metanate.com; s=stronger; h=To:Date:Message-Id:Subject:
	Content-Transfer-Encoding:Content-Type:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=EEh3hrHXDURH+C+BXcjBfML05ZmkJ4iRj9VtgewP5aw=; b=C5lRo8Ft87A+DaeynL2Gn7VfN7
	fcfhkzqhXKDAtd716fmnuq+AOvnyaJt2lPoPxtsP6a5FPOS2iosgjX2zFKOTByvMTCeVZ3nxwfUXb
	CtGKNL3JnqizZ2fyUcFOFNg5bFvBoaTHRnlMJwHrP2d4O8OOvj/KpAVLgxZo55v3BGMDEIc+xCHRw
	QEWET0aEV11L36LhZKatE4lP9PvXB9/kF8ug9t73H7ZMp3vsOVhxv9hZaFOZ+l/inxvW6O8Zbdfss
	iAiFD4HLleNg4niMW9LqF4qapCPvx2LVCyjXOcUdEFJJsWxi9XAlpl6Q52911KsY68DXUsi3v1pz/
	/QsvS/AQ==;
Received: from cpc159311-cmbg20-2-0-cust374.5-4.cable.virginm.net ([82.5.237.119] helo=smtpclient.apple)
	by email.metanate.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <stu@metanate.com>)
	id 1rBDfK-0008PR-2U
	for linux-bluetooth@vger.kernel.org;
	Thu, 07 Dec 2023 12:39:42 +0000
From: Northfield Stuart <stu@metanate.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: [PATCH BlueZ v1] client: make ad_clear_data() clear the correct
 structure
Message-Id: <66D06D2D-01A5-4ED2-BF1D-EDABC9F42146@metanate.com>
Date: Thu, 7 Dec 2023 12:39:32 +0000
To: linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6)
X-Authenticated: YES

Fix longstanding =E2=80=98cut and paste=E2=80=99 bug which clears =
Manfacturer Data=20
structure when it should be clearing Data structure

---
diff --git a/client/advertising.c b/client/advertising.c
index a7474d6a2..b8e3f4ab3 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -757,7 +757,7 @@ void ad_disable_manufacturer(DBusConnection *conn)
   static void ad_clear_data(void)
 {
-    memset(&ad.manufacturer, 0, sizeof(ad.manufacturer));
+    memset(&ad.data, 0, sizeof(ad.data));
       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }







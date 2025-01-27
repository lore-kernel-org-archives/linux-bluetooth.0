Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB77CF16
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997120; cv=none; b=J+Lr8t1GzGGUzkeIUFbmlX8sE46xvtrAFCrfxv1IXrZpyao020z/OE4iwX63yXAWBWyzt6xteJNdB61Jj5xfASHF6kHfscm7PQRTwZDzqLTWXMy3mMzg9adlOWL6GHFAJ1i7IKZcwLWH086zUKXj0562w0VQCHTfQ8hD4LG8qig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997120; c=relaxed/simple;
	bh=fKBYIomqh/ymmxcJUfw/H9OhVdZ7ALTdXjCOjK/l8cA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sG6EWpqSiZCvPKdWmuybSUdnxplhzYbAKU0jV7o/Z5/TGTLRZGS6F5nHg6/3BpY8I+NCLK3zIURo65e7PL5hcefBSIP7CqBsfQWr6bz2RhZDF2dIjpqZF4vNjz1lJdlmXwcD0A8y8+cajKfMuZNiZSa+ClL6kUB5858Q0BYe28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVEx70+5; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVEx70+5"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e17de2816so2136821a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 08:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737997117; x=1738601917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZWX/17z5Hb56zPJIAljPOERJQUzXw6gPxkJcJvka6A=;
        b=EVEx70+59NSvwA8F2dW1FY6fzVki+U8Cb+Skm/1tE3RTW1e72ObenNQVXhzRKhwvCK
         1QXQ3qDn59IXPYrEtPJwbIYQdoOmWM/rys2HaqSC1jtUkEOkvo7Kw4vKOpcznA+Ilzeh
         jtludBPGj62aUURiik65+Iole+FGKFWXgPd/CcbrrJ3m3W6iExwetFjBUXwkZv755+4j
         5UsLEJFgBrWJAZ6hChjFkB7ut4CDzfIIILgYfKgILbcPtEvWf/rxkng6lK+C8lpONpMZ
         T+7Ip2ped/9MuH8eSi3fy2YGBHvn9YbSVLBZcfmhJeEgEAEqqWvDCz2N6ON6lPTNPHeI
         sT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737997117; x=1738601917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZWX/17z5Hb56zPJIAljPOERJQUzXw6gPxkJcJvka6A=;
        b=QdJMxUgdren5JhqS9FZNWTamhwZkn2HtK1AVQfBf21JdDbKE84A9xjiXsT3Rf378uG
         14spOzK6pm2JO4tTMKozqR6W3dVni/1O0/zSw/TL5X5Lw0Rah2Vlazwlr9MgPTDseuxO
         SzkQ9TE9ZAJiWs8bAlDvcq51TzOt853RALB3CkO+RUO1bLqxaH79cjrHK/mm9eLabrbA
         yZxYKUIP6bf7zOOsooIzuYG1+YfNKjEUAW7r+fKudSo8OYO4GZIZbV54VZ7Zr6YRHi9U
         zFrP/tWTRYPCYgPkhzeRUqc4v54ZtEyUfP/X/b04XuejVnwCtWtUyW6pJVDMcFhF/o0p
         8Wzw==
X-Gm-Message-State: AOJu0YwrM7vfGzuTq/MXab7L6XAdd1tY8WlE7rYGlkFT5AqQCyuK6v6i
	8tbEyduEO/d504jRrFrUR3iXEvoqVuH5LZPaaPCVrsWT5IWtHE1R9555hjmV
X-Gm-Gg: ASbGncv+DMdmRgxi9YFqO1yKzu5r+6FVbnvcpvYso6+jq4SBV5I2RFk1JoOUI7b2KWu
	E8LEP1qQW7EqnygCISc2p+BW+ciIHdgsBeWyrhdUyCREiSMXlABcwLYQ7HIkiJM4sxMV6i4Y6MC
	7pu8EENFenXv7YzhXUaifi20VtjjVM4Iwy7g60U1hfrtm28VRYs99hr7kQzVXMYg748xOz4vpU/
	c7WHPKqJiaEWRDoaZ9YzUA5y7uTLmvgBh128fSJNr8AsoB7XWOWn97003qIc/NOEBpX7jT0tVKl
	KhCDJDwE5UWw2rtST+uH8v1SAnghIjs3qYjY178ybU1x/s27S+ab
X-Google-Smtp-Source: AGHT+IEWn6Pe7ZVhW6AAeYFcWByrds9v+4SkGStEuEmW1EJO6+0jCaKsTVZ/jcvFzU6+uIfsSef8EQ==
X-Received: by 2002:a05:6830:6887:b0:71d:62ad:5262 with SMTP id 46e09a7af769-7249da7d75bmr25330928a34.10.1737997116680;
        Mon, 27 Jan 2025 08:58:36 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-724ecf88fd0sm2294827a34.47.2025.01.27.08.58.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:58:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] org.bluez.LEAdvertisement: Add dedicated Scan Response field
Date: Mon, 27 Jan 2025 11:58:31 -0500
Message-ID: <20250127165833.866133-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Scan Response fields as experimental so we can evaluate if
this should be made into a stable API.
---
 doc/org.bluez.LEAdvertisement.rst | 101 +++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 35 deletions(-)

diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
index d3f9cc480470..bab507439355 100644
--- a/doc/org.bluez.LEAdvertisement.rst
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -60,31 +60,32 @@ string Type [readonly]
 	:"broadcast":
 	:"peripheral":
 
-array{string} ServiceUUIDs
-``````````````````````````
+array{string} ServiceUUIDs [readonly, optional]
+```````````````````````````````````````````````
 
 	List of UUIDs to include in the "Service UUID" field of the Advertising
 	Data.
 
-dict ManufacturerData
-`````````````````````
+dict ManufacturerData [readonly, optional]
+``````````````````````````````````````````
 
 	Manufacturer Data fields to include in the Advertising Data.  Keys are
 	the Manufacturer ID to associate with the data.
 
-array{string} SolicitUUIDs
-``````````````````````````
+array{string} SolicitUUIDs [readonly, optional]
+```````````````````````````````````````````````
 
-	Array of UUIDs to include in "Service Solicitation" Advertisement Data.
+	List of UUIDs to include in the "Service Solicitation" field of the
+	Advertising Data.
 
-dict ServiceData
-````````````````
+dict ServiceData [readonly, optional]
+`````````````````````````````````````
 
-	Service Data elements to include. The keys are the UUID to associate
-	with the data.
+	Service Data elements to include in the Advertising Data. The keys
+	are the UUID to associate with the data.
 
-dict Data
-`````````
+dict Data [readonly, optional]
+``````````````````````````````
 
 	Advertising Data to include. Key is the advertising type and value is
 	the data as byte array.
@@ -101,8 +102,38 @@ dict Data
 		<Transport Discovery> <Organization Flags...>
 		0x26                   0x01         0x01...
 
-bool Discoverable
-`````````````````
+array{string} ScanResponseServiceUUIDs [readonly, optional, experimental]
+`````````````````````````````````````````````````````````````````````````
+
+	List of UUIDs to include in the "Service UUID" field of the Scan
+	Response Data.
+
+dict ScanResponseManufacturerData [readonly, optional, experimental]
+````````````````````````````````````````````````````````````````````
+
+	Manufacturer Data fields to include in the Scan Response Data. Keys
+	are the Manufacturer ID to associate with the data.
+
+array{string} ScanResponseSolicitUUIDs [readonly, optional, experimental]
+`````````````````````````````````````````````````````````````````````````
+
+	List of UUIDs to include in the "Service Solicitation" field of the
+	Scan Response Data.
+
+dict ScanResponseServiceData [readonly, optional, experimental]
+```````````````````````````````````````````````````````````````
+
+	Service Data elements to include in the Scan Response Data. The keys
+	are the UUID to associate with the data.
+
+dict ScanResponseData [readonly, optional, experimental]
+````````````````````````````````````````````````````````
+
+	Scan Response Data to include. Key is the advertising type and value is
+	the data as byte array.
+
+bool Discoverable [readonly, optional]
+``````````````````````````````````````
 
 	Advertise as general discoverable. When present this will override
 	adapter Discoverable property.
@@ -110,8 +141,8 @@ bool Discoverable
 	Note: This property shall not be set when **Type** is set to
 	"broadcast".
 
-uint16 DiscoverableTimeout
-``````````````````````````
+uint16 DiscoverableTimeout [readonly, optional]
+```````````````````````````````````````````````
 
 	The discoverable timeout in seconds. A value of zero means that the
 	timeout is disabled and it will stay in discoverable/limited mode
@@ -120,8 +151,8 @@ uint16 DiscoverableTimeout
 	Note: This property shall not be set when **Type** is set to
 	"broadcast".
 
-array{string} Includes
-``````````````````````
+array{string} Includes [readonly, optional]
+```````````````````````````````````````````
 
 	List of features to be included in the advertising packet.
 
@@ -130,8 +161,8 @@ array{string} Includes
 	See **org.bluez.LEAdvertisingManager(5)** **SupportedIncludes**
 	property.
 
-string LocalName
-````````````````
+string LocalName [readonly, optional]
+`````````````````````````````````````
 
 	Local name to be used in the advertising report. If the string is too
 	big to fit into the packet it will be truncated.
@@ -139,27 +170,27 @@ string LocalName
 	If this property is available 'local-name' cannot be present in the
 	**Includes**.
 
-uint16 Appearance
-`````````````````
+uint16 Appearance [readonly, optional]
+``````````````````````````````````````
 
 	Appearance to be used in the advertising report.
 
 	Possible values: as found on GAP Service.
 
-uint16_t Duration
-`````````````````
+uint16_t Duration [readonly, optional]
+``````````````````````````````````````
 
 	Rotation duration of the advertisement in seconds. If there are other
 	applications advertising no duration is set the default is 2 seconds.
 
-uint16_t Timeout
-````````````````
+uint16_t Timeout [readonly, optional]
+`````````````````````````````````````
 
 	Timeout of the advertisement in seconds. This defines the lifetime of
 	the advertisement.
 
-string SecondaryChannel
-```````````````````````
+string SecondaryChannel [readonly, optional]
+````````````````````````````````````````````
 
 	Secondary channel to be used. Primary channel is always set to "1M"
 	except when "Coded" is set.
@@ -170,24 +201,24 @@ string SecondaryChannel
 	:"2M":
 	:"Coded":
 
-uint32 MinInterval
-``````````````````
+uint32 MinInterval [readonly, optional]
+```````````````````````````````````````
 
 	Minimum advertising interval to be used by the advertising set, in
 	milliseconds. Acceptable values are in the range [20ms, 10,485s].
 	If the provided MinInterval is larger than the provided MaxInterval,
 	the registration will return failure.
 
-uint32 MaxInterval
-``````````````````
+uint32 MaxInterval [readonly, optional]
+```````````````````````````````````````
 
 	Maximum advertising interval to be used by the advertising set, in
 	milliseconds. Acceptable values are in the range [20ms, 10,485s]. If the
 	provided MinInterval is larger than the provided MaxInterval, the
 	registration will return failure.
 
-int16 TxPower
-`````````````
+int16 TxPower [readonly, optional]
+``````````````````````````````````
 
 	Requested transmission power of this advertising set. The provided value
 	is used only if the "CanSetTxPower" feature is enabled on the
-- 
2.48.1


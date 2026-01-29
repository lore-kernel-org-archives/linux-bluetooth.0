Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com [209.85.222.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AB322B7B
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728955; cv=none; b=aOTm0rCUibF/M+8xOZBlwLxYrqpEF4EU+E90Zsj0IjvqwnMuhzQTjif1s1leS7KyGuyBxBkprqL5qIc4CSJDyQvQpqPxgtZX+yGyya9k3l3hKkDxQKVgaSWIU+xWxIJf+QX/cdqNNoISvH4OLdFYuqx51mXpjZqSlfOdMRgur6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728955; c=relaxed/simple;
	bh=karhn36r2dw3YCaVQ69/+B/QGP6u/VqXnJ+RL+1Rk1o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1mJj3eBfsslWj55s2qRBqVkHU1VK7zSVREJ5T59qI1P7XHx8J6o/vojkvegBRd8/HOAX7dO0ZLaEYF++dPIO/kn8Vh7vdLVm2ePMOXrREmtQXA0Y0457+ICt7cFB43uVz72oiYScASas2dkbGgdFg+Adr3zOPIkcxqQnePsBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0SR28LK; arc=none smtp.client-ip=209.85.222.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0SR28LK"
Received: by mail-ua1-f68.google.com with SMTP id a1e0cc1a2514c-941063da73eso886743241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728952; x=1770333752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovUTgvfl4chlDJ52UCSi03bvIDXOeI4KQQAtGq3CS9A=;
        b=V0SR28LKbM7C2Xa2N8f6hQ1RVBbXBjG8YpNJ11NrcQbDKj3XqZW/RCWqJ8/b56nTOC
         mIWW+C7kz17G4d96gq2rsrbZItQ/p1Cgi7Y0O7LxblAJQ/zBxaFs0/VdMppxMbgR2diU
         Q8fmqcGdQx9yWDYdAAlPwuqosWvN+YolWbTz4bgXnz5Qj4//y7Q30YYJgEoHvz07eb1Y
         +rrgAwIVCeIerqb+nZegVsCYAXJoN6RcyV5H2pggiCkHpwneEAWFOJZ0SKT+rrpG+qp1
         oT0J1GqM62HzjOHEnPkA45bNYD0kZ0KDkUOSdHa/swVQ9REBXAoPVtl0la82w1V4JVu3
         jPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728952; x=1770333752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ovUTgvfl4chlDJ52UCSi03bvIDXOeI4KQQAtGq3CS9A=;
        b=PGkjYUH98jkzdtFxQArOQVEjYQqS3mD+zMhCcYSpBNJYyTD8xca4yhRy/u3qTnFwT0
         gJ8TYJrhrizZ0c0zKLHMB2jd+BeQ+LqcWW/mPuXdMXHGFwbeLt/Bd8KZ62Uh9iFkfE4N
         uLFQz1ohOZGQbq4WJa3x1bNnngaHkxKk+TQfxJnvlZgvHiPRQ2VL74gOWNgPvGzjxFJv
         9dPsXTphYWknzzy27aJZhdz61mWREjxy4GZnYAsVNBF/MdGaDYf5rqiSr1ezLuEKN6SB
         cgE7pmGOz4DaYx/GOLiqU5gtE+25YvHU2xXb7VxRg7zU89d69R4fYZDU9p8xDZED7MZ7
         YBQw==
X-Gm-Message-State: AOJu0YxUcGh1ca53L2N5+l4pQTbX9auJjXMi/qzvqILV4xkm3rxT40Wv
	osvBPQpZ8kgyUOfX1LNvgSbEqtH/vKRu8JJllLPjRS1xSRTSImlxpbKR4elB4U8JGoQ=
X-Gm-Gg: AZuq6aLgnIn2ZqKcyiWfBYE56WMqpm419WrXNqVY3IcYRwfaHQHA0RPW+FQcPtFq935
	+rj+yx03ETHMGsciep+zf93cLRUKhEdMjUNmI0DVCWs1gzPaCXr9Khhf41XCJIDFaha4qb8nv9/
	BuKFgJU1gILqFl5zuRf5cDgcJeB8kTGYTJAdUVIQ7LiHk008DHYLaWimTHQhLfedeIIMC6g6Wj4
	nYD2HhU/sQjp9GbQEe9Zig7kQkN6CF8tleq8bhA9b1DIZeyLqBS/I0ns8puAxGqLJkHTBuhGuJd
	FJou4P60f5Hc3cR54sKQDn3Z1oJXKUaNfdnxE/i2v26t3HKCn8ejpZNesyHno389wxNR1F37qu4
	bvvk88y30PkZ7qE4Lo+eJYXOA+b5wAVUosBlAMP4+ZStsFTKxplj6NEP2f5xQI2C58CGUt31+9j
	MY1ku9lis9dZiAZAu4nBfUubJgsiiu6rWmArgeDNY4IthG7Qoo1g/bGp8FCbd2wzwWTUOTTASoy
	ILkWg==
X-Received: by 2002:a05:6102:44d8:20b0:5f8:e365:31dc with SMTP id ada2fe7eead31-5f8e36553c4mr200453137.17.1769728952365;
        Thu, 29 Jan 2026 15:22:32 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 14/15] doc/bluetoothctl-telephony: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:53 -0500
Message-ID: <20260129232201.1049568-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129232201.1049568-1-luiz.dentz@gmail.com>
References: <20260129232201.1049568-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add parameter documentation for telephony commands including show,
select, dial, show-call, answer and hangup. Documents audio gateway
paths, phone numbers and call object parameters for telephony
operations.
---
 doc/bluetoothctl-telephony.rst | 66 +++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/doc/bluetoothctl-telephony.rst b/doc/bluetoothctl-telephony.rst
index a6870e781a7a..ae79ab0036d8 100644
--- a/doc/bluetoothctl-telephony.rst
+++ b/doc/bluetoothctl-telephony.rst
@@ -27,34 +27,69 @@ list
 List available audio gateways.
 
 :Usage: **> list**
+:Example Display all available HFP audio gateways:
+	| **> list**
 
 show
 ----
 
 Show audio gateway information.
 
-:Usage: **> show [audiogw]**
+:Usage: **> show [telephony]**
+:[telephony]: Audio gateway device path (optional, shows current if omitted)
+:Example Show information for currently selected audio gateway:
+	| **> show**
+:Example Show information for specific audio gateway device:
+	| **> show /org/bluez/hci0/dev_00_11_22_33_44_55**
+:Example Show information for another audio gateway:
+	| **> show /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF**
 
 select
 ------
 
 Select default audio gateway.
 
-:Usage: **> select <audiogw>**
+:Usage: **> select <telephony>**
+:<telephony>: Audio gateway device path to set as default
+:Example Select specific audio gateway as default:
+	| **> select /org/bluez/hci0/dev_00_11_22_33_44_55**
+:Example Select different audio gateway as default:
+	| **> select /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF**
 
 dial
 ----
 
 Dial number.
 
-:Usage: **> dial <number> [audiogw]**
+:Usage: **> dial <number> [telephony]**
+:<number>: Phone number to dial
+:[telephony]: Audio gateway device path (optional, uses current if omitted)
+:Example Dial number using currently selected audio gateway:
+	| **> dial 555-1234**
+:Example Dial international number using current audio gateway:
+	| **> dial +1-555-123-4567**
+:Example Dial emergency number using current audio gateway:
+	| **> dial 911**
+:Example Dial number using specific audio gateway:
+	| **> dial 555-1234 /org/bluez/hci0/dev_00_11_22_33_44_55**
+:Example Dial UK number using specific audio gateway:
+	| **> dial +44-20-7946-0958 /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF**
+:Example Dial with caller ID blocking:
+	| **> dial *67-555-1234**
+:Example Dial with caller ID hiding (GSM format):
+	| **> dial #31#555-1234**
 
 hangup-all
 ----------
 
 Hangup all calls.
 
-:Usage: **> hangup-all**
+:Usage: **> hangup-all [telephony]**
+:[telephony]: Audio gateway device path (optional, uses current if omitted)
+:Example Terminate all active and waiting calls on current gateway:
+	| **> hangup-all**
+:Example Terminate all calls on specific audio gateway:
+	| **> hangup-all /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 list-calls
 ----------
@@ -62,6 +97,8 @@ list-calls
 List available calls.
 
 :Usage: **> list-calls**
+:Example Display all active, waiting, and held calls:
+	| **> list-calls**
 
 show-call
 ---------
@@ -69,6 +106,13 @@ show-call
 Show call information.
 
 :Usage: **> show-call <call>**
+:<call>: Call object path to display information for
+:Example Show information for specific call:
+	| **> show-call /org/bluez/hci0/dev_00_11_22_33_44_55/call1**
+:Example Show information for another call:
+	| **> show-call /org/bluez/hci0/dev_00_11_22_33_44_55/call2**
+:Example Show call information from different device:
+	| **> show-call /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/call1**
 
 answer
 ------
@@ -76,6 +120,13 @@ answer
 Answer call.
 
 :Usage: **> answer <call>**
+:<call>: Call object path to answer
+:Example Answer incoming call:
+	| **> answer /org/bluez/hci0/dev_00_11_22_33_44_55/call1**
+:Example Answer waiting call:
+	| **> answer /org/bluez/hci0/dev_00_11_22_33_44_55/call2**
+:Example Answer call from different device:
+	| **> answer /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/call1**
 
 hangup
 ------
@@ -83,6 +134,13 @@ hangup
 Hangup call.
 
 :Usage: **> hangup <call>**
+:<call>: Call object path to terminate
+:Example Terminate specific active call:
+	| **> hangup /org/bluez/hci0/dev_00_11_22_33_44_55/call1**
+:Example Terminate waiting or held call:
+	| **> hangup /org/bluez/hci0/dev_00_11_22_33_44_55/call2**
+:Example Terminate call from different device:
+	| **> hangup /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/call1**
 
 RESOURCES
 =========
-- 
2.52.0


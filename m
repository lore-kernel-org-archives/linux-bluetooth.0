Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A043E4A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842705; cv=none; b=Eb5MCvVI4Hn61cYcswaFoN2Fdr2IR3zkZjvNnLLUzgOZZMPKRfKLZfBF6Skf9VtIt/UpyjP70C5fOZASyrceDGaE5YL6MiHuPzIsBie0e5LXaoIMBCAU87Vwq/JF/E+Ffu3nsxR+e2bhEzMNR/4D8DXTk8lMyg/VArMOSxBh5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842705; c=relaxed/simple;
	bh=AC1EfWTsOsaefEMPoMH0p5MkPXNJ3yg4n3ha6PlMOnc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=klOXwqy2foPJXPYtZx6S+JJfzMSbL/lpW3PEGGOER5kA7nj4w9KqbJJZE0dcJQUXqfU2DJbVv7OBNbzIRDVZju/WY5IJk6QxtjDAMXc4gaz6KiVacYSGnCQGtb50RGXIE2N9CpkQNaMKti1c/aYnoZUyowPXHbglZ3gpY2286pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CD203ECAA
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 14:58:16 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bap: Fix stack buffer overflow in BlueZ LE Audio BASE parser
Date: Thu, 27 Aug 2026 16:58:00 +0200
Message-ID: <20260827145807.1568199-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFaJDW2Uts6bpstXi2ABxShFfSJJIeUAfpuzroLYaMxR2WqFl1iQwaj6ZrEDV7Vq9DVy9cS1UuJxzz/tEmoc2+Vwo3s7YH2KGB32IZgE/iuUNeLteSc8Eerly5t8qxfpASnCBtmg9kAYEIUjZ73KOnoReuQaERtTGOdB3cHsChVr6aq5hVWHhgkOiaHbuZfwkTAEdQPh2vZb4YLGetS2z+a2HI6Y27lmCakFkEKMuT47gqXUKTPBTjNnC43hCKBm4HfdEZEiB9NgTmRjsi8WPAtDiycE461ERdbVdSJzfRvHZ/ZiCmAYZyi3/lvPSRFj2RO62EceoCAR35DU9C6rkYynOvIGCgFTB+yIxDLtpcPT6cLGm6Wfetiti3Y1d5LYYnawfQgdfQllK0KCWBpgWqIKEscII0D22hSYchKNADzZ04gVXUkgQ3ANj5NKjI7RSSGRcQo09k4UokxVyw5AHgW2/QCeZvEMJJmCV/D2MdAWpphQYgFibrsJi7raZBEck4dg2ogz5ixTOAlsb4RvdnyvDfL1dbUWZnEzcx38Z/aIW9JnYQqTu6VmguFefy2xT6SG1RGkfm8YVezXdp5wX+VJ2fva74Ymb4bm/vudeprNCQI4mJerN13hEdXrdovW8P5yXvoJetWScsibzItDyHlTwpGNFjpPdLDsMhafqjB8w
X-GND-State: clean
X-GND-Score: 0

A stack buffer overflow (CWE-121) in bap_sink_match_allocation() in
src/shared/bap.c allows an attacker within BLE range to write ~195
attacker-controlled bytes past a 4-byte stack buffer in bluetoothd
with no pairing, no connection, and no user interaction. The BAP
profile auto-syncs to any device advertising the BCAAS UUID.

bap_sink_match_allocation() copies the value of an
Audio_Channel_Allocation LTV (type 0x03) into a 4-byte uint32_t stack
local using the LTV's attacker-controlled length byte as the memcpy
size, with no upper bound check:
	// src/shared/bap.c:7767
	memcpy(&location32, v, l);  // l attacker-controlled, no upper bound

A second identical instance exists in bap_sink_get_allocation() at line 2558.

Per Bluetooth Assigned Numbers, Audio_Channel_Allocation is a fixed 4-octet
bitfield; any other length is malformed.

https://github.com/bluez/bluez/security/advisories/GHSA-9683-2chf-hfw9

Co-Authored-by: @thaidn and @bronson-calif of Calif.io in collaboration with
  Claude and Anthropic Research.
Reported-by: @thaidn and @bronson-calif of Calif.io in collaboration with
  Claude and Anthropic Research.
---
 src/shared/bap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1660b8b2c1cf..da3e265e2077 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2555,7 +2555,7 @@ static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
 {
 	uint32_t location32;
 
-	if (!v)
+	if (!v || l != sizeof(location32))
 		return;
 
 	memcpy(&location32, v, l);
@@ -7764,7 +7764,7 @@ static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t,
 	struct bt_ltv_match *data = user_data;
 	uint32_t location32;
 
-	if (!v)
+	if (!v || l != sizeof(location32))
 		return;
 
 	memcpy(&location32, v, l);
-- 
2.55.0


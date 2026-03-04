Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0E377EAC
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647181; cv=none; b=n5lZ4C8nUlfZf/RVbSOz9IDYjUxn9+Rz/2KkCK+w9l23emoupzdpRMs3mYidBDKrw2TVxGmhj17S6FaGL1bM0kDRmiixP9JH5RqVho5CSWeAGHzl8uVmLtUbz/wSSdy9E+jrmv1qFM4uLGZn3JPG1jHJCJL9jENKvrZLBbWdvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647181; c=relaxed/simple;
	bh=GeZtsKycC9AsOOM4RNuRCz6I20k9D59ZtjII6Wv1lKs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=czlys/OT7QiDRPZdMuyss3n37q5F19c5+0bKaPVNcjbGBrEZx0fE9IuZxX8ixp2iBjNsEabDTXBu0f4jHZ1Sc52ShziAl+Ssc0o+0uM1FHJeN7DZ07eBtRC44eJwZu+0yfQsn1G5c6iKQpz/m9s2daMqZLJLzmqcXYb4TrBFrTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FptKTkyd; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FptKTkyd"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56a8ebde349so5875311e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2026 09:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772647179; x=1773251979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxOkBHoTFdo6ohIMxbVym9y7BBADOiNyMHzXdh7iP8A=;
        b=FptKTkydp5xrAHZkzWZjPwDhv1//07vsmmsar4/CpLKHx8agQa/mvptcfsxPTNSnua
         qfnc/3676f0QANpMxMQHDYHBsJetUIVpLFrcsBHXF/F450lfMX43fE7J5kSbsbM8rkl2
         NMHfDQmOz0rfSQCRiXM4/KeCop8e0dT92pg0fW4z7nDvR2+9CLI/lM7MrJf2kHysNf24
         e/j2Fn+YYxkuNdQdSZETaf1aF/OJ92fmqpvIvId68tr2FH/frpKXWO65jLY/lK6ig4qs
         LI1Ve6blLe7cJheBiS67eph1Pv/STFFw+XWjEaoIf0MS/S4VruvBALQe5ZmNR29A0jWL
         iwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647179; x=1773251979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxOkBHoTFdo6ohIMxbVym9y7BBADOiNyMHzXdh7iP8A=;
        b=B7BT5elDSja1rYL/YyVsKStKc5J6mgEbESqzEzSVv00/iW6EtjaPfPcoT/jbU9aL7I
         +QWpaqxHAOhbsXOwHxTLn1b01z5p+ELzH85ILRq8wdH9ZeV2YYf03XORpLl7AT1ncYt4
         yztQ/An3MUYas9wPuLxbcN+kyxOzy8u+wPNszOjkaDrck1pxUjwDKrvwmrWIQOOGV5oF
         PrKlCYag0//2M/kHAP8iVQMhWJs4pS8mNU0karjILo98S6CFzSVfCn9O/qiz+XhFr2uF
         KHkAVg7QWoP++RIhQnVmY9AKv+ytz2vKxfQ7uOMNq1e+9TQBrYI9/ZLbNzrqv3ThoIhf
         1fLQ==
X-Gm-Message-State: AOJu0YzMPzvHa7RPx2ZXHAGa9uuqNAwEi5r3JGq3MUBEot0oClK6vGd0
	NX/Zdcy08AcqwOEmZwEnG7sN6eyhN3KBDp1rdipu0B9FyMZLHLmUQzvN7lHIADkp5JE=
X-Gm-Gg: ATEYQzxGDKzZuN3pqk3zNfxaRiTeNbeXqR4oSrnBAlqGjhFTZ0Cef9hQ2LXXgdqoZFL
	BIxKe9S/NIHhK2+7pwa43DO9fqLqQrYddsoTd2XcXqHOrSv26Lq0jLDKOqplqbp7GvY8D8ubNs4
	zT2sSh7pD7LcDcsyut6CBn/gBmmPzGelPnYWctgAkMDNqNrGjYJYSDPVU7G9BpXPN2bhaAngyTS
	1JNy7/D23aSy73mbQZ0OaOhMUj2uViUqgtnQd9zylZKxq0SiaxSSGnxryjUAr+iqFnFVEF7jyie
	0uigvdO4+U+wVzftjs0t3H/cSd4tADfiXS4trtWaOEOtAnB5/xyP2sOrE7I5xd1q8ksfFmC+f8g
	2iApKHw3J+VjxTNN6UPGKHykUmwznN2zlnNdP/XLlLIkwoPFHe8qFcUKQT0N13JHdh57wcGXLfK
	UnZsNIH7pC/6eUFUdrlzNwhl/kppGQIQfiRi4eOqTsr/HWPpeWECQzmfXfzLEn6N6kV1wYs3IRN
	nvMeTTeWJ4q+DGR8Q==
X-Received: by 2002:a05:6122:1b8f:b0:566:25a6:7979 with SMTP id 71dfb90a1353d-56ae77f4baemr1301967e0c.19.1772647178607;
        Wed, 04 Mar 2026 09:59:38 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56aee8c9a86sm1722079e0c.18.2026.03.04.09.59.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:59:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] l2test: Attempt to update BT_SNDMTU/omtu when using -D
Date: Wed,  4 Mar 2026 12:59:32 -0500
Message-ID: <20260304175932.255741-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to update the omtu using getsockopt(BT_SNDMTU) since it
can be updated after the initial connection and there are tests such
L2CAP/ECFC/BV-23-C that attempts to check that the updated MTU is used.

Fixes: https://github.com/bluez/bluez/issues/1941
---
 tools/l2test.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index aa05f5247c5e..48fff715f23b 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -957,6 +957,7 @@ static void do_send(int sk)
 {
 	uint32_t seq;
 	int i, fd, len, buflen, size, sent;
+	socklen_t optlen;
 
 	syslog(LOG_INFO, "Sending ...");
 
@@ -1021,8 +1022,15 @@ static void do_send(int sk)
 		}
 
 		if (num_frames && send_delay && count &&
-						!(seq % (count + seq_start)))
+						!(seq % (count + seq_start))) {
 			usleep(send_delay);
+			/* Attempt to update the BT_SNDMTU/omtu */
+			if (getsockopt(sk, SOL_BLUETOOTH, BT_SNDMTU, &omtu,
+					&optlen) < 0)
+				syslog(LOG_ERR,
+					"getsockopt(BT_SNDMTU): %s (%d)",
+					strerror(errno), errno);
+		}
 	}
 }
 
-- 
2.53.0


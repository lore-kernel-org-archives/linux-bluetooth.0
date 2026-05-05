Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F6D3D333D
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971482; cv=none; b=ci8E6wRJlOj365qolq3YHdAFqHsDac3UoIlWEFu0EWUgKQnj9r5RUdTiBFAjL2+doo4KvbMojvLeHqScub0kQ6md7uTaXWnQ5yKHJrsMH7wfSP4GD3Xy10kH8yuNAEdwfJh9RR35ze5yDyJ4Xw00mIKeQU3IHFqx/TcVfpZnIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971482; c=relaxed/simple;
	bh=KHCu8OatL2kNLnMHT3vJAvGOWngJDgvnGmiYF6I5nQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6S9bHb/7QSKIt5jvP7LmiQvtHKcp1jQaQQ6nQ/X+fyfZeAmAOH1qNVwgRKeRgtwwvToULtGOeoFUUniGRoO5Obfg4WFF/X/OveIzqWb3kAL/QLgCXIAHFJ1dzQp2hGRDcLfC5Wfe4D5fnJxW632Qmxb4LQpDDVCw7b8a40KQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CCCF3EBD8
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:52 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 12/16] build: Only build gdbus library if there is a user
Date: Tue,  5 May 2026 10:45:18 +0200
Message-ID: <20260505085741.2497401-13-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505085741.2497401-1-hadess@hadess.net>
References: <20260505085741.2497401-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTF7m1kdtbVHsZr2LXd0j4SaLCDeEFbauGG+fBV8q/Lb0JtuMjsr5muOTSEAf7igQM0Bnw8BHYljvnxFnsAmHOLly4+52VorB9b4KAmDSVF4GGxfoa10KOzkkk0FZ/iH7EudoHjCU3lQOFMf08hNxPB0Om5CXgN/JaXrD8vR0QFR6vK+BgL2HzcSZsu+faoyhdo4a67AVWTy2kRkYaFGckVGbBf8TVfzXT8T3W71rhL99sA17fK9wNykeLee1lk/s3PuiKITlPDUhdt/XRmi48jSPOFu1u+d/gMtvWUS3SjNATRBgl/nHvW2jk6XZ5zgKwUZHQGjWGUUgyPiGRUQZieqhvS+eTyupB8yJbRasv+JD0iNUy/JgdF9TaSAoTJ0pZhEm/tgBwC3t8zrDxS8wuWdDEHNsg7YR9GkTv3uOrQbSe5hpM4/BdRsKcjjyfvOdNlecolxIF/PJi9VoMBz0DnFnTSRYWr/hy/ZFWTKuUq1lTIO0UvjtxOdzvS2yAoI2o1NzyaHzCOKQXw6qZfr90OgyoHyS/kMkgs82egZ4VfrDNFW9V+EoLienNZOJKjsvvuH0ePonPXVIP+THnjvLjjx+CablVsOn9q1ANRqzNq6BBlW7AdZVSQN0J5V3rqZayOGDoZn/KQo3ICYnVXy7ffYmHE6V5T6ab1zAdfqdPrymg

---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d67abfe32430..e98e78d68e4c 100644
--- a/meson.build
+++ b/meson.build
@@ -265,7 +265,9 @@ configure_file(
 )
 
 subdir('lib')
-subdir('gdbus')
+if not get_option('tools').disabled() or get_option('client').enabled() or get_option('obex').enabled() or not get_option('tests').disabled() or not get_option('daemon').disabled()
+  subdir('gdbus')
+endif
 subdir('attrib')
 subdir('btio')
 subdir('plugins')
-- 
2.54.0


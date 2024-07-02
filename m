Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3851B5837
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930289; cv=none; b=T7s2CqLqP30ZJ9fkUznzQu/27HQQjrPLJerMtozsox2Q5cJzCE8ZDqSATLLpmFZd0q2mZLt3P3y2mlwXe+vlUdHF4bqgO+vjXR4bmzlC99wpBa7g9fjq5tF/3WA5mI3nyOg7JrQea/LrDa2vzR0T9UQ+w07B7u3wjtPEraK4AaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930289; c=relaxed/simple;
	bh=AMs8ychV2P29ai3YR75bpglgCf2JFXuMVDB5Yw5686M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMIWZxDUYU1NtFwrKPlZgI1s655OyGnAmvb085MxPWT1IZIa4D/JB/QaJbyTuztVmI+8rfMu7lg2gf9t/9H/l8ajCKAlY4dEdxXe3p2+zAjP6/zZcU6bdF+uNcVjyJvcGQWpsvzpwhBeEvpsG2x0d9e6gyi+0v9I8kShle386v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 080BD240014;
	Tue,  2 Jul 2024 14:24:39 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ resend 9/9] sdp: Check memory allocation in sdp_copy_seq()
Date: Tue,  2 Jul 2024 16:23:41 +0200
Message-ID: <20240702142436.833138-10-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702142436.833138-1-hadess@hadess.net>
References: <20240702142436.833138-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Fix a potential null-dereference if sdp_data_alloc_with_length() fails,
as is done in other similar functions.
---
 lib/sdp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index b87951b007a3..b64245f668d3 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1538,6 +1538,11 @@ static sdp_data_t *sdp_copy_seq(sdp_data_t *data)
 		value = sdp_data_value(tmp, &len);
 		datatmp = sdp_data_alloc_with_length(tmp->dtd, value, len);
 
+		if (!datatmp) {
+			sdp_data_free(seq);
+			return NULL;
+		}
+
 		if (cur)
 			cur->next = datatmp;
 		else
-- 
2.45.2


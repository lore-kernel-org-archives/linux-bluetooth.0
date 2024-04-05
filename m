Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397016F84B
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329480; cv=none; b=sSIfMoA4P3TpzxmQGK3KRPVvdK/AqJ9BNlT/9hVSrq+CqKbxAjz6JIc+4BXGxIT3iev3UeQGVyGU4ZHfPXXkYm4fqBI6pIGOKDBZGeCmOf3EJflhzPjVko5vJB1mKZE/uUGJb1vdUO++/Y1rRFRET+5RFpurSAgaNLrUaPokr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329480; c=relaxed/simple;
	bh=oBYiZuw4EXH6CclXvwVXPz++tRo1ZT9usZqsMq50P3o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WybgzgCrxxJF87RqtYPVdPBK7UNdxLGppxEWaluIrNXg5OHV1Ig9QSgGSUsNamhYKP95anaaZSYkA2weyfUZ3tJsiGB7LBbtZ8az5ylxusm7FcQc6eTC8e0AYNeO3rFVGck0PkFV+MXl4xa5FiM9A+8LU0fXVqmObT9Ps5KjVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqFsn7T+; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqFsn7T+"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22eccfeee22so514711fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712329477; x=1712934277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xhyNVQ9ZSEd+DznykOtJOMpyp8tgw0j029Fgjisiwo=;
        b=bqFsn7T+x/c7hj4ydcRKWIZWemOhgNAhxQHbYomUHam9o0HO3olYNZM+ujX+QSwr5y
         BXqbg88aH0VU2oDfFiVH1an9NBQcWTaitWYVYELjj2BI3xnoJ0qHcE5foIrQkseulAFP
         WfmQDYcOazZwufTYTd1GfbHVqdL/YFJh+T0sazf9OUdWpg3AaDfpAMbA9i6RvfqjgCn3
         WsSKUZWHMGRsL3KMn9srURdfHpAPGtR5OHh0MtaXJFi+r/c9olzVLdEsrWzuYsmggoF+
         mIuXx7wjWdko4RwFF/1+Z+lJnBT/q3jkdX+G1dwngcng5eR6bBKhGzTzUwzrImcG/45t
         kznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329477; x=1712934277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xhyNVQ9ZSEd+DznykOtJOMpyp8tgw0j029Fgjisiwo=;
        b=LaXkJQdzIhsSlW+ezknFsdwm7ovFkEEE1vxNGzobBuEvb4+0HZau6xavw87iOQbwdA
         bK7w7Gz2V8a9NAT7a8htMoblkLEuN+db8LIhH+Krn1ZeYn8CMhL7oXhbgsXO9hVyFfKz
         djk8my8yEgXBZr0smVqLmKzkQAWZPSBrL/tIlH1UsD23SQBxw8ywuFbJLPS8DAOGSr2G
         Avqpu+G60mLiDK7POeGa/foR4i5oKOoe6zFdfSKvD5uLi4h+ReyXcUyCpfXKa1Ddgmuf
         GzQCNzX7IdcGdRn6xw2J/LUQKcIzg3NHLtf+2xXnLjaG9DYE09Bu1Oc+1dR5IeQGSk5P
         wtWA==
X-Gm-Message-State: AOJu0Ywj8LrAwLLKk2iyvMOjQhHT8nMrE7YSLpHAxvuWw2gyhHLHZL3f
	ZEJmx9rfngliD5KOG3QpejUmS4KLpP/efFFcwER4JTBVFq8oLBelzJ4idtml
X-Google-Smtp-Source: AGHT+IF0yySSTadtBjG0tQQE2ifzimgK/US22rZmR7LyQMHy1fVf/GyPxVYLS8pK0WlFjTexBeqUeQ==
X-Received: by 2002:a05:6871:3211:b0:22e:c08c:b1cd with SMTP id mo17-20020a056871321100b0022ec08cb1cdmr1407217oac.3.1712329477587;
        Fri, 05 Apr 2024 08:04:37 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id l9-20020a9d4c09000000b006e82f65ad4esm306451otf.11.2024.04.05.08.04.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:04:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 2/3] input.conf: Change IdleTimeout unit to be in seconds
Date: Fri,  5 Apr 2024 11:04:31 -0400
Message-ID: <20240405150432.3360157-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405150432.3360157-1-luiz.dentz@gmail.com>
References: <20240405150432.3360157-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes IdleTimeout unit to be in seconds instead of in minutes
which offer better granularity.
---
 profiles/input/input.conf | 5 +++--
 profiles/input/manager.c  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index fc20c58b6b32..273e15bc9c80 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -4,8 +4,9 @@
 # particular interface
 [General]
 
-# Set idle timeout (in minutes) before the connection will
-# be disconnect (defaults to 0 for no timeout)
+# Set idle timeout (in seconds) before the connection will be disconnect and
+# the input device is removed.
+# Defaults: 0 (disabled)
 #IdleTimeout=0
 
 # Enable HID protocol handling in userspace input profile
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 92789a003c89..f4598bcd4e47 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -89,7 +89,7 @@ static int input_init(void)
 							"IdleTimeout", &err);
 		if (!err) {
 			DBG("input.conf: IdleTimeout=%d", idle_timeout);
-			input_set_idle_timeout(idle_timeout * 60);
+			input_set_idle_timeout(idle_timeout);
 		} else
 			g_clear_error(&err);
 
-- 
2.44.0


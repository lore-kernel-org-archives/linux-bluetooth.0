Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0462046AC
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515300; cv=none; b=N+xAm4VHitVjzpixYMCMojt+rHu6GfYJv6faT4HZKut7jvqsaYz+5GBubYZi/OZj2WOU6SzyR0iGipftOFldCXm5VL2D2v09C8Jsrj0S65zTYxUnE7FftQ9QVOajiLhfSiN8XnU0QVs05oDiUOZl5U7gWSfFMyVynWzSX7dwjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515300; c=relaxed/simple;
	bh=4WhEMBBGqWCUlwmCT/jMtIYJ5f2f+VB8cH5i+u35PII=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZqZTEVjwKslc5i+TEu/Hdet0mtVo9gYbQrW9LTv9R+TUeYjZumNiAowSw2qdB+++fUiFqVZJNd7fj15OAUaCFCi2ReNPqkh2tCAI3UNq9J6CAzN4mQPX51117BxIHGAJ6WzTSYTh35csqpWgusE8w7J7ZmyWQswFTpZGUb79Yxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZUESLXz; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZUESLXz"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-524038ba657so5516682e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743515295; x=1744120095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gToIK2PvaFY14aeRA1rIWW0y+Ql+ARxVjYhq/EWykEI=;
        b=IZUESLXzh9leQ4jFn1/jROo6aa8bN6BTWNWnJlcKpBPCqmHn0/a45KvbwDmPquVFLX
         UDnvmU3Zg/wHr1/7jWfl+84jNM/rl9cqcZmAowrH8yXrliGcS2uMGCLDtm1L6Wyg36oR
         9YRHFYtWqJ+v9Ms56eqtQc5a1z/O8R/SEe3R0DmI2/D/uFlQFGQ5ratqlqyauhfBlBPE
         8/Xr5Cyag4gdt6t54rqf43hK47D7dckezLpS6KGsVv4UKcpLBVCuh5q5NkDAH7pkqTgu
         6u7pv+YupbRodWq/2TUQYpktFsvKt/2CN8uFEWITx4CMXUyk0IaumYyCc8etgp8EuXeJ
         fu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515295; x=1744120095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gToIK2PvaFY14aeRA1rIWW0y+Ql+ARxVjYhq/EWykEI=;
        b=PAaHLOzo82nwh5Hh9js+lE/COvEL4ezxAOOndABmn0M3mr7DHfLKR9RIPBqrGs4BHH
         xnrb4wrhU5sA5t2PMtyBanhoCcZgRV11vLWrHn+1Vjr/uUHTZ+lm1hh9zT7FbP6GzN53
         88N5zeqtMC/GfKhj6llvZpN3QcoaoUFrEuK/hpjl12srgROIszovMzB3Exfcxrm/VF4v
         41WV7YdLSnQHA7HokyCEyFxSqElzvBsq1Ma/mWvgBhRI47LmAfo4H4JEET6rxAPs2Zc2
         SWfVOMdoL6/30R75aCfJ8hJPeJk646I61ClDESfE1XP3+3jfiPeaIOG1SBlbJCImfzjm
         GnSw==
X-Gm-Message-State: AOJu0YxTrviHA9ehzQjyGgSRDG11MCUtWIQGNMciwnTsvvwSC7c2ktNn
	1eYwp+GaTHHv3kIsdmIw7lhjOKFjNb8NhZHq1Cp6bp+eTYL0vSxYAKSj5ogc
X-Gm-Gg: ASbGnctqA0S2LoAow00SbOkTE84bEADD3VF+vPmU989FMGGuvXjqwK9n3HKWpN2oPe/
	tE3SfV8cFgCCGdHAsaRu78u4j1DRp4v0v/xMEOuWeZuZ7Kfuz/6gsYc5tD4/i7ZyCrdaWBEVUUz
	bDTSvodUvFHyJGDBWKu047rlzDXfvZ2ZIAwKDNU9sEVQrNOvQ8RsmU8NWiCjUNZQP+EkebIvLmW
	iBIvLWgH/L5aeXvjYv+BJdyPWBm7Z+76KBb+WFgP9nhIcOYn/zRCYmuq8Zx19Ws0U2SBw2Dzn2l
	eCpOxXVBQ/2erhFmrXVaqf8w//HpfX4utu3fv8kl/1O+580I7peTJH78SHbE14mkr1Vpbc0UwGC
	H6DWr+lgOrcEnNA==
X-Google-Smtp-Source: AGHT+IFQbjx/aySnJ6XNMz1YK9/GMd63BZ4W6M5jj6gUPrxX/okkmBMFgTkBB3hlGGSbIYWx4wkHGQ==
X-Received: by 2002:a05:6122:1829:b0:520:4806:a422 with SMTP id 71dfb90a1353d-52748050a4bmr9854e0c.3.1743515295551;
        Tue, 01 Apr 2025 06:48:15 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5260e6a0cf6sm2011965e0c.8.2025.04.01.06.48.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:48:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] dbus: Fix condition for invalidating path
Date: Tue,  1 Apr 2025 09:48:11 -0400
Message-ID: <20250401134811.3720865-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the condition introduced in cdd02afbb7ef
("dbus: Fix add invalid memory during interface removal") which was
reversed while applying the original fix.
---
 gdbus/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 54e04b983a98..f8c694aaffdf 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -810,7 +810,7 @@ static struct generic_data *invalidate_parent_data(DBusConnection *conn,
 	if (child == NULL || g_slist_find(data->objects, child) != NULL)
 		goto done;
 
-	if (!g_slist_find(parent->objects, child))
+	if (g_slist_find(parent->objects, child))
 		goto done;
 
 	data->objects = g_slist_prepend(data->objects, child);
-- 
2.48.1


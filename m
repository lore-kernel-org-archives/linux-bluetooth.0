Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B6A2222C4
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056128; cv=none; b=jwvnI6yokfA39n8D8azNd5wqpuIIo1f1kwo7jKU/iuZN7SxZnqke8FpXm9oqIe9LWoAiOaOWD+8cGlINqdYLoqQiSPoC1gHbconsGsBCBT7fASvGcKBJXKZJQMSyN/Y+YEvxm5KnGOx/EGQxrovNvX7FqPwFGuzNEdbmhkojUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056128; c=relaxed/simple;
	bh=PgbhRObiC1Xo5WN5NLu9N8o0fGCltXCT2cK67EZgONs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2Ta+2lvA0L4RpG45arTETS5NGGySRBTmeQRAI7YZ5fuqKiwbv/EfQGMurfcQ5dr+d55sjHuw/xF1lWvH3GKTI+7S16ni4AhwK8Zy1uXChxyZeRKUh/JInQn28Et+Q0rdpabzyvD5A5eRjMnNvRzg5NRmfwU9i6IhMYyzhrD3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QghaQe2X; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QghaQe2X"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d3805a551so2061983241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056125; x=1744660925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZ8URkVUm4xrDQ6W+Ksv8SyeFtQqiErCqkAYQsiUZck=;
        b=QghaQe2XgbSqmIDkAmD+D7ptJ/TAwyWCQIsCPWOUhiYAg5z6dQlapQhl4iIBD5zKf9
         ROW6vYhhPG3ywcWvMZha4UeJ25AwrrqfdZt+EZmS8DpQZN+u7TYgL3mfIbJa2YfrEQXG
         LMw+DrUkQdj5Sd/owqXrsmAYs6apMBRQm2eLKWxQW4psC4bpoKUydoxajKEITOO5BOOv
         NGc2kLs+maAqKLHPqHE0AW8S2AxxcHvqKTQeTYrXEiVCKvzvts++l/D/WyBlUNVj6atK
         He5FeFPc8HsZIxMBZzMA7UXO60xHpj2j+ciGnJHKZXIAcXNFR1Nx4jEyjG6xaW8ue+Hm
         YvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056125; x=1744660925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZ8URkVUm4xrDQ6W+Ksv8SyeFtQqiErCqkAYQsiUZck=;
        b=R6vWy3S/q6AF3GjoeAs55RCX74cN0RItbnK1yl0iJw8Aa5QqlRBO9pDiWVIGlFoGt3
         e5vE879yrBFQz3ppm502YPuJrpe7sfRFB+hPmpEqv3p4Rl0QaTz/u03mJrfAvbxs7Drs
         1wjzi1oCLFWnnlMmIaYuj9tL/HUPCXLg4HBYx5e985vrMQueyupBoyETS05ShJ18Q5rG
         R0XWUakPpZ0swZsrY1oPaI2bz9JVZLtiwsiReO1m6oNDefPlGYNoKkhw7NpmmPt2IJr1
         pv7yi8wLBzZT1het4fwgbw0RbQMKGjKYjx1qXTZubUwtX7udT1OvQD/k03Hh14ecwLpt
         DT5g==
X-Gm-Message-State: AOJu0YwjCqgdiTZacgXHaGkM+k22RYXcM5FjMe7O3TzOZyqrQw91YxXW
	Gm1zOs87iFqbTeIoWfXTCtb1tVrFz+fIlmGIfHB51XgsAszm5eeaXO8YDEVM
X-Gm-Gg: ASbGncu7WUzdEqdWo2r6q3TyHeCpkMfc337FeC8o6RVWcXtTkyjgMLVZ3UWeZGZbJa4
	QuEZ/COH7ouYMPM5MOci/vTHxBiE2g5lmTfzkL/Dr92wXSWVTuey1XMLr0n2ke2IHSmzTs0dl9X
	t7kJPD9Asv6/nDW+vlfyS9K1WaKLrVxi3iC/iqsNiFkZ8Fu6lUO+iu0rM+zaKUJ6Rne5t6PAQoP
	mkX1LbQIM5BK5JaBLKuZweh72s+KyTrz3c9lAamwCWYoM0Pzdg7NuB8wRRgY31xBbPCLJIFK48P
	5z6GYOJUGQ9EOuwrP8nO22uyZ/jglFbbZKEjDoefBkKzg4qxza0Ak1f0LYc5iKmmIsRK9uLpQda
	Kbvi+tqvtYQE55w==
X-Google-Smtp-Source: AGHT+IH0yw5UNjffUlaIo1KU084kqYXfTzldCovRZZ6W/P/T/jcN2OD0HpPT1JjvkSJqVojSaFWZSQ==
X-Received: by 2002:a05:6122:2665:b0:527:8771:2d39 with SMTP id 71dfb90a1353d-5278771399bmr3217408e0c.7.1744056125135;
        Mon, 07 Apr 2025 13:02:05 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.02.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:02:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 13/15] shared/bap: Fix notifying with the wrong state
Date: Mon,  7 Apr 2025 16:01:19 -0400
Message-ID: <20250407200124.881534-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407200124.881534-1-luiz.dentz@gmail.com>
References: <20250407200124.881534-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

stream_notify_metadata is reused by a couple of states so it needs to
pass on the actual state to be notified rather than using ep->state
which may have been transitioned already.
---
 src/shared/bap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 76f221102dc6..be35c2e60911 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1088,7 +1088,7 @@ static void stream_notify_qos(struct bt_bap_stream *stream)
 	free(status);
 }
 
-static void stream_notify_metadata(struct bt_bap_stream *stream)
+static void stream_notify_metadata(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
 	struct bt_ascs_ase_status *status;
@@ -1106,7 +1106,7 @@ static void stream_notify_metadata(struct bt_bap_stream *stream)
 
 	memset(status, 0, len);
 	status->id = ep->id;
-	status->state = ep->state;
+	status->state = state;
 
 	meta = (void *)status->params;
 	meta->cis_id = stream->qos.ucast.cis_id;
@@ -1738,7 +1738,7 @@ static void stream_notify(struct bt_bap_stream *stream, uint8_t state)
 	case BT_ASCS_ASE_STATE_ENABLING:
 	case BT_ASCS_ASE_STATE_STREAMING:
 	case BT_ASCS_ASE_STATE_DISABLING:
-		stream_notify_metadata(stream);
+		stream_notify_metadata(stream, state);
 		break;
 	case BT_ASCS_ASE_STATE_RELEASING:
 		stream_notify_release(stream);
-- 
2.49.0


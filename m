Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164CC1F7566
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887729; cv=none; b=mGE7lrLWoOOTfzKTM4AqIPrdtZMnuaUB3IsQEzPKG/KWLfw3QRMius25FaM2Dbr8xAFOR4AsLqg4bVAq1rin3f0C6+ZfuHVnXzCOFJg1W6FvBTfAjzMDoNKl8WKwPnQN9Fy8QFs//ptgUBJS+l/0soNKkJ7LHOdvu1zS0SMvg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887729; c=relaxed/simple;
	bh=l0XdraoLz9j0lCXsnjuGpc5MvupNHJVv1KTEkLe69j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYJAnXikbqadn5v+jvu6Wz8WP6G9v5pxIjxGgGQKsZQVzC6QFLK6qt4FxbBFMQ372XgqzdRyftU38fZGTskgn7a5OBOAI+VzYujEqr39qmuwPYt9PUfrSvAEQmn8yGVmH5eoRM4meW6gU+I4UxLlv2o3CBtc2q3D6yb44p8+ikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com; spf=none smtp.mailfrom=igorinstitute.com; dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b=IGxeZDEQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b="IGxeZDEQ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71ec997ad06so1755544b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20230601.gappssmtp.com; s=20230601; t=1729887727; x=1730492527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aICNTXl5G5zGWiYVH0GxewweJH1V4f1rzTrocvL9Drw=;
        b=IGxeZDEQEMyOVpDrBpyioc6+ohAo+I7u9jn0XQxSGszHmOqlVl3KukJiebF5XB+XD4
         iq8FjMRxO5FpHuWkZl6nAeKgg4ZiExTZnkSgknfAg8bBiM0KbHRCNx6yNSezvMsAooQj
         DPt8+eQI5geSKYQS4RwMjPYXRzuwo+QG7cciWzFy2WuzaPZQcvqieENFCSavAMVHxnQq
         FkWWvM06wrp54jY7xW5XAovPOb4jURWQqtLHzzjYqj+0c/Z1Oksuz5KbOlRTDmznx1U2
         e5x7mqQ+6qAHuy3ZPJfE4TjWw3+YJqrJ971z/mV8Rh4OC2CKhT0dD/iYTuuiiBE8JTCO
         UktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729887727; x=1730492527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aICNTXl5G5zGWiYVH0GxewweJH1V4f1rzTrocvL9Drw=;
        b=mndtBpAubDuf6LwZBF4cpRY20d887Ov5VCDUqO5+ltEyrol56FJq0SSASog3hS0hT8
         VqoCzSmvBMquwT0wVDuurQlMVkEeeQ0Ho202ibB3GnwbSm3wdHm1kC5zPtYYU798L7/f
         fqDC3+NMqvaFeXsj3Fvl/COyRDaMAK9fYIZ5uejWdAGAMagntHps3bQnrvHyqVGl5h1k
         3PPUXCzNFegGLpR2OnSXnOCNv4oxQOToHuWxZR2ooYKrBHxeCydSlUUaB3kVF42ZM9n9
         OHkVlrmZbnZbGT0Ma3F3owTkYaFV59n8b/VrYXeE+sX3USuvN9A6BbrWR/11vXqBkvcI
         Z1dQ==
X-Gm-Message-State: AOJu0YyXdQ/dVBBsVt7TDD/gXK44rOk8yVCoSfbwme4N6qaaBLBsZOoh
	zqOdNf9qhJGfJ7KL1YdtY3RWCWFSlI9a3ZGZL2oePxbGnzWznZv5bvLW6RlA2QCdr2M9yQLKZdS
	u93o=
X-Google-Smtp-Source: AGHT+IFTEFUwK7V3xLw4DjjJOUBaB5yaiYta5B5vRKhfjOrgG4mV+Vm+yDx81bp6Xt7D07CspgAzBg==
X-Received: by 2002:a05:6a00:845:b0:71e:7674:4cf6 with SMTP id d2e1a72fcca58-72062f8335fmr1025898b3a.8.1729887726799;
        Fri, 25 Oct 2024 13:22:06 -0700 (PDT)
Received: from localhost (118-92-78-251.dsl.dyn.ihug.co.nz. [118.92.78.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931785sm1469320b3a.50.2024.10.25.13.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 13:22:06 -0700 (PDT)
From: Daniel Beer <daniel.beer@igorinstitute.com>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Beer <daniel.beer@igorinstitute.com>
Subject: [PATCH BlueZ 2/2] source: clean up outstanding AVDTP requests if the stream goes away.
Date: Sat, 26 Oct 2024 09:21:41 +1300
Message-ID: <20241025202141.158946-2-daniel.beer@igorinstitute.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
References: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the stream goes IDLE while we have an outstanding request, connect_id
stays non-zero and is never cleared via a completion callback. As a
consequence, the profile on this device will never be connected
successfully again until BlueZ restarts.
---
 profiles/audio/source.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 9fac352c8..db777e86d 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -134,6 +134,11 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	case AVDTP_STATE_IDLE:
 		btd_service_disconnecting_complete(source->service, 0);
 
+		if (source->connect_id > 0) {
+			a2dp_cancel(source->connect_id);
+			source->connect_id = 0;
+		}
+
 		if (source->disconnect_id > 0) {
 			a2dp_cancel(source->disconnect_id);
 			source->disconnect_id = 0;
-- 
2.43.0


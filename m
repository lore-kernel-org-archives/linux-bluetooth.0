Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F468526A
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814634; cv=none; b=UcOpUvVA3fZKZ/xWSzrWlN59puUscqvaVh5rPsKXdy3A8RtOF6GH1qwoau2yKVDiOMTkzSyqeQ8mhkkimhA+8712jCVfq5BUBblS2mXQ12mEkJVJjkXiw3mMg8+Ul5VJzRW57zDmMKBp3JKFgDPXIsNElMVBW/cnhXPyx3XQwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814634; c=relaxed/simple;
	bh=YtUoUoBrhRocQ2Ss6fStMsNtC+W4fNfPhKPHhIahCEs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmW5H2/bj7JyhZ21oW3XNXMdCh7IauydsN/H7t8CA3VU2SFO0ztctsCEnwMCT1DS9pb3DK+y6u3434xr4vNFi5e4nxXT7i2R/iXlfXsOunruWjj3Tc504su2VflVH7Gjj2CNFLHYrcZbExS4geL9sm5xkkV3iCl9OvfL+MpKl54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxcmohJT; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxcmohJT"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5bbbe5844so652190241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 11:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814629; x=1707419429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5hnVXQvWmjukNR4Nfm70AbPyy5IeGX3k1DvjsBuGHc=;
        b=QxcmohJT+08fdWDqHzlLVHUYoc2c6UzZmWMYgwvdRssh7VOUC2k2BPfvrT7fiaH/XL
         XrJhbBLKjSkTq54clIH0scCAqeydoUcM6ZK95sjA+mOi9YBozeU+wV7tUPDKKlsOqck+
         /6ZMqOQZbmSAkGgv+5AhEA4Y21EddfnjUoEs+9H+9xm/TFLcYzg4x+FSdcnAWhwzkTjm
         hpoWM2Ajl5hz3eWjVw1fwXpxk2j3Wr6+WxCAQ9bd/WM8F6ukJsG9UxTbdgrdyfYxuV7P
         fhsRoMokoT9SA9blVqGV6tRlanGUUtAOd5+fhawZmTScxpihk6VN5dOnsSu/4BVnNAA+
         SI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814629; x=1707419429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5hnVXQvWmjukNR4Nfm70AbPyy5IeGX3k1DvjsBuGHc=;
        b=PYU9ICcMpvbmasetm3926tr8LqhdD5mb+GBbIAxtRmsv+4g2U6ybyKWS/rFeVHv3P3
         9HBiPj8eSwjhpqj6YG7vDHz0aCpycYbS9R0QtU9e6cWGKVo9iUXxGQq1zAEU2mFkUrZk
         Uo8b3JuwyH+UL/yGwiJ39+cMbt7AEk+kEYxQEKMbMgKOWa5bGJbxLNOZiG7dF+trG6ia
         9mHYCA30bX6b3hPmr+fK4YjDKFHuhPZ+XzZepOtSqORfPCyW087Be+F+oO27/mSvMH9n
         WlpNikU8Y6AB9lmrvoR3+df8shxQ+b7UBw6YujzSyPGAgC3PUk21pQfkdR6a0K0ZsSVo
         lxcw==
X-Gm-Message-State: AOJu0YxCPFpu30Z8saGtuogZjHR1vKL+/2eHXR7Ce8O9Zzz4JTFVqWiK
	Gr2QX3gRlEHDXFex6QhtTaD9CyS/IQmf44tmBSqwntfuO6wDyErcEB0hgzkP
X-Google-Smtp-Source: AGHT+IGTcflhxIcx9TJgWOc6XV5ik9OyKHls0pVY4J9/7aoaNwGFZAdEIzEHqqH4p1Eb1QNV4d6VXA==
X-Received: by 2002:a05:6122:30f:b0:4bd:8029:6700 with SMTP id c15-20020a056122030f00b004bd80296700mr5002231vko.16.1706814628099;
        Thu, 01 Feb 2024 11:10:28 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id db16-20020a056130239000b007d2e2f14bd4sm35912uab.29.2024.02.01.11.10.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:10:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/8] shared/bap: Fix not being able to reconfigure Broadcast Source
Date: Thu,  1 Feb 2024 14:10:14 -0500
Message-ID: <20240201191016.1122194-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201191016.1122194-1-luiz.dentz@gmail.com>
References: <20240201191016.1122194-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not being able to reconfigure broadcast source due to it
being in Releasing:

bluetoothd[37]: src/shared/bap.c:stream_set_state_broadcast() stream
0x8919e0 dir 0x00: streaming -> releasing
bluetoothd[37]: profiles/audio/bap.c:setup_new() ep 0x8802d0 setup
0x88d3e0
bluetoothd[37]: src/shared/bap.c:bt_bap_stream_new() Unable to find
unused ASE
---
 src/shared/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index ce8d35f86af3..f2d2ca09bb24 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1379,6 +1379,7 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 		break;
 	case BT_ASCS_ASE_STATE_RELEASING:
 		bap_stream_io_detach(stream);
+		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_QOS);
 		break;
 	}
 
-- 
2.43.0


Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D3C125D6
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754616866; cv=none; b=u+nUR9U4ab8PmhuIFiB0AWbtXPZPMCO6StZ7SBjrvGIWxuIgDaLiF28yKS3GRmyCJRPJd9QsYkAf2VhuMJqSfM3VUsQXoGeoNBCM3xBB9uQr1rcRLpA5I7q05cnfEq9rgxiVuCZDtfBHJBomzV8GIteTN3I9UZJgEaLUpxq7NNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754616866; c=relaxed/simple;
	bh=9KJ318Tcsl6QU041FAxqhl3hAZg9SZ6lcfrqmti0bwM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F6vdDXMTaBLUcNhiKHh5v1t5DepNtsl1IOum3N8U1IATUcR9h1H+3jGiYKwV6WCZa++ZTr+6o1MCgDvbhPGr70kbrLPT9uwGzCVKrfccB0RZJsRmD392+2xLy+6iuxQCtmDPcDgSu64fDfAUGZcCm0zNjoVw2IYo7O3K/QBrQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0JhMIQT6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0JhMIQT6"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-242a1390e9eso32800225ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Aug 2025 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754616864; x=1755221664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=owidIAv6qk7lLwiRC3yUjTDMVg68RBg/1Dy7JWmHqi8=;
        b=0JhMIQT62C1zASnbMbeYScJZG3kR2S6AJaANHrhCC1/D7RiX5U5ltaKmSqN+KkrZA/
         j+WmviU0bvDwp97h0c1Nw7NAVlZ5cJvU3fVIW0LKr2dS+eg+Ak+qM0+SSFcgPVjmNZWv
         FofiSfpmylafpzx7WHY2vhS+CyeO2p3wn0ywPFQTT74Io49DXAZ4mUXiYAw9f7JCqGEA
         BIAa7Zclz+Kv5hxbtKoBoZxEfHxN7cAf/bdgHW2NO3Nm+pXbEcwIusRahs+iQ+5RyEvQ
         9DtvcW5za83nrn8+NHKf10c+RsYFIBJclAbFr1GsNKo9IfATPxWcKmWNmCmJka3s7M9U
         8/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754616864; x=1755221664;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owidIAv6qk7lLwiRC3yUjTDMVg68RBg/1Dy7JWmHqi8=;
        b=U7w0M0aQRwS7qGwscthCt7UhLiVDnT16oOvo48uZay8imde5uQCyekByCQqbds09h1
         TUDawPSp/rcgLqJBSjBxNraIb5k7acvaow9JTqClRukWGduTrIOKMvpQdT1pM17ZnhT1
         Ix6+3K3VvGhR+ZmEspfxZ4O0ZTtzhAZ39Z+Otu+zk2i39AQXVMRJS4suUkRt4jekBVxh
         qW6XJQzJ0JxJachOFll7JpHb1FcgAGguthC7dJxaGVrvHPayyciPpV1n/AwrNDC6MGj5
         tVYbOjI2Y6JKpcEZpyAiIXkFc3f5C95tbWoGb/NJk9GbvMiW+d3JqZddJT+G5Q6zAp++
         Nqiw==
X-Gm-Message-State: AOJu0Yyl7IXOIUV2Qgt2RL5WybSTfKLsN4ldMXqo2IjO/rv1+xnDQY1u
	iosmaGdS0CKAI3PbtikzYOqIH2hUzB6smWXxdQLfYF7zEfRBzbdieG4nQA/SRZXiMh+7GclmtN3
	6Aj1h24ZHh7WBzZHYTn5TI1fHrDTVMKHpsvg0RW9kHA3koi0LB2cw1yLnzutBBYLWOUGpnyOPtz
	x1A4ze7U45hKjSQa+nhjw3To33KAIKi8siBl++vamBom4kIFDX
X-Google-Smtp-Source: AGHT+IFyfLiJULJiw2LI1JP9NdhjwmeX6Pxc2HMA4aPIR9mZfbPajdXIv/8uMNNxadVXcN0A78dKAVTtAuM=
X-Received: from pjyt9.prod.google.com ([2002:a17:90a:e509:b0:31c:2fe4:33b7])
 (user=ochang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecca:b0:242:c66f:9f80
 with SMTP id d9443c01a7336-242c66fa504mr4342765ad.53.1754616863902; Thu, 07
 Aug 2025 18:34:23 -0700 (PDT)
Date: Fri,  8 Aug 2025 01:34:01 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808013402.548986-1-ochang@google.com>
Subject: [PATCH BlueZ 0/1] Fixed a buffer overflow found by OSS-Fuzz.
From: Oliver Chang <ochang@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: oss-fuzz-bugs@google.com, Oliver Chang <ochang@google.com>
Content-Type: text/plain; charset="UTF-8"

This fixes an old issue that OSS-Fuzz:
https://issues.oss-fuzz.com/issues/42516062

Oliver Chang (1):
  Fixed heap-buffer-overflow in `compute_seq_size`.

 src/sdp-xml.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.50.1.703.g449372360f-goog


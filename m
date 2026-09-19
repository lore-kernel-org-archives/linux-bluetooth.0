Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0D485943
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789818905; cv=none; b=s4R1x7O25gHStJw3Th30HRtxcxpZPDdMPivp6k6DGMCqrHwCNrfOutRAvKiRiOFazTCgrwVOowU1AkVdVQBIw2lRwQk8MaTzqKjVxJoZ0KnhrHIh5aRNaJ4lBhmcxfl/AWhNl4Zh09rbWZQNixz1OdIx30ZEQb9GH8zxdn4tb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789818905; c=relaxed/simple;
	bh=0gsHMzOO4cRcCBVLdHgl0Sd1gCQeYtv2YaNf+w50Z8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GttyRg3iFVyyNsjsrr0WFn4MONsHBdJUBbXZwZEYiVSdFpfVnl6WakItk6AudSqmlWWVOvlTYHnoXDRBM/sn5hPxZ7jPgt0esG9YVhJhvQjrUNX9JXHMLmPHIUP25ZX2gp8tMxBOJQCiAH8tXyaockul1NxVOXyUcff8Iz215SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaSW7N68; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaSW7N68"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ec6185so10098815ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789818901; x=1790423701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M2KopMb5MO+iQvHKojzedzUOkJZuYo1aJE/N0iz10Ds=;
        b=DaSW7N68seEmrIDmnWLiwtIyBQ6+ZJ6BkgxHFSHcmA9Rpa54z+/qw8JXdiRM06Z9BK
         YdfCvN5KFoHItI8OsVcERdCaP922ijG9UrYAfxPbyz7hF+r89Jrd85Gb/lH544nI9Okt
         VwBemtnMj5aGkT2d5mfLptpbFpP08nYSlH9+6I6ITy+wbmT4s59OLfE/40sceI0Zd9lX
         9H7x42jJAb1HsnigE6MZMX7/ioTvZt/3oyONa5HfZ+qwJMihBUwMxQUi0npx1e5xAsXK
         b7DGRgRstzy6JgVFMgMQZxiWhj7z+2/+YIFedpjSOnqNBr2KOnsj3NDna9WcFh0wZBdl
         HTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789818901; x=1790423701;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2KopMb5MO+iQvHKojzedzUOkJZuYo1aJE/N0iz10Ds=;
        b=AS+yvDI974aGFGRK79PAAe+Td14u1kK31iLz7NtUGjlRmVC0usY4/zGbM8x7tKSvpc
         +WiL+EFZRSXZaRDfQQjBzpJ5aJFQoa8eyRUBeok3KwqdDIqV2CEZAzk0Z5XSzvDlZ3z5
         zZ4EeO4F0ISFv4VP6yZ6RxW2cTXVi+dXguzQYofKI7jukIv6/7n1MkgsdXHdJiepovrP
         yYENhpTqDoVySiYkbiKxWkvemBFfrLVmRIiwpPVidXuWt8j3kNLDSJx1XaY+g65fPuQY
         T/z7Pmz3SkYXc1eAMj51A/lUtgIJY98RynzVafbSiV4Ut0cbhFN4QImsg2R+PwVnNd/F
         k16A==
X-Forwarded-Encrypted: i=1; AKwUvByO66nPNarYH5q1IcCT9f48Mybweujei6mGh5vh6/MtC4h7kUErbjdsjYM6nRYQK6O5i0VSzhdsKO9FznNwMzU=@vger.kernel.org
X-Gm-Message-State: AFuF++m9f/XWuaqpx7PdXSPKCe3UWS21PaorVcuJJnc8mywH33uHc4wd
	wIqXxCk3zM1c36iFun2G7bkS/iCzr2Eq2WQzieiQa9dMI3YvejQIP++l
X-Gm-Gg: AYBFou2qjBTCH1yPe/zFAo7xchSW7WyHtePF2nvxe1PqNaLZ5rk0ozdeyctz/kyRUco
	JLlrcSyejJdHbHgX14jnAWrLX9FR1sOGjFXT6X2rz5aFPC9KZ9syTmRdFQQjqUcL5vWC/ZmsO/q
	gTaq+rmmo+XfaBrk1ffYDq8BtUaen/chHlA4gqE0uwxsq2CnGz1uMrQHv9uA49UuB8uUcDWs3gA
	H6McsJt4L/JS0o002ZvGVN3r75WpoEIMw7+KPVAZK5hC645auJFz6mPmm0X0Kt/zGBKU2extIkC
	RndFH9UryhW2+uOuj4DLiDNTl8F7lYu/zJOI5KnwPr+We51Z1et1qyjJWLctcd0dwPAzbCQbVBb
	vEZqbRguKw8PBfVLB9wpNdvKqMC9ygpYDyXr7jEP7wtTX9bUP/TJJM/Etdpe8I4lvIURHXu4OdL
	qBerns8x9X62VZGWKzzTB5znPYAcWdJTcU+pMMDK4G3W3eSTEVPtGY4pla7LNskSVsXdvTyIU6g
	f0zoFQA1Xh67dHTM1ZqCeZx8L8XNJzskXNgw9+iKY7F5pwlYa7Td8sa+yKc/XT/LnvGwV+NgTZE
	q3l1
X-Received: by 2002:a17:903:3205:b0:2d8:f965:7e48 with SMTP id d9443c01a7336-2ddb1ab3990mr103667045ad.1.1789818901377;
        Sat, 19 Sep 2026 04:55:01 -0700 (PDT)
Received: from phui-2.c.googlers.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc15deea0sm9653685ad.0.2026.09.19.04.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:55:01 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: lee@kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: MGMT: Fix mesh_tx Use-After-Free and leak in mesh_send()
Date: Sat, 19 Sep 2026 11:55:00 +0000
Message-ID: <178981890089.4001113.207387311305810171@gmail.com>
In-Reply-To: <20260919112517.3871992-1-benquike@gmail.com>
References: <20260919112517.3871992-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please drop this patch, and sorry for the noise.

Two things are wrong with it.

First, the mechanical problem the CI already reported: I based it on
Linus' tree rather than bluetooth-next, so it does not apply.

Second, and more to the point, the use-after-free half of it is no
longer needed. 71af682ba469 ("Bluetooth: mgmt: Dequeue pending
mesh_send_sync entries on cancel") fixed that on 2026-09-15, and fixed
it better than this patch did. It dequeues the pending mesh_send_sync
entry at the point where mesh_tx is freed, which addresses the problem
at its source. What I had done instead was take hci_dev_lock() across
mesh_send_sync() and re-validate mesh_tx against mgmt_mesh_next(), which
only narrows the window for the two callers I happened to look at and
would not help any future path that frees a queued mesh_tx. I should
have checked bluetooth-next before sending.

What does survive is the other half: mesh_tx is leaked when
hci_cmd_sync_queue() fails in mesh_send(), because the cleanup is
guarded by "if (sending)" while that error can only occur when sending
is false. That is still present in bluetooth-next today. I have sent it
separately as a one-hunk patch against the right tree:

  [PATCH] Bluetooth: MGMT: fix mesh_tx leak on hci_cmd_sync_queue() failure
  Message-ID: <20260919115436.3998954-1-benquike@gmail.com>

Hui


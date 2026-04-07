Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F23CFF73;
	Tue,  7 Apr 2026 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577835; cv=none; b=ViDLwvahS6ZfYAqeBDQh2YcCi7C6WwSj78AvbvOTFQ+NRNH449Gb6Imkw7R6vJ79Bb3L2oKVTtTF9E9lpcYFn02Bj+HeeWCeRKYlhChJol3Q5JW5bJpUprdOu7cjpV1sc8Gp67ntvCKUXB9d7WvW7KZqgXeTJup5ExVYsBIIyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577835; c=relaxed/simple;
	bh=4ekckLVHC6JNlQ4+cwG1UzpRHWBEe2fAGVVPOLGy4R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6ajivksdyhx886ntCJV3Uyo13yP1+nhjDucr231qdEteqNf9WviC2fSPAaB8vcV6IJcflsFVcSVWOOpqS6UjuBnD7/hx5z71exJZ2QkPvAvwhZpOdI2lKPNFeVgyBwypERrZpcDCNRib7vsBdeRfmi6m+GL0pLpT2CNr8c1qRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=qSo4Red0; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="qSo4Red0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=0UZ4nM5ntRTkbDrlVt7CXwcY4ov92h/7RcMa2AIanwA=; b=qSo4Red0hA9iIVZtglDgmQLDfC
	l5JsDBXdO2/CzltDZtArJ4WwV7NzmC6BPplR8N9aSXQlWZ+Aoj8ssFPheD5Qgr9ADG+KzZtMmEwlk
	Ayfztl85Vp5HGr5uPyA0FDSlj/nNw9cVlFDfs814fxOnU+NQ48WeVIZvZ2nZz7Oc1XkjGpy1Iw5sU
	wMiDBznHnatewtVKvOTWD1EE978yng7itidLTymOVgVgh19p67I5SHWDLXGAZDCYuWA4pCKa7Jyhk
	vQw/igIiANmjHC8oGi3RrpdJaeU9Bs1UXGVggt2BF9w+T2kL/yzJu3NsPpg85XPMOewyXNDOFzDUn
	oGwU/nxRyLi2z0JzyNV1pXny7S+ulV0cDL2voK66VxjQoIhvISTE2hvuMWv55Pcge4VtK1y5gBXYp
	zC0qYo3zeS+vCf6xGjawJo8Ty0j/tFUywUyEj4wSCtccFVxsp6/qoDzOWBVZ1pt/V1XDw9sLe5X2O
	x0haqQ6CLkoU/ZdEOI1T7i6s;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA8tv-00000007Xj8-0Juu;
	Tue, 07 Apr 2026 16:03:39 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-kernel@vger.kernel.org
Cc: metze@samba.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Dmitry Safonov <dima@arista.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Michal Luczaj <mhal@rbox.co>,
	David Wei <dw@davidwei.uk>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Xin Long <lucien.xin@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] sockptr: fix usize check in copy_struct_from_sockptr() for user pointers
Date: Tue,  7 Apr 2026 18:03:14 +0200
Message-ID: <cfaedbc33ae9d36adaabf04fa79424f30ff1efdd.1775576651.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775576651.git.metze@samba.org>
References: <cover.1775576651.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copy_struct_from_user will never hit the check_zeroed_user() call
and will never return -E2BIG if new userspace passed new bits in a
larger structure than the current kernel structure.

As far as I can there are no critical/related uapi changes in

- include/net/bluetooth/bluetooth.h and net/bluetooth/sco.c
  after the use of copy_struct_from_sockptr in v6.13-rc3
- include/uapi/linux/tcp.h and net/ipv4/tcp_ao.c
  after the use of copy_struct_from_sockptr in v6.6-rc1

So that new callers will get the correct behavior from the start.

Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
Fixes: ef84703a911f ("net/tcp: Add TCP-AO getsockopt()s")
Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
Fixes: 3e643e4efa1e ("Bluetooth: Improve setsockopt() handling of malformed user input")
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Francesco Ruggeri <fruggeri@arista.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Michal Luczaj <mhal@rbox.co>
Cc: David Wei <dw@davidwei.uk>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>
CC: Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 include/linux/sockptr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index 3e6c8e9d67ae..ba88f4d78c1b 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -91,7 +91,7 @@ static inline int copy_struct_from_sockptr(void *dst, size_t ksize,
 	size_t rest = max(ksize, usize) - size;
 
 	if (!sockptr_is_kernel(src))
-		return copy_struct_from_user(dst, ksize, src.user, size);
+		return copy_struct_from_user(dst, ksize, src.user, usize);
 
 	if (usize < ksize) {
 		memset(dst + size, 0, rest);
-- 
2.43.0


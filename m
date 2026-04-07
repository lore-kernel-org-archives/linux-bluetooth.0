Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67FD3D649F;
	Tue,  7 Apr 2026 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577847; cv=none; b=EGYDAU/M2hO6Z9xYHV76nObReZm/j2ha1HRY47mX2pbLoZfbRjhhOWBx01MbawmmMnDA3SOkMaS4vgG81fU8Pq24/fhQ+OE7CPYy1OVMkUaBKGDuVDh+9wgDoyBBSZGVsSdZtxkxl+ikqK/gnN/HycfYN+xQMYrBmO91fdXArXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577847; c=relaxed/simple;
	bh=TAHbJ8shCUysdP4d22ZFghQI2jeDo3bLaktPKkLvi3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTCBuMGuI7UzrgBriEaItGSM6MQPQ051SG/PGy3Tlrm/ee1Ol8XAYNhYsS8+k7CKfxYWPv88aI6TryITXxstC/3Ats0kof4LAvDfcCEHPib8ARmHlkLQUQZPmGjBFwkEAt4vYuwEdUOw7zeyDjgdA0Z7CLVUoiPYFYA9ULz8g2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=bh2U4TGB; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="bh2U4TGB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=vIAh/1ZMFfnKbOCb9A/NbitCMcGGjkXhI3WpqSRlpLI=; b=bh2U4TGB9VGY9vtQW4X15pPD7Q
	5CjfNPNASTyFRx6XQjQqK+GSVYy66EPSINPXK0EovcAWjWAaGH2Uej/8dyqRJn4uloBr2wf40GGGk
	6Pm/oEIml6zdFeUwm3ivA5WGeXSDOQec/gly5IlQzvKoeoVcUMpuX6JBrmHaQEjX29DCMPsSAFH2L
	dgeJplxifyTCW7xVUk+dosT7gneAwH1xcXCDoEmWn5S8cZX3/DrY/+4pvSmLiIjjGaPPdtZtR8aaw
	iP9CEC2RPHZz3KQ64pf+XmMgejT7UxqN1PDVhDlPpSvuCWuN5xu9R1YOWZ8vJHTV6JNr/feYTtInf
	pyyFLqrQzSn17xuUhzSFxLrEIJMVfHA74JYd3zLDj22RK/edgGoQ6EPlGFn83PZ4j4AQUYFpwQsWF
	WghxJGTlOb7/6XAurEngk2aQOriVo/6iJmJ5/d8Tz5pwdr+KuVXWvyGPjlCJ0Pbng5z7/stjrtyje
	MPWJ6YI9AUGLYXmZFS5fQGDw;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA8uC-00000007Xkj-1c22;
	Tue, 07 Apr 2026 16:03:56 +0000
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
Subject: [PATCH 5/5] sockptr: introduce copy_struct_to_sockptr()
Date: Tue,  7 Apr 2026 18:03:17 +0200
Message-ID: <c950ee1578cb93b4411c3731010def9c1cd82f0d.1775576651.git.metze@samba.org>
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

We already have copy_struct_from_sockptr() as wrapper to
copy_struct_from_user() or copy_struct_from_bounce_buffer(),
so it's good to have copy_struct_to_sockptr()
as well matching the behavior of copy_struct_to_user()
or copy_struct_to_bounce_buffer().

The world would be better without sockptr_t, but having
copy_struct_to_sockptr() is better than open code it
in various places.

I'll use this in my IPPROTO_SMBDIRECT work,
but maybe it will also be useful for others...
IPPROTO_QUIC will likely also use it.

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
 include/linux/sockptr.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index 706a8526cf3c..9c2429c1a570 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -107,6 +107,16 @@ static inline int copy_to_sockptr(sockptr_t dst, const void *src, size_t size)
 	return copy_to_sockptr_offset(dst, 0, src, size);
 }
 
+static inline int
+copy_struct_to_sockptr(sockptr_t dst, size_t usize, const void *src,
+		       size_t ksize, bool *ignored_trailing)
+{
+	if (!sockptr_is_kernel(dst))
+		return copy_struct_to_user(dst.user, usize, src, ksize, ignored_trailing);
+
+	return copy_struct_to_bounce_buffer(dst.kernel, usize, src, ksize, ignored_trailing);
+}
+
 static inline void *memdup_sockptr_noprof(sockptr_t src, size_t len)
 {
 	void *p = kmalloc_track_caller_noprof(len, GFP_USER | __GFP_NOWARN);
-- 
2.43.0


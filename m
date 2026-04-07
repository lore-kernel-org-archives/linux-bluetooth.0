Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83D370D6E;
	Tue,  7 Apr 2026 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577826; cv=none; b=apW8F0q55B22N0hZcdpEyeueEtnadQ7IAxhpjKSasXirXwqZRhcCeN+aidyA1W/wcByUQv/CDmmQ4No+9W1P8W8H5i90nZGSfVJfh3gJYh0OqyjJtI6FA8Qda+yV6LHjKx1eFrYBzQ+m2bYG0h4qLzjrX9fI02H2HYqy9noqFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577826; c=relaxed/simple;
	bh=4tzNatN0lLNbSZtg3kjtdU6xpsyEALCIiXGSM4tnjsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htr2q5rASAOWnsP/pS7FuOiV8BXeHcJBymsfkZvgh2l2Jx0icPu4ftD2L2ni/+If+8J20xYd7Ri+bOGdMHlKD8vT8e3vw0akqCMrg3/n7shAHHnwovu6V1Q/+CvZ3V0rkzMWJf0KjSe+/lkJtC+0kWCOVCSy9MOR1IO0krCEMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=E8ECd56h; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="E8ECd56h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=1sWKeUoiedloG4v+5cKbhOh9byM/6fDeRhbG1bWIQbw=; b=E8ECd56hN1iYhq+ulix96lYfec
	BSSD9n27nLPltvOqe1wKsaj1T6uNDrDUATj6RviiugjU5Nno1VV1fJElrU9eUfJpb2Zx6MvnmyoEc
	TUaMlYuOCih63EaAJ2DIG3droMK0b1ra/DVyL2uHRGB5OqWbL1sJ4LZ8sgx/C8vpiyCtUOoKobykU
	J02WfiwlIIx7K5Bd30TLWS2c3DI+aO4LR2xtGKllZLeD5tikhcTh4oXIQuVGAHEVc+9+gyqxdcQMS
	rSpNKdkES8O2A6tqQFetsrGkPH7yM+AjbrEGcxZxFX/VAjnSgnGinxBs5BKB68ryi35+JKqJPr6PO
	rcP/MfA9lzfuitNwQrLujw9FKLXIB0XKMbkKSAQxhmkUcKES65ge65e8Ee6LlSamdqIWvHGruQ1YZ
	i0fkH+5Q3saPwdqD3H1OXCVVIomY6f0CgRiKp4HnV8Dd+QLemW+dZy/FWJscn2/xLJh6KOgO+lDvt
	5olATBcZFV49Qfr0Xw+j1Wwj;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA8tp-00000007XiV-1Sez;
	Tue, 07 Apr 2026 16:03:33 +0000
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
Subject: [PATCH 1/5] uaccess: fix ignored_trailing logic in copy_struct_to_user()
Date: Tue,  7 Apr 2026 18:03:13 +0200
Message-ID: <71f69442410c1186ed8ce6d5b4b9d4a5a70edbad.1775576651.git.metze@samba.org>
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

Currently all callers pass ignored_trailing=NULL, but I have
code that will make use of.

Now it actually behaves like documented:

* If @usize < @ksize, then the kernel is trying to pass userspace a newer
  struct than it supports. Thus we only copy the interoperable portions
  (@usize) and ignore the rest (but @ignored_trailing is set to %true if
  any of the trailing (@ksize - @usize) bytes are non-zero).

Fixes: 424a55a4a908 ("uaccess: add copy_struct_to_user helper")
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
 include/linux/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 4fe63169d5a2..1234b5fa4761 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -505,7 +505,7 @@ copy_struct_to_user(void __user *dst, size_t usize, const void *src,
 			return -EFAULT;
 	}
 	if (ignored_trailing)
-		*ignored_trailing = ksize < usize &&
+		*ignored_trailing = usize < ksize &&
 			memchr_inv(src + size, 0, rest) != NULL;
 	/* Copy the interoperable parts of the struct. */
 	if (copy_to_user(dst, src, size))
-- 
2.43.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620703BFE26;
	Thu,  9 Apr 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739941; cv=none; b=GdsDjx2KszBdIWuNlrWGenRoTDNcPLkAGRG1RrusWYBh132Yv/V56r8oRevzEUIXkSW1zH0QbcARcOiT0AJkc7PxXVpY9i9YlT012Buo0MVMqPSgsU2D7RXecMGmN+Dzw/bGjmUuk2XWymscOqYiRRXH4dAqpMdfxIt2EMxRdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739941; c=relaxed/simple;
	bh=J0s6O4DpU42FeihdRs7hFM5/jocnnBLeGwX2SLhu0Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcnlKDR6JFJKd8LA9G7Uu4Ne29W1XAM6QJbAeEcBRlc3uUUPUWIFQaxOAsI2xnUHtYO1rECroWTdxJyusV77fiCPe1fXAExFjF7bYUsIYjTQNdPgmprtNKngpfuIG9xpki+RYBMN+J3Kdc44wT5v8x8iSCPp+tWREf6yawTb39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHrGHXUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHrGHXUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E3EC4CEF7;
	Thu,  9 Apr 2026 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775739941;
	bh=J0s6O4DpU42FeihdRs7hFM5/jocnnBLeGwX2SLhu0Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHrGHXUof5Do4EsuKLEJ5AIBTWZfJjLC2Le0XzIY/5ubmFBVD+umqmi2M/C/NoKiK
	 f+WrWhRWbw+R10z06ZGno/dnMGejWropuaiVQWnV8PJbF3SaD+Pxnm3MhJhZklEX7G
	 d7e84q4wDXAgEuLm8Efw916uAl9F0lOen07kte2ewTLAX2NuvTzLWHlmjbS6io850b
	 D8i+Kc0GecoJxEcWB5xHkA0N62brmErvqmyfDnunHMph1wcZHfy9ZU9hhTRs0Uae8a
	 WRA++gcYGs4ZKDxWWZExYiPsBWe1Ah9K4HKHofIcQv7vr+jBai7LSaHpRzbr/azC2q
	 HDK2Kmcod5wFQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
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
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 0/5] uaccess/sockptr: copy_struct_ fixes and more helpers
Date: Thu,  9 Apr 2026 15:05:06 +0200
Message-ID: <20260409-lehnstuhl-zerkratzen-549c8e1d376f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775576651.git.metze@samba.org>
References: <cover.1775576651.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=brauner@kernel.org; h=from:subject:message-id; bh=J0s6O4DpU42FeihdRs7hFM5/jocnnBLeGwX2SLhu0Uo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReXyJUlXBq6dyyzx4sx5M2FfyecPn50xuLd0xbzbsh+ U9V4PyNNh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT0fJg+O972//WnrNtt6vZ C+s3+NnVC607vJeze66xhHzwpc452asYGS7yLTydfEtwlZAIV2n2vULd0+v7I3880qvn86l7IfF WnBMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 07 Apr 2026 18:03:12 +0200, Stefan Metzmacher wrote:
> here are some patches related to
> copy_struct_{from,to}_{user,sockptr}()
> I collected during my work on an IPPROTO_SMBDIRECT
> implementation wrapping the smbdirect code used
> by cifs.ko and ksmbd.ko.
> 
> The first patch fixes copy_struct_to_user()
> to behave like documented.
> 
> [...]

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/5] uaccess: fix ignored_trailing logic in copy_struct_to_user()
      https://git.kernel.org/vfs/vfs/c/0a8d67b47a5c
[2/5] sockptr: fix usize check in copy_struct_from_sockptr() for user pointers
      https://git.kernel.org/vfs/vfs/c/e555ebefea0a
[3/5] uaccess: add copy_struct_{from,to}_bounce_buffer() helpers
      https://git.kernel.org/vfs/vfs/c/14e710721cd3
[4/5] sockptr: let copy_struct_from_sockptr() use copy_struct_from_bounce_buffer()
      https://git.kernel.org/vfs/vfs/c/62343ea38031
[5/5] sockptr: introduce copy_struct_to_sockptr()
      https://git.kernel.org/vfs/vfs/c/9899f22cc41d

Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638B3D0915;
	Tue,  7 Apr 2026 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577826; cv=none; b=MLLyZEbz/Wl0k3UoHY1pty8/eFh6G0EJX9qdjqK7hXohu/mIh/f2niEnG+vRs7kvXQljGci+Fd+5PafuBGeNH6mXRJ0JDR4LnkCal0QD2DTTEJWQmTUOwojsn+r7UvWVhPTh2gRHZo/MGG4qnzXyak7CeB1VAVPECupfmY6GqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577826; c=relaxed/simple;
	bh=NcHcmhUOGybP6gS5OognOpnXF/Dz8AmzBbNWA8Ix82Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q55OLQRZ+L+z9Q60mhmBxz4ZQdK6b/dj7wv8LVaonBmpPXq1az29Gb/zpmARUFO1REEg4IMQX49HYu+9ymTGyQ+AONQD2hax/0NvzDKwCkr4J2M1I9gy4FAtxlsb4NvV+6Lv2IfLydhOrwXmz4irZ/8clKQIle16LBO3Fr8/0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=RKAqJfUM; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="RKAqJfUM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=OgMUkPGD+QGqun249lXP7nlRpauKbjFxYQIydEFqJLE=; b=RKAqJfUMlcoY8QofLUSUrOn14D
	rwNExfVdFBogKVmuxWA63hTJ0iqe7u29wfcadeEcIBNRtpV3MuxWs9YqWaGqPVxx3o9i532lYu+bD
	grdp/Dadss6alhr8lYrQQMWOyy4nQvNsawkVb1wN5o0OicrzwxEuavlwRtyEbUiWV29mR3lmRBN3H
	W7s7jYmPxA5w7lsdmvIwBqsP+ZAGYZxCjXeqgVfR75WwtwyHykuokSuXy9l8ok3UgWELaff6ye3Yf
	4i7l5UKNfZmDL2cLSWY2Sz24uks6dYAFej93XfiNPMntOzkGHzbAuYCouLr5x437rX42LCLZ5QyWU
	300uR9oHtmS44xqHi1NBGYjH4dLKT7lyqQYIw94aQHdoUSb2EN5i4oyamRafblGHNyPibonOHfJBu
	JmGaTNFD+oaXAybkfUYi1K+02y3He0WmAZYJilSXr6o1FccqeULSL6AMeGNQRtC2Vq2lJnkig1nzX
	1WtYVvzuJ7hkQoeXpwspskXw;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA8tj-00000007Xi0-2Z6E;
	Tue, 07 Apr 2026 16:03:27 +0000
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
Subject: [PATCH 0/5] uaccess/sockptr: copy_struct_ fixes and more helpers
Date: Tue,  7 Apr 2026 18:03:12 +0200
Message-ID: <cover.1775576651.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

here are some patches related to
copy_struct_{from,to}_{user,sockptr}()
I collected during my work on an IPPROTO_SMBDIRECT
implementation wrapping the smbdirect code used
by cifs.ko and ksmbd.ko.

The first patch fixes copy_struct_to_user()
to behave like documented.

The 2nd patch fixes the case where
copy_struct_from_user() is called by
copy_struct_from_sockptr().

The 3rd patch introduces
copy_struct_{from,to}_bounce_buffer()
as a result of a discussion about the
IPPROTO_QUIC driver in order to
be future prove when handling msg_control
messages in sendmsg and recvmsg.
But I'll likely also use them in my
IPPROTO_SMBDIRECT driver.

The 4th patch makes copy_struct_from_sockptr()
a trivial wrapper switching between
copy_struct_from_user() and
copy_struct_from_bounce_buffer()

The 5th patch introduces copy_struct_to_sockptr()
which I'll also use in my IPPROTO_SMBDIRECT driver.

As future cleanup I was thinking about trick
to hide size_t ksize from the callers, similar
to what was done with kmalloc_obj(). Whould
others think that would be useful?

Stefan Metzmacher (5):
  uaccess: fix ignored_trailing logic in copy_struct_to_user()
  sockptr: fix usize check in copy_struct_from_sockptr() for user
    pointers
  uaccess: add copy_struct_{from,to}_bounce_buffer() helpers
  sockptr: let copy_struct_from_sockptr() use
    copy_struct_from_bounce_buffer()
  sockptr: introduce copy_struct_to_sockptr()

 include/linux/sockptr.h | 28 ++++++++----------
 include/linux/uaccess.h | 65 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 17 deletions(-)

-- 
2.43.0


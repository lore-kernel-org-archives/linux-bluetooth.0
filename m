Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BkdG/RZp"
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837A9A
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Dec 2023 10:21:46 -0800 (PST)
Received: from github.com (hubbernetes-node-03f2d36.ash1-iad.github.net [10.56.168.34])
	by smtp.github.com (Postfix) with ESMTPA id DEBF5100389
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Dec 2023 10:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1701454905;
	bh=3zv5VphZBw1yp2lduOZ5rKRNSVA7ZBgRWczCPos5sb4=;
	h=Date:From:To:Subject:From;
	b=BkdG/RZp06aLeDNpvpcxReRFIA4aZUl8T8iuWqMcaNVYGJj5OaCUTc7SaGbxBjIR+
	 GwZEeIHEnl7Hn5RNzi7bNoxMRd9/O73Axnyi9ermDVRVd8uAXEhPdC23TNdK/6BYza
	 VF9VED4wmKI5104vD1T3BSPFxUm6Yn7uuXbTWbWo=
Date: Fri, 01 Dec 2023 10:21:45 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4db4d5-cb1a3f@github.com>
Subject: [bluez/bluez] cb1a3f: shared/vcp: Fix build error
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: cb1a3fd96c48a878f1a93ffc81e0c5d867b03cd8
      https://github.com/bluez/bluez/commit/cb1a3fd96c48a878f1a93ffc81e0c=
5d867b03cd8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-30 (Thu, 30 Nov 2023)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Fix build error

This fixes the following build error in some architectures:

src/shared/vcp.c:961:24: error: lvalue required as unary =E2=80=98&=E2=80=
=99 operand
 961 |     iov.iov_base =3D &cpu_to_le32(vocs->vocs_audio_loc);
   |            ^



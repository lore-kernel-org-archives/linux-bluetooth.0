Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1973033F5
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166063; cv=none; b=ra6q8ia40nJpSC3wAWgGJXt5ogSGNpek7fSYttJ78DGWDW5XUvAG71/uw4HTqG3tx8dp9Pe7Kv/z/LVDE92ybDhTM67jkh3fP5KS1Coie9LErzm4Bv+y795oB5l0leIRDGmyD1edoA8S/3qICP19I9BXsRhdHa6Chcyph7kHFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166063; c=relaxed/simple;
	bh=fH2xM7CnNmaspLr3GXLy4sqoriDT4NwIPKH/67ZFMRo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=apG0R4VDxmsuBlDTZGAenkd0KSufGKaACstHF1wTgkpKPEWpbVOXFdb43DVAm165qIGlTXa4tAxc9U2KUemZClIAnsFMqtTPtF08Y6QiaKQQxAzufWpvjNzXmL5pAE+xaH1Ocq9E6ihmHRC5xy7fFglve+p+h0LoDKjzXut0P7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=U1wKkMaZ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="U1wKkMaZ"
Received: from github.com (hubbernetes-node-02e0b84.ac4-iad.github.net [10.52.86.25])
	by smtp.github.com (Postfix) with ESMTPA id D4FA640092B
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 03:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769166061;
	bh=UA6xGXq7wvQK+is3vNMaLPdyXnOXuF40AN8tt0B30uI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=U1wKkMaZdojiXMudL2eznofYVr+McADqRsp5H1doWPwPiOcj+p66qF6lJIXXrkKjU
	 DJEbZHQAifAif1IBTdXdU3shA23tAiW+UsaAMh07/0SZbF1jFWq6BeCIVxHKFcNS7Q
	 fWg+tWpG9PtuRYsC0oSHYnrt806FPgaNNEphF+RA=
Date: Fri, 23 Jan 2026 03:01:01 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046201/000000-fb2c7c@github.com>
Subject: [bluez/bluez] fb2c7c: doc/qualification: Add PICS and howto for the
 SM q...
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

  Branch: refs/heads/1046201
  Home:   https://github.com/bluez/bluez
  Commit: fb2c7cec01b313ad0d57bf884aaf7c85b1ad1999
      https://github.com/bluez/bluez/commit/fb2c7cec01b313ad0d57bf884aaf7=
c85b1ad1999
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-23 (Fri, 23 Jan 2026)

  Changed paths:
    A doc/qualification/sm-pics.rst
    A doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the SM qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications

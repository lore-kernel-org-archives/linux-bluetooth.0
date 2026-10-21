Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792594909;
	b=BI9uZUBTM0/L7hRIfDmP1rIsvFAA1mJdK5+1OpK7T89QaKsvL+P0TrgfgGTamy+iGp8n
	 QAiOBghw4aRP/4dS71ppvYIoy5WGo92hn4Wpxvj5Qso2lUaNng0+YA2oM+I+RcjTkYVTX
	 xZ5N+MwNj5Qktw6pIINsP7npCLJnhY6PKFQXC3if6lHVfJbC+6NVFVWxkCALmDTAL3Fon
	 4VZ1tcMMJcSPBpzfSPQfReHKJOuTEzBzhopN3QlA487vtGN9PW9cFq3yNWThiDmFk9FMR
	 XBShxkUEPcNFA14LFng12jU3KO7HSdiS2mTbux/Zmf6kmNLFjPl+cDOipsooXBKoK9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594909;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=MEuHMwMGpTvdAyx1HbAbs8pNbQFFOt3GVEoCCFvmVLk=;
	b=wyfzLGSC+Fn178sbXRM05YASeiqkU2BXzeCjoZEh4a2SyT9leeohiEj5NazkoLWFbqLe
	 vNs+WC4erkTYlHVpayDxmv7XE6NEYU7x/T55xDn03BQBcc8p5I5lRuCe06rAOT9ZoeSrD
	 5Q8VcA2L7RPrJSEicPvebWRmBnsM/PSQY11/6RGSRu9G9DBBdKgvqSX6oaLubX4/qpOGx
	 +U/QOJ0lXkhLZKqBgPntmHOsvPKevKN5aWNt+CnGmmizMWw/tgz7T5Jk03AopfzCZfSmN
	 qtzFyOJMMwflFuIHKf96T6I5nC+ZhZKGunfIiWvPBT6lsftpm9eBBzgTdYRZia/aOzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NPviSmTj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466F606A31A
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 21 Oct 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NPviSmTj
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847425771
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792594909; cv=none; b=SRkEEryFW9J97AYpMhgtUfAdGdsYOgrnrCVi96G5Xo482InzIx5Qmk5QwMq9e7O8KBG9iVrSdexMQPriNRV+OkeCGttAwDUWH0uzUbOcTL3SmNXmfQppyHA0DztlLfr+iKVmt5K8WLSJUv1Gj8cZ6V1mNFcMc5ASWKZyFVc+sdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792594909; c=relaxed/simple;
	bh=Rg5C0ZbB0qRpK0aRZszMi0jfKVv4LI8I0idJv4TwzD4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IFiQ2u7HUP6aLeIsXwxOT5bdZqRj3+jOf/nnogCXtkci5BILJWmAUFBMk2PuruBla6w48ck8ddXBEqxglBtqPqLze9y+HEq1uYXNDeS6T0nEdPb9Xn8sKoxCwEpwV5HrCT+Pw0rI5wrbrxa+Hx1xYgSPgb/SdAc9Bzk4SohqrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPviSmTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5759AC2BCFF
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792594908;
	bh=Rg5C0ZbB0qRpK0aRZszMi0jfKVv4LI8I0idJv4TwzD4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NPviSmTjvU/LBlCBTg88usr3sr6ycvAW0vA0KNvpRWlqZKk5ssFu6G3ybB2RO1hYW
	 l4sbw1tXv2uLOrxI0/pogzhwfpotoMAKHylWUpWVWv1UhmW1Dd0XwDTOm+rfh9zee/
	 Qb1XIUiYwlJXDC0ekit0HxIuXsMZMISv1V+DqZsuiYE93YW0OpUGxNn2Bs83+Zqn2G
	 kM7DaPO2G5iT+PgKlClGn3GYQL34e1+xCkoeGHIHJKZJF/60UvLp5XGrUKewshlMsk
	 6OrC1oAIklkuInVupM/ueamXMwvE8rXDzj5mOxZdEHtNPkXSuQxMqXc3qn7+lA7tZe
	 OfTD08nWdtFwQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 46ED5C53BC5; Wed, 21 Oct 2026 15:01:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222164] MT7902 Bluetooth: firmware coredump after ~10h uptime,
 then subsys reset fail; followed by permanent USB disconnect
Date: Wed, 21 Oct 2026 15:01:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-222164-62941-prynkCsvRH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222164-62941@https.bugzilla.kernel.org/>
References: <bug-222164-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222164

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|MT7902 Bluetooth: firmware  |MT7902 Bluetooth: firmware
                   |coredump after ~10h uptime, |coredump after ~10h uptime,
                   |then &amp;quot;subsys reset |then subsys reset fail;
                   |fail&amp;quot; and          |followed by permanent USB
                   |permanent USB disconnect    |disconnect

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B9146010
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359524; cv=none; b=oz+9AE9a4+Y9g4C95CjCAjIxBN7SvykSgKoAl3SIcPVMR1MgL0zzn9PJhXEU+L3UolxMCrugyth/nnm+0U2dfiBcqND7JxmMw5nbd6ersd/3sk0s3x8i+8GwXSDhZpCBAir7W4Us8sw2FSciv6Bo6tIyqkah458nDyZ1Kg6yFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359524; c=relaxed/simple;
	bh=ST74PPnnGVbTknn+iqWWbSMNA5ohxxbiG23ZjSHH5wI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGAJz6YWkTNXpOdrrSzyYrEM5u6/IgHdH4douNFsQ0bZmHFnEsj6QNGf+/ickTwFUi37Y3LSzNN7zlQ24WGJp9H692ZIOh7kH2ZlAp5CYB5rMmQXZVjgdVRCmVxQTAvcjYV+UNnfqTyylg3HlgAobiohAkNrAnLfmmomqFHiX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBiZ8k0m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBiZ8k0m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7F15C43390
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711359523;
	bh=ST74PPnnGVbTknn+iqWWbSMNA5ohxxbiG23ZjSHH5wI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TBiZ8k0m6LUuoJrlmOMTDZ5wkH6btBHiW2CPrgywVkwoFpG1OYTjXQCfpeth3bEB8
	 usgeMfFm83hxlJaJ1gpKZyztuAeWUi2qfXo/2i1920SZChvn1koEKI/u4YsajF4RMp
	 XQxTQMn/NizXkDx/NQNtdUtiU//hhPdw5Tl1NGC7WCnU0Z7OmSNdNYt73+mI1zY01Z
	 pD6NkVJuebtFw5FBDWDg5qdV4wNdehSX4T8CZeDwJtgofY2HL7OQ2QkiSRMTb2+UmW
	 ZAzeEh34L+bAVN+0hNHQQuPXg1Qn56YJAqL4ASk+jd7JTHnVMyp1K/DI1xKTyC00TM
	 o/o1OkXbBDiHw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A68BCC53BCD; Mon, 25 Mar 2024 09:38:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Mon, 25 Mar 2024 09:38:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vjstink@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-vdNfRU8qrL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #8 from Jhon (vjstink@gmail.com) ---
(In reply to Nickolas Gupton from comment #7)
> Bluetooth is still not working on boot with kernel 6.7.9 with linux-firmw=
are
> 20240220
> However, if I run this script (may take 2-3 runs sometimes) it will work:
>=20
> $ cat reset_bluetooth.sh=20
> modprobe -r btusb
> modprobe -r btintel
> sleep 2
> modprobe btintel
> modprobe btusb
> sleep 1
> systemctl restart bluetooth


Thanks for the script, it actually works after a couple of tries as you say,
really great.

I wonder, how did you enable these extra debug messages in journalctl? For
example, in mine it doesn't say anything about which firmware files it trie=
s to
load.
I was trying to identify what it loads to replace them with some older vers=
ions
and see if I can make it work that way.


I also want to confirm again that the issue is still present in kernel 6.8.1
with the latest firmware update: 20240312

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

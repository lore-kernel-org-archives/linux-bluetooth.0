Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B615472540
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141274; cv=none; b=OlIM7LyDaFmn8/6FYZNghYkub35F78FMpKh6xiy1DgbcDa7suYVwMBxdMy/+7fjq0vSvR0ihDogswAoBtjH8mq8TP3WLxjDBkVj1vef76zUgRtX5pPfKqlSzEOWpQ6Bk/NJeVNMXt7sI49xybU2McMOUKZgcUvvs8R+LQqG9KvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141274; c=relaxed/simple;
	bh=jPigUtaGPuZXDmOBVKSjcn7CgoXP4YKKBZhpTY29nwU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VenUEXmOIzh/Pr28rxVXPmuqjQVKVfJ+wuTArzfGxuEStvr0+In8jFzIgxH4+lrnjMV2ldqnaseR/2QS/xCGnBzgLyrQuEgiyHKM8DcXfXxtIUwlyeNs5tTvTeLSmPZcooEnwt8BTPLlPX4msP3BijrdkRh3I7i1TcBSSNaBDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZonTF5+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZonTF5+K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E174FC2BCC7
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787141273;
	bh=jPigUtaGPuZXDmOBVKSjcn7CgoXP4YKKBZhpTY29nwU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZonTF5+KwSKG393NH9A/+OUHrlgx/GSgCwoLGkfv8mnxZWOvKFKBUSbj3OGC88BcU
	 Ygy4sYISjnAhUoQXJsMxynwp/PlzUQZlubyT/W821kZ7CjCkhUJB4V8UhFZl8VRFbJ
	 x82A9i5eNUi5IbantAS8+Ng1lTFUJZxbK++9KQg0Y9h33mTlVTIXY95wsLJ3iyYPTx
	 UIgNDNHLG7hKFmkvQMJ7aqfOoRVGL7AFiwy5HTEd0cj2x3xVdM1cBzCdoW8ofcTD4D
	 4jmS56/CgomhBrzOI12l2V3MAdgYr/yQY8UOxCclxhtp8vMWJRL3RcrPl+a8Ky34Zw
	 0Bc8XeE1tg0LA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C69C8C53BC5; Wed, 19 Aug 2026 12:07:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date: Wed, 19 Aug 2026 12:07:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: kernel.org@engmark.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-80791-62941-K8Bxs02Lzo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

Victor Engmark (kernel.org@engmark.name) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel.org@engmark.name

--- Comment #16 from Victor Engmark (kernel.org@engmark.name) ---
Found this issue while looking for a reason why my Bose QC-45s were crackli=
ng
during playback.

> kernel: Bluetooth: hci0: ACL packet for unknown connection handle 3837

(Oddly, it's even the same handle number as the two logs other people have
posted above. Is there something special about that?)

`sudo systemctl restart bluetooth` seems to have fixed it.

Running NixOS unstable (26.11, commit ID
2fcb964de67fcf60b43471c55d5d99e61a9ccb5a) with bluez 5.86

Service config:

```
=E2=9D=AF cat
/nix/store/zc356bzkix2dj7l63jpsphi89px6wc2x-system-units/bluetooth.service.=
d/overrides.conf=20
[Unit]

[Service]
Environment=3D"LOCALE_ARCHIVE=3D/nix/store/dmm8l3wf59027myllvph9b0w5bzdllp8=
-glibc-locales-2.42-67/lib/locale/locale-archive"
Environment=3D"PATH=3D/nix/store/di26b1kkbammy0sj70nq5qzvfrh78wxl-coreutils=
-9.11/bin:/nix/store/fcqbwp5hx5wh3lzf0457wmf0divknz7y-findutils-4.11.0/bin:=
/nix/store/aak8d9mrdv9sgn0lcg7xss7wxdg9sqh3-gnugrep-3.12/bin:/nix/store/7mf=
smbhsd3arnypipwm251rcd0b45riy-gnused-4.10/bin:/nix/store/r6sz8p6sd6c73fp9z8=
nzl04dri7lyx8n-systemd-261.1/bin:/nix/store/di26b1kkbammy0sj70nq5qzvfrh78wx=
l-coreutils-9.11/sbin:/nix/store/fcqbwp5hx5wh3lzf0457wmf0divknz7y-findutils=
-4.11.0/sbin:/nix/store/aak8d9mrdv9sgn0lcg7xss7wxdg9sqh3-gnugrep-3.12/sbin:=
/nix/store/7mfsmbhsd3arnypipwm251rcd0b45riy-gnused-4.10/sbin:/nix/store/r6s=
z8p6sd6c73fp9z8nzl04dri7lyx8n-systemd-261.1/sbin"
Environment=3D"TZDIR=3D/nix/store/2nndxyf3phkb5aggxm3c16sapa0f49kz-tzdata-2=
026c/share/zoneinfo"
X-RestartIfChanged=3Dfalse
CapabilityBoundingSet=3DCAP_NET_BIND_SERVICE
ConfigurationDirectoryMode=3D0755
ExecStart=3D
ExecStart=3D/nix/store/5w050dyskx5si0skc328b0q9mxbn5lmn-bluez-5.86/libexec/=
bluetooth/bluetoothd
"-f" "/etc/bluetooth/main.conf"
LockPersonality=3Dtrue
MemoryDenyWriteExecute=3Dtrue
NoNewPrivileges=3Dtrue
PrivateNetwork=3Dfalse
PrivateTmp=3Dtrue
PrivateUsers=3Dfalse
ProtectControlGroups=3Dtrue
ProtectKernelModules=3Dfalse
ProtectKernelTunables=3Dfalse
ProtectProc=3Dinvisible
RestrictNamespaces=3Dtrue
RestrictRealtime=3Dtrue
RestrictSUIDSGID=3Dtrue
SystemCallArchitectures=3Dnative
SystemCallFilter=3D@system-service

[Install]
WantedBy=3Dbluetooth.target
```

bluez config:

```
=E2=9D=AF cat /etc/bluetooth/main.conf=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
[General]
ControllerMode=3Ddual
Privacy=3Ddevice

[LE]
ConnectionLatency=3D0
MaxConnectionInterval=3D9
MinConnectionInterval=3D7

[Policy]
AutoEnable=3Dtrue
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

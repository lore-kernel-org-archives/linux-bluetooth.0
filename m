Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A10388E6C
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233784; cv=none; b=aZhL356HvWI0kuXUP56PWJmWODspEtApoHWEIqlhKOSgFCVE3wejGvGaTuebsIr2P38a8U133cu8im0ZxvpW5VdbgY5G+hRpfiQvidgmCV4a46jEtX2PqoEnop3FPEZsWu1Fib0kSOg7eyr3ikjc0+++7qQ75z/YXXUxqE8yVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233784; c=relaxed/simple;
	bh=RC20ysQJfh6O96KvRu6Nd8UXZLC2YQtillbIjEHwSzU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSLcniuHSWQoflfVl3Fshnmbe68RK1TE0BnYVNPcPmjS3+WnCZ+yvZJxpm8NXdY3jiSEYzKPEbw9Uh416CDzHx9lE/n4rTn81m/mY8ILv81XLW5PKx4TC/KPc8y7Cgqa+DljlhFO96IzVmlALx+1u5tef2FcTr4ALxTuhIb5STc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRLzsPQa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRLzsPQa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FE9AC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 06:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776233783;
	bh=RC20ysQJfh6O96KvRu6Nd8UXZLC2YQtillbIjEHwSzU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CRLzsPQaijleUSiaJCasbAVhxojO/nGxHrN61Mfj2knMyK06IcUzyPI5H83uqXiIh
	 KNcentuiYqqmbTMlNd9bvKgRx6ZSDOIv0XbaZyuYNrGDMpZqI4SwDIeFeG08A3WRBh
	 9u70BPi6sVEVelmpqLD/rapYsbRMP4Ky/uZU+T8KyprPYcBaLpk5LNLIbbeD8+ttms
	 uO2ffbcnwPSIYByvQh+4mVwmKR9IhR+8/muuGpHWREOr2rdez1JF9gH2SXDUJIfESB
	 OeLrt2Xw2FJ+D2SLAjJQIivXZjbEwAdoKStFZE66ooEl648eu+83FuC6T/MUtXK1Xf
	 tqxLeOZwO7Bdg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 25A1BC41612; Wed, 15 Apr 2026 06:16:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221346] Bluetooth: btintel_pcie (8086:e476) may hang in
 shutdown path (synchronize_irq) during reboot stress test
Date: Wed, 15 Apr 2026 06:16:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangzhigang1996@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221346-62941-puMcSTn4q7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221346-62941@https.bugzilla.kernel.org/>
References: <bug-221346-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221346

--- Comment #6 from Zhang Zhigang (zhangzhigang1996@gmail.com) ---
I would like to provide more details about my system setup, as it may be
relevant to the shutdown hang issue.

My filesystem layout is non-standard. In addition to `/boot` and `/`, I hav=
e a
separate `/data` partition, and several key directories are bind-mounted fr=
om
it.

Current block layout:

* nvme0n1p1 =E2=86=92 /boot
* nvme0n1p3 =E2=86=92 / (root filesystem)
* nvme0n1p5 =E2=86=92 /data

The `/data` partition contains subdirectories which are bind-mounted to
standard system paths:

* /data/home      =E2=86=92 /home
* /data/var       =E2=86=92 /var
* /data/local     =E2=86=92 /usr/local
* /data/opt       =E2=86=92 /opt

Example mount output:

```
aa [ ~ ]$ lsblk=20
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
nvme0n1     259:0    0 476.9G  0 disk=20
=E2=94=9C=E2=94=80nvme0n1p1 259:1    0   511M  0 part /boot
=E2=94=9C=E2=94=80nvme0n1p2 259:2    0  14.6G  0 part=20
=E2=94=9C=E2=94=80nvme0n1p3 259:3    0  19.5G  0 part /
=E2=94=9C=E2=94=80nvme0n1p4 259:4    0  19.5G  0 part=20
=E2=94=94=E2=94=80nvme0n1p5 259:5    0 422.7G  0 part /var
                                      /usr/local
                                      /opt
                                      /home
                                      /data
aa [ ~ ]$ mount | grep nvme
/dev/nvme0n1p3 on / type ext4 (rw,relatime,seclabel)
/dev/nvme0n1p1 on /boot type vfat
(rw,relatime,fmask=3D0077,dmask=3D0077,codepage=3D437,iocharset=3Diso8859-1=
,shortname=3Dmixed,utf8,errors=3Dremount-ro)
/dev/nvme0n1p5 on /data type ext4 (rw,relatime,seclabel)
/dev/nvme0n1p5 on /home type ext4 (rw,relatime,seclabel)
/dev/nvme0n1p5 on /opt type ext4 (rw,relatime,seclabel)
/dev/nvme0n1p5 on /usr/local type ext4 (rw,relatime,seclabel)
/dev/nvme0n1p5 on /var type ext4 (rw,relatime,seclabel)

aa [ ~ ]$ ls -a /data/
.  ..  home  local  opt  .swap.img  var
```



These mounts are managed via systemd `.mount` units .
Key characteristics:

1. `/data` is mounted early with `DefaultDependencies=3Dno`
2. Other mount points (`/home`, `/var`, `/usr/local`, `/opt`) are bind moun=
ts
with:

   * `BindsTo=3Ddata.mount`
   * `After=3Ddata.mount`
3. All mount units explicitly include:

   * `Conflicts=3Dumount.target shutdown.target`
4. Additional ordering is enforced via:
   `/etc/systemd/system/sysinit.target.d/data-mount.conf`

This setup ensures that `/data` is mounted before other system paths and th=
at
dependent mounts are tied to it.

```
cat >/etc/systemd/system/data.mount <<"EOF"
[Unit]
Description=3DData Partition
DefaultDependencies=3Dno

After=3Dsystemd-udevd.service
Before=3Dsystemd-journald.service sysinit.target local-fs.target

OnFailure=3Demergency.target
Conflicts=3Dumount.target shutdown.target

[Mount]
What=3D/dev/disk/by-uuid/UUID
Where=3D/data
Type=3Dext4
Options=3Ddefaults

[Install]
WantedBy=3Dlocal-fs.target
EOF

cat >/etc/systemd/system/home.mount <<"EOF"
[Unit]
Description=3DBind /data/home =E2=86=92 /home
DefaultDependencies=3Dno

BindsTo=3Ddata.mount
After=3Ddata.mount
Before=3Dsysinit.target local-fs.target
Conflicts=3Dumount.target shutdown.target

[Mount]
What=3D/data/home
Where=3D/home
Type=3Dnone
Options=3Dbind

[Install]
WantedBy=3Dlocal-fs.target
EOF

cat >/etc/systemd/system/var.mount <<"EOF"
[Unit]
Description=3DBind /data/var =E2=86=92 /var
DefaultDependencies=3Dno

BindsTo=3Ddata.mount
After=3Ddata.mount
Before=3Dsystemd-journald.service sysinit.target local-fs.target
Conflicts=3Dumount.target shutdown.target

[Mount]
What=3D/data/var
Where=3D/var
Type=3Dnone
Options=3Dbind

[Install]
WantedBy=3Dlocal-fs.target
EOF

cat >/etc/systemd/system/usr-local.mount <<"EOF"
[Unit]
Description=3DBind /data/local =E2=86=92 /usr/local
DefaultDependencies=3Dno

BindsTo=3Ddata.mount
After=3Ddata.mount
Before=3Dsysinit.target local-fs.target
Conflicts=3Dumount.target shutdown.target

[Mount]
What=3D/data/local
Where=3D/usr/local
Type=3Dnone
Options=3Dbind

[Install]
WantedBy=3Dlocal-fs.target
EOF

cat >/etc/systemd/system/opt.mount <<"EOF"
[Unit]
Description=3DBind /data/opt =E2=86=92 /opt
DefaultDependencies=3Dno

BindsTo=3Ddata.mount
After=3Ddata.mount
Before=3Dsysinit.target local-fs.target
Conflicts=3Dumount.target shutdown.target

[Mount]
What=3D/data/opt
Where=3D/opt
Type=3Dnone
Options=3Dbind

[Install]
WantedBy=3Dlocal-fs.target
EOF

mkdir -pv /etc/systemd/system/sysinit.target.d
cat >/etc/systemd/system/sysinit.target.d/data-mount.conf <<"EOF"
[Unit]
Requires=3Ddata.mount var.mount home.mount usr-local.mount opt.mount
After=3Ddata.mount var.mount home.mount usr-local.mount opt.mount
EOF
```

However, I suspect this layout might be contributing to the shutdown hang,
especially during the late unmount phase. Since multiple critical directori=
es
(e.g. `/var`) are bind-mounted from a single filesystem, there may be order=
ing
or dependency issues when systemd tries to unmount them.

The issue still occurs intermittently and typically at a late stage of
shutdown, where logging is limited.

If this filesystem layout or mount configuration could potentially trigger =
such
behavior, I would appreciate any guidance on how to further debug or simpli=
fy
the setup for testing.

Thank you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

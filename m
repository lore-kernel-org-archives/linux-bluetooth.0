Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83985260
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716585541; cv=none; b=c0f+TksMd/Gq/2GrrGr2LHLBxILkdz7+fq0oa7589TfX7wxvnEu9V7Xe5GxJg2Cm7uD7sdk9TOQRnKOxqjjfKbkL/xnAFcUJSV1VmWAQYVS6t4SEuYchxLPQmX7itLefK4cj3f9Xp3KE7grfHTUAvQIF4VWlASih8RjVnNoAiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716585541; c=relaxed/simple;
	bh=didW0BQK1LpDm6K79IR/y2MmGOIhtjjY59vlYGqD5Sk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQw0gzStGdU57UngN1IoKjm6CQJge+B0xw2OIT0c4B3n23h0brkFbD/Vt6bTxCE9rEPi6eQpR+66eDfgo2yhcMXP9Tg9xepisA9gfk/OHdGmTZJSr6v7GGTsFQQp7tQMpFznBKU84wF5VAl21fCdHZZJz4oRJ/ww1EfIdchp5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFK4fsEN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFK4fsEN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8850C4AF08
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716585540;
	bh=didW0BQK1LpDm6K79IR/y2MmGOIhtjjY59vlYGqD5Sk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nFK4fsENX3qDmSRMpSQ2lTpJY2eRhzsiReRnuUslb4RMlMITc21NItbh6FFTjnA7Q
	 oRCu6XTXsF8YClmyIz1GSi1Vuh4bUMucBEkU9MEIJnYaYbWA9+s2gXrjulFKGFGlZW
	 DPycvNj/kRijdQI0Qp/pR8xlto+46sDqAKySBXf0FhbOoO1kYMwHGjvJvIITcNY6mV
	 TzolumHx2IuUFIF3K8v91ocjT2qpfaoRIwTe2vB9ej0MLADR/gX760gXmSfZht0XC8
	 nCMRyfw4gYkxZsL8HUqOCDYeV06QLxky/PuT/Z2hOujjze3ywIHK2PgZZ0mTfpQWOy
	 SZ2WbEdEwqd5w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DD25FC53BB8; Fri, 24 May 2024 21:19:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 24 May 2024 21:19:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickolas@gupton.xyz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218416-62941-Fz5FGUyCVm@https.bugzilla.kernel.org/>
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

--- Comment #32 from Nickolas Gupton (nickolas@gupton.xyz) ---
Created attachment 306340
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306340&action=3Dedit
dmesg log

(In reply to Paul Menzel from comment #26)
> @nickolas, from your bug description it=E2=80=99s unclear, if this is a r=
egression,
> or if Bluetooth never worked for you. Could you please clarify?
>=20
> Please attach the output of `dmesg`.
>=20
> Also, please run `bluetoothctl` and share all the output.

The issue is still presenting the same as originally reported, bluetooth do=
es
not work on boot and requires the reset script I provided before it will st=
art
working. The only difference between then and now is that one log is missin=
g.

Here are the extra logs you've asked for, the dmesg log was quite long so I
attached it as a file:

# dmesg
(see attached file)

(before running the reset script)
$ bluetoothctl
Waiting to connect to bluetoothd...

(after running the reset script)
$ bluetoothctl
Waiting to connect to bluetoothd...[bluetooth]# Agent registered
[bluetooth]# hci0 new_settings: powered bondable ssp br/edr le secure-conn
wide-band-speech=20
[bluetooth]# [CHG] Controller A4:B1:C1:D5:F5:24 Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]#



(In reply to Dustin from comment #27)
> This is a regression. It has been broken since 6.5. It worked fine in pri=
or
> kernel versions.

I believe your issue is different than this one, this issue has been report=
ed
starting in 5.16 on the original bug linked that they closed and asked for
someone to make a new issue if it was still present.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

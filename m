Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90D82D8C
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634313; cv=none; b=XqO47FSZdlO97qpJcOsNDUv4nc8xJZcflJ+Yuzrl0hERKoBdO6U+hY1CzMSaHvNOIURGVHR6h657A/+6wGeE0f0c8rHXucS6K54YaSHXYyOc8c4f9Cgp8K90UTI1Hg6wp/s69GwczE0VYCutWUsgk5MlVKn1+ts2uhx/HYknqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634313; c=relaxed/simple;
	bh=xC0Pe9Gl/+58zxMAgVR4XtYgcioRe4pUgBuT+1n0pHQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qbi7xGz37P3M+eegGDJrZ5zoIPqp7coUDuyqcEW8caSLFW+EUdtCxgUftJ6M3blfdK0eYuMnsWlJLJMQO5x/YLjD4nXCPBuepSI8uL8Gt58ACIJ4q6Gk9cv4kHpUxZtIqPqWJZFZnjzUd6uttzMpd1kR9ZuexEFBX7Ie/+EWgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA/EJG5w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA/EJG5w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D717C433C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 17:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706634313;
	bh=xC0Pe9Gl/+58zxMAgVR4XtYgcioRe4pUgBuT+1n0pHQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jA/EJG5wgYgD1pufxCx/NuXGPRDaGrlKxXj0FxzWwwx2xHnoSWqWHPN04K3mUCLpa
	 RRJgA6MzHo1B3HJrdrTmaDPZntjyjoPfjA4j45zm9Blkyd35VZN472TS17Ed4/zPxY
	 6XS4I5y1VIk829fqKvOx+b1OGJ9o/I7f5ZaF2juUvfDD8Up8iv6NyEO5MTADAEGhmS
	 AQoOHpn/1k6WN3MlzqyvWxrhCUf29za31IULn9hjYEpSwr5olQFgZIP30HeRBKr0/B
	 Vs/oy0/B5zHhVTtLxTeuDLnBtPmPSLM6itmYwwLbaMepIovX3W3tfypXv1E+HgD/pE
	 CZF5kjKN1Z0hA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CF50EC4332E; Tue, 30 Jan 2024 17:05:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Tue, 30 Jan 2024 17:05:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dustin@falgout.us
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-7g5k4B0wMR@https.bugzilla.kernel.org/>
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

--- Comment #2 from Dustin (dustin@falgout.us) ---
I'm also experiencing this issue. It started with kernel 6.5. Bluetooth has
been broken ever since. The issue was not present in earlier versions of the
kernel.

```
$ uname -a

Linux 6.5.0-17-generic #17~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Jan 16
14:32:32 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
```

```
$ lsusb | grep -i bluetooth

Bus 001 Device 004: ID 8087:0032 Intel Corp. AX210 Bluetooth
```

```
$ journalctl -b | egrep -i bluetooth

Jan 30 10:28:53 systemd[3247]: Reached target Bluetooth.
Jan 30 10:28:53 systemd[1]: Reached target Bluetooth Support.
Jan 30 10:28:55 kernel: Bluetooth: hci0: command 0xfc05 tx timeout
Jan 30 10:28:55 kernel: Bluetooth: hci0: Reading Intel version command fail=
ed
(-110)
```

```
linux-firmware/jammy-proposed,now 20220329.git681281e4-0ubuntu3.25 all
[installed,automatic]
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

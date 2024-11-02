Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED3157A6B
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730586412; cv=none; b=t2oTXwcJ/LlM3GANa1RrYbgEsCO247Jf19Zlp+S9qhMMvV7PTQVkxGnwfD7zqHcKaAX0mCK/VOTTKrdv5XFvgL74BHySaYefDvcpwaeDLOkez3BsXSviABzQatn4vUmHYqQARbEK1l19hUtsDlfoCCorAg69/WQfzhxoY1k8bjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730586412; c=relaxed/simple;
	bh=6GFY93GwHgRY0jkNP6nWfH62aVoVxk5t3IGuBDYEtqw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZUw7I7WXhv4tXrfzzvXA+sAEQg63rkbFObeXM7Z0F1fzZkn436sOwTZR0jDBW90szVr+wAF2CxJbUKlJ/lIxyMRptnp892mhfaoORTXcoElmNHA9UJMRlJUEQrlZxOrOTuOAJHAWm6i80cOZ+eDebZOZx0yW4A5p3WI7covrKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ4wpdBJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ4wpdBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 177B3C4CEC3
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 22:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730586412;
	bh=6GFY93GwHgRY0jkNP6nWfH62aVoVxk5t3IGuBDYEtqw=;
	h=From:To:Subject:Date:From;
	b=BZ4wpdBJcpgLic76Nd+dE3qUSyeLMia5wZZbYbu8MlCNvOlLdChWp5M4nMiJha4+r
	 9vy+VyVNOdILLS3pw19sIZujHjHktNgUWjfBGeLBSLvlflOmcp3Vv5oGzQf3rtzqUU
	 1eF+ZBNsNo01JtXxx9g/AM4mtpkb/cROhx0M24qHRKO0y4HvlBCj/MKAckAVs8q9Zm
	 JBlPtE71SZwiLN4gnOLk/55GYYoeZx8NcYjq3WISg+DPid/guYrFoW+7tppEtqukE2
	 tSezCCmGP+6MIvLWPgkvtc2sQo6tSCXnbcgWnJTMAfoDHcxKxzyDXppyDxm3Cc/5GF
	 fv1Qla7cPbLlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 07D05C53BC2; Sat,  2 Nov 2024 22:26:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] New: bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Sat, 02 Nov 2024 22:26:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ghibo@mageia.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

            Bug ID: 219458
           Summary: bluetooth connection fails after L2CAP: Fix uaf in
                    l2cap_connect patch
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ghibo@mageia.org
        Regression: No

Hi guys.

After a recent kernel update I get problems in bluetooth connectivity. Most=
ly
some bluetooth audio devices (like speakers or headphones) are getting very
difficult to connect, even if already paired. And when the connection is
finally established they do not seem to do it in the correct way, to the ex=
tent
that the devices are not later correctly attached to pulseaudio or pipewire,
and not listed there. I thought the problem could be in bluez's bluetoothd,=
 so
I tried several version of bluez, up to 5.78, including the current git
version, but mostly the behaviour hadn't changed.

I noticed this behaviour in 6.6.59 (including up to the current stable-queue
for 6.6.59 as of today, which will be merged into next 6.6.60). Ditto for
kernel series 6.11.x, in particular 6.11.5 and 6.11.6 show the same behavio=
ur.

After a long series of attempts, I found the culprit can be traced back to
these single patch with subject "Bluetooth: L2CAP: Fix uaf in l2cap_connect=
":

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/releases/6.6.55/bluetooth-l2cap-fix-uaf-in-l2cap_connect.patch

and

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/releases/6.11.3/bluetooth-l2cap-fix-uaf-in-l2cap_connect.patch

which were included starting from kernels 6.6.55 and 6.11.3.

By reverting this patch, the connection with the device gets back working a=
gain
like a breeze, either at connecting and disconnecting several times in a ro=
w,
while before this reverting the connection was pretty clumsy.

Apparently this patch was for a security fix, but probably it's still
incomplete, as there is this side effect.

Difficult to track in logs, as logsa are pretty verbose anyway, as even in a
situation where a connection working there are a lot of warnings; mostly in=
 a
broken connection with the patch included, logs are like:

bluetoothd[10741]: Failed to set mode: Failed (0x03)
bluetoothd[10741]: No matching connection for device
bluetoothd[10741]: No matching connection for device

while in a working connection, with the patch reverted, logs are like:

bluetoothd[10863]: Failed to set mode: Failed (0x03)
...
bluetoothd[10863]: No matching connection for device
...
bluetoothd[10863]: /org/bluez/hci0/dev_<mac_address>/sep2/fd2: fd(42) ready

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

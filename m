Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD238333A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119157; cv=none; b=fnGewaovpPtgqH0weIkLq4rrVL5+FzSJoBzgmupmgJ1IebcmKFqahl/BZNMqfpYMbEWQFcqXywGtK8TldnyK/ZmSbYpJS+eegQW2w9SwOGwmyNp8r3d/1Et78+PL0kRLlU8RCM8+HqlJCDUOIYgQiAzH9AATTTac9F4Vt6CQOls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119157; c=relaxed/simple;
	bh=tYij8sBsv8LBqBaFJ/k1HPE1sow/WUQsYKN/JFsEc98=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qzmNE+7iCWV/CHES55o3VVF5ciMSov0hKgsCDDspXPyR6EFkf+DHEFXPfFJgMw51TqJjJpuDjsE6lLsXxtYiVwk9+sKKnPjiyGV9+HBpA/iXnpRCww4hTzfkHypd0dpX+1ImDgXF63e11Qq1TSa4S6ItO4JkX6NJCP2RatPTnWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4zcB27i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4zcB27i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF41AC2BCC7
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786119156;
	bh=tYij8sBsv8LBqBaFJ/k1HPE1sow/WUQsYKN/JFsEc98=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k4zcB27i3mwmmTzqtOj5aFH0mukmL/TUDOsgiYRDmH1o+qNCwHSVqLCEPH0vAOAOc
	 IbxSZvQtSTXIOofXLPhIWqklh2OaiLs52ftTx2mAMRfPM8zWCM+mLHxU9X6DzhsksV
	 5+ygbZM05pRMn/qipIgkqRjjKYr+JzY/CgiIjLzQC4IVOk4QyfigWpYRK68f19mV48
	 wMAQN0D2ecpyoHcTd/eOTEcDo3Ab30fI2UxhPKqqRAc8jYR/CzCsN2+nUuYkpy65lX
	 c+7b2YEfkKwhd8aiRrdmOJ4WtAU33EiXdjRNARdbA+j0dJD8BukmWYsgws21ncyCJu
	 98YISpf/12Wqw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C3C05C53BBF; Fri,  7 Aug 2026 16:12:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Fri, 07 Aug 2026 16:12:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: serge.brun@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221754-62941-F16xdqrXVJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221754-62941@https.bugzilla.kernel.org/>
References: <bug-221754-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221754

serge.brun@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |REOPENED
         Resolution|ANSWERED                    |---

--- Comment #9 from serge.brun@gmail.com ---
Agreed, reopening makes sense =E2=80=94 thanks q234rty for flagging the ups=
tream patch,
and Adam for confirming that mihaits repo works with Secure Boot too (via
mokutil --import, good tip for anyone else on Secure Boot).

To be clear about what's actually been verified so far: the DKMS workaround
(https://github.com/mihaits/rtl8852bd-bt-linux) is a real, working fix at t=
he
driver level. I've confirmed it myself (comment #6) and Adam has too. But i=
t's
a third-party out-of-tree module, not a mainline fix, and per the repo's own
"Upstreaming" note, it was blocked specifically on Realtek needing to publi=
sh
proper firmware support which sounds like exactly what's now happening via
Hilda Wu's patch.

Given that, this should stay open until:
  1. The btrtl firmware-format patch lands in mainline, and
  2. The actual eco-4 firmware for this chip is published in linux-firmware=
.git

Will keep an eye on the patch thread and report back once I can test agains=
t a
kernel that includes it. In the meantime, mihaits workaround remains a
solid stopgap for anyone hitting this =E2=80=94 for the sake of clarity it'=
s a bridge,
not the destination.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

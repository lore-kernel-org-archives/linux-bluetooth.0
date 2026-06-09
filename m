Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605442EEB0
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017693; cv=none; b=OTb9mGfM32rH9fcE25WsfcxBxq/TAjwUW8aDk4B+2M2vdVO9O6itbkaOGBZCbT9PwuDtQOFiQbQHxbWrbWWbfrQeEvbKVKt3hvsfCeC/1l+WGSi1qVSY0IVYBRxyBr+D9zbcWPcBz7YlkYHSBodVeNxPqrETyZb2FQfwtvEMe9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017693; c=relaxed/simple;
	bh=8RQzS/guGeUh9IekreaooLKsffT7w7gVdCLwxOdRxME=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=StPUwsFvXnoXmFmO6rTBhIY+Xz3tz6twFQTprOvz0P8+IDUqbJsxCF6mGrsEiShiJJr2raa/zll+Z32cghfiTH07PzBNUOwAsqNdod326k66bzZlSkhNV42O8DitHn3Agy1cf2OWJz+8gTRayk7Pe8YYYx0Kwl/8GUdZDLNuQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOh602dA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOh602dA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A186C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781017693;
	bh=8RQzS/guGeUh9IekreaooLKsffT7w7gVdCLwxOdRxME=;
	h=From:To:Subject:Date:From;
	b=mOh602dAiGbk/srtjLKI4b7dbl+LoO4a/5CLlCxPTTsKwIU8o2G/glMfHyc6dlNef
	 4loYVjJhPLduPrIeHex0lKOImz57hIk8O+nsed/ZO2wY+9lJt2Y/J0Zb54hwhm9nlt
	 8GYiOKTee14mjcikaTleHui/wPQ7FAn0Atc9dxL1Z31T/F0vIPlwQsqZkp3y8mlfEF
	 jefDMyit5TVmbjymADJkZlmBU7qDomjXdBNlu/fhRrpbKW+Q52C9ih6IB+ZOa4+8ac
	 CKmvQzdJz0Qwx6EoUqNfpIQpHk1DULDY04dshQOnqxflDVWH1a6gQ+yBvfh6JEk8He
	 d8COUuFhNiY2Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4D2E1C3279F; Tue,  9 Jun 2026 15:08:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221627] New: MT7925E - System locks up with flashing caps lock
Date: Tue, 09 Jun 2026 15:08:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tom@helix.me.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221627-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221627

            Bug ID: 221627
           Summary: MT7925E - System locks up with flashing caps lock
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: tom@helix.me.uk
        Regression: No

Created attachment 310284
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310284&action=3Dedit
kernel config and wifi/bluetooth journals

I'm not sure the circumstance that causes the crash, but it doesn't happen =
with
bluetooth soft blocked. I'm guessing it's during scanning. I have no devices
paired, but many bluetooth devices in the house.

However it could still be an issue with the wifi.

I have a MT7925 as my WiFi module with the MT7925E driver installed as a
module. No other WiFi cards are compiled into the kernel.

I'm running on a Framework Laptop 13 / AMD Ryzen 7 7840U on 7.1.0-rc7.

I can't find any logs related to the crashing, however when restarting (hol=
ding
power, then turning back on) Sometimes the TTY gets filled with errors and =
the
system locks up again. I haven=E2=80=99t had this happen for a while but wi=
ll attach a
screenshot of these logs when it happens again.

I've attached my kernel config file and the logs I have.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

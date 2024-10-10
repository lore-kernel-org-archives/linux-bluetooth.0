Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC83E479
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Oct 2024 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529537; cv=none; b=HNYn/ayJL+dTV9wCZNdkrt+RBzXY1CIkT3b7wvSzMZKZa3mAuVom6qSXKJxqD6kKuNymb9WlyEUm8n8ieuYLYO4BZf1iKbd+FYWJaA0HVmDdj8/LGShM84Ch86gzhFeLsA+ir+dxoky/9DK/I+bPPDsiY9j3t+rU/OwrQ56PJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529537; c=relaxed/simple;
	bh=4MdDR7Jnj7sbj4UC+yQE24HLtU7POYUSVRhokX0IsgQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hsRGTqH0UVNMYBQ2AoElvkdwukBw4vmgdNx6cKrA0K/pSWtANeGfLBEgyMWENmIS4B29Rzp1SWmoX1GMSJlYIbSu/Ct8IZIznaNjcAUcpnT2w1DmnnpUB5UxBx1afJiQU79prY6fJkThdGH9PVjbHjKMF6Sa8J/AqheraUmb3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNfGR0pB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNfGR0pB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C89AC4CECF
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Oct 2024 03:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728529537;
	bh=4MdDR7Jnj7sbj4UC+yQE24HLtU7POYUSVRhokX0IsgQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GNfGR0pB8UREipIBqr6fvhDRgWUkuv1EurPbi3YpMDCFiSe7Hm20omh1/eMV4U/gt
	 M6dYH/qSua++B85b/ZfsF5p4PCz6X3XiKAhLzAX8x9rjApEplaZxPSXz4dS6fdXSPT
	 tOorFcM4CfP9ZRFDMFZU/wIuewx+nRCS4aqygytCVWUnu849Eofg+nl1aNV8/x5jkR
	 1mkBqmqDlWREfGAnQw+1/ogwR5T+psxB9CJH6WuOwXAoiqweldF7US8SEEgouoWq59
	 L9YwW+KENYKt9yF+hnMY2HzxmDUstBS6dlzU2vowoDeR2NyZJzktK+2ChbhaQqlhnz
	 aSmXwGCfVNP8A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3561FC53BCB; Thu, 10 Oct 2024 03:05:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Thu, 10 Oct 2024 03:05:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: adilson@adilson.net.br
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219365-62941-AQeh0k4lKh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219365-62941@https.bugzilla.kernel.org/>
References: <bug-219365-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

--- Comment #8 from Adilson Dantas (adilson@adilson.net.br) ---
Created attachment 306998
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306998&action=3Dedit
Trace usbmon file from a kernel with the fault commit.

Trace usbmon file from a kernel with the fault commit.

My BT Dongle fails when it is plugged.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

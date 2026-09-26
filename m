Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1D3655EC
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790456160; cv=none; b=j1vxWIDLJEvbvORYtys7Jdm9XG7J1QYA6wgF5XHndXSS5J85XRobcoGFXPLBmqs4kKQHkr1wX4wdo0q+YhKIr7C72uN4Lov1n+WOaare+X6vaqBD9H0fm7DQ1u2OKHtD4BUpDjoJkIzviWSKvHRuGMR8n/2LX5uEKMn5Q87Cc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790456160; c=relaxed/simple;
	bh=osEW03ROYnRlF4+9bLa4qn0UC/YwrajfExYiQlQbA6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/hMdaRCVoscRS8lpJZ89di/3z4hlh0Sn9JEs7hRwe58NgpDdR6gsLVLntkYJwtTcV/8fzZuKm+OMg1NzxP7ErRfvCbZFedCgIutSaOJ9cdKw9bCAtsC4n3ENtTHH3OqohgZsSEbBNf6jIAlKEVSo4oG9z8tg030n3gWUtCIWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEPwcNAC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEPwcNAC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AC35C2BCF7
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 20:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790456160;
	bh=osEW03ROYnRlF4+9bLa4qn0UC/YwrajfExYiQlQbA6k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QEPwcNACJ6IkHpwt7tEhdNIwWGck27/o9PSCiXMKHYhUmbTzsjyUlm89HqLzs6Nod
	 3NpBVPjnM1vsnY/RdR7eWOeTabXJxgMhkAyNzvCsfjCj3F5TorTb0tIEOy0PXvdSm8
	 h9Qi5aXjXB0r8Kz5lgOIg/k0scq/FTF9b6NQfw5wT+Ut+++s5H+WzCc8XNMX+yoYUC
	 KAoX8buhr3/LSFFVrYfHUqM05h9pLFezw7gvB8TJqGoo0/TruRNXwvvqOE2K860ceK
	 SwTpMbSOsXpg778XeSsjzmJLQGGUIzCcy1N7Fc0YIn7wapBw0jSorHhK+CpdFEvimC
	 /8X94uXThiOnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EE48CC433E1; Sat, 26 Sep 2026 20:55:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Sat, 26 Sep 2026 20:55:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: virtualfoxyloon@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221754-62941-Y9oW7wOFMk@https.bugzilla.kernel.org/>
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

FoxyLoon (virtualfoxyloon@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |virtualfoxyloon@gmail.com

--- Comment #10 from FoxyLoon (virtualfoxyloon@gmail.com) ---
I'm also having this exact problem on my computer. I have a Lenovo LOQ
Essential 15ARP11. This card also reports =E2=80=9C0bda:b853=E2=80=9D and =
=E2=80=9Crom_version=3D3=E2=80=9D with
the same symptoms described.

However, I tried to apply the fix by following the instructions, but
unfortunately, I was unable to do so. I get the error =E2=80=9Cerror:
rtl8852bd_mp_chip_new.dat not found...=E2=80=9D. I downloaded the Windows B=
luetooth
driver from Lenovo=E2=80=99s support page for my computer model and followe=
d the
instructions as stated, but I don=E2=80=99t know why it doesn=E2=80=99t inc=
lude the required
.dat file.

I downloaded this one specifically from my computer=E2=80=99s model page (i=
t was the
only one available there as well):
- Name: Bluetooth Driver (Realtek, Mediatek)
- Version: 8852BE_18.4032.0.3008,MT7920_25.20.5.20
- Date: Aug 18, 2026

I also don=E2=80=99t know which other driver might have this necessary .dat=
 file, since
it was mentioned that it=E2=80=99s not something found in just one place or=
 specific to
a single brand, but I=E2=80=99d rather play it safe.

So, I=E2=80=99ll be waiting for them to fix this kernel bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

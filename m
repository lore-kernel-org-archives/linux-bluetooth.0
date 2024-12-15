Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB9189F20
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Dec 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296766; cv=none; b=qwJhsGeb5OD4ey2SZeoqAILIJszPOaORAr73FGkLQGf0Mno2oxwjdHlm/UACld2xERiNzC7RVSG5OZFGG/KkhKjVeH7sPZKDDL/vO76VUnYh8ttKGdaajdc+CqSIUXfD1lyffqEbKjf2eRACbh0ErpQA6F8u/n/a+g8+rZVoj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296766; c=relaxed/simple;
	bh=oovXPkK7murpuRWTPBN3BotIlOv0ecFw7SXF7+cShBk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VOG/8aLlM8in0//LEqqMKpHtpfVmBJQXSvJYJtBDrvvwR+CG3r6M32MpyD/VftSaRbRLj3kAP/HvPRRZaJWrYG3Oc4qp7A6XKUP3yydz85b1no6iB9LgLuHdYu9TbOfA6U8j6WCdPcD72DL2e5TEKLCrw9uCLvf1j/B5lHqJSfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjSKBfed; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjSKBfed"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C990C4CECE
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Dec 2024 21:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734296765;
	bh=oovXPkK7murpuRWTPBN3BotIlOv0ecFw7SXF7+cShBk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jjSKBfednbQ+Y/vSCL+wsopaYdUYwvA2OKrV3E9FyQ2MjYeTmihIB7k04G9Rc+kvN
	 NLCSHAYrJulry1wXAnLoOdb3P94Mf0SyNLT0LAqFIMLUyEyJG22b9LP8u4Vbl0a3Rh
	 DbwBx5Cl5AUWPl8j9r+LlVpCT+JhYIYBNDiq+1IJ7ofXJH4tN03CgUhGjATH97xRSl
	 jBe7I5DTYYku47UFPq8oncHLfzq+qce0lR0CbDbRlMHFv+Q/s91y7VWJK+PwojX0I3
	 LRIys9JNPxHfq1ULYfbMUZrAAKeuLQuB0PJQas/SAGlOMBcE0SLPL2epcWfMdvj+Cn
	 Pq7Cc1EHJdmyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7ABAFC3279E; Sun, 15 Dec 2024 21:06:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Sun, 15 Dec 2024 21:06:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: h@realh.co.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219514-62941-ESnLv8F142@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

--- Comment #2 from Tony Houghton (h@realh.co.uk) ---
I've copied btusb.c and btmtk.c from 6dc22ab9f085 to a checkout of 6.13-rc2=
 and
changed a few lines to make it compatible with some things that have changed
since then:

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index fe3b892f6c6e..9eeddbb7d991 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -6,7 +6,7 @@
 #include <linux/firmware.h>
 #include <linux/usb.h>
 #include <linux/iopoll.h>
-#include <asm/unaligned.h>
+#include <linux/unaligned.h>

 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 034256c399dd..0e5cc454e2f9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -17,7 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/gpio/consumer.h>
 #include <linux/debugfs.h>
-#include <asm/unaligned.h>
+#include <linux/unaligned.h>

 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3887,8 +3887,8 @@ static int btusb_probe(struct usb_interface *intf,
        if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
                set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);

-       if (id->driver_info & BTUSB_VALID_LE_STATES)
-               set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+       if (!(id->driver_info & BTUSB_VALID_LE_STATES))
+               set_bit(HCI_QUIRK_BROKEN_LE_STATES, &hdev->quirks);

        if (id->driver_info & BTUSB_DIGIANSWER) {
                data->cmdreq_type =3D USB_TYPE_VENDOR;

Some guesswork was involved, but it seems to work for me. I'd like to try to
get to the bottom of the issue so I don't have to keep patching my kernel. =
Are
there any options I could try?

I've got plenty of experience with C, but not with the kernel, so if you co=
uld
give me some guidance such as a summary of what changed in ceac1cb0259d, wh=
at
code paths are taken during suspend/resume and any code tweaks I can try, it
would be much appreciated.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

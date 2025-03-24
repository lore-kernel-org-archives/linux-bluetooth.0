Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A46854723
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823157; cv=none; b=LUN293mujrwXCZKsFJlxR1yvNHQrcXd0IPeeCMUUvdw94Sz4IJJabQn96xuhhPlHkrdNfmaCHr2GKdezQBtI6jLm+U2YKlR0UNYh2Xcfr+vCzpWVzHJ2g3MNVokJkhwCsD9y+eeyNe/xDORsZP6bd4rbzWLrFVJFN/EyzoGZb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823157; c=relaxed/simple;
	bh=xw33ul5otK75LJnNogfaYSYOdEPHSNqaLG6pJULjvQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9aW2OTYEjXnhg/rJR6YLWjlARX1ioGKW15IYyjhoRGZLWvWJzLcoN5PMYeUDCtPHWs7rx40thrQik/uyrQ77nPBGB5sMrCCFdGl7LgERp1rhQCheWzxC5vTTbnHLz+mNq6R2gAwXTcqO1aPblSZlQt78lBc6ogwH57p3Y7S0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZUq9xMf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZUq9xMf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1F5BC4CEEA
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742823156;
	bh=xw33ul5otK75LJnNogfaYSYOdEPHSNqaLG6pJULjvQQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DZUq9xMfUCCV0SLyHAwKUhaYVzObSwFwOOMm0fwgVoLsiLb227euWoICAatpBa8cz
	 euVKq8goBam3RrgvzYuNNcVC0RJ8jXa+nBCQ6n/WbQEHX7CIOE1wb2rF/pZ4kqhCR6
	 K2cXvtpQ6ZewJwGvLKpP0KUSMPX66yZAUMiiXFhLw9YVww33WM320vI90sHE+thLvO
	 RpR0p2FhvC6cxZEChMUiLJzuB8WgLsZdvSEHY4JQtp0ebx/KKlw4KXEesqplAH28v3
	 qU8rgPKVm+p/njtQw6SkzUct1ca9VgRjlpSJGsJcow9JY9MGTcWybkuI780dprJhoD
	 unIyFwQOCc/TQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AAF2AC53BC5; Mon, 24 Mar 2025 13:32:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219553] Intel Corp. Bluetooth 9460/9560 Jefferson Peak (JfP)
 not able to connnect to Logitech MX Master 3S
Date: Mon, 24 Mar 2025 13:32:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ike.devolder@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219553-62941-U0tjO3Dvzh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219553-62941@https.bugzilla.kernel.org/>
References: <bug-219553-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219553

Ike Devolder (ike.devolder@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ike.devolder@gmail.com

--- Comment #2 from Ike Devolder (ike.devolder@gmail.com) ---
Hi,

I think this is the exact same issue encountered on the Starlite Mk V

I have bisected the issue with a generic LE bluetooth keyboard here:
https://github.com/StarLabsLtd/firmware/issues/180#issuecomment-2732540740

And currently have that keyboard working on the Starlite Mk V with kernel
6.13.8 as it was working before with kernel 6.1.131 lts.

The change made to have it work is the following:

```
commit 49de268ad2d7f217579090da90a5d93cad281477 (HEAD ->
refs/heads/blackikeeagle-starlite-btintel)
Author: BlackEagle <ike.devolder@gmail.com>
Date:   Tue Mar 18 09:06:21 2025 +0100

    Bluetooth: btintel, don't reclassify signal for GfP2 and GaP

    Should fix issue with LE devices not being found or able to connect.

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d496cf2c3411..4ecebae58792 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3249,9 +3249,6 @@ static int btintel_setup_combined(struct hci_dev *hde=
v)
                break;
        case 0x18: /* GfP2 */
        case 0x1c: /* GaP */
-               /* Re-classify packet type for controllers with LE audio */
-               hdev->classify_pkt_type =3D btintel_classify_pkt_type;
-               fallthrough;
        case 0x17:
        case 0x19:
        case 0x1b:
```

https://gist.github.com/BlackIkeEagle/630e76164d9eca5f1eb617888c7f1576

This is not the real fix I guess since that reclassification of the pkt_typ=
e is
not there for no reason. But the skipping of it works around the issue

Hopefully this helps someone to find the actual issue

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

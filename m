Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1892A1BA
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825838; cv=none; b=bdQf9v5r06kc+9hSF12lhQzHWayy9CDt6TZ5EBmUPuK9P0dFtrd9WoyTS5Ibp2HKnwwYQ4D0/UKi9f/L5HTxeTgKhIL2s20o6L9ziD+1A92eP1Vk9Q7ae8EX9x9KKHS4O17Bbs+w3mudBEFpf13Py5Zn8cKl835kgeyAwyt7kPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825838; c=relaxed/simple;
	bh=txdmrJiKB6UbVhI7xYqWq6iDl3PxMKq4BO9QZw3HnbA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LbVlCAlQOe5pA6eE9v9PfXtOt7lOjqJjXZlV2kgFR/hPPbfoM9GEjFuyXnR/39o80nijW0mq1knQqiOaa8T2UlEp/CbfwhgJ2zGg3w1EE+zrse1YxxaG5QL9DzOQQ0s07G2JmenYvD4JIL2vFyu588GwST2uUeW0QcM8zWuf+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvR9cnl1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvR9cnl1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B43CCC4CEE9
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742825837;
	bh=txdmrJiKB6UbVhI7xYqWq6iDl3PxMKq4BO9QZw3HnbA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BvR9cnl1y6n4pC/JDrdgha5mvfEMmzGAOjqm2jnRg6nlxPdJxcxEMAWVDN40+GnXg
	 pvQQVpvUnhA13jR9Op75JNLOopTCOHWO4KNWPgKAUhg5BzIl89pQimLrzET6BTf/D4
	 3/R8vefncEOPNktWemNTa7zyynFdZM9398zC0Ca1iSadbCwxZIAWM7//+tGp8fGg7F
	 WwZojGmgnT35vYncgxk43XbbeVTjkrZcQ7d0uRYwWMqWs3tOAzNzUNewDO8Zd60NhK
	 24U47NoOo+r3M2ukxu3PyjaX26CFA6+KcuY3FYVnsm3bUomQDYAnpvRl+x7xtDsERK
	 W37b11NfsWolQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A3137C41612; Mon, 24 Mar 2025 14:17:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219553] Intel Corp. Bluetooth 9460/9560 Jefferson Peak (JfP)
 not able to connnect to Logitech MX Master 3S
Date: Mon, 24 Mar 2025 14:17:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219553-62941-kXBiFFbVqD@https.bugzilla.kernel.org/>
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

--- Comment #4 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Ike Devolder from comment #2)
> Hi,
>=20
> I think this is the exact same issue encountered on the Starlite Mk V
>=20
> I have bisected the issue with a generic LE bluetooth keyboard here:
> https://github.com/StarLabsLtd/firmware/issues/180#issuecomment-2732540740
>=20
> And currently have that keyboard working on the Starlite Mk V with kernel
> 6.13.8 as it was working before with kernel 6.1.131 lts.
>=20
> The change made to have it work is the following:
>=20
> ```
> commit 49de268ad2d7f217579090da90a5d93cad281477 (HEAD ->
> refs/heads/blackikeeagle-starlite-btintel)
> Author: BlackEagle <ike.devolder@gmail.com>
> Date:   Tue Mar 18 09:06:21 2025 +0100
>=20
>     Bluetooth: btintel, don't reclassify signal for GfP2 and GaP
>=20=20=20=20=20
>     Should fix issue with LE devices not being found or able to connect.
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index d496cf2c3411..4ecebae58792 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3249,9 +3249,6 @@ static int btintel_setup_combined(struct hci_dev *h=
dev)
>                 break;
>         case 0x18: /* GfP2 */
>         case 0x1c: /* GaP */
> -               /* Re-classify packet type for controllers with LE audio =
*/
> -               hdev->classify_pkt_type =3D btintel_classify_pkt_type;
> -               fallthrough;
>         case 0x17:
>         case 0x19:
>         case 0x1b:
> ```
>=20
> https://gist.github.com/BlackIkeEagle/630e76164d9eca5f1eb617888c7f1576
>=20
> This is not the real fix I guess since that reclassification of the pkt_t=
ype
> is not there for no reason. But the skipping of it works around the issue
>=20
> Hopefully this helps someone to find the actual issue

These are not the same controller as the bug description suggests, so if you
are having something with GfP2/GaP that is probably something different.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

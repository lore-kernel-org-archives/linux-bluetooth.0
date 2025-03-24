Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AE6125
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826758; cv=none; b=QUKC8/Lmd+jTWIO68ZpU90+YNgmunexXYTPj5o+MICk325hDl55qFjLrWTgCfxNDsT83LAnOvwn4GkZAyGBEYJHqMVxamwHWJOHp9jk63I7K0W0HREqVWnelIr3Qt+hQ/DCay5m+M/vSqCk5S5Paz/4OUSBMsqHtPY3QI8e1RwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826758; c=relaxed/simple;
	bh=IoLd2bL1f8a2XMA/Q2GSioBcTON/2HZlFQRZmEBrksc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=joqJvZmUwkiBre/nD8rxVN7jey9CzJj4LLHewyjneKgjw9CxbZg1WmBZYQaxarB5JNU2pb0T7c3rqHQfRhajuRqaElk2gefDP2KwcrgJp0z1UK6V6+KCyZUPLkuY3maMTPztR6sOOrK9B8Mf2shMhheltMGsP/c+0aVvRWH9ELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrhwDjvD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrhwDjvD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F40A2C4CEED
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826758;
	bh=IoLd2bL1f8a2XMA/Q2GSioBcTON/2HZlFQRZmEBrksc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WrhwDjvDGSa/3PqY/SfgYwKgAlHLnKI5R80iMg8bRt1mOKGMrgbzUXUp2fXrXL7Sj
	 NAU7/EMOOdJT2feCct1F2uewHv+gwRdWq57JJ2WM4uX+C2Zci84rH4AGaAXqggzuow
	 3tK3cweuqepHp/ApcC5VgfD5T9iCEVHKDAB08HgIhgJLRnPnrVsJcLGEY3ucMuoHdY
	 q14DiVBg6vKV9e1zBxPzVX1JmpV9JvNDIqkpjLPRKN5slmLZagQjg50E/MfCE0vxez
	 XG3W72hUo+ZYlHBASlzvK5PVx5zdtNPSrJZ65kd/XAy7iO45izBaxKcPrg9GOsNsCU
	 QTtL1oYXq6uRg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EB3A9C41612; Mon, 24 Mar 2025 14:32:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219553] Intel Corp. Bluetooth 9460/9560 Jefferson Peak (JfP)
 not able to connnect to Logitech MX Master 3S
Date: Mon, 24 Mar 2025 14:32:37 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219553-62941-AgwS8d2xEO@https.bugzilla.kernel.org/>
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

--- Comment #5 from Ike Devolder (ike.devolder@gmail.com) ---
(In reply to Luiz Von Dentz from comment #4)
> (In reply to Ike Devolder from comment #2)
> > Hi,
> >=20
> > I think this is the exact same issue encountered on the Starlite Mk V
> >=20
> > I have bisected the issue with a generic LE bluetooth keyboard here:
> > https://github.com/StarLabsLtd/firmware/issues/180#issuecomment-2732540=
740
> >=20
> > And currently have that keyboard working on the Starlite Mk V with kern=
el
> > 6.13.8 as it was working before with kernel 6.1.131 lts.
> >=20
> > The change made to have it work is the following:
> >=20
> > ```
> > commit 49de268ad2d7f217579090da90a5d93cad281477 (HEAD ->
> > refs/heads/blackikeeagle-starlite-btintel)
> > Author: BlackEagle <ike.devolder@gmail.com>
> > Date:   Tue Mar 18 09:06:21 2025 +0100
> >=20
> >     Bluetooth: btintel, don't reclassify signal for GfP2 and GaP
> >=20=20=20=20=20
> >     Should fix issue with LE devices not being found or able to connect.
> >=20
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index d496cf2c3411..4ecebae58792 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -3249,9 +3249,6 @@ static int btintel_setup_combined(struct hci_dev
> *hdev)
> >                 break;
> >         case 0x18: /* GfP2 */
> >         case 0x1c: /* GaP */
> > -               /* Re-classify packet type for controllers with LE audi=
o */
> > -               hdev->classify_pkt_type =3D btintel_classify_pkt_type;
> > -               fallthrough;
> >         case 0x17:
> >         case 0x19:
> >         case 0x1b:
> > ```
> >=20
> > https://gist.github.com/BlackIkeEagle/630e76164d9eca5f1eb617888c7f1576
> >=20
> > This is not the real fix I guess since that reclassification of the
> pkt_type
> > is not there for no reason. But the skipping of it works around the iss=
ue
> >=20
> > Hopefully this helps someone to find the actual issue
>=20
> These are not the same controller as the bug description suggests, so if =
you
> are having something with GfP2/GaP that is probably something different.

Oh, I did not realize it could be a different chip, I looked at the opensuse
report and saw the same firmware `ibt-0040-2120.sfi`.

Do I have to create a new ticket for this?

Some info about my bluetooth:

```
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Device revision=
 is
2
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Secure boot is
enabled
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: OTP lock is ena=
bled
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: API lock is ena=
bled
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Debug lock is
disabled
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Minimum firmware
build 1 week 10 2014
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Bootloader
timestamp 2019.40 buildtype 1 build 38
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: DSM reset method
type: 0x00
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Found device
firmware: intel/ibt-0040-2120.sfi
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Boot Address:
0x100800
mrt 23 00:53:25 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Firmware Versio=
n:
151-5.24
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Waiting for
firmware download to complete
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Firmware loaded=
 in
1917199 usecs
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Waiting for dev=
ice
to boot
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Device booted in
17233 usecs
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Found Intel DDC
parameters: intel/ibt-0040-2120.ddc
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Applying Intel =
DDC
parameters completed
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Firmware timest=
amp
2024.5 buildtype 1 build 151
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Firmware SHA1:
0x00000000
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Fseq status:
Success (0x00)
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Fseq executed:
00.00.02.36
mrt 23 00:53:27 archlinux-Yjk4NzBh kernel: Bluetooth: hci0: Fseq BT Top:
00.00.02.36
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143712206BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716460; cv=none; b=UMtfnay3PFzxqVfxT7XeY+c9Hl+11o2MV6iLnicDPpGzXWURzVF0VROOKfI4mvXPkv2jE3yn0yaCDpjFzO1Pfy9m1pH0SkQb39nggiQt8+PLMNe53D8VkVYr9IWOkQyQuIt/pv/sp9j4pRu2qp4LBLvBpv3U0KnV9VUint5qklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716460; c=relaxed/simple;
	bh=xLuNVgNBMSsMfvtwa4XFZ6iCJtWQprlxmOYOTUrat2w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYGai1S0Adgcr2kugunmvBQbgRiRfuQibY5BIvq4BZ0RMewytJqJZpNkWO3hn/mhQfT0uRaFEs/v+YSOtUEeczzeLzjoLd/bxWmzj0fXXBZgtJzpE5+yFYaaau64bnnmi1YMB8Azincf22/Cmu0N3epwMy21LDknBWjd+dZjL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9LHfwfw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9LHfwfw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6866FC4CED7
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734716459;
	bh=xLuNVgNBMSsMfvtwa4XFZ6iCJtWQprlxmOYOTUrat2w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q9LHfwfwadhQ+9jVNaT9DB9TmktjH57yYrHHsM947BmjACbpR3Ppoc/vitN+7K3yG
	 Kf0a7fUqdtDAaYSuimBr0EdHs9imlVGFne9RtF1GtCvkrNCp17CKC7YOaWzIkKPir+
	 i4QRK71vyuUlo+yCzdNvTg9TSAmiEQbRHYa9GhWd7tE4YdWTehlsugdYaUCXWrRvog
	 fLWJdhOBBKQaYik3S7UBiU3gjsHHo6BCLh39WIDeK8N39A1vF7zS8l35E5apLWIiz8
	 eD4YarFLjXPuoB97NbB/J7hUjPyo6CdXX5mYL29O86yyP5IlTG/s4gApGVX9Wzoel1
	 cds7sj1Zp49QQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 59B83C4160E; Fri, 20 Dec 2024 17:40:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219294] NULL dereference pointer in Bluetooth at boot
Date: Fri, 20 Dec 2024 17:40:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: casteyde.christian@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219294-62941-u6wd1GwcNl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219294-62941@https.bugzilla.kernel.org/>
References: <bug-219294-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219294

--- Comment #7 from Christian Casteyde (casteyde.christian@free.fr) ---
Le vendredi 13 d=C3=A9cembre 2024, 10:29:57 CET bugzilla-daemon@kernel.org =
a=20
=C3=A9crit :
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219294
>=20
> Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:
>=20
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
> CC|                            |pmenzel+bugzilla.kernel.org
>                    |                            |@molgen.mpg.de
>=20
> --- Comment #6 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.d=
e)
> ---
> Luiz responded [1]:
> > I suspect this has been fixed recently:
> >=20
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.g
> > it/commit/?id=3D6f3f7e9414834fc4210a2d11ff6172031e98d9ff
> Does this commit fix the issue for you?
>=20
> [1]:
> https://lore.kernel.org/all/CABBYNZJJ+28EvyEvDsVzZv6ZbZLhSkZ-tuDckAvNfR_=
=3DqCK
> VMw@mail.gmail.com/#t

I didn't managed to apply the patch on 6.12.6.
There was rejects I fixed manually, but it doesn't build with the following=
=20
error:
drivers/bluetooth/btusb.c: Dans la fonction =C2=AB btusb_probe =C2=BB:
drivers/bluetooth/btusb.c:3862:21: erreur: =C2=AB struct btusb_data =C2=BB =
n'a pas de=20
membre nomm=C3=A9 =C2=AB disconnect =C2=BB
 3862 |                 data->disconnect =3D btusb_mtk_disconnect;

The commit doesn't contains header diff.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

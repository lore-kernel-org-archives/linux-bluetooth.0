Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795020686;
	b=SkXg7T0GR61nzsl4nH5gGL3fs0G0+S9OS8n8DQ0GsipBRngkyMESwSHYx6vpW8qj2dH5
	 BeyrYTGm+IFHGTEIx7OzTV8LGzdMiPOOq2VhmJpHbU74fcquepJZcLib4vf6B8szvRzVf
	 4UMpCDHAzUSxRXjdc3+mtH/UJqZVxoLc2Knhapwo5Ctz6zc6Pqd8XnUB5bTMZk++PdNUp
	 4J6snBWLu/p/uoVgU+wnf8qybyh8IZwjIgXmm1Mdbt/qCstVJH3qLwd/pTdK1kXv4iFGT
	 35qu4jJc/eAv74kxPx5fg89dc3fG0voXSlSCJ065WQpioIaZP8gJHiMx7QBoPqqzYmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=AVfRAzHZQT/rOuI7gYnblrmxS6vEowmPPhMtXWYyyJg=;
	b=C4JGtazR0XfqIbuMTE0WFP5AqRVsleh9N6TJt5qJpIl+5bnqPHUIeCSvEf5ac1xPNXZB
	 Aqm3r6mzmlZ8Py+c4T6VgIYtRjaXEpWAZiiR4A+m1zZnsPsku4SQM6s8ZHr5dne2EwU0K
	 fgR4GWKmUznTCQNumnfOm0u7kop4RjX3YRiBfor7f5p8bZH44PdUTNvZCjyM9DyuseGps
	 8k4WSp/D0L1U5zLNLqmB31qcUZHvYQPz2MgZc+JHTQCQeaYsxhfnkZQHwPV8hih5hdz0O
	 nB3WpxgP/4PudpTW/+QnuK7VR/hI3BeS9bG95gruC4yZzbjoDh0KQVNARz2mWBjXGOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WAWscMp4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7D606A338
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CA7D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WAWscMp4
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c1f548f87so11907426d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 08:51:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795020685; cv=none;
        d=google.com; s=arc-20260327;
        b=flv4IbjrXsU+JH4JDOhh/jEtP8f8o4pcXbqMcjHbjEL6rGbb5J9nt4j+XKCRkbJJfX
         Zmmp8qmIH0r3je2EG7nEGJkmg4ruOHIkplEMvT2FpAoqTmVP5HcCbfVGGS+6dqPEqAkn
         RjupTCTKtMefihezRGO2ncBsaa5PKj0IWgo2NL2Yr9XaUNsTlremC9OjkQQ1S7Mros/6
         h1ef4vDIAaweITp8abNYHe0jttg332seaNun+5wKRhPfQ1teefmBY0jgQXj60ScnQN8k
         VdMbNpp4oImCT9RuJ91NLSDvCo3xCf3AEYDOySMSIaogWxJNWX3edfxIgsc8act1SMke
         G7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AVfRAzHZQT/rOuI7gYnblrmxS6vEowmPPhMtXWYyyJg=;
        fh=EMLy0SrAggPxvQAzWbZw0XMvgmdr+32bO4XlqGPZOgs=;
        b=Cj5YE2IhSusNm3mukNKj7RC0/7XJxfml9quJXt6fpa33/ew2tqV7Jd5/phsxqXJ3PY
         +XqPwsrNOm3PEMc9WliMB0I4kACFEK53MhxGLLaIXvWHpuAOUrmrOkaWWuneBN0tE10+
         Q3GFq7dX3gHZUlKZpuZtEdCufNEyW3WFPplysvyylwgLzaxwltGUMWIgCxq0/ncO4Xjh
         /wS+sgpoSlrcq2ForideLR7qL6LVr9PJgtCSWm3qeLh9T1fWWPmdnPyIwLNq1+VUTtIL
         P2lTh1hQgm+0t9/dZbfLP8Zy9JLQQP0tUPCN9f3ZKRM6RJxBg+S9jxZ2RSub/14GzVIq
         wP5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795020685; x=1795625485; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVfRAzHZQT/rOuI7gYnblrmxS6vEowmPPhMtXWYyyJg=;
        b=WAWscMp43UmSU5MWK+PB1j3jajEKrSiNjtktpp+tI84nlCHd8CApxQVxAsCPVdc17m
         VSFf6JN4zyKnFQUFc06TBzJrKI/99ffBDFTH5lAWGxxBiTyHEdD1eM4zKREhBXz7wrzy
         /JC3owRvcunIEFc/ZjFTjS717wFVzjyvtdpkeoR+Ihms0BDKhBz+GFWaHzxzN9L1qO3k
         Sj5198pj1yw+qFOVtY+5aOCxJFIx1wNEQqsil0k6dFx13mF5bWvF4qNJxjDqhFWFZydf
         09e5nUdW8JzgnDSh9j7xfXyKkCwLF9MR73lgStjOjpujBOa9pXF7KouxYDu7fZkSbv4k
         uyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795020685; x=1795625485;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AVfRAzHZQT/rOuI7gYnblrmxS6vEowmPPhMtXWYyyJg=;
        b=xTy1I4GIN0YIsY7PFic9delhISDS+yFl97oK4i89Rc7bqZ8b/k2WicV0j1PFSWXPJb
         8wRyz5ejVTLlE+IAeT+xG/vIHQk7cTiaMQJ+1RhLPAu8JZndFrLKKvuiY3W6v8kPV48e
         zsW2VxrpcLXqE/93o617Zo+YELn8xVz4MIlf3uzNiH5WXQQG/rhdzN56SyW2h4j+3ggg
         98J0xM2hnrh31/3EgxOQHdgQBPx8E8i/zWerceV5EH4QoUb+4kHrQPS+/fRs8WfidT36
         nV17Ib+nf+K2MsljuAngIgYQmrjR6xGVTKU6PyaJRqItA9WvZrQvV9ipcAO5pZqSqYfA
         fIeQ==
X-Forwarded-Encrypted: i=1; AL+hErEguHokcvNwxl1H58jmDa+4qtsmRcN6mDyy6lVg7/6K8cNmjE8hGSZwqGRQLaHX7FJfXbh+EBBao1IY6A+KeYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z86Mrheh8kAKDhgfCBrmPDd9EkeukuMe4JvXeOIuAUR4HJKqGCy
	t4oJgilODXnubLB2koa1/VpSQEfVwf6AGRceM5PC6/f2KY/slU0btevPz//85Kp7P4hIqotnCz+
	Ar1jZOHjd0JS7vIYRv+Igidb4GeZnflA=
X-Gm-Gg: AZFdTZdPzuDXWOOA/xxhbKCMC7L2eT9lhak4aJDyvya/Q4qRvYLN35nHCpr42Ka8b0h
	d9PANdPGLv73y8LBTF7YbfBPc976qvg3rC8WsEb2w3aO7e1iYtJHUWyiCxE5CKExegQZrnqHtgL
	XHXcktNfHbc6eIuMk2HZ/pN9zMn9nASzP+X3+e9USx4JIhbt49ThyJ58fq+D3m20icYWxZfcvi8
	WBE0Q0kUS9s+DhwPTOoQEljRtufK4Ru26W6YVxHkT/9zg1qvDdRUR+wKUXTawHziO3yYI/faz+Q
	8x50J4yq2TQ2DSfjaEV9WC2obS616cHLdq+F55GNDF0z3LEwkORBMqrOJREEbPFDPdAnexrZ6yg
	Ha7JwxEAbXQwIDehLQGupkzrWv8MTJg8G8FAyqu1oRrqn6sw5Yf7mXGah1tiuz4vAMd13Yls=
X-Received: by 2002:a05:6214:2428:b0:91f:300e:a8d9 with SMTP id
 6a1803df08f44-92114e17007mr46718686d6.21.1795020684764; Wed, 18 Nov 2026
 08:51:24 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAD37_9j+G03rRiUXCJD6+7ULxnxrc6=cJRBsNogpPs9tuNvR6Q@mail.gmail.com>
 <CABBYNZKNyOF87ZExeDuigwo+SwAqGqy0_wKnSqVdBy=Ps+D=Sg@mail.gmail.com>
In-Reply-To: <CABBYNZKNyOF87ZExeDuigwo+SwAqGqy0_wKnSqVdBy=Ps+D=Sg@mail.gmail.com>
From: Mohammed <mohammed.saad.alquraini@gmail.com>
Date: Wed, 18 Nov 2026 19:51:11 +0300
X-Gm-Features: Aa3M54oACuj8E-t9SmV9ONTGWUSsiohTp6HDMLRsJHA2aCWCWrcXpC84XBaJyIk
Message-ID: <CAD37_9hj3gs3XDyAQM22XNUk6gy0qEd-DOOeVic_v3KjGdxz1Q@mail.gmail.com>
Subject: Re: [Security] Bluetooth: SMP accepts a peer's claimed identity over
 an RPA link and overwrites another bond's IRK
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000048052906608fd2d5"

--00000000000048052906608fd2d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Appreciate the quick response. The point you raised is fair to be honest.

I have attached the patch in the email; my smtp is broken and I'm
relying on Gmail GUI :).

Best,
Mohammed

On Wed, Nov 18, 2026 at 7:29=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Mohammed,
>
> On Wed, Nov 18, 2026 at 11:16=E2=80=AFAM Mohammed
> <mohammed.saad.alquraini@gmail.com> wrote:
> >
> > Hi,
> >
> > I'm reporting a vulnerability in the Linux kernel Bluetooth LE Security=
 Manager
> > (net/bluetooth SMP / IRK handling). A suggested tested fix is inlined
> > below the scissors
> > line at the end (git am --scissors).
> >
> > Affected: present in torvalds/linux 666539eecdf4 and unchanged at
> > mainline master
> > as of 2026-11-18 (no net/bluetooth change since 2026-11-09 touches thes=
e paths).
> > Reachable once LE privacy / RPA resolution is active, which userspace
> > (bluetoothd)
> > enables via mgmt Set Privacy whenever LE privacy is in use; not
> > reachable on a bare
> > kernel with no userspace privacy setup.
> >
> > Summary
> > ----------------
> > During LE pairing key distribution, smp_cmd_ident_addr_info() accepts
> > the identity
> > address a peer claims in its SMP Identity Address Information PDU witho=
ut any
> > ownership check when the connection is over a Resolvable Private
> > Address, which is
> > the normal LE-privacy case. hci_add_irk() then stores the peer's IRK un=
der that
> > claimed identity and overwrites any existing entry in place. A peer
> > can therefore
> > claim the identity address of a different, already-bonded device and
> > replace that
> > bond's stored IRK (and the LTK distributed in the same pairing) with it=
s own key
> > material. No MITM-protected pairing method is required; Just Works is
> > sufficient.
> >
> > Details
> > -----------
> > 1. smp_cmd_ident_addr_info() (net/bluetooth/smp.c) rejects a mismatched=
 identity
> >    only when the connection address is itself an identity address:
> >
> >         if (hci_is_identity_address(&hcon->dst, hcon->dst_type) &&
> >             (bacmp(&info->bdaddr, &hcon->dst) ||
> >              info->addr_type !=3D hcon->dst_type)) {
> >                 bt_dev_err(hcon->hdev,
> >                            "ignoring IRK with invalid identity address"=
);
> >                 goto distribute;
> >         }
> >
> >    hci_is_identity_address() is false for an RPA/NRPA connection, so un=
der LE
> >    privacy (hcon->dst is an RPA for a fresh pairing) this check is
> > skipped and the
> >    claimed (bdaddr, addr_type) is accepted. The in-code comment above t=
his check
> >    states the intent to drop a peer that provides a different identity =
address,
> >    which is the guard the RPA path is missing. The sibling that does en=
force an
> >    identity property is the type check just above (commit e12af489, dis=
card IRKs
> >    whose address type is not public or static random); the mismatch che=
ck itself
> >    (commit 1d87b88ba26e) was added as a workaround for one device and
> > only covers
> >    the non-RPA case.
> >
> > 2. hci_add_irk() (net/bluetooth/hci_core.c) is find-or-create and overw=
rites:
> >
> >         old_irk =3D hci_find_irk_by_addr(hdev, bdaddr, addr_type);
> >         irk =3D old_irk;
> >         if (!irk) { ... allocate ... }
> >         memcpy(irk->val, val, 16);
> >         bacpy(&irk->rpa, rpa);
> >         if (!old_irk)
> >                 list_add_rcu(&irk->list, &hdev->identity_resolving_keys=
);
> >
> >    If an IRK for the claimed (identity, type) already exists, that
> > bond's key value
> >    and cached RPA are replaced with the attacker's.
> >
> > 3. Nothing requires the distributed IRK to resolve the connection's
> > RPA before it
> >    is bound to an identity. smp_cmd_ident_addr_info() records the
> > connection RPA but
> >    never verifies ah(IRK, prand) =3D=3D RPA.
> >
> > 4. On completion, smp_notify_keys() exports the entry (mgmt New IRK)
> > and, for an LE
> >    link, rewrites hcon->dst to the claimed identity; the LTK and any
> > CSRK from the
> >    same pairing are stored under that identity. hci_find_irk_by_rpa()
> > then resolves
> >    an RPA the attacker forges from its own IRK to the claimed identity.
> >
> > This is distinct from CVE-2025-62235 (Apache NimBLE) and the BLERP
> > re-pairing work,
> > which concern the LTK via the SMP Security Request / re-pairing path
> > in other stacks
> > and do not touch IRK or identity-address handling.
> >
> > Reproduction
> > ------------------
> > On an unmodified build of commit 666539eecdf4 (CONFIG_BT=3Dy, BT_LE=3Dy=
,
> > BT_HCIVHCI=3Dy,
> > debugfs on), driven over /dev/vhci in a QEMU guest:
> >
> > - Establish a legitimate bond: a Just Works pairing from an RPA, distri=
buting an
> >   IRK for identity B (a public address). debugfs
> > identity_resolving_keys shows one
> >   entry for B with that IRK.
> > - Poisoning pairing: a second Just Works pairing from a fresh RPA whose=
 Identity
> >   Address Information claims B's identity. No rejection fires. debugfs =
shows the
> >   same single entry, its IRK value overwritten in place with the attack=
er's; the
> >   attacker LTK is stored under B's identity (mgmt New Long Term Key for=
 B).
> > - Impersonation: an RPA forged from the attacker's IRK is resolved by
> > the kernel to
> >   B's identity (mgmt Device Connected reports B's address).
> >
> > A self-contained reproducer (fake controller plus attacker pairing) is
> > available on
> > request.
> >
> > Impact
> > ------------
> > A remote peer, via a pairing the kernel accepts, overwrites the stored
> > IRK and LTK
> > of a different already-bonded device in hdev->identity_resolving_keys,
> > which breaks
> > that legitimate bond, and the kernel then resolves addresses the
> > attacker forges to
> > the victim device's identity. The destruction and redirection of an
> > unrelated bond
> > do not depend on the host trusting the attacker's own device; the only
> > interaction
> > required is that the host pairs with the attacker. Access that bond
> > resolution may
> > subsequently authorize at the application layer was not exercised and
> > is not claimed.
> >
> > Severity: CVSS:3.1/AV:A/AC:L/PR:N/UI:N/S:U/C:N/I:H/A:L =3D 7.1 (High).
> > I:H because a
> > trusted bond's key is overwritten and the attacker is then resolved as
> > that device;
> > S:U because the impact stays within the host's own Bluetooth bond
> > store (no crossing
> > into another security authority); A:L for the denial of the
> > overwritten bond. UI:N
> > because the kernel performs the overwrite with no user interaction:
> > the SMP state
> > machine accepts the Identity Address Information PDU and overwrites
> > the IRK, and Just
> > Works bonding with a NoInputNoOutput peer is auto-accepted with no prom=
pt.
>
> The last sentences are actually not correct, even with NoInputNoOutput
> it will still require the user to authorize, the only way to skip it
> is by setting main.conf:JustWorksRepairing=3Dalways[1] which would mean
> that the system accepts the risk of having impersonation attacks like
> this, so no its nothing new, although hardning against it is still
> valid.
>
> > Suggested fix
> > -------------
> > The patch below is a suggested fix; the final form is of course yours
> > to decide. It
> > refuses, in smp_cmd_ident_addr_info(), to replace an IRK that is
> > already bound to an
> > identity when the peer connects from an unresolved RPA
> > (hci_bdaddr_is_rpa(&hcon->dst) && hci_find_irk_by_addr(... info->bdaddr=
 ...)). A
> > genuine reconnection of a bonded device has its RPA resolved to that
> > identity before
> > key distribution, so hcon->dst is the identity and the existing check
> > applies; an
> > unresolved RPA claiming an already-bonded identity means the peer is
> > not that device.
> > First-time bonding and reconnection of a bonded device are unaffected;
> > changing a
> > bonded identity's IRK now requires removing the old bond first.
> > Requiring the IRK to
> > resolve the RPA was considered and does not work, since the peer
> > controls both and
> > derives its RPA from the IRK it sends. Tested on the affected commit: b=
efore the
> > patch the poisoning pairing overwrote the bond's IRK and the forged
> > RPA resolved to
> > the victim; after it, the pairing is rejected, the stored IRK is
> > unchanged, and the
> > forged RPA no longer resolves.
> >
> > Credit
> > -------------
> > Mohammed Alquraini, HUMAIN. Found with an AI tool (an LLM-based code an=
alysis
> > pipeline) and validated by hand with the reproduction above.
> >
> >
> >
> > ------------------------ >8 ------------------------
> > From: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
> > Subject: Bluetooth: SMP: don't overwrite a bonded IRK from an unresolve=
d RPA
> >
> > smp_cmd_ident_addr_info() stores the IRK a peer distributes under the
> > identity address the peer claims, via hci_add_irk(), which replaces any
> > existing entry for that (address, type). The only ownership check, adde=
d
> > by commit 1d87b88ba26e, is gated on hci_is_identity_address(&hcon->dst)
> > and is skipped when the connection is over a Resolvable Private Address=
,
> > i.e. the normal LE privacy case.
> >
> > A peer can use this to claim the identity address of a different,
> > already-bonded device and overwrite that bond's IRK (and the LTK
> > distributed in the same pairing) with its own key material. Just Works =
is
> > enough. The legitimate bond then stops resolving, and an RPA the attack=
er
> > forges from its own IRK resolves to the victim device's identity.
> >
> > Requiring the distributed IRK to resolve the connection RPA does not he=
lp:
> > the peer controls both and can derive its RPA from the IRK it sends.
> >
> > Refuse instead to replace an IRK already bound to an identity when the =
peer
> > connects from an unresolved RPA. A genuine reconnection of a bonded dev=
ice
> > has its RPA resolved to that identity before key distribution, so hcon-=
>dst
> > is the identity rather than an RPA. First-time bonding and reconnection=
 of a
> > bonded device are unaffected; changing the IRK of a bonded identity now
> > requires removing the existing bond first.
> >
> > Fixes: 1d87b88ba26e ("Bluetooth: Add SMP workaround Microsoft Surface
> > Precision Mouse bug")
>
> Fixes tag looks wrong, we probably need the commit id of the one that
> added the check for is_identity, etc.
>
> > Reported-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
> > Assisted-by: LLM
> > Signed-off-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
> > ---
> >  net/bluetooth/smp.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > index b7015e37e1f1..6a417e3c9041 100644
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -2634,6 +2634,16 @@ static int smp_cmd_ident_addr_info(struct
> > l2cap_conn *conn,
> >       info->addr_type !=3D hcon->dst_type)) {
> >   bt_dev_err(hcon->hdev,
> >     "ignoring IRK with invalid identity address");
> > + goto distribute;
> > + }
> > +
> > + /* Don't let a peer connecting from an unresolved RPA replace the IRK=
 of
> > + * an already-bonded identity: it has not proven it is that device.
> > + */
> > + if (hci_bdaddr_is_rpa(&hcon->dst, hcon->dst_type) &&
> > +    hci_find_irk_by_addr(hcon->hdev, &info->bdaddr, info->addr_type)) =
{
> > + bt_dev_err(hcon->hdev,
> > +   "ignoring IRK for an identity already bound to a bond");
> >   goto distribute;
> >   }
>
> And this needs to be a proper patch, git format-patch + git send-email
> preferably.
>
> --
> Luiz Augusto von Dentz

--00000000000048052906608fd2d5
Content-Type: application/octet-stream; 
	name="REPORT-linux-bluetooth-smp-irk-poisoning.patch"
Content-Disposition: attachment; 
	filename="REPORT-linux-bluetooth-smp-irk-poisoning.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mwmcxv4h0>
X-Attachment-Id: f_mwmcxv4h0

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb2hhbW1lZCBBbHF1cmFpbmkgPG1vaGFtbWVkLnNhYWQuYWxx
dXJhaW5pQGdtYWlsLmNvbT4KRGF0ZTogVHVlLCAxOCBOb3YgMjAyNiAwMDowMDowMCArMDAwMApT
dWJqZWN0OiBbUEFUQ0hdIEJsdWV0b290aDogU01QOiBkb24ndCBvdmVyd3JpdGUgYSBib25kZWQg
SVJLIGZyb20gYW4gdW5yZXNvbHZlZCBSUEEKCnNtcF9jbWRfaWRlbnRfYWRkcl9pbmZvKCkgc3Rv
cmVzIHRoZSBJUksgYSBwZWVyIGRpc3RyaWJ1dGVzIHVuZGVyIHRoZQppZGVudGl0eSBhZGRyZXNz
IHRoZSBwZWVyIGNsYWltcywgdmlhIGhjaV9hZGRfaXJrKCksIHdoaWNoIHJlcGxhY2VzIGFueQpl
eGlzdGluZyBlbnRyeSBmb3IgdGhhdCAoYWRkcmVzcywgdHlwZSkuIFRoZSBpZGVudGl0eS1hZGRy
ZXNzIGNoZWNrcyB0aGVyZQphcmUgZ2F0ZWQgb24gaGNpX2lzX2lkZW50aXR5X2FkZHJlc3MoJmhj
b24tPmRzdCksIHdoaWNoIGlzIGZhbHNlIHdoZW4gdGhlCmNvbm5lY3Rpb24gaXMgb3ZlciBhIFJl
c29sdmFibGUgUHJpdmF0ZSBBZGRyZXNzICh0aGUgbm9ybWFsIExFIHByaXZhY3kKY2FzZSksIHNv
IHRoZXkgYXJlIHNraXBwZWQgYW5kIHRoZSBjbGFpbWVkIGlkZW50aXR5IGlzIGFjY2VwdGVkIGFz
LWlzLgoKQSBwZWVyIGNhbiB1c2UgdGhpcyB0byBjbGFpbSB0aGUgaWRlbnRpdHkgYWRkcmVzcyBv
ZiBhIGRpZmZlcmVudCwKYWxyZWFkeS1ib25kZWQgZGV2aWNlIGFuZCBvdmVyd3JpdGUgdGhhdCBi
b25kJ3MgSVJLIChhbmQgdGhlIExUSwpkaXN0cmlidXRlZCBpbiB0aGUgc2FtZSBwYWlyaW5nKSB3
aXRoIGl0cyBvd24ga2V5IG1hdGVyaWFsLiBKdXN0IFdvcmtzIGlzCmVub3VnaC4gVGhlIGxlZ2l0
aW1hdGUgYm9uZCB0aGVuIHN0b3BzIHJlc29sdmluZywgYW5kIGFuIFJQQSB0aGUgYXR0YWNrZXIK
Zm9yZ2VzIGZyb20gaXRzIG93biBJUksgcmVzb2x2ZXMgdG8gdGhlIHZpY3RpbSBkZXZpY2UncyBp
ZGVudGl0eS4KClJlcXVpcmluZyB0aGUgZGlzdHJpYnV0ZWQgSVJLIHRvIHJlc29sdmUgdGhlIGNv
bm5lY3Rpb24gUlBBIGRvZXMgbm90IGhlbHA6CnRoZSBwZWVyIGNvbnRyb2xzIGJvdGggYW5kIGNh
biBkZXJpdmUgaXRzIFJQQSBmcm9tIHRoZSBJUksgaXQgc2VuZHMuCgpSZWZ1c2UgaW5zdGVhZCB0
byByZXBsYWNlIGFuIElSSyBhbHJlYWR5IGJvdW5kIHRvIGFuIGlkZW50aXR5IHdoZW4gdGhlIHBl
ZXIKY29ubmVjdHMgZnJvbSBhbiB1bnJlc29sdmVkIFJQQS4gQSBnZW51aW5lIHJlY29ubmVjdGlv
biBvZiBhIGJvbmRlZCBkZXZpY2UKaGFzIGl0cyBSUEEgcmVzb2x2ZWQgdG8gdGhhdCBpZGVudGl0
eSBiZWZvcmUga2V5IGRpc3RyaWJ1dGlvbiwgc28gaGNvbi0+ZHN0CmlzIHRoZSBpZGVudGl0eSBy
YXRoZXIgdGhhbiBhbiBSUEEuIEZpcnN0LXRpbWUgYm9uZGluZyBhbmQgcmVjb25uZWN0aW9uCm9m
IGEgYm9uZGVkIGRldmljZSBhcmUgdW5hZmZlY3RlZDsgY2hhbmdpbmcgdGhlIElSSyBvZiBhIGJv
bmRlZCBpZGVudGl0eQpub3cgcmVxdWlyZXMgcmVtb3ZpbmcgdGhlIGV4aXN0aW5nIGJvbmQgZmly
c3QuCgpUaGlzIHdhcyBmb3VuZCB3aXRoIGFuIEFJLWFzc2lzdGVkIGNvZGUtYW5hbHlzaXMgdG9v
bDogaXQgZmxhZ2dlZCB0aGUKbWlzc2luZyBvd25lcnNoaXAgY2hlY2sgaW4gc21wX2NtZF9pZGVu
dF9hZGRyX2luZm8oKSBmb3IgdGhlIFJQQSBjYXNlLAphbmQgdGhlIGZpeCB3YXMgd3JpdHRlbiBh
bmQgdmVyaWZpZWQgYnkgaGFuZC4gVGhlIG92ZXJ3cml0ZSBhbmQgdGhlCmZvcmdlZC1SUEEgcmVz
b2x1dGlvbiB3ZXJlIHJlcHJvZHVjZWQsIGFuZCB0aGlzIGZpeCBjb25maXJtZWQgdG8gc3RvcApi
b3RoLCBvdmVyIC9kZXYvdmhjaSBpbiBhIFFFTVUgZ3Vlc3Qgb24gdjcuNC1yYzM7IHRoZSByZXBy
b2R1Y2VyIGlzCmF2YWlsYWJsZSBvbiByZXF1ZXN0LgoKRml4ZXM6IGUxMmFmNDg5YjkxZCAoIkJs
dWV0b290aDogRml4IHZhbGlkIElkZW50aXR5IEFkZHJlc3MgY2hlY2siKQpTaWduZWQtb2ZmLWJ5
OiBNb2hhbW1lZCBBbHF1cmFpbmkgPG1vaGFtbWVkLnNhYWQuYWxxdXJhaW5pQGdtYWlsLmNvbT4K
LS0tCiBuZXQvYmx1ZXRvb3RoL3NtcC5jIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL3NtcC5jIGIvbmV0
L2JsdWV0b290aC9zbXAuYwppbmRleCBiNzAxNWUzN2UxZjEuLjZhNDE3ZTNjOTA0MSAxMDA2NDQK
LS0tIGEvbmV0L2JsdWV0b290aC9zbXAuYworKysgYi9uZXQvYmx1ZXRvb3RoL3NtcC5jCkBAIC0y
NjM0LDYgKzI2MzQsMTYgQEAgc3RhdGljIGludCBzbXBfY21kX2lkZW50X2FkZHJfaW5mbyhzdHJ1
Y3QgbDJjYXBfY29ubiAqY29ubiwKIAkgICAgIGluZm8tPmFkZHJfdHlwZSAhPSBoY29uLT5kc3Rf
dHlwZSkpIHsKIAkJYnRfZGV2X2VycihoY29uLT5oZGV2LAogCQkJICAgImlnbm9yaW5nIElSSyB3
aXRoIGludmFsaWQgaWRlbnRpdHkgYWRkcmVzcyIpOworCQlnb3RvIGRpc3RyaWJ1dGU7CisJfQor
CisJLyogRG9uJ3QgbGV0IGEgcGVlciBjb25uZWN0aW5nIGZyb20gYW4gdW5yZXNvbHZlZCBSUEEg
cmVwbGFjZSB0aGUgSVJLIG9mCisJICogYW4gYWxyZWFkeS1ib25kZWQgaWRlbnRpdHk6IGl0IGhh
cyBub3QgcHJvdmVuIGl0IGlzIHRoYXQgZGV2aWNlLgorCSAqLworCWlmIChoY2lfYmRhZGRyX2lz
X3JwYSgmaGNvbi0+ZHN0LCBoY29uLT5kc3RfdHlwZSkgJiYKKwkgICAgaGNpX2ZpbmRfaXJrX2J5
X2FkZHIoaGNvbi0+aGRldiwgJmluZm8tPmJkYWRkciwgaW5mby0+YWRkcl90eXBlKSkgeworCQli
dF9kZXZfZXJyKGhjb24tPmhkZXYsCisJCQkgICAiaWdub3JpbmcgSVJLIGZvciBhbiBpZGVudGl0
eSBhbHJlYWR5IGJvdW5kIHRvIGEgYm9uZCIpOwogCQlnb3RvIGRpc3RyaWJ1dGU7CiAJfQoKLS0K
Mi40My4wCg==
--00000000000048052906608fd2d5--

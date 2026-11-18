Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795019394;
	b=IM9ihLP2Gn/ziWc2M02HC29rPjxf6scn5HjhDVtXMvgykOuVCMfeHBUIGuPv60t3sJS1
	 MGNfUeDIm7TG+IUkjN+4h2RSJahvkfyUXRklLaeVpH5iIhPUUKanOUzcKoUIpHPiSxxUg
	 s/ZHQ02R+PJve2SIi5OEVaaPQbOcPLRTk6pnxT5VJusw0y2EBEVBVvMLMHxJj6wHUMJMI
	 nAOPGnZzveSvZqYbNRKnWg28q672C4LYMXkVvu/3/YCo42toq1C6bDgdcikx/Qc/Uc8Kl
	 gu0VL064Wb+pdkhzMzgnL5skq4No8lLHOu9eY8PgLZSIibic8oi5ikRn1rKsc4Uy2cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6u58KpXyWwql/K0uWawaYZGJH97iQXpqfYrBEkY7azg=;
	b=kQWWVMO9jClxUhXsCVp7ulPsru1qIwf+jYq0xuSjgGmBYZ8WzA4lYONLiqCusOee8Zxu
	 QZ3ZgGZuUpoYiVtNMr9g4QfNoN26Mkq/XaMX+8MPD9scyTADaRxLZvSkbzAOb+IBefk2x
	 MO47R+JMennxO2RuqJc6/Y6yyetLFUXOaWW/hbe+iacRV6I87B1Y3OixXTXl/csah/tA9
	 KYV+HfeckxVzDc6iirtJc5KHxwUrK3NhUC85bS6Wk6/2moYzHrjSO3PSaCMgw7FRE8FJa
	 b0kHHQwUkLckWRxGAl0B5zu4Tbmf5mqkBGUiwZNIb/0WadYAGd4VwUo3NusFkKvXOTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQ2EIoD+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86622606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86622606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQ2EIoD+
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67921b515a7so1235414d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 08:29:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795019388; cv=none;
        d=google.com; s=arc-20260327;
        b=mambT70fhbFnrZjZHG3ih3CeBzLZDrxVlZft+bHYB5WnKXJ2WIZx9Erifizxj7jJLp
         jPthXIhtsWNrv7iq2ItcO+87BTBtWFwgpi8JntnIj717h95Vdgjm44ByxZD53vXSQzKw
         GSzOoscAszyx6OWhk0FSzFsaHniFwobDqf8cgl0IQJOTL6Dwo8yS9mmOV5NRuCh+zzEr
         JkW31N79U3yPc0lzpxw7j2AOUSaaV9HXkcLmlQYzN5HF1lR3gDRxWwsBmES5GdrU4IWg
         y5cQ42Ck686vfUAvxD55WlCElXIvyvOONYHaEanNIBFDY71YxRJcPtRN5S/fKawz0Bdn
         eRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6u58KpXyWwql/K0uWawaYZGJH97iQXpqfYrBEkY7azg=;
        fh=0JXMfM+NsNo2HIaGs1c88q2wnyZ2NbrR0pNFF90ygIw=;
        b=kYk6jyNOTEL3y0ZWFLwXUCsrf68kYSW0hwe42qQ7pgW189i2HKhOp326Dv5sf3Wboo
         SkOhkN+oMbSln7K7eJwibL7zfQixaJVJPFuJahysiE/zGH8T9tauQRAQ1sphbpzlQSnr
         YK2Z+gSYesRKLg2MuCylEf4XRB8kNy3dQ3oTp5c3DBSKYjs7I/mTk2euq3gatsJ/zIfa
         dh8oH7nk+Fdg3VC3AL5ugEYFmX4XXnoMqCNi3MbaT1qjvTJ57YhA/fQgfGhcIaBR67KY
         jF45uLBTzKownc8AoRDbeU1cvuAnF+x4fv7cQQjE0LeSdQzS/faYKdw06j8SRsj4CrvS
         sI7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795019388; x=1795624188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6u58KpXyWwql/K0uWawaYZGJH97iQXpqfYrBEkY7azg=;
        b=AQ2EIoD+QRs4YitRsdaNogNTq+eWsUVtYmwNNl2EVpvuSCgEk7EwXEPKN3NyXC7wDf
         Zxsx4EcF6Y6k9IZfQS5uQioxO6e1y/liFpSdb0lXgdaa5ENF8OowUfKxVWYfYolkps0N
         1Aeel4MaU6AleDCu3+TAFTgardXR/5Bxk+jU4IvkvBplDCo1ssDizs2cVwmZbHx1r+yf
         jxaQ5kCtal7F9s9sicxLir24PGFYbsi1Xml7SC7dtGY7mVo4K1vX/OWyxPHzMcp8+nCh
         5WfBVtfGowTvBCWicnvTN131I5NgTyxNanPqgp8bvQAl1VBcVLypvH7DkjRuYCGv2qcj
         pCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019388; x=1795624188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6u58KpXyWwql/K0uWawaYZGJH97iQXpqfYrBEkY7azg=;
        b=kGCsZZ+Px1Pz0w0vWe34ZYSr7T8Bu2wS51XH7TgBykcfBH0FYoluiADyRqLSi0ObiC
         r/aqwN8Xgw7x8lsB0Atqiwogop6xyTRqVvFC/i8H3cLhs/4Pqupf2fDlNcaRwN2rVaYH
         6VHpSSfwwJA0AMwEDLfmIOSsZwme2O7kp/exrhhbQWt0Pp5FE78mFp9mPiUGivDAQKcI
         Sl02XXD2Vskxz1uzqCNWpdbS/S2Z/6cstqm0LYNJmRhPSUkN4A2N2GjJ1u65KjHneiQE
         g3rges0gzX26Cfi/7+AZ5jv47MtUS31iitfOGsH+bvogQEurp7qVTc+rVEMMq9BDqAnk
         C4Rg==
X-Forwarded-Encrypted: i=1; AL+hErGYeIz1obqAOjnaUF6FayTxWDBGrFiV6w5VZjAk653WjJT1mXs1HCkv+42myaCDyy7IX3uqEpGEgjO5iYBjwmA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8q/eRRQ/N7jLylIR5XThAQaqmeLVWwInyLGwlGsFV/lPEhCcBB
	RZStev0X15TtUM4xZIFtNPyvFpmq+VAG/pyPS6frv72btNxRMn+nS6M8sBpM5dT+kqzic+2mqgK
	C8hJGu1UR0Pl4T42OmapgJueupxvwwao=
X-Gm-Gg: AZFdTZeZq56NeEcAqq1YBPOVD1Fy5LZzTl2U7I1m+rqvEIVaBAxUOBFJiXqY8aVSVdi
	VfKnndvjBOD3I19KqVqniC1GvsTb5e9A+sXmyioYZEDnib5crL16XPgkhV6qFEQHEeJRB2vJSp/
	V0D1ffMDG3TtRz/qw/GlVfoi2n2TtUvOuQ8a9mCvdnjGJ3XHxdSfFD79jQgmRqJeuoS+p9bwfUB
	smyzdHrNo+wADntdm3wOtidT2ymUouLHsfDoGeB2IEQ1GmiIhKZONgrdWYkxkxSHkMJxeUv7f07
	oRwJKzDyK5i74V6lgDiFDvyEkvvlt3IuyuNb6O97vGQJz1wmZdkCzAJEWHIhO6bfcDq6kuc/F+f
	yvsFdyNUwvCLIkX/xLHAnJfVbyXrYQqakBXMcAH+6flgGLz3ooRNh+WtYX/fpkd2zl12SrL18Wk
	BllAmOae6An52Fw9eZdx5LVb79iFq1NiyCl2P+uCvXaah0A8d6foeGKHdB
X-Received: by 2002:a05:690e:11ce:b0:67c:8ea:be13 with SMTP id
 956f58d0204a3-67dd3f717ccmr1473957d50.52.1795019388299; Wed, 18 Nov 2026
 08:29:48 -0800 (PST)
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
In-Reply-To: <CAD37_9j+G03rRiUXCJD6+7ULxnxrc6=cJRBsNogpPs9tuNvR6Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Nov 2026 11:29:36 -0500
X-Gm-Features: AclHuK8HbSq51n2TaWRAN2rRsxHMAZgPNWRbE3fXYjXDp5zOVXeWaYnhzs0HbZA
Message-ID: <CABBYNZKNyOF87ZExeDuigwo+SwAqGqy0_wKnSqVdBy=Ps+D=Sg@mail.gmail.com>
Subject: Re: [Security] Bluetooth: SMP accepts a peer's claimed identity over
 an RPA link and overwrites another bond's IRK
To: Mohammed <mohammed.saad.alquraini@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mohammed,

On Wed, Nov 18, 2026 at 11:16=E2=80=AFAM Mohammed
<mohammed.saad.alquraini@gmail.com> wrote:
>
> Hi,
>
> I'm reporting a vulnerability in the Linux kernel Bluetooth LE Security M=
anager
> (net/bluetooth SMP / IRK handling). A suggested tested fix is inlined
> below the scissors
> line at the end (git am --scissors).
>
> Affected: present in torvalds/linux 666539eecdf4 and unchanged at
> mainline master
> as of 2026-11-18 (no net/bluetooth change since 2026-11-09 touches these =
paths).
> Reachable once LE privacy / RPA resolution is active, which userspace
> (bluetoothd)
> enables via mgmt Set Privacy whenever LE privacy is in use; not
> reachable on a bare
> kernel with no userspace privacy setup.
>
> Summary
> ----------------
> During LE pairing key distribution, smp_cmd_ident_addr_info() accepts
> the identity
> address a peer claims in its SMP Identity Address Information PDU without=
 any
> ownership check when the connection is over a Resolvable Private
> Address, which is
> the normal LE-privacy case. hci_add_irk() then stores the peer's IRK unde=
r that
> claimed identity and overwrites any existing entry in place. A peer
> can therefore
> claim the identity address of a different, already-bonded device and
> replace that
> bond's stored IRK (and the LTK distributed in the same pairing) with its =
own key
> material. No MITM-protected pairing method is required; Just Works is
> sufficient.
>
> Details
> -----------
> 1. smp_cmd_ident_addr_info() (net/bluetooth/smp.c) rejects a mismatched i=
dentity
>    only when the connection address is itself an identity address:
>
>         if (hci_is_identity_address(&hcon->dst, hcon->dst_type) &&
>             (bacmp(&info->bdaddr, &hcon->dst) ||
>              info->addr_type !=3D hcon->dst_type)) {
>                 bt_dev_err(hcon->hdev,
>                            "ignoring IRK with invalid identity address");
>                 goto distribute;
>         }
>
>    hci_is_identity_address() is false for an RPA/NRPA connection, so unde=
r LE
>    privacy (hcon->dst is an RPA for a fresh pairing) this check is
> skipped and the
>    claimed (bdaddr, addr_type) is accepted. The in-code comment above thi=
s check
>    states the intent to drop a peer that provides a different identity ad=
dress,
>    which is the guard the RPA path is missing. The sibling that does enfo=
rce an
>    identity property is the type check just above (commit e12af489, disca=
rd IRKs
>    whose address type is not public or static random); the mismatch check=
 itself
>    (commit 1d87b88ba26e) was added as a workaround for one device and
> only covers
>    the non-RPA case.
>
> 2. hci_add_irk() (net/bluetooth/hci_core.c) is find-or-create and overwri=
tes:
>
>         old_irk =3D hci_find_irk_by_addr(hdev, bdaddr, addr_type);
>         irk =3D old_irk;
>         if (!irk) { ... allocate ... }
>         memcpy(irk->val, val, 16);
>         bacpy(&irk->rpa, rpa);
>         if (!old_irk)
>                 list_add_rcu(&irk->list, &hdev->identity_resolving_keys);
>
>    If an IRK for the claimed (identity, type) already exists, that
> bond's key value
>    and cached RPA are replaced with the attacker's.
>
> 3. Nothing requires the distributed IRK to resolve the connection's
> RPA before it
>    is bound to an identity. smp_cmd_ident_addr_info() records the
> connection RPA but
>    never verifies ah(IRK, prand) =3D=3D RPA.
>
> 4. On completion, smp_notify_keys() exports the entry (mgmt New IRK)
> and, for an LE
>    link, rewrites hcon->dst to the claimed identity; the LTK and any
> CSRK from the
>    same pairing are stored under that identity. hci_find_irk_by_rpa()
> then resolves
>    an RPA the attacker forges from its own IRK to the claimed identity.
>
> This is distinct from CVE-2025-62235 (Apache NimBLE) and the BLERP
> re-pairing work,
> which concern the LTK via the SMP Security Request / re-pairing path
> in other stacks
> and do not touch IRK or identity-address handling.
>
> Reproduction
> ------------------
> On an unmodified build of commit 666539eecdf4 (CONFIG_BT=3Dy, BT_LE=3Dy,
> BT_HCIVHCI=3Dy,
> debugfs on), driven over /dev/vhci in a QEMU guest:
>
> - Establish a legitimate bond: a Just Works pairing from an RPA, distribu=
ting an
>   IRK for identity B (a public address). debugfs
> identity_resolving_keys shows one
>   entry for B with that IRK.
> - Poisoning pairing: a second Just Works pairing from a fresh RPA whose I=
dentity
>   Address Information claims B's identity. No rejection fires. debugfs sh=
ows the
>   same single entry, its IRK value overwritten in place with the attacker=
's; the
>   attacker LTK is stored under B's identity (mgmt New Long Term Key for B=
).
> - Impersonation: an RPA forged from the attacker's IRK is resolved by
> the kernel to
>   B's identity (mgmt Device Connected reports B's address).
>
> A self-contained reproducer (fake controller plus attacker pairing) is
> available on
> request.
>
> Impact
> ------------
> A remote peer, via a pairing the kernel accepts, overwrites the stored
> IRK and LTK
> of a different already-bonded device in hdev->identity_resolving_keys,
> which breaks
> that legitimate bond, and the kernel then resolves addresses the
> attacker forges to
> the victim device's identity. The destruction and redirection of an
> unrelated bond
> do not depend on the host trusting the attacker's own device; the only
> interaction
> required is that the host pairs with the attacker. Access that bond
> resolution may
> subsequently authorize at the application layer was not exercised and
> is not claimed.
>
> Severity: CVSS:3.1/AV:A/AC:L/PR:N/UI:N/S:U/C:N/I:H/A:L =3D 7.1 (High).
> I:H because a
> trusted bond's key is overwritten and the attacker is then resolved as
> that device;
> S:U because the impact stays within the host's own Bluetooth bond
> store (no crossing
> into another security authority); A:L for the denial of the
> overwritten bond. UI:N
> because the kernel performs the overwrite with no user interaction:
> the SMP state
> machine accepts the Identity Address Information PDU and overwrites
> the IRK, and Just
> Works bonding with a NoInputNoOutput peer is auto-accepted with no prompt=
.

The last sentences are actually not correct, even with NoInputNoOutput
it will still require the user to authorize, the only way to skip it
is by setting main.conf:JustWorksRepairing=3Dalways[1] which would mean
that the system accepts the risk of having impersonation attacks like
this, so no its nothing new, although hardning against it is still
valid.

> Suggested fix
> -------------
> The patch below is a suggested fix; the final form is of course yours
> to decide. It
> refuses, in smp_cmd_ident_addr_info(), to replace an IRK that is
> already bound to an
> identity when the peer connects from an unresolved RPA
> (hci_bdaddr_is_rpa(&hcon->dst) && hci_find_irk_by_addr(... info->bdaddr .=
..)). A
> genuine reconnection of a bonded device has its RPA resolved to that
> identity before
> key distribution, so hcon->dst is the identity and the existing check
> applies; an
> unresolved RPA claiming an already-bonded identity means the peer is
> not that device.
> First-time bonding and reconnection of a bonded device are unaffected;
> changing a
> bonded identity's IRK now requires removing the old bond first.
> Requiring the IRK to
> resolve the RPA was considered and does not work, since the peer
> controls both and
> derives its RPA from the IRK it sends. Tested on the affected commit: bef=
ore the
> patch the poisoning pairing overwrote the bond's IRK and the forged
> RPA resolved to
> the victim; after it, the pairing is rejected, the stored IRK is
> unchanged, and the
> forged RPA no longer resolves.
>
> Credit
> -------------
> Mohammed Alquraini, HUMAIN. Found with an AI tool (an LLM-based code anal=
ysis
> pipeline) and validated by hand with the reproduction above.
>
>
>
> ------------------------ >8 ------------------------
> From: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
> Subject: Bluetooth: SMP: don't overwrite a bonded IRK from an unresolved =
RPA
>
> smp_cmd_ident_addr_info() stores the IRK a peer distributes under the
> identity address the peer claims, via hci_add_irk(), which replaces any
> existing entry for that (address, type). The only ownership check, added
> by commit 1d87b88ba26e, is gated on hci_is_identity_address(&hcon->dst)
> and is skipped when the connection is over a Resolvable Private Address,
> i.e. the normal LE privacy case.
>
> A peer can use this to claim the identity address of a different,
> already-bonded device and overwrite that bond's IRK (and the LTK
> distributed in the same pairing) with its own key material. Just Works is
> enough. The legitimate bond then stops resolving, and an RPA the attacker
> forges from its own IRK resolves to the victim device's identity.
>
> Requiring the distributed IRK to resolve the connection RPA does not help=
:
> the peer controls both and can derive its RPA from the IRK it sends.
>
> Refuse instead to replace an IRK already bound to an identity when the pe=
er
> connects from an unresolved RPA. A genuine reconnection of a bonded devic=
e
> has its RPA resolved to that identity before key distribution, so hcon->d=
st
> is the identity rather than an RPA. First-time bonding and reconnection o=
f a
> bonded device are unaffected; changing the IRK of a bonded identity now
> requires removing the existing bond first.
>
> Fixes: 1d87b88ba26e ("Bluetooth: Add SMP workaround Microsoft Surface
> Precision Mouse bug")

Fixes tag looks wrong, we probably need the commit id of the one that
added the check for is_identity, etc.

> Reported-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
> ---
>  net/bluetooth/smp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index b7015e37e1f1..6a417e3c9041 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2634,6 +2634,16 @@ static int smp_cmd_ident_addr_info(struct
> l2cap_conn *conn,
>       info->addr_type !=3D hcon->dst_type)) {
>   bt_dev_err(hcon->hdev,
>     "ignoring IRK with invalid identity address");
> + goto distribute;
> + }
> +
> + /* Don't let a peer connecting from an unresolved RPA replace the IRK o=
f
> + * an already-bonded identity: it has not proven it is that device.
> + */
> + if (hci_bdaddr_is_rpa(&hcon->dst, hcon->dst_type) &&
> +    hci_find_irk_by_addr(hcon->hdev, &info->bdaddr, info->addr_type)) {
> + bt_dev_err(hcon->hdev,
> +   "ignoring IRK for an identity already bound to a bond");
>   goto distribute;
>   }

And this needs to be a proper patch, git format-patch + git send-email
preferably.

--=20
Luiz Augusto von Dentz

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795018604;
	b=cgSheknt5CPJqhCoqoa5PxO4lNvowKeo8fGhkaVo7YWh5334Eg2ZD8BABEDqsWzAEatp
	 2ie3ZRTM57GAsz0cjekmPTCxXjcCj2itObohJUcqTRd0vD1BHEZMarqydndtsG25UCiVN
	 rBKOxWsyEAdMXSrzqUeP9x12SPQBWs4GF9TZg9aoSp0ozBlA2kYilG4ISnxTZPCw1eOTm
	 IFyoTlk7w0UXdRczw4aGRcvd9r1QoSd68Np/c95UkGIW3PdOEuGx470gwG2nQzAI8dkx2
	 eGuRaePt0qdUH0qycPSSub7renoOi3RgLuVchW9e5VRvrYKD2iuKHRb01iZoYuGR4XA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=0s4ek5vnxvvbCN5S1DfqY5qzuROwFD8ntTn1dH2RDMk=;
	b=KWRztYJzhJLOlOp/gcfIfwR1I35qdPigbcHROOmDOMDmQcYYDWvc81eVKl+C47de7NU0
	 Nq1aGKE69Jsg8ZB/sztbZywJc8m8lUWKsA8/pqh/F4+8zXhR1+MZEVLWoi5pIjpnBccRi
	 6DIEYgfCPb4k85IBJOGb+kTWbCC0krY2sp1eFPjItyFiW+UE7y6i2ykuK+2BgNtKYpFpZ
	 BQyIjNeB28wk9Z2xWWOOTdEVVBXId6POyntkbvkcmETraTvFvxV5WnJJDAqNeUW7F8Ynk
	 3/LnxO0DQT6R6BB3zqRgTS7hhQUeJAd/A825becgk2uyHQ1WUZ/FabDgayG6P5Qzg6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MYA73y4C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4EF606A33B
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A4EF606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MYA73y4C
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91ec2d42231so6234476d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 08:16:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795018603; cv=none;
        d=google.com; s=arc-20260327;
        b=T/UpjjnvQHtTZaHpJJEOJX+ZUtL261Le8sJFYbMFoQN3bH4KMqw+APHTX3Uwz0n8uD
         ZjZsDSlyPXFlg/Nszg2ZOqQQ7RSASqxpG/1NyMT71PQder0QghrV0rOGueYiYeAsiZr0
         XxqynbeaF6SvdE3mz/CcXfb4VnzEM1jrfFsIo8w5gKzVU47qV7e7cSKgleEMkrPQhsaW
         AbjPFJSt8wx44Z4l9Kku5bfnb1FGfsPBbxvbPIgDgPGc+6xHzPEaAcZQIeeOdZq1+ENW
         NEuwrkO9VjVx+Wmt83r02fzVXtpJOxYqZeKE8LVkDFlxFv45SbrvJQfGmG7qHKc7WFvb
         zFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0s4ek5vnxvvbCN5S1DfqY5qzuROwFD8ntTn1dH2RDMk=;
        fh=BYmJYYrzNkcsHw//JR1Bfw3zo6Y5IQv28VtVshOmLU0=;
        b=CgdYlaGxxW9IGS6zQAgstffEerWi0T7dN0iOgqtgwApcG1JGtiN3Ou4D0fhmhvnVCR
         tLywGUSj/oxqzN7rR/scM+RTomjltppKfMezdEmsFBvMG20hjN9PAazqQHrNkF9xuhXo
         urcsRko5SWU5WgCuWaKtL5DBLaE27B2APyABLeHW1HisnKyVaVzLw94gAUrlEC1quaCH
         sQL3cDZuo13efBQjE0E5mQoe7r0p+Nw5CSQsc7zz2zPoKCGPrmt8bnwQQE534cIHrjvy
         g4gOO1H6C6z+jS7awoOulCm7UNs+Xxs2pDV5oqk4Vt703YHLQdMyjLk7kVUZk7Kz4BaP
         58uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795018603; x=1795623403; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0s4ek5vnxvvbCN5S1DfqY5qzuROwFD8ntTn1dH2RDMk=;
        b=MYA73y4C69Y4nHidMevejLIxogcvqMyqdcV1DiFUFXiLX6IqK6JCpDCkpsNbWPslbd
         bME8SqodabgKvKjug5Vd9f6+xAe6tlbliMtf/bcaqoSyesnlDOSucl0npUtwBMNQZQKY
         nwPxNjg1VxxXgG3zOiLt/x8u6N9eiDk+c+4ax/XnDUL5TdQzi+sj8si4q/XSWC+0Uv+d
         4CmuBFaiNcabyrugT0hQx4KaNh20odP87X0tOBlfTpQOHz/yKZGmdfFYR6t61RgCj9sR
         SvKBhSEuWYqsWTiQ6LN/z9Pvk+De6D6NzGPW4unnK7Zfmawl5l3AUUg5lRsIwa5puVTD
         5Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018603; x=1795623403;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0s4ek5vnxvvbCN5S1DfqY5qzuROwFD8ntTn1dH2RDMk=;
        b=Crj0sF8cZ9sNC5RrRne6Ftx9A/5MimcbLe3m5+/RHfwItWg86hHyyXrJPUIapCMhFd
         7vppJ5x2SEs2YF6nBA0Gk3FtOl5yJfj2SfdnxkwJB/T8+M9MUv6aDc2VgoiE4oLkiVWJ
         ijlNKZR5Dkf2sZiG1uqHosttTty9PFLYuX821gOSonmINxUcXEvWEnln+1fPquF7EPEk
         VbDVaN9jF5OSX6gXFDfUq8m0GWubiriXiDBqCCHHZZhQLNxumxxS4hhewS6xFfycHDSg
         4M7kmql4x0nuoT+ZAnu4izGkcWl4Miv2yKJSPbh42SYiDAXJWVTli1F3l0TbD07b0Fg/
         a5bA==
X-Gm-Message-State: APuU4Z8Hc40z+VXqnWe8He6GQwmIMdiTkUAEsoCl8Jady/fLqAz3kVUO
	QGGPc3xHJWHAWc84UmesXvKzvbrUbVB/KMrQihhLaZZY2rcGO3grxYIrNaOtpAwB4YdQGsyGOe/
	lDSYayT3AGazrb20atYHJToS/z/hWX4WkTXog
X-Gm-Gg: AZFdTZc1jNm9WxpQVkORbDVZ0MB1xzncyKEqpTyaQKC+oTzgJG4HL3ou4uKnr6G2pRx
	COWKGJSW6Vr3tBgJBOAKwMlOA9miView/apmDnLdaq8oMxpwlbads/qOACaYou02YiU88ghbJdu
	hHl8G4i/nFrqIxmlfcAAJTHoXdvl05pk0MYCSKYAO7zNqnptlL/TEdkRqC1Ru26AFjuoehTOqrW
	JHY4cPVVpaLO6iZgMSP7bAD0adn3u9DfDM+I/ES4CtrW2UAM+nOExDsAs4bJZmiq9ZHasr9zPkE
	STcjtNEYBpRZSFxUIloRw0Vx7wRikfT3fJZUlKf3FcNuT25QwntM++UZVp/0SlSw10fcq8FOfZz
	agZPNgqhF95bJtptno59vc5hX8QC6cV0gOiABC3LXLT7TLIp734eRcaDIEd4oMTM+jQdaQ+I=
X-Received: by 2002:a05:6214:4112:b0:91f:ee9:c557 with SMTP id
 6a1803df08f44-92114ea4b99mr46512826d6.44.1795018602863; Wed, 18 Nov 2026
 08:16:42 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Mohammed <mohammed.saad.alquraini@gmail.com>
Date: Wed, 18 Nov 2026 19:16:31 +0300
X-Gm-Features: Aa3M54ph2pHrTR8AZKDe2mu-qwvZOPF0oSxhtWK6gpVJbV7voWNsNirjfsXyB-U
Message-ID: <CAD37_9j+G03rRiUXCJD6+7ULxnxrc6=cJRBsNogpPs9tuNvR6Q@mail.gmail.com>
Subject: [Security] Bluetooth: SMP accepts a peer's claimed identity over an
 RPA link and overwrites another bond's IRK
To: marcel@holtmann.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm reporting a vulnerability in the Linux kernel Bluetooth LE Security Manager
(net/bluetooth SMP / IRK handling). A suggested tested fix is inlined
below the scissors
line at the end (git am --scissors).

Affected: present in torvalds/linux 666539eecdf4 and unchanged at
mainline master
as of 2026-11-18 (no net/bluetooth change since 2026-11-09 touches these paths).
Reachable once LE privacy / RPA resolution is active, which userspace
(bluetoothd)
enables via mgmt Set Privacy whenever LE privacy is in use; not
reachable on a bare
kernel with no userspace privacy setup.

Summary
----------------
During LE pairing key distribution, smp_cmd_ident_addr_info() accepts
the identity
address a peer claims in its SMP Identity Address Information PDU without any
ownership check when the connection is over a Resolvable Private
Address, which is
the normal LE-privacy case. hci_add_irk() then stores the peer's IRK under that
claimed identity and overwrites any existing entry in place. A peer
can therefore
claim the identity address of a different, already-bonded device and
replace that
bond's stored IRK (and the LTK distributed in the same pairing) with its own key
material. No MITM-protected pairing method is required; Just Works is
sufficient.

Details
-----------
1. smp_cmd_ident_addr_info() (net/bluetooth/smp.c) rejects a mismatched identity
   only when the connection address is itself an identity address:

        if (hci_is_identity_address(&hcon->dst, hcon->dst_type) &&
            (bacmp(&info->bdaddr, &hcon->dst) ||
             info->addr_type != hcon->dst_type)) {
                bt_dev_err(hcon->hdev,
                           "ignoring IRK with invalid identity address");
                goto distribute;
        }

   hci_is_identity_address() is false for an RPA/NRPA connection, so under LE
   privacy (hcon->dst is an RPA for a fresh pairing) this check is
skipped and the
   claimed (bdaddr, addr_type) is accepted. The in-code comment above this check
   states the intent to drop a peer that provides a different identity address,
   which is the guard the RPA path is missing. The sibling that does enforce an
   identity property is the type check just above (commit e12af489, discard IRKs
   whose address type is not public or static random); the mismatch check itself
   (commit 1d87b88ba26e) was added as a workaround for one device and
only covers
   the non-RPA case.

2. hci_add_irk() (net/bluetooth/hci_core.c) is find-or-create and overwrites:

        old_irk = hci_find_irk_by_addr(hdev, bdaddr, addr_type);
        irk = old_irk;
        if (!irk) { ... allocate ... }
        memcpy(irk->val, val, 16);
        bacpy(&irk->rpa, rpa);
        if (!old_irk)
                list_add_rcu(&irk->list, &hdev->identity_resolving_keys);

   If an IRK for the claimed (identity, type) already exists, that
bond's key value
   and cached RPA are replaced with the attacker's.

3. Nothing requires the distributed IRK to resolve the connection's
RPA before it
   is bound to an identity. smp_cmd_ident_addr_info() records the
connection RPA but
   never verifies ah(IRK, prand) == RPA.

4. On completion, smp_notify_keys() exports the entry (mgmt New IRK)
and, for an LE
   link, rewrites hcon->dst to the claimed identity; the LTK and any
CSRK from the
   same pairing are stored under that identity. hci_find_irk_by_rpa()
then resolves
   an RPA the attacker forges from its own IRK to the claimed identity.

This is distinct from CVE-2025-62235 (Apache NimBLE) and the BLERP
re-pairing work,
which concern the LTK via the SMP Security Request / re-pairing path
in other stacks
and do not touch IRK or identity-address handling.

Reproduction
------------------
On an unmodified build of commit 666539eecdf4 (CONFIG_BT=y, BT_LE=y,
BT_HCIVHCI=y,
debugfs on), driven over /dev/vhci in a QEMU guest:

- Establish a legitimate bond: a Just Works pairing from an RPA, distributing an
  IRK for identity B (a public address). debugfs
identity_resolving_keys shows one
  entry for B with that IRK.
- Poisoning pairing: a second Just Works pairing from a fresh RPA whose Identity
  Address Information claims B's identity. No rejection fires. debugfs shows the
  same single entry, its IRK value overwritten in place with the attacker's; the
  attacker LTK is stored under B's identity (mgmt New Long Term Key for B).
- Impersonation: an RPA forged from the attacker's IRK is resolved by
the kernel to
  B's identity (mgmt Device Connected reports B's address).

A self-contained reproducer (fake controller plus attacker pairing) is
available on
request.

Impact
------------
A remote peer, via a pairing the kernel accepts, overwrites the stored
IRK and LTK
of a different already-bonded device in hdev->identity_resolving_keys,
which breaks
that legitimate bond, and the kernel then resolves addresses the
attacker forges to
the victim device's identity. The destruction and redirection of an
unrelated bond
do not depend on the host trusting the attacker's own device; the only
interaction
required is that the host pairs with the attacker. Access that bond
resolution may
subsequently authorize at the application layer was not exercised and
is not claimed.

Severity: CVSS:3.1/AV:A/AC:L/PR:N/UI:N/S:U/C:N/I:H/A:L = 7.1 (High).
I:H because a
trusted bond's key is overwritten and the attacker is then resolved as
that device;
S:U because the impact stays within the host's own Bluetooth bond
store (no crossing
into another security authority); A:L for the denial of the
overwritten bond. UI:N
because the kernel performs the overwrite with no user interaction:
the SMP state
machine accepts the Identity Address Information PDU and overwrites
the IRK, and Just
Works bonding with a NoInputNoOutput peer is auto-accepted with no prompt.

Suggested fix
-------------
The patch below is a suggested fix; the final form is of course yours
to decide. It
refuses, in smp_cmd_ident_addr_info(), to replace an IRK that is
already bound to an
identity when the peer connects from an unresolved RPA
(hci_bdaddr_is_rpa(&hcon->dst) && hci_find_irk_by_addr(... info->bdaddr ...)). A
genuine reconnection of a bonded device has its RPA resolved to that
identity before
key distribution, so hcon->dst is the identity and the existing check
applies; an
unresolved RPA claiming an already-bonded identity means the peer is
not that device.
First-time bonding and reconnection of a bonded device are unaffected;
changing a
bonded identity's IRK now requires removing the old bond first.
Requiring the IRK to
resolve the RPA was considered and does not work, since the peer
controls both and
derives its RPA from the IRK it sends. Tested on the affected commit: before the
patch the poisoning pairing overwrote the bond's IRK and the forged
RPA resolved to
the victim; after it, the pairing is rejected, the stored IRK is
unchanged, and the
forged RPA no longer resolves.

Credit
-------------
Mohammed Alquraini, HUMAIN. Found with an AI tool (an LLM-based code analysis
pipeline) and validated by hand with the reproduction above.



------------------------ >8 ------------------------
From: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
Subject: Bluetooth: SMP: don't overwrite a bonded IRK from an unresolved RPA

smp_cmd_ident_addr_info() stores the IRK a peer distributes under the
identity address the peer claims, via hci_add_irk(), which replaces any
existing entry for that (address, type). The only ownership check, added
by commit 1d87b88ba26e, is gated on hci_is_identity_address(&hcon->dst)
and is skipped when the connection is over a Resolvable Private Address,
i.e. the normal LE privacy case.

A peer can use this to claim the identity address of a different,
already-bonded device and overwrite that bond's IRK (and the LTK
distributed in the same pairing) with its own key material. Just Works is
enough. The legitimate bond then stops resolving, and an RPA the attacker
forges from its own IRK resolves to the victim device's identity.

Requiring the distributed IRK to resolve the connection RPA does not help:
the peer controls both and can derive its RPA from the IRK it sends.

Refuse instead to replace an IRK already bound to an identity when the peer
connects from an unresolved RPA. A genuine reconnection of a bonded device
has its RPA resolved to that identity before key distribution, so hcon->dst
is the identity rather than an RPA. First-time bonding and reconnection of a
bonded device are unaffected; changing the IRK of a bonded identity now
requires removing the existing bond first.

Fixes: 1d87b88ba26e ("Bluetooth: Add SMP workaround Microsoft Surface
Precision Mouse bug")
Reported-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
Assisted-by: LLM
Signed-off-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
---
 net/bluetooth/smp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b7015e37e1f1..6a417e3c9041 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2634,6 +2634,16 @@ static int smp_cmd_ident_addr_info(struct
l2cap_conn *conn,
      info->addr_type != hcon->dst_type)) {
  bt_dev_err(hcon->hdev,
    "ignoring IRK with invalid identity address");
+ goto distribute;
+ }
+
+ /* Don't let a peer connecting from an unresolved RPA replace the IRK of
+ * an already-bonded identity: it has not proven it is that device.
+ */
+ if (hci_bdaddr_is_rpa(&hcon->dst, hcon->dst_type) &&
+    hci_find_irk_by_addr(hcon->hdev, &info->bdaddr, info->addr_type)) {
+ bt_dev_err(hcon->hdev,
+   "ignoring IRK for an identity already bound to a bond");
  goto distribute;
  }

--
2.43.0

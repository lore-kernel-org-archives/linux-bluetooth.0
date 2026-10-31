Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470204;
	b=uWcV2kDGjbVPGEkmNvIVVmsZTcMOqxogQVN2YAAk/JWmxYPLTxszZrCQtSul3ME9viuc
	 CoitgTU0BlIVs0+U3cf48DYCxVsuh1trcw1T5R1s5SAYfPXlGynBslz2pVpw5i7/nrRYE
	 4RHmhKMZHAvZbibSIktKm5aGBOb76ohqGWomh102V8bh4ZP0Cu1AdXDGs33gttUnn6miO
	 bQfHkLgM18SvykUVetVFCiUBudrq3pp0vFZaEO/a2OhweOpfecx7ZUXHrR2bvj5GqTBqh
	 nI4zmkgkfX/VFlxRnQZmFWp8BzC0Pecg6A/9178+N9oY1nBaK05JKv203Pq8I1mgFMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470204;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=CHWHq9Zy5vR+qsWvsEuNRapQeyx5jnj9xkVdG6wSBf8=;
	b=xqr/S0dRZDvcQuOgW+ZiYcjwRTKXY/BUJ3BDeqMAeJwKKIMZk5fqWFDkMTLQ7MBinyac
	 Nu2QTgCBN2WHre83nIPlElhgS2E1q0o1+U1/0RN47NfKycf4pUt57h0+eIYFZGYgqL6pC
	 TNFnC8mHW3IEbUO/k6ddcrnHzrvH8mp6s7QQSHwXMerWMR20RxJA/5ELlaytbMoPnicyt
	 FuVS0cByUsbbKn0/P5Hyd7R3NI06Y3HtDCoARNBUJ1lDIPT8DtoUekqtQYtOjcvhw97OC
	 DxMw07QueEYJJsIxOPwnd7m0hSu3veUePBFGiP4DsevlMAOEYNMsYVFQdvYcLehMAQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=pY8PCseU;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF68606A31C
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 18:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF68606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=pY8PCseU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793470200; x=1793729400;
	bh=CHWHq9Zy5vR+qsWvsEuNRapQeyx5jnj9xkVdG6wSBf8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pY8PCseUedGIzg8v3yuRHeGjR2PuCMY2/q8SnXrD9Z5xS6gRqZkTsmFHUfTLD41gK
	 Mtikgkjo1/CSm+qh9Uxfoftkic2dyVcwjYWO12gdkrxOPwDgFHkgNROyZibFqB2eeR
	 ZucsRPlJuIGF/X4XhPNLBt4FPgs3QN+1ybFaMkZiRwVij/xMW6B/RoLZwzL5jIZHHd
	 LH1LVlGLiLuzFmF+zK5PeLJR17Juy3w+18Ft5Zwy4KTvGKlPmU5P23KyJ3amrjcla1
	 9q0NXXjR9oSrOUzYalA+CuhAxIsWAbZgESW/G5xs9oHRqZEW5TGurtOqZTUHKeC6po
	 VH5TaAXQxDE1Q==
Date: Sat, 31 Oct 2026 18:09:56 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
Message-ID: <YB5bF2dg3T-u9TmGb7FEVGtgbh2rZqn_iTrvaFz_OuXxV098th7TxqvC8qa_-CL4yFoj1UA2QQ_K1v59c3JJKPqRFPNIQ3BCwE__A8U53j4=@proton.me>
In-Reply-To: <20261015181624.48318-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me> <20261015181624.48318-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: d27bbdf3fe02708e6f8c1eeb5c35dcdce6b6deac
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Following up on this patch, is there anything else needed to move it forwar=
d?

Thanks,
Kyle


On Thursday, October 15th, 2026 at 2:16 PM, Kyle Pepper <cochcoder@proton.m=
e> wrote:

> Credit indications can invoke resume on fixed or unready channels.
> Connected LE credit-based sockets can also resume during a security
> upgrade because credits and security share the socket suspend flag.
>=20
> Validate the target mode and state for every identifier. Track pending
> LE/ECRED security upgrades and retain credits without sending queued
> data or resuming the socket until encryption meets the requested level.
> Drain queued data after security completes and keep credit-starved
> sockets suspended.
>=20
> Fixes: fad5fc89594d ("Bluetooth: Add LE flow control discipline")
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> Changes since the standalone security submission:
> - Wrap test notes to fix the GitLint B1 failures in series 1186119.
> - Refresh onto bluetooth-next ff8b09806b7b without a source delta.
> - Include this prerequisite as patch 1/2 of the credit RFC v3 series.
>=20
> This security fix is independently useful. It does not accept identifier
> zero and can be considered without patch 2. The series uses an RFC prefix
> because patch 2 still requires agreement on a specification exception.
> Do not queue the dependent patch alone before this prerequisite lands.
>=20
> The saved standalone CI report lists every job except GitLint passing,
> including the native L2CAP tester. This is not a CI result for this serie=
s.
>=20
> Earlier local runs on 397464709a20: nine focused security controls pass
> on security-only and combined guests. The 14 public credit controls pass
> 13/14 security-only (expected positive zero-ID failure), 14/14 combined.
> There were no skips or captured kernel alerts in these focused runs.
> GCC W=3D1 changed objects and source-extracted fixtures also passed there=
.
>=20
> That base's full local attempt was incomplete: SCI Fast Mode timed out
> after an invalid HCI response length for opcode 0x20a3. The same failure
> reproduced unpatched; this patch does not claim to fix it. Initial spaced
> VM filters selected broader tests; corrected space-free focused runs are
> the results above. Historical older-base results of 133/134 and 134/134
> are not fresh full-suite results for this series.
>=20
> The combined Arch trial is reported working, not isolated security or
> exhaustive lifetime coverage. No severity/CVE claim is made. The private
> reproducer and detailed private regression logs remain excluded.
>=20
>  net/bluetooth/l2cap_core.c | 33 +++++++++++++++++++++++++++++++--
>  net/bluetooth/l2cap_sock.c |  9 +++++++--
>  2 files changed, 38 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 4dd56e007..7a7f30531 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5391,6 +5391,11 @@ static inline int l2cap_le_credits(struct l2cap_co=
nn *conn,
> =20
>  =09l2cap_chan_lock(chan);
> =20
> +=09if (chan->state !=3D BT_CONNECTED ||
> +=09    (chan->mode !=3D L2CAP_MODE_LE_FLOWCTL &&
> +=09     chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL))
> +=09=09goto unlock;
> +
>  =09max_credits =3D LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
>  =09if (credits > max_credits) {
>  =09=09BT_ERR("LE credits overflow");
> @@ -5404,6 +5409,9 @@ static inline int l2cap_le_credits(struct l2cap_con=
n *conn,
> =20
>  =09chan->tx_credits +=3D credits;
> =20
> +=09if (test_bit(FLAG_PENDING_SECURITY, &chan->flags))
> +=09=09goto unlock;
> +
>  =09/* Resume sending */
>  =09l2cap_le_flowctl_send(chan);
> =20
> @@ -7967,6 +7975,8 @@ static void l2cap_security_cfm(struct hci_conn *hco=
n, u8 status, u8 encrypt)
>  =09mutex_lock(&conn->lock);
> =20
>  =09list_for_each_entry(chan, &conn->chan_l, list) {
> +=09=09bool pending_le;
> +
>  =09=09l2cap_chan_lock(chan);
> =20
>  =09=09lockdep_assert_held(&chan->conn->lock);
> @@ -7974,7 +7984,12 @@ static void l2cap_security_cfm(struct hci_conn *hc=
on, u8 status, u8 encrypt)
>  =09=09BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
>  =09=09       state_to_string(chan->state));
> =20
> -=09=09if (!status && encrypt)
> +=09=09pending_le =3D hcon->type =3D=3D LE_LINK &&
> +=09=09=09     (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> +=09=09=09      chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
> +=09=09=09     test_bit(FLAG_PENDING_SECURITY, &chan->flags);
> +
> +=09=09if (!status && encrypt && !pending_le)
>  =09=09=09chan->sec_level =3D hcon->sec_level;
> =20
>  =09=09if (!__l2cap_no_conn_pending(chan)) {
> @@ -7984,7 +7999,21 @@ static void l2cap_security_cfm(struct hci_conn *hc=
on, u8 status, u8 encrypt)
> =20
>  =09=09if (!status && (chan->state =3D=3D BT_CONNECTED ||
>  =09=09=09=09chan->state =3D=3D BT_CONFIG)) {
> -=09=09=09chan->ops->resume(chan);
> +=09=09=09if (pending_le) {
> +=09=09=09=09if (!encrypt ||
> +=09=09=09=09    !smp_sufficient_security(hcon, chan->sec_level,
> +=09=09=09=09=09=09=09    SMP_ALLOW_STK)) {
> +=09=09=09=09=09l2cap_chan_unlock(chan);
> +=09=09=09=09=09continue;
> +=09=09=09=09}
> +
> +=09=09=09=09clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
> +=09=09=09=09chan->sec_level =3D hcon->sec_level;
> +=09=09=09=09l2cap_le_flowctl_send(chan);
> +=09=09=09}
> +
> +=09=09=09if (!pending_le || chan->tx_credits)
> +=09=09=09=09chan->ops->resume(chan);
>  =09=09=09l2cap_check_encryption(chan, encrypt);
>  =09=09=09l2cap_chan_unlock(chan);
>  =09=09=09continue;
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index c396987c5..2d7f2935c 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -993,10 +993,15 @@ static int l2cap_sock_setsockopt(struct socket *soc=
k, int level, int optname,
>  =09=09} else if ((sk->sk_state =3D=3D BT_CONNECT2 &&
>  =09=09=09    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) ||
>  =09=09=09   sk->sk_state =3D=3D BT_CONNECTED) {
> -=09=09=09if (!l2cap_chan_check_security(chan, true))
> +=09=09=09if (!l2cap_chan_check_security(chan, true)) {
> +=09=09=09=09if (conn->hcon->type =3D=3D LE_LINK &&
> +=09=09=09=09    (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> +=09=09=09=09     chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL))
> +=09=09=09=09=09set_bit(FLAG_PENDING_SECURITY, &chan->flags);
>  =09=09=09=09set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
> -=09=09=09else
> +=09=09=09} else {
>  =09=09=09=09sk->sk_state_change(sk);
> +=09=09=09}
>  =09=09} else {
>  =09=09=09err =3D -EINVAL;
>  =09=09}
>=20
> base-commit: ff8b09806b7b18884ad8d3a2b3d702da534a4e21
> 

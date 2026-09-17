Received: from mail-106104.protonmail.ch (mail-106104.protonmail.ch [79.135.106.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110F518146
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664456; cv=none; b=EaSFdzW8si12+BpUPxVv4mRjhFQTnV2Mx6wAfT0j3yjNq+7x53ctRvHGfvqY3K+YHJryNzebVdQnoudsUHwFYMC5sz2n26pLlP/E8MClzRnSbXp9IMzFtbRrQeqF5OM4u0Rp/KNwdt6FBxIjxObEkz+XpH/zQT+IB9HR4P0g/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664456; c=relaxed/simple;
	bh=RH2fdnCvl3JTE9JHPg781MV3wfHoLK3z7Dik2Z+ygBs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DayvzIVH+FE/B41qWA8HcjrWoeJwnQ8AFYwHikHhkUcGoAc0HHaUM/Yp4305IKYzI1EHhmPXSPGHfYfrpUUUkPFKZMaVMEYSO0xXswzP99P1uLuGeghGnLJ73Wes6ipLn4ikagCUfe8CVE/hIWSf4MEMNKoP72hWTd/3BHVZ0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XPPFBfQt; arc=none smtp.client-ip=79.135.106.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XPPFBfQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=dsxkraekkjfr5aur2sxgmzimye.protonmail; t=1789664443; x=1789923643;
	bh=Bjj492CjLO9Jk7RQo/iZcYYunbV0Pd0jNyVOvuYcz3M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XPPFBfQt1ljFhySJEZjaUjqkPIb+0ViwmaA5K0vmyMbySkrJJ6pTQquGjJmrYpr/b
	 Bm+YMl7A3ZiDV6l6Z8pjKaAbKKHPviI2+af+y2dq8VlTg8720Q9rPv73nbyW8smCvJ
	 04H7BUB9sRFkn8bGdkVglUeiHpvo0FowrmwQgkBZZ7w2rlDLdLpBkDrDmMFEqRSdnW
	 a9dkLglA0Lf9wclU68NmeT7EIvDw6opq+u+aKDRqkbrvwvahnmqfw1l3qRt77hC3pn
	 PS320wW9mDVyfgzd4dAU2EGkIqYUc89kMFwMXnRmrBsP45hhuSU2rEardJ5A4ZNAiB
	 hA6QGhg2U1NBA==
Date: Thu, 17 Sep 2026 17:00:39 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v4 1/2] shared/bap: Skip local metadata Config callbacks
Message-ID: <BL2ma9jjRAUeT3MnEg6XM7bojQ-aauPDy75cebC98yo5E9OVFN0uhsKtemymwe6669o08bpgH5T9_tqgx9tZ9NISnATcThQ8fJ4qujO7fZE=@proton.me>
In-Reply-To: <CABBYNZ+OqjfHErzn96k6vw_end_LLM8uECOgyeuncTxt0MJFFA@mail.gmail.com>
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me> <pEIogdpm1KrQokz6n7Vp2rMm4FqyjlQ2X2YtxXFBhhWy_IaqXXNp8K7EwDeohmT6yelHFNOy7IuYYi7ooLtT2zeODVf8LPoBiOTrs7ua3O4=@proton.me> <CABBYNZ+hzc_v_t5xtwsMPDzrhFgLzUwcN6QmABy_=GqJjMHEHg@mail.gmail.com> <6TMaqpYkRT0WXnrX1OlkxzNfaStK17vM4wQJWLFJWEP4ZZ_VRyfVhUEMg8KwzWWQzOsyUY8zEzSg1SBT04BDh9F9yC4Y9rft9GtBAzekwF4=@proton.me> <70Tk7oozT7RMA83SmYEKlhm5sNES1V664l63179SDXwOnzZnXOurvxWa-gGmSDBQ_OS7_2m1ibyKcUr1_CBNoNFsnm-PdGGSOWGeXsgBH9k=@proton.me> <CABBYNZ+OqjfHErzn96k6vw_end_LLM8uECOgyeuncTxt0MJFFA@mail.gmail.com>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: b45d7c7785926cfc497f98a89d3926fb0f82977b
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

When reconfiguring a client stream that is already Codec Configured,
setup_config() queues Codec Configuration and then caches metadata.
stream_metadata() emits a same-state CONFIG notification for that local
update. The profile callback treats it as the peer's configuration
completion and clears config_pending before the peer has responded.

If the control point response precedes the ASE state notification, QoS
setup can run while need_reconfig is still set and fail locally.

Cache client metadata in CONFIG without emitting a state notification.
Keep genuine peer CONFIG notifications and server metadata handling
unchanged.
---
Yes, coalescing masks the failure. The earlier earbud capture has
separate notifications and a 117-byte ATT write; the MTU exchange was
not captured.

v4: MTU 48 was incorrect. Use MTU 64 and reconfigure both streams,
    checking their removal, replacement and acquisition. In two A/B
    runs, fixed passes both cases; unfixed fails Media metadata before
    the second ASE notification. The source fix is unchanged.

 src/shared/bap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 891a2f4fd..6d351d010 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2282,6 +2282,11 @@ static uint8_t stream_metadata(struct bt_bap_stream =
*stream, struct iovec *meta,
 =09case BT_BAP_STREAM_STATE_IDLE:
 =09=09/* Initial metadata */
 =09=09break;
+=09case BT_BAP_STREAM_STATE_CONFIG:
+=09=09/* Local client metadata does not confirm the peer config. */
+=09=09if (stream->client)
+=09=09=09break;
+=09=09/* Fallthrough */
 =09default:
 =09=09/* Force state change to the same state to update metadata */
 =09=09stream_set_state(stream, bt_bap_stream_get_state(stream));
--=20
2.55.0



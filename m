Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [37.187.220.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E354D487F
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.220.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672348; cv=none; b=ufFvNxWkurpD7AglP9AmxuOl87KlNcjJsqhS6zDnTmJ2TmEOH/3Ivjdc+L6y8pcNzGRt2dMFlBPpY7tl1LHgkOWF4E9cFTCCRdAi9Scm3HFHmqGRVRZK3vXglspOe12l4NGDOt+ARYLDDfm4U2oRrTyAym4d4F3ZJ1pSD0P7/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672348; c=relaxed/simple;
	bh=rEeL7vE+G3W/ZmlSn7Mw55xQhLvPZwRoxN84p3YcLn0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izoG2BVLX4PZNUbKCjg5rNXmJA+eV/KV/TGRb1ZlECi0ksRENzfl5tlqvBAFM+D4+ljyYQ2w//JnwykWgd/A5GwrNLlZoTyEBl/yau0zKaLyEZ5KgAb7zV9zf0qN1TnvmL4OKUGR6q7d1vz6BZ3Tdff9MVLcYe7cT4rMkMHGltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FtJJmrPS; arc=none smtp.client-ip=37.187.220.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FtJJmrPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789672328; x=1789931528;
	bh=zBELSGaCAQ+pJHGiN5YTc7TEQyId0cd0lt+k4z0EVS8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FtJJmrPSXywG1poBZdqx8sCPWztdvEG2cuZzFLuKjKMHHKpezXDbg2QuptvWJPgZ4
	 SgJM0WQ22iiUOCKRWsi4Onne6AF4y+jnO2J83P0vY9xLjBKuDAumkv4uNUryRld3JG
	 UAxug6vfcxD5vYtBx0BIFClO18Ns63la6FXQfUE1JuBFNbZ8v1CCJBINamytNI4SwO
	 WSp0/Muu6Uyx8lRbcMC0ezg+2/n1ZhcxFUhnhxl/d0chiQ7YbBdx/TEvph6l9o9JMv
	 G+Q1xx9DyqzzaWJXbnvTkqhYS+usZEHsEySg0GbI1+xIemTBSgBVwNgZ3JIs/zymhs
	 c6CKCX8h5ZFpQ==
Date: Thu, 17 Sep 2026 19:12:04 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v5 1/3] shared/bap: Skip local metadata Config callbacks
Message-ID: <ys4-B1PGqhV2wgPjUFnZLGOi_QkoCs1ZyOZl679pGV8nNJLfR28E4wDuGQti0eyGwIYHgFGa4GqfTi5Vg_nvOqQBqEhRaTlA_D9MxgEblZo=@proton.me>
In-Reply-To: <CABBYNZL22xwzZ5ZgV+k66nNLprgvOM59vEdkq2dq+JX3C2ZMsA@mail.gmail.com>
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me> <pEIogdpm1KrQokz6n7Vp2rMm4FqyjlQ2X2YtxXFBhhWy_IaqXXNp8K7EwDeohmT6yelHFNOy7IuYYi7ooLtT2zeODVf8LPoBiOTrs7ua3O4=@proton.me> <CABBYNZ+hzc_v_t5xtwsMPDzrhFgLzUwcN6QmABy_=GqJjMHEHg@mail.gmail.com> <6TMaqpYkRT0WXnrX1OlkxzNfaStK17vM4wQJWLFJWEP4ZZ_VRyfVhUEMg8KwzWWQzOsyUY8zEzSg1SBT04BDh9F9yC4Y9rft9GtBAzekwF4=@proton.me> <70Tk7oozT7RMA83SmYEKlhm5sNES1V664l63179SDXwOnzZnXOurvxWa-gGmSDBQ_OS7_2m1ibyKcUr1_CBNoNFsnm-PdGGSOWGeXsgBH9k=@proton.me> <CABBYNZ+OqjfHErzn96k6vw_end_LLM8uECOgyeuncTxt0MJFFA@mail.gmail.com> <BL2ma9jjRAUeT3MnEg6XM7bojQ-aauPDy75cebC98yo5E9OVFN0uhsKtemymwe6669o08bpgH5T9_tqgx9tZ9NISnATcThQ8fJ4qujO7fZE=@proton.me> <N6chZc2PG1IpFdftdUK9QY8V8u64pnKS9bvFVoOvdqLwVBN0WBY7gx_UOLAA74ICFbjI0iguwbG0GrndRQP5fbaSG9IK14SZxr6Y-bPQJ-o=@proton.me> <CABBYNZL22xwzZ5ZgV+k66nNLprgvOM59vEdkq2dq+JX3C2ZMsA@mail.gmail.com>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 0c8d151a392952366d66d068875a79655c49b97b
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
I tried a custom preset with Media metadata. endpoint.config succeeded,
but the transport metadata was empty: cmd_config_endpoint() does not
copy preset->meta. Patch 2 fixes that; patch 3 now uses custom presets.

v5: Use an equivalent early return to remove the fallthrough warning.
    Forward preset metadata and test through endpoint.config. Both
    MTU64 cases pass; without the BAP fix, Media fails at premature QoS.

The CI device_addr_type_cmp teardown crash also reproduces on unmodified
f87a79667 with ASan/UBSan. I have not reproduced the separate CIG stack.

 src/shared/bap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 891a2f4fd..536d47161 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2278,6 +2278,11 @@ static uint8_t stream_metadata(struct bt_bap_stream =
*stream, struct iovec *meta,
 =09util_iov_free(stream->meta, 1);
 =09stream->meta =3D util_iov_dup(meta, 1);
=20
+=09/* Local client metadata does not confirm the peer config. */
+=09if (stream->client && bt_bap_stream_get_state(stream) =3D=3D
+=09=09=09=09=09BT_BAP_STREAM_STATE_CONFIG)
+=09=09return 0;
+
 =09switch (bt_bap_stream_get_state(stream)) {
 =09case BT_BAP_STREAM_STATE_IDLE:
 =09=09/* Initial metadata */
--=20
2.55.0



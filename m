Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8D4E323C
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658904; cv=none; b=l8fc4G5mMJ1Y/yK9NWAW7xBfwuxAzcZ7rNe5dVMpDISJk4mGtHEgUWhF2ukTUM+swibYogFSGUc+rAsEvmEwq3XdbSapaqucnpglBbH9/HU885uwLiSw+BqcoqdFEomeNSomzqpBm33jZdcHOWmwkUAJvRqsN4GPBfwmrkkUfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658904; c=relaxed/simple;
	bh=/TztiNX+5iSFG70r99UV5VO+e3r/gcPxUc90YrIkK+A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/XgeywQV0HMDdUQxmfNL4PFsXBwsZcz5N2tbUGyOafMpILmc6kwdbsAw65oCeha5tpJDE5eksF7JGdcftXY5GDhpGfKinn5jZPvwNrhYtnVMAhqLJlcrgEembFCq2Ii/vLdM5jvt+sHFP+wsE05it/zxycsmkNB8uOkhZ7+xKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dmMCoAzc; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dmMCoAzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789658888; x=1789918088;
	bh=gVTrrgoSk97bMswh0cEh7E1eyP9axqzqI9KPccsKAOU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dmMCoAzcf4ppoUNgYMgRmcXiHJ5oHml6aAHo1BeZFkeDF3QEa67i41A44QIO0Y20j
	 gM70FJ4Koq43CAs+Ao8/iRw+mxqelSQVmVFt5T07IIXIHY4lWeNbwdXNkX8+oFLHwA
	 pHrWCecCf1sW+tZW6/YGp/l5xNP373Bc+/Vfbf1GzEEv7G3+Ya/n/na1t3H5iHpQdT
	 PHzTDQ2Ul/76eS8lXIzSSqjDBBEDsjhIkcyuPNYV3v9YRyppmq9FttB8gMVXTrAgG0
	 0JD86Dsg3imrXWsPfnhf4sMUAyDYauKa9rUQETcn3A4a/7lXc/GOX6LQl0ctwH9Fmu
	 aIsWM9Ft6uQtQ==
Date: Thu, 17 Sep 2026 15:28:01 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v3 1/2] shared/bap: Skip local metadata Config callbacks
Message-ID: <6TMaqpYkRT0WXnrX1OlkxzNfaStK17vM4wQJWLFJWEP4ZZ_VRyfVhUEMg8KwzWWQzOsyUY8zEzSg1SBT04BDh9F9yC4Y9rft9GtBAzekwF4=@proton.me>
In-Reply-To: <CABBYNZ+hzc_v_t5xtwsMPDzrhFgLzUwcN6QmABy_=GqJjMHEHg@mail.gmail.com>
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me> <pEIogdpm1KrQokz6n7Vp2rMm4FqyjlQ2X2YtxXFBhhWy_IaqXXNp8K7EwDeohmT6yelHFNOy7IuYYi7ooLtT2zeODVf8LPoBiOTrs7ua3O4=@proton.me> <CABBYNZ+hzc_v_t5xtwsMPDzrhFgLzUwcN6QmABy_=GqJjMHEHg@mail.gmail.com>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 29365f373045f866ceecb57f00bda1e4b43b73c1
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
v3: Replace the unit regression with a real-daemon functional test.
    The source fix is unchanged. Patched unicast tests pass; the
    unpatched metadata case fails in repeated negative controls.

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



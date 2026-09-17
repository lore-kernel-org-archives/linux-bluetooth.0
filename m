Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5639DBD4
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672571; cv=none; b=iMG0yyfVSPrke0FiyCmoeAzeDNhVW1tcPCOc20DKAy9UcmXt2ahaYE41t9FVgEhw9jLI05JEJRYEDcsCS/KgEBL7QfDW2fFwSQLiEq5Q0JdDmqTOob1bSPUn5VFj4A+ZNdRYsxiywiz7e56u8TITUEnEGlob5JaeOdzfb0ZLsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672571; c=relaxed/simple;
	bh=QCUVm+K8oPLVtIHK961QOeH+GGEE+jS2Hcu+nnKR6JI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwPCwIWU/xVytIB0FjviX4ph2qxfeSzmJAX8AdCppZqugHiIaxvX0Q+nDmhwp5Bku4kZ3hOdOiuZdAZHkKR1vlSAPkzkn+/M2qlc89NCCoPRdfpV5TVgejTctTHLnAWOTqibtcrxX/xeDbJ+QtsUaaEoJ0ybVXkyLpqpqHNBEII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ieCq58LV; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ieCq58LV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789672559; x=1789931759;
	bh=QCUVm+K8oPLVtIHK961QOeH+GGEE+jS2Hcu+nnKR6JI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ieCq58LVHOPTFHpDM16OrHJjk3WfyUrqd7dkSS9SYJwVbyjx7WDmmqGbJYZakfsIG
	 44GDWRf6kj73KwteA551cKES2Q0id9OlKAffP0K+pksA8vhWKWuxvfVT+gzvQoIPvJ
	 KelFsJry0IieK1j3xj2KznNthoIpy/hO0molkq7/Pa8Wuy003kMsxLEE0yJ5mYHZJb
	 az4spB27UBpI7624Dz7a+ig+XzhZ7us+iYMoEuIpyxNfweA43Y62bs/bHy4/1676NA
	 RoIiFOQ927aKIYUQrIuXWas8cNeAWyE9k5hX5WUvVhYgVVp9dHwnQuK+Od8udI4DGW
	 hTqt1B6smqC9g==
Date: Thu, 17 Sep 2026 19:15:56 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v5 2/3] client: Pass unicast preset metadata to config
Message-ID: <bAsGrY3-7F2-GlQXHH1h-gzPEZeWQVAazpGLK26IZrhLNgbP5QWANKfd9bVMsn1mV8bT0kGBbekgBMZTOmeEDg_twEcwOoWfjnBexvBjVK0=@proton.me>
In-Reply-To: <ys4-B1PGqhV2wgPjUFnZLGOi_QkoCs1ZyOZl679pGV8nNJLfR28E4wDuGQti0eyGwIYHgFGa4GqfTi5Vg_nvOqQBqEhRaTlA_D9MxgEblZo=@proton.me>
References:
	=?us-ascii?Q?<IGuo=5FED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI=5Fr8dHKBUfAGLjZxXmgfIE=3D@proton.me>_<pEIogdpm1KrQokz6n7Vp2rMm4FqyjlQ2X2YtxXFBhhWy=5FIaqXXNp8K7EwDeohmT6yelHFNOy7IuYYi7ooLtT2zeODVf8LPoBiOTrs7ua3O4=3D@proton.me>_<CABBYNZ+hzc=5Fv=5Ft5xtwsMPDzrhFgLzUwcN6QmABy=5F=3DGqJjMHEHg@mail.gmail.com>_<6TMaqpYkRT0WXnrX1OlkxzNfaStK17vM4wQJWLFJWEP4ZZ=5FVRyfVhUEMg8KwzWWQzOsyUY8zEzSg1SBT04BDh9F9yC4Y9rft9GtBAzekwF4=3D@proton.me>_<70Tk7oozT7RMA83SmYEKlhm5sNES1V664l63179SDXwOnzZnXOurvxWa-gGmSDBQ=5FOS7=5F2m1ibyKcUr1=5FCBNoNFsnm-PdGGSOWGeXsgBH9k=3D@proton.me>_<CABBYNZ+OqjfHErzn96k6vw=5Fend=5FLLM8uECOgyeuncTxt0MJFFA@mail.gmail.com>_<BL2ma9jjRAUeT3MnEg6XM7bojQ-aauPDy75cebC98yo5E9OVFN0uhsKtemymwe6669o08bpgH5T9=5Ftqgx9tZ9NISnATcThQ8fJ4qujO7fZE=3D@proton.me>_<N6chZc2PG1IpFdftdUK9QY8V8u64pnKS9bvFVoOvdqLwVBN0WBY7gx=5FUOLAA74ICFbjI0iguwbG0GrndRQP5fbaSG9IK14SZxr6Y-bPQJ-o=3D@proton.me>_<CABBYNZL22xwzZ5ZgV+k66nNLprgvOM59vEdkq2dq+JX3C2ZMsA@mail.gmail.com>_<ys4-B1?=
 =?us-ascii?Q?PGqhV2wgPjUFnZLGOi=5FQkoCs1ZyOZl679pGV8nNJLfR28E4wDuGQti0eyGwIYHgFGa4GqfTi5Vg=5FnvOqQBqEhRaTlA=5FD9MxgEblZo=3D@proton.me>?=
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: b863245c28646b6bdcc3a0e4d2488b15a3c85c50
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

Custom presets retain metadata, but endpoint.config copies only their
codec capabilities and QoS into SetConfiguration. Copy the metadata too,
and free configuration buffers on completion and immediate failure.
---
 client/player.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/client/player.c b/client/player.c
index 6cd5aeb4a..ae2ce66f0 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3797,15 +3797,20 @@ static void config_endpoint_setup(DBusMessageIter *=
iter, void *user_data)
 =09append_properties(iter, cfg);
 }
=20
+static void config_endpoint_free(struct endpoint_config *cfg)
+{
+=09util_iov_free(cfg->caps, 1);
+=09util_iov_free(cfg->meta, 1);
+=09free(cfg);
+}
+
 static void config_endpoint_reply(DBusMessage *message, void *user_data)
 {
 =09struct endpoint_config *cfg =3D user_data;
 =09struct endpoint *ep =3D cfg->ep;
 =09DBusError error;
=20
-=09free(cfg->caps->iov_base);
-=09free(cfg->caps);
-=09free(cfg);
+=09config_endpoint_free(cfg);
=20
 =09dbus_error_init(&error);
=20
@@ -3827,6 +3832,7 @@ static void endpoint_set_config(struct endpoint_confi=
g *cfg)
 =09=09=09=09=09=09config_endpoint_setup,
 =09=09=09=09=09=09config_endpoint_reply,
 =09=09=09=09=09=09cfg, NULL)) {
+=09=09config_endpoint_free(cfg);
 =09=09bt_shell_printf("Failed to config endpoint\n");
 =09=09return bt_shell_noninteractive_quit(EXIT_FAILURE);
 =09}
@@ -4050,8 +4056,10 @@ static void cmd_config_endpoint(int argc, char *argv=
[])
=20
 =09=09if (cfg->ep->broadcast)
 =09=09=09endpoint_set_config_bcast(cfg);
-=09=09else
+=09=09else {
+=09=09=09cfg->meta =3D util_iov_dup(&preset->meta, 1);
 =09=09=09endpoint_set_config(cfg);
+=09=09}
=20
 =09=09return;
 =09}
@@ -4062,7 +4070,7 @@ static void cmd_config_endpoint(int argc, char *argv[=
])
 =09return;
=20
 fail:
-=09g_free(cfg);
+=09config_endpoint_free(cfg);
 =09return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
=20
--=20
2.55.0



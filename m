Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1237C939
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396632; cv=none; b=sR6iWMyOUtir6PDfRjBYYbxztSMks/rpAUWklMLbMNt0PpLByGmZ0D7qvosc/1TwIzKWD02u3jmO612Z+97CPbOfAAokKz6bUu4UjnJJXAW568WCvvOIjy+PZFmrBzpzh9AYKBGmKKwgScBza/lTjl8LKWUiNrKOJ+aYyzFiHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396632; c=relaxed/simple;
	bh=j1mRufUOquv2NXn6zZqjsjnV5mUi+paBnoXj4LO/MSk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZcaQsplOA2S7E6BPu+u4fN6AoheuGRQVJrNqmPnZnh2+mWzxPP4Bt7O+ulFaucBg+fGkskl4MMXPBs6zkfYOYGuHqPz690g0hmjw2Kr3vCR4TEt0tLeLn3Z8GmRND1FJ/2hI6+K57kDxW+TJcbB/zEnt170HCLZuf8QruPJurLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F074B3EB86
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 10:37:01 +0000 (UTC)
Message-ID: <c78c585353447232262945ca86e54cd715fd9844.camel@hadess.net>
Subject: Re: [RFC BlueZ] media: Fix possible crash on exit/adapter removal
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 02 Jun 2026 12:37:01 +0200
In-Reply-To: <20260512101431.2017966-1-hadess@hadess.net>
References: <20260512101431.2017966-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFtOxJutsUk6KKWRKsYs82T4/5u+2HVbqGjNKdeeeWRY3oOVjrFI+rwYXU8dFRvm4s7hguFnfPpRpcmIZhqf674fFb+eRVuGL6vd83HDD6/yif865lIU7PDWc+Vn2qZQPe3plqO3mDurf5gubwmG/BEbF49MWvAGtywHBI3nC6c++9b2bYSud+cTGTLu91xbcE81uU+rsEc9VmCrY6nQpMCl0ZE0g8Yn2gBzkO+lgq6OdrKmA+y8bMCoDEo9c0Yz8cb8u/cKwAOy4uMoGyM+7lfGWgbjMH7EVNMu41pa0SmzKMssM0N5IWdhAJF0wKLR9LrYEchJn7uZpsa4Puo+xxsGRRQ4boIGD7t60BAkft6nU3xGInFStfTzQU47clzMnLbx4jJkSNNdxcj6QmYQsl6epWqFOnl2+5HfRGfjdtxxabL1IFoUVK1cVMFljxikCyLUtVPmHNoSnzZbRusOCCuvqwyIBnAIKO1et3sgAFQZhFfkFmwaDtuIM8pXLKZ1GCBDV2lgoNBE/yjYQxxfUT3badekNRr3aZMytk4BupBvaQFxdtVN17zwZevlHxx3aU05avoXOT6zqwustNOTcDtl2tt64es6kZpdpmk4V0QOrlGQYby5XnGpVVOKlnjqT5/QEdKwy1hdzP8IFG4S4EXlz1WIO56uj78yjb/ekBQHg

Hey,

Anyone with more knowledge of that audio profile code who could review
this patch?

Cheers

On Tue, 2026-05-12 at 12:14 +0200, Bastien Nocera wrote:
> Nothing protects media_endpoint_remove() from being called multiple
> times for the same structure. Before a g_free() call is made on
> endpoint->capabilities, there are NULL checks, and NULL setting,
> for every variable that might get modified, so a second call to the
> same
> function, even though it's still using-after-free, is only
> reading-after-free, and might crash at the first attempt at modifying
> that freed memory.
>=20
> The reason why this function might be called multiple times is
> because
> in some circumstances, another signal might be received that the
> endpoint is getting removed while we're already in the process of
> removing that endpoint.
>=20
> For example, release_endpoint() (which should appear in between
> path_free() and media_endpoint_remove() in the below backtrace, as
> that's the function called at profiles/audio/media.c:3651), will send
> a
> D-Bus message which it then waits for the answer to, meaning that
> other
> D-Bus message could be received while we're waiting for the answer,
> and
> then destroying the endpoint.
>=20
> =C2=A0#11 media_endpoint_destroy at profiles/audio/media.c:231
> =C2=A0#12 media_endpoint_remove at profiles/audio/media.c:314
> =C2=A0#13 path_free at profiles/audio/media.c:3651
> =C2=A0#14 remove_interface at gdbus/object.c:742
> =C2=A0#15 g_dbus_unregister_interface at gdbus/object.c:1499
> =C2=A0#16 g_slist_foreach at ../glib/gslist.c:837
> =C2=A0#17 unload_drivers at src/adapter.c:5932
> =C2=A0#18 adapter_remove at src/adapter.c:7088
> =C2=A0#19 adapter_unregister at src/adapter.c:9504
> =C2=A0#20 index_removed at src/adapter.c:10693
> =C2=A0#21 queue_foreach at src/shared/queue.c:207
> =C2=A0#23 process_notify at src/shared/mgmt.c:349
> =C2=A0#24 can_read_data at src/shared/mgmt.c:409
> =C2=A0#25 watch_callback at src/shared/io-glib.c:173
> =C2=A0#27 g_main_context_dispatch_unlocked at ../glib/gmain.c:4451
> =C2=A0#28 g_main_context_iterate_unlocked at ../glib/gmain.c:4516
> =C2=A0#30 mainloop_run at src/shared/mainloop-glib.c:65
> =C2=A0#31 mainloop_run_with_signal at src/shared/mainloop-notify.c:196
>=20
> in profiles/audio/media.c:
> =C2=A0231=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(endpoint=
->capabilities);
>=20
> See https://bugzilla.redhat.com/show_bug.cgi?id=3D2467980
> ---
> =C2=A0profiles/audio/media.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index cdaafb04e38c..ad31872c6431 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -611,6 +611,7 @@ static gboolean set_configuration(struct
> media_endpoint *endpoint,
> =C2=A0static void release_endpoint(struct media_endpoint *endpoint)
> =C2=A0{
> =C2=A0	DBusMessage *msg;
> +	struct media_adapter *adapter =3D endpoint->adapter;
> =C2=A0
> =C2=A0	DBG("sender=3D%s path=3D%s", endpoint->sender, endpoint->path);
> =C2=A0
> @@ -631,7 +632,9 @@ static void release_endpoint(struct
> media_endpoint *endpoint)
> =C2=A0	g_dbus_send_message(btd_get_dbus_connection(), msg);
> =C2=A0
> =C2=A0done:
> -	media_endpoint_remove(endpoint);
> +	/* Make sure endpoint didn't already get removed */
> +	if (g_slist_find(adapter->endpoints, endpoint))
> +		media_endpoint_remove(endpoint);
> =C2=A0}
> =C2=A0
> =C2=A0static const char *get_name(struct a2dp_sep *sep, void *user_data)

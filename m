Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304D291C3F
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791400; cv=none; b=ch+qqHyFCPgSAJc5AOMThLRRHvNowbKyCjYYbehki8QQESNxsazF303EsFtVrN4EiybYb0hYrGyGNQe812IyFyDHDh5hFBNUU7MZOkzFebSILL5D1DSATYzyZXswaKDhkGWzRJxo7gvXr9W8Kd8rEVoB3ea+264Z7nus+NrFuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791400; c=relaxed/simple;
	bh=5ydw3n7sORoyfTmD/4zCMTjivFFggk5KPJO0z4rtLyA=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=eR/zbfhQB/c/lGIbaTUKKwqy6yjk4tJn5DwEVg92rG3nh++RYtjMknmevHHqEoFPn3IETBEifJMByGm90Yzbxihrd8jA7d/rmgkU+OmoeTIyRV4AP063VXnzMfQhCtwU8EF5BgMROLJaZX5cDSIj/w763gZDBPLb4pMFx4bvLJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E486431FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 09:36:29 +0000 (UTC)
Message-ID: <4817e2e497496a8638d289bfc32f9f19fd8fd033.camel@hadess.net>
Subject: Another build failure with a2dp disabled
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 15 Dec 2025 10:36:29 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefieegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkuffhvffftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffhfejjeffgfekkeeuvedvtedtieeggeelheduuefhudevgfelgffgvdefhffgvdenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupedugfegkeeigeefudfhvedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean

Hey,

We probably need to add this selection of options to the CI. I found
this using the meson build system, but it also applies to autotools.

Cheers

$ ./bootstrap-configure --disable-a2dp && make
[...]
profiles/audio/media.c: In function =E2=80=98media_player_destroy=E2=80=99:
profiles/audio/media.c:2010:17: error: implicit declaration of function =E2=
=80=98avrcp_unregister_player=E2=80=99 [-Wimplicit-function-declaration]
 2010 |                 avrcp_unregister_player(player);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c: At top level:
profiles/audio/media.c:2282:15: error: variable =E2=80=98player_cb=E2=80=99=
 has initializer but incomplete type
 2282 | static struct avrcp_player_cb player_cb =3D {
      |               ^~~~~~~~~~~~~~~
profiles/audio/media.c:2283:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98list_settings=E2=80=99
 2283 |         .list_settings =3D media_player_list_settings,
      |          ^~~~~~~~~~~~~
profiles/audio/media.c:2283:26: error: excess elements in struct initialize=
r [-Werror]
 2283 |         .list_settings =3D media_player_list_settings,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2283:26: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2284:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98get_setting=E2=80=99
 2284 |         .get_setting =3D media_player_get_setting,
      |          ^~~~~~~~~~~
profiles/audio/media.c:2284:24: error: excess elements in struct initialize=
r [-Werror]
 2284 |         .get_setting =3D media_player_get_setting,
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2284:24: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2285:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98set_setting=E2=80=99
 2285 |         .set_setting =3D media_player_set_setting,
      |          ^~~~~~~~~~~
profiles/audio/media.c:2285:24: error: excess elements in struct initialize=
r [-Werror]
 2285 |         .set_setting =3D media_player_set_setting,
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2285:24: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2286:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98list_metadata=E2=80=99
 2286 |         .list_metadata =3D media_player_list_metadata,
      |          ^~~~~~~~~~~~~
profiles/audio/media.c:2286:26: error: excess elements in struct initialize=
r [-Werror]
 2286 |         .list_metadata =3D media_player_list_metadata,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2286:26: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2287:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98get_uid=E2=80=99
 2287 |         .get_uid =3D media_player_get_uid,
      |          ^~~~~~~
profiles/audio/media.c:2287:20: error: excess elements in struct initialize=
r [-Werror]
 2287 |         .get_uid =3D media_player_get_uid,
      |                    ^~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2287:20: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2288:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98get_metadata=E2=80=99
 2288 |         .get_metadata =3D media_player_get_metadata,
      |          ^~~~~~~~~~~~
profiles/audio/media.c:2288:25: error: excess elements in struct initialize=
r [-Werror]
 2288 |         .get_metadata =3D media_player_get_metadata,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2288:25: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2289:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98get_position=E2=80=99
 2289 |         .get_position =3D media_player_get_position,
      |          ^~~~~~~~~~~~
profiles/audio/media.c:2289:25: error: excess elements in struct initialize=
r [-Werror]
 2289 |         .get_position =3D media_player_get_position,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2289:25: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2290:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98get_duration=E2=80=99
 2290 |         .get_duration =3D media_player_get_duration,
      |          ^~~~~~~~~~~~
profiles/audio/media.c:2290:25: error: excess elements in struct initialize=
r [-Werror]
 2290 |         .get_duration =3D media_player_get_duration,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2290:25: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2291:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98get_status=E2=80=99
 2291 |         .get_status =3D media_player_get_status,
      |          ^~~~~~~~~~
profiles/audio/media.c:2291:23: error: excess elements in struct initialize=
r [-Werror]
 2291 |         .get_status =3D media_player_get_status,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2291:23: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2292:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98get_name=E2=80=99
 2292 |         .get_name =3D media_player_get_player_name,
      |          ^~~~~~~~
profiles/audio/media.c:2292:21: error: excess elements in struct initialize=
r [-Werror]
 2292 |         .get_name =3D media_player_get_player_name,
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2292:21: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2293:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98play=E2=80=99
 2293 |         .play =3D media_player_play,
      |          ^~~~
profiles/audio/media.c:2293:17: error: excess elements in struct initialize=
r [-Werror]
 2293 |         .play =3D media_player_play,
      |                 ^~~~~~~~~~~~~~~~~
profiles/audio/media.c:2293:17: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2294:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98stop=E2=80=99
 2294 |         .stop =3D media_player_stop,
      |          ^~~~
profiles/audio/media.c:2294:17: error: excess elements in struct initialize=
r [-Werror]
 2294 |         .stop =3D media_player_stop,
      |                 ^~~~~~~~~~~~~~~~~
profiles/audio/media.c:2294:17: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2295:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98pause=E2=80=99
 2295 |         .pause =3D media_player_pause,
      |          ^~~~~
profiles/audio/media.c:2295:18: error: excess elements in struct initialize=
r [-Werror]
 2295 |         .pause =3D media_player_pause,
      |                  ^~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2295:18: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2296:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98next=E2=80=99
 2296 |         .next =3D media_player_next,
      |          ^~~~
profiles/audio/media.c:2296:17: error: excess elements in struct initialize=
r [-Werror]
 2296 |         .next =3D media_player_next,
      |                 ^~~~~~~~~~~~~~~~~
profiles/audio/media.c:2296:17: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c:2297:10: error: =E2=80=98struct avrcp_player_cb=E2=
=80=99 has no member named =E2=80=98previous=E2=80=99
 2297 |         .previous =3D media_player_previous,
      |          ^~~~~~~~
profiles/audio/media.c:2297:21: error: excess elements in struct initialize=
r [-Werror]
 2297 |         .previous =3D media_player_previous,
      |                     ^~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2297:21: note: (near initialization for =E2=80=98pla=
yer_cb=E2=80=99)
profiles/audio/media.c: In function =E2=80=98set_status=E2=80=99:
profiles/audio/media.c:2327:9: error: implicit declaration of function =E2=
=80=98avrcp_player_event=E2=80=99 [-Wimplicit-function-declaration]
 2327 |         avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, =
mp->status);
      |         ^~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2327:40: error: =E2=80=98AVRCP_EVENT_STATUS_CHANGED=
=E2=80=99 undeclared (first use in this function)
 2327 |         avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, =
mp->status);
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2327:40: note: each undeclared identifier is reporte=
d only once for each function it appears in
profiles/audio/media.c: In function =E2=80=98set_position=E2=80=99:
profiles/audio/media.c:2356:41: error: =E2=80=98AVRCP_EVENT_TRACK_REACHED_S=
TART=E2=80=99 undeclared (first use in this function)
 2356 |                                         AVRCP_EVENT_TRACK_REACHED_S=
TART, NULL);
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
profiles/audio/media.c:2365:48: error: =E2=80=98AVRCP_EVENT_TRACK_REACHED_E=
ND=E2=80=99 undeclared (first use in this function)
 2365 |                 avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_RE=
ACHED_END,
      |                                                ^~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
profiles/audio/media.c:2371:40: error: =E2=80=98AVRCP_EVENT_STATUS_CHANGED=
=E2=80=99 undeclared (first use in this function)
 2371 |         avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, =
status);
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c: In function =E2=80=98parse_player_metadata=E2=80=99=
:
profiles/audio/media.c:2545:40: error: =E2=80=98AVRCP_EVENT_TRACK_CHANGED=
=E2=80=99 undeclared (first use in this function)
 2545 |         avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, &=
uid);
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2546:40: error: =E2=80=98AVRCP_EVENT_TRACK_REACHED_S=
TART=E2=80=99 undeclared (first use in this function)
 2546 |         avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_ST=
ART, NULL);
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
profiles/audio/media.c: In function =E2=80=98set_property=E2=80=99:
profiles/audio/media.c:2564:40: error: =E2=80=98AVRCP_EVENT_SETTINGS_CHANGE=
D=E2=80=99 undeclared (first use in this function)
 2564 |         avrcp_player_event(mp->player, AVRCP_EVENT_SETTINGS_CHANGED=
, key);
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c: In function =E2=80=98media_player_create=E2=80=99:
profiles/audio/media.c:2787:22: error: implicit declaration of function =E2=
=80=98avrcp_register_player=E2=80=99 [-Wimplicit-function-declaration]
 2787 |         mp->player =3D avrcp_register_player(adapter->btd_adapter, =
&player_cb,
      |                      ^~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2787:20: error: assignment to =E2=80=98struct avrcp_=
player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer wit=
hout a cast [-Wint-conversion]
 2787 |         mp->player =3D avrcp_register_player(adapter->btd_adapter, =
&player_cb,
      |                    ^
profiles/audio/media.c: At top level:
profiles/audio/media.c:2282:31: error: storage size of =E2=80=98player_cb=
=E2=80=99 isn=E2=80=99t known
 2282 | static struct avrcp_player_cb player_cb =3D {
      |                               ^~~~~~~~~
profiles/audio/media.c:1488:13: error: =E2=80=98a2dp_endpoint_supported=E2=
=80=99 defined but not used [-Werror=3Dunused-function]
 1488 | static bool a2dp_endpoint_supported(struct btd_adapter *adapter)
      |             ^~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:645:15: error: =E2=80=98get_capabilities=E2=80=99 de=
fined but not used [-Werror=3Dunused-function]
  645 | static size_t get_capabilities(struct a2dp_sep *sep, uint8_t **capa=
bilities,
      |               ^~~~~~~~~~~~~~~~
profiles/audio/media.c:638:20: error: =E2=80=98get_path=E2=80=99 defined bu=
t not used [-Werror=3Dunused-function]
  638 | static const char *get_path(struct a2dp_sep *sep, void *user_data)
      |                    ^~~~~~~~
profiles/audio/media.c:631:20: error: =E2=80=98get_name=E2=80=99 defined bu=
t not used [-Werror=3Dunused-function]
  631 | static const char *get_name(struct a2dp_sep *sep, void *user_data)
      |                    ^~~~~~~~
profiles/audio/media.c:533:32: error: =E2=80=98find_device_transport=E2=80=
=99 defined but not used [-Werror=3Dunused-function]
  533 | static struct media_transport *find_device_transport(
      |                                ^~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:496:17: error: =E2=80=98select_configuration=E2=80=
=99 defined but not used [-Werror=3Dunused-function]
  496 | static gboolean select_configuration(struct media_endpoint *endpoin=
t,
      |                 ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8595: profiles/audio/bluetoothd-media.o] Error 1
make[1]: *** Waiting for unfinished jobs....
profiles/audio/transport.c: In function =E2=80=98media_transport_get_device=
_volume=E2=80=99:
profiles/audio/transport.c:2769:17: error: unused variable =E2=80=98l=E2=80=
=99 [-Werror=3Dunused-variable]
 2769 |         GSList *l;
      |                 ^
profiles/audio/transport.c: In function =E2=80=98media_transport_update_dev=
ice_volume=E2=80=99:
profiles/audio/transport.c:2800:17: error: unused variable =E2=80=98l=E2=80=
=99 [-Werror=3Dunused-variable]
 2800 |         GSList *l;
      |                 ^
cc1: all warnings being treated as errors

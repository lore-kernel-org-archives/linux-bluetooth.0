Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172178;
	b=ivsp5U7izW2mbzIiuRbNuPDOigigtuvhog7cE/E4uRc5ihC2V/1KehKtyv0uTYIBHUuI
	 Yc8NjNZeS3K07J2XNDatS2kgcVUmJAnC6wnYvSxzH5C/++/z9tNcV+nlp2qbnLvKAXs0B
	 Z4GxTnF6oKJIbZHrhbIzTxV7HG94736+vgE+D1a/udWjUXUnzAY6vZPAOid1XNzX4dDly
	 Xe4wD9ptYWuxWJ9sPvYuw2yVCBJLq47fWB7wkGFiNfemp4KDxqqrOm6cwY+lXyYYg/wNf
	 hb0BGU6XRHTYmOSZYv6TxTLGtkKl6P7+No4aoI/9JM+gwx+/XkG++LJZk1Gnv5duSCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172178;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2GYR0BM5EGVGU8lAVkyAzE6Sdu9Rqqcfum9sD8y2vUg=;
	b=AcrYD8uijQTfZmFzBWOpYkFru7TwM/N6DJMWqOPBwZEU751xF23ucK368NBrBkS3qi79
	 MtTza/0K1jf5jUM91J7X4Pd5x+UaMvgZ/6DazF4yVosqC7Z2DGZfv403YGfJXGKX4lkB6
	 iEBy2EQmWdKtGOQsjCABV6BBUb1LShd9ps0CIFfgiKeguPH8SbIOxI/I/qo1qkUYQkV/h
	 MkqGaH1FdsvURF1aYIDyaBiXeck0z7y/SHx7HFRsECTkRvER5kA+pAbHSAn+CsyxblynA
	 VRQViR9bWb8NFpgwIR3FpbNmJKYkqJ1yNxkYNFBD+OLEWXeg1S1+s0jVrt0jztqlH+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="j5Pm133/";
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B403606A339
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 10:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B403606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=j5Pm133/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795172174; x=1795431374;
	bh=2GYR0BM5EGVGU8lAVkyAzE6Sdu9Rqqcfum9sD8y2vUg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=j5Pm133/v+XzLZ0tmb0qCmlaZwMMiLre7ZhBBY6OY0k3SGXt06YJr7lJKYlUfYe99
	 /HMZk6b+fBed0E+XnNc4+oHFAU90DFXVd1BQgTcCg1c2biKtdz9D1OZun9HPm3bSHJ
	 iQfk0HusxK+cKWHFCUS+ONhWAS1DtxBiuazx85CeFu7JtBoHl0QB4H4hQeEkGPc3Kt
	 oh8nOb/EBzLsfrMq0rcHsQusFsfiTIKxTF3kZnqLuE5o+EIVknVEcNZBem0+/qcLHW
	 pZOtXb29I3IZk8fQ8ck4IYrNhrxbCocomknTiyN0xm2x6EwwtMA72ykGzM3XSYrwtr
	 iuiGr0ZtryFqg==
Date: Fri, 20 Nov 2026 10:56:11 +0000
To: linux-bluetooth@vger.kernel.org
From: Jovelyn Custodio <noplatinumfound@protonmail.com>
Subject: [PATCH BlueZ] main.conf: Add SecureSimplePairing option
Message-ID: <20261120105609.94042-1-noplatinumfound@protonmail.com>
Feedback-ID: 27263372:user:proton
X-Pm-Message-ID: 9ee0a230cedddc3cf293db1f69d0f463436244fa
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

This adds SecureSimplePairing option to General section which can be
used to keep Secure Simple Pairing disabled on BR/EDR capable adapters.
It defaults to true, which keeps the current behaviour of always
enabling it.

Some HID devices can't reconnect to a host that has SSP enabled. A
Nintendo Switch Pro Controller reconnecting to an RTL8851BU adapter
authenticates and encrypts the link on its own, opens PSM 17 and then
stalls until Encryption Key Refresh Complete arrives with LMP Response
Timeout 30 seconds later. PSM 19 is never opened. With SSP disabled
the host starts authentication instead, no key refresh takes place and
the controller reconnects.

Assisted-by: Claude:claude-fable-5-2
---

Notes:
    I ran into this with a Switch Pro Controller on an RTL8851BU combo
    stick (kernel 7.3.4, BlueZ 5.88). Fresh pairing works, but pressing
    Home to reconnect fails every time: the controller pages the host,
    authenticates and turns on E0 by itself, opens PSM 17, and about 100 ms
    later the link stalls. 30 seconds on I get Encryption Key Refresh
    Complete with LMP Response Timeout and a disconnect. PSM 19 never shows
    up.
   =20
    Link policy 0x0000, Secure Connections off, UserspaceHID=3Dfalse and
    disable_ertm didn't help. Accepting as peripheral (a2dp and avrcp
    plugins off) didn't either, since the controller asks for a role switch
    itself and I'm back at the stall.
   =20
    Refusing the role switch as well got further: Encryption Key Refresh
    Complete came back with Transaction Collision, then Success, PSM 19
    opened and hid-nintendo bound. About 0.8 seconds later the controller
    turned encryption off and the kernel dropped the link with
    Authentication Failure. So the refresh seems to only get stuck when the
    adapter is central.
   =20
    Turning SSP off with btmgmt was the only single change that fixed it,
    but bluetoothd switches it back on at every start, hence the option.
   =20
    Tested on that one adapter and controller only:
     - option absent or true: SSP gets enabled as before
     - option false: SSP stays off after a daemon restart and after
       rebinding btusb, and the Home press reconnect works with a link key
       made while SSP was on
     - pairing from scratch with the option false works too (legacy
       pairing, autopair answers with PIN 0000)
     - make check passes, checkpatch is clean
   =20
    Not tested:
     - adapters whose controller supports BR/EDR Secure Connections. Going
       by mgmt.c the kernel rejects Set Secure Connections there while SSP
       is off, so they'd lose SC with this option. That's what the note in
       main.conf is about.
     - ControllerMode =3D bredr
     - UserspaceHID=3Dtrue. I'd already switched it to false before I found
       this and haven't gone back yet.
   =20
    I can't see LMP on this chip, so I don't know if the stuck key refresh
    is Realtek's firmware or the controller's. It's probably the same thing
    as https://github.com/bluez/bluez/issues/824.

 src/adapter.c | 22 ++++++++++++++++++----
 src/btd.h     |  1 +
 src/main.c    |  4 ++++
 src/main.conf | 11 +++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1439642..3d3a272 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10841,6 +10841,19 @@ static void read_exp_features(struct btd_adapter *=
adapter)
 =09btd_error(adapter->dev_id, "Failed to read exp features info");
 }
=20
+static void set_ssp(struct btd_adapter *adapter)
+{
+=09bool enabled =3D adapter->current_settings & MGMT_SETTING_SSP;
+
+=09if (!(adapter->supported_settings & MGMT_SETTING_SSP))
+=09=09return;
+
+=09if (enabled =3D=3D btd_opts.ssp)
+=09=09return;
+
+=09set_mode(adapter, MGMT_OP_SET_SSP, btd_opts.ssp ? 0x01 : 0x00);
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 =09=09=09=09=09const void *param, void *user_data)
 {
@@ -10921,8 +10934,8 @@ static void read_info_complete(uint8_t status, uint=
16_t length,
 =09=09=09set_mode(adapter, MGMT_OP_SET_LE, 0x01);
 =09=09if (missing_settings & MGMT_SETTING_BREDR)
 =09=09=09set_mode(adapter, MGMT_OP_SET_BREDR, 0x01);
-=09=09if (missing_settings & MGMT_SETTING_SSP)
-=09=09=09set_mode(adapter, MGMT_OP_SET_SSP, 0x01);
+
+=09=09set_ssp(adapter);
 =09=09break;
 =09case BT_MODE_BREDR:
 =09=09if (!(adapter->supported_settings & MGMT_SETTING_BREDR)) {
@@ -10933,8 +10946,9 @@ static void read_info_complete(uint8_t status, uint=
16_t length,
=20
 =09=09if (missing_settings & MGMT_SETTING_BREDR)
 =09=09=09set_mode(adapter, MGMT_OP_SET_BREDR, 0x01);
-=09=09if (missing_settings & MGMT_SETTING_SSP)
-=09=09=09set_mode(adapter, MGMT_OP_SET_SSP, 0x01);
+
+=09=09set_ssp(adapter);
+
 =09=09if (adapter->current_settings & MGMT_SETTING_LE)
 =09=09=09set_mode(adapter, MGMT_OP_SET_LE, 0x00);
 =09=09break;
diff --git a/src/btd.h b/src/btd.h
index 9bf3102..39fb609 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -141,6 +141,7 @@ struct btd_opts {
 =09bool=09=09device_privacy;
 =09uint32_t=09name_request_retry_delay;
 =09uint8_t=09=09secure_conn;
+=09bool=09=09ssp;
=20
 =09struct btd_defaults defaults;
=20
diff --git a/src/main.c b/src/main.c
index 3a051c5..27d98a6 100644
--- a/src/main.c
+++ b/src/main.c
@@ -83,6 +83,7 @@ static const char *supported_options[] =3D {
 =09"MultiProfile",
 =09"FastConnectable",
 =09"SecureConnections",
+=09"SecureSimplePairing",
 =09"Privacy",
 =09"JustWorksRepairing",
 =09"TemporaryTimeout",
@@ -1117,6 +1118,8 @@ static void parse_general(GKeyFile *config)
 =09parse_config_bool(config, "General", "RefreshDiscovery",
 =09=09=09=09=09=09&btd_opts.refresh_discovery);
 =09parse_secure_conns(config);
+=09parse_config_bool(config, "General", "SecureSimplePairing",
+=09=09=09=09=09=09&btd_opts.ssp);
 =09parse_config_bool(config, "General", "Experimental",
 =09=09=09=09=09=09&btd_opts.experimental);
 =09parse_config_bool(config, "General", "Testing",
@@ -1479,6 +1482,7 @@ static void init_defaults(void)
 =09btd_opts.refresh_discovery =3D TRUE;
 =09btd_opts.name_request_retry_delay =3D DEFAULT_NAME_REQUEST_RETRY_DELAY;
 =09btd_opts.secure_conn =3D SC_ON;
+=09btd_opts.ssp =3D true;
 =09btd_opts.filter_discoverable =3D true;
=20
 =09btd_opts.defaults.num_entries =3D 0;
diff --git a/src/main.conf b/src/main.conf
index c990614..76f9ec0 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -122,6 +122,17 @@
 # Defaults to "on"
 #SecureConnections =3D on
=20
+# Default Secure Simple Pairing setting.
+# Enables Secure Simple Pairing for BR/EDR on adapters that support it.
+# Disabling it makes BR/EDR pairing fall back to legacy PIN code pairing, =
so
+# only do it for remote devices that don't work otherwise. Existing link k=
eys
+# are kept. The kernel refuses to enable Secure Connections without it on
+# controllers that support BR/EDR Secure Connections. If the adapter is
+# already powered the change applies the next time it is powered on.
+# Possible values: true, false
+# Defaults to true
+#SecureSimplePairing =3D true
+
 # Enables D-Bus experimental interfaces
 # Possible values: true or false
 #Experimental =3D false
--=20
2.56.1



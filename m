Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F7227587D
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734136; cv=none; b=EUiFbO/Eon4wR5fePPIJdNUsC9luDzkHWSMFhoPxBJu3GfI+4vVnrD3GNzwNT4GdNz8wUiMmZgi3zGV0iuTpT/dUjxx+H2NZTZzbDdd0Vvo36uBywCrMS6aVL0sL6gnUG7xYGAknZuCXX59kptPIDNARGHWaEcRgRXsELyt884w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734136; c=relaxed/simple;
	bh=C7MqMwJHpbfs9UKzRUJpiyPYNevfRQ47fBBkOS7Bm9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dv3iklXWWghR4GYrocXeaOs4qr/cLd0bAG4/dyKJsEhcBvnRcxFJemsybRDuASIk3I+ZRCAz3fufuPrlIfYpCxcCumWVQcKnFXIh1qNYSC+S/ligdhp2yiRYd7/eQ9Nhd45p56IC0w03qcxMS+mj65vtKO7hLarAFzU8C5QNE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhZxsksq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhZxsksq"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b9d8122fdso16196481fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 06:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763734131; x=1764338931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iqU2VRA3jxI8c36megxiFWKesHsWozgIZGTGpLqnsY=;
        b=lhZxsksqkJQxs4tiMAweHx4NqGXJLD2gbdAw50iOpNQXaTeHkhLmM0ThkD0KQ5Dyn5
         Tm/wcf0qEfpQdAQnXCPHOfWwEJmCVvpzpql5C5SsNhQki0FRv4pm4YiWWcZ3WORKCBNe
         CxlbfKk3tKgcbQgs+TdlN2XkGvRDz+8MLhBRg0cZplk/IIyVJbU1KqIj0lO0FEGc1qT3
         R0bIqcMqrp0AdnxIcoEIoTAEf71OsK/5yP7wGEeoMLvWiNWem0dD7KUv494xzbN3GJAZ
         ajDnUoltBUjUeeVMoYt3OLn/A8gLGBTM0b9tU2qwHKKHpvcLcw/9Au2IwD/G4jksXkrt
         GAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734131; x=1764338931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5iqU2VRA3jxI8c36megxiFWKesHsWozgIZGTGpLqnsY=;
        b=oJztCRY2/m6+nqCzHpnSpSlfnzzd6T78nMpOjGAfyomXUgOcIAr9Z/5j3zOxpRkLMs
         9HsjICJNS7l4tACyvNmMsji/hjC70UaTFsBPrxd0iqrl1PatLE+eOYBIYtYn/twk0Q8v
         yUrsld/EfRuJTE4wEJiGxILpo4VFMCbw9YDkXBu3xN71zipEx27DpKN2Wy1o3I6LQbNc
         BKvzf5TS5K8rI0CESqAAHOvKUny6P28Jb/9YjITDJ61iY7/xbISBOydqOsfO6cAhywrf
         l5dJ5VQSIyK6bf6ySutaOwyTrvqwwGTsw2DWFZJefDyfCxmt3XDYs6nSL7b+barZxIrV
         vdEQ==
X-Gm-Message-State: AOJu0YxC+EtFvm+dpQ9U7P0xd2tgVX7D68Rg19cFb6djJ0K9/HyNl3g6
	Ls5huGWLPZTCVQlzcbC+Y6ixRILi8Rv70LF1f27thi7lgsC+hoJN8f7L4kYFBx/RIJZp2JbjY31
	3z1QJF1scP5ec1PrIet/NFphj4i4MXzU=
X-Gm-Gg: ASbGncs2D1Kv4j+aQwdnzDDA+1Kyo3bYLzoS4Xo4ByKsDB0IHPaMHujcH8gUMp2Y3Zc
	K5oTcxcSyIMkpNsTYytxq0pL2hbxKqGi7RsT1OJp0feFdmVE+5Ii7VPVsOSlZgXT8mFRXzmQ8M+
	KsU8H8yx9iv/+cJ7MIAjLeTc8kYX3GLGZDO18T0ibRORZxVmSsvc5mx5RoKS6nbhru3Q28OxWoL
	6uUfO3TDMQ2x+y+884s43tIYWxR5sUyX9dmsJFLn3rGkgUW8q0uG+0xNt+hEj7iso8MJA==
X-Google-Smtp-Source: AGHT+IHx4RRmcrk5VRuE+UYNFmmAstKSt0J/mfGLh7z0xHHPC8fnLad+QYqa4JjCkkWF2yGfaHVVEHmKgdVLbEqlxek=
X-Received: by 2002:a05:651c:31d8:b0:37b:b8c0:b5ec with SMTP id
 38308e7fff4ca-37cd923d1aemr6572321fa.24.1763734130667; Fri, 21 Nov 2025
 06:08:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121-bearer-impl-v4-1-b52149dfd9a6@amlogic.com>
In-Reply-To: <20251121-bearer-impl-v4-1-b52149dfd9a6@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Nov 2025 09:08:37 -0500
X-Gm-Features: AWmQ_bl-MoRGUGr4hzTD_PaiphCikXMahY07XuULl4ra3slqtdl61Z-6E9uRqqY
Message-ID: <CABBYNZLqvJu=jM5eWujNU3LRnLAvFMqFRU9X44PvH65hK-xjrQ@mail.gmail.com>
Subject: Re: [PATCH bluez v4] bearer: Implement Connect/Disconnect methods
To: ye.he@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 21, 2025 at 3:54=E2=80=AFAM Ye He via B4 Relay
<devnull+ye.he.amlogic.com@kernel.org> wrote:
>
> From: Ye He <ye.he@amlogic.com>
>
> This patch provides implementations for the Connect and Disconnect
> methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
> interfaces.
>
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
> Changes in v4:
> - Add a bearer field to btd_profile to indicate which bearer type the pro=
file
> - belongs to, thus we can distinct the services per bearer.
> - Link to v3: https://patch.msgid.link/20251118-bearer-impl-v3-1-dadcd8b0=
c75d@amlogic.com
>
> Changes in v3:
> - Move the modification logic from the device to bearer, and add
> - some helper functions to the device.
> - Link to v2: https://patch.msgid.link/20251113-bearer-impl-v2-1-c3e825cc=
6758@amlogic.com
>
> Changes in v2:
> - Fix build error & warning.
> - Link to v1: https://patch.msgid.link/20251111-bearer-impl-v1-1-f4158514=
4218@amlogic.com
> ---
>  profiles/audio/a2dp.c         |   2 +
>  profiles/audio/asha.c         |   2 +
>  profiles/audio/avrcp.c        |   2 +
>  profiles/audio/bap.c          |   2 +
>  profiles/audio/bass.c         |   1 +
>  profiles/audio/ccp.c          |   1 +
>  profiles/audio/csip.c         |   2 +
>  profiles/audio/mcp.c          |   1 +
>  profiles/audio/micp.c         |   1 +
>  profiles/audio/vcp.c          |   1 +
>  profiles/health/hdp_manager.c |   2 +
>  profiles/input/hog.c          |   1 +
>  profiles/input/manager.c      |   2 +
>  profiles/midi/midi.c          |   1 +
>  profiles/network/manager.c    |   3 +
>  profiles/scanparam/scan.c     |   1 +
>  src/bearer.c                  | 192 ++++++++++++++++++++++++++++++++++++=
+++++-
>  src/device.c                  | 158 +++++++++++++++++++++++++++++-----
>  src/device.h                  |  17 ++++
>  src/profile.h                 |  10 +++
>  20 files changed, 380 insertions(+), 22 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index d8f24eaebc745a6d91a8207f6595f0b90d982c39..7f7917fc066b7b7e9176c6a99=
ee510ff8a3ac15c 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -3757,6 +3757,7 @@ static void media_server_remove(struct btd_adapter =
*adapter)
>  static struct btd_profile a2dp_source_profile =3D {
>         .name           =3D "a2dp-source",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_BREDR,
>
>         .remote_uuid    =3D A2DP_SOURCE_UUID,
>         .device_probe   =3D a2dp_source_probe,
> @@ -3773,6 +3774,7 @@ static struct btd_profile a2dp_source_profile =3D {
>  static struct btd_profile a2dp_sink_profile =3D {
>         .name           =3D "a2dp-sink",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_BREDR,
>
>         .remote_uuid    =3D A2DP_SINK_UUID,
>         .device_probe   =3D a2dp_sink_probe,
> diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> index e870ea06f03ac1c20e5b29fb158c815aa2ce756c..94414ea815215cf7e0825bd09=
dff5bdb106e6338 100644
> --- a/profiles/audio/asha.c
> +++ b/profiles/audio/asha.c
> @@ -499,6 +499,8 @@ static int asha_source_disconnect(struct btd_service =
*service)
>  static struct btd_profile asha_source_profile =3D {
>         .name           =3D "asha-source",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
> +
>         .remote_uuid    =3D ASHA_PROFILE_UUID,
>         .experimental   =3D true,
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 21bc80bbd095da49788a87357fd67c8e96ab779d..e6f7e1bfde9879ab6bf028e16=
384d474332fe805 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -4868,6 +4868,7 @@ done:
>
>  static struct btd_profile avrcp_target_profile =3D {
>         .name           =3D "audio-avrcp-target",
> +       .bearer         =3D BTD_PROFILE_BEARER_BREDR,
>
>         .remote_uuid    =3D AVRCP_TARGET_UUID,
>         .device_probe   =3D avrcp_target_probe,
> @@ -4951,6 +4952,7 @@ done:
>
>  static struct btd_profile avrcp_controller_profile =3D {
>         .name           =3D "avrcp-controller",
> +       .bearer         =3D BTD_PROFILE_BEARER_BREDR,
>
>         .remote_uuid    =3D AVRCP_REMOTE_UUID,
>         .device_probe   =3D avrcp_controller_probe,
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 85bba9543974e5bf2a1ff6380c36e518ebc095ac..a03a120ddaaed7e261d40ac06=
a8f9502c52772bc 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -3865,6 +3865,7 @@ static void bap_adapter_remove(struct btd_profile *=
p,
>  static struct btd_profile bap_profile =3D {
>         .name           =3D "bap",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .remote_uuid    =3D PACS_UUID_STR,
>         .device_probe   =3D bap_probe,
>         .device_remove  =3D bap_remove,
> @@ -3879,6 +3880,7 @@ static struct btd_profile bap_profile =3D {
>  static struct btd_profile bap_bcast_profile =3D {
>         .name           =3D "bcaa",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .remote_uuid    =3D BCAAS_UUID_STR,
>         .device_probe   =3D bap_bcast_probe,
>         .device_remove  =3D bap_bcast_remove,
> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> index 9ace372376f9452050724360c2c28e7cdcf1391b..8886a27d99b63b37e2937d8d7=
0f71dfeda3d9ef2 100644
> --- a/profiles/audio/bass.c
> +++ b/profiles/audio/bass.c
> @@ -2172,6 +2172,7 @@ static void bass_server_remove(struct btd_profile *=
p,
>  static struct btd_profile bass_service =3D {
>         .name           =3D "bass",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .remote_uuid    =3D BASS_UUID_STR,
>         .device_probe   =3D bass_probe,
>         .device_remove  =3D bass_remove,
> diff --git a/profiles/audio/ccp.c b/profiles/audio/ccp.c
> index 8aa537b044e13b6d6a773645b420161bedca13ef..fb85045bb8ba1ec47a33856af=
1129d0ef78bf500 100644
> --- a/profiles/audio/ccp.c
> +++ b/profiles/audio/ccp.c
> @@ -208,6 +208,7 @@ ccp_server_remove(struct btd_profile *p,
>  static struct btd_profile ccp_profile =3D {
>         .name           =3D "ccp",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .remote_uuid    =3D GTBS_UUID_STR,
>         .device_probe   =3D ccp_probe,
>         .device_remove  =3D ccp_remove,
> diff --git a/profiles/audio/csip.c b/profiles/audio/csip.c
> index b8f29ddf852231d89760d6fe7ca2cfd684236570..d766c3da951899d990aa59132=
b820737604b1b7c 100644
> --- a/profiles/audio/csip.c
> +++ b/profiles/audio/csip.c
> @@ -303,6 +303,7 @@ static void csip_remove(struct btd_service *service)
>  static struct btd_profile csip_profile =3D {
>         .name           =3D "csip",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .remote_uuid    =3D CSIS_UUID_STR,
>
>         .device_probe   =3D csip_probe,
> @@ -442,6 +443,7 @@ static void csis_server_remove(struct btd_profile *p,
>  static struct btd_profile csis_profile =3D {
>         .name           =3D "csis",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .local_uuid     =3D CSIS_UUID_STR,
>
>         .adapter_probe  =3D csis_server_probe,
> diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
> index 6651b0897e6f631906b1467f5a479737541da286..8d4eed64399195533ac13fd07=
5d7196a35cf2113 100644
> --- a/profiles/audio/mcp.c
> +++ b/profiles/audio/mcp.c
> @@ -383,6 +383,7 @@ static void media_control_server_remove(struct btd_pr=
ofile *p,
>  static struct btd_profile mcp_profile =3D {
>         .name                   =3D "mcp",
>         .priority               =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .remote_uuid    =3D GMCS_UUID_STR,
>         .device_probe   =3D mcp_probe,
>         .device_remove  =3D mcp_remove,
> diff --git a/profiles/audio/micp.c b/profiles/audio/micp.c
> index f1fb133897320677225a1c8bee06b4a1214f14fa..475f32daf75c06dc28ca72420=
a80e30802e5a3e9 100644
> --- a/profiles/audio/micp.c
> +++ b/profiles/audio/micp.c
> @@ -300,6 +300,7 @@ static void micp_server_remove(struct btd_profile *p,
>  static struct btd_profile micp_profile =3D {
>         .name           =3D "micp",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .remote_uuid    =3D MICS_UUID_STR,
>
>         .device_probe   =3D micp_probe,
> diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
> index 8949c71858e53448ee01c5c4261082f3912a759c..471ad59250386941c377e2f81=
e911467d7023cce 100644
> --- a/profiles/audio/vcp.c
> +++ b/profiles/audio/vcp.c
> @@ -328,6 +328,7 @@ static void vcp_server_remove(struct btd_profile *p,
>  static struct btd_profile vcp_profile =3D {
>         .name           =3D "vcp",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .remote_uuid    =3D VCS_UUID_STR,
>
>         .device_probe   =3D vcp_probe,
> diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.=
c
> index d1e627a3382a01bdd5002bcc0da01da35e872da1..72b69428036df77e2cdb224f1=
86fb13191f955ed 100644
> --- a/profiles/health/hdp_manager.c
> +++ b/profiles/health/hdp_manager.c
> @@ -57,6 +57,7 @@ static void hdp_driver_remove(struct btd_service *servi=
ce)
>
>  static struct btd_profile hdp_source_profile =3D {
>         .name           =3D "hdp-source",
> +       .bearer         =3D BTD_PROFILE_BEARER_BREDR,
>         .remote_uuid    =3D HDP_SOURCE_UUID,
>
>         .device_probe   =3D hdp_driver_probe,
> @@ -68,6 +69,7 @@ static struct btd_profile hdp_source_profile =3D {
>
>  static struct btd_profile hdp_sink_profile =3D {
>         .name           =3D "hdp-sink",
> +       .bearer         =3D BTD_PROFILE_BEARER_BREDR,
>         .remote_uuid    =3D HDP_SINK_UUID,
>
>         .device_probe   =3D hdp_driver_probe,
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 1f5b82b774353244067e460f49aaccd09e26dcc8..f50a0f217f7f732f82645e289=
419e51ee6412917 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -215,6 +215,7 @@ static int hog_disconnect(struct btd_service *service=
)
>
>  static struct btd_profile hog_profile =3D {
>         .name           =3D "input-hog",
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .remote_uuid    =3D HOG_UUID,
>         .device_probe   =3D hog_probe,
>         .device_remove  =3D hog_remove,
> diff --git a/profiles/input/manager.c b/profiles/input/manager.c
> index b0e415f6706c54e7c96199d3bb5e483d0927153f..916849cbc02b047ad9cf83feb=
46c3ddadbe7f437 100644
> --- a/profiles/input/manager.c
> +++ b/profiles/input/manager.c
> @@ -45,9 +45,11 @@ static void hid_server_remove(struct btd_profile *p,
>
>  static struct btd_profile input_profile =3D {
>         .name           =3D "input-hid",
> +       .bearer         =3D BTD_PROFILE_BEARER_BREDR,
>         .local_uuid     =3D HID_UUID,
>         .remote_uuid    =3D HID_UUID,
>
> +
>         .auto_connect   =3D true,
>         .connect        =3D input_device_connect,
>         .disconnect     =3D input_device_disconnect,
> diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
> index 90e00a5f58361f1da57a71f393e581da5128310c..d7e72420e0db9598169601f77=
e5bf366652cf09d 100644
> --- a/profiles/midi/midi.c
> +++ b/profiles/midi/midi.c
> @@ -460,6 +460,7 @@ static struct btd_profile midi_profile =3D {
>         .name =3D "MIDI GATT Driver",
>         .remote_uuid =3D MIDI_UUID,
>         .priority =3D BTD_PROFILE_PRIORITY_HIGH,
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .auto_connect =3D true,
>
>         .device_probe =3D midi_device_probe,
> diff --git a/profiles/network/manager.c b/profiles/network/manager.c
> index 51f382529df27600d1a4fd806cb656d7f1a682af..693547d45fbc5b2f227fed832=
b4efb8fb87c2d59 100644
> --- a/profiles/network/manager.c
> +++ b/profiles/network/manager.c
> @@ -120,6 +120,7 @@ static void nap_server_remove(struct btd_profile *p,
>
>  static struct btd_profile panu_profile =3D {
>         .name           =3D "network-panu",
> +       .bearer         =3D BTD_PROFILE_BEARER_BREDR,
>         .local_uuid     =3D NAP_UUID,
>         .remote_uuid    =3D PANU_UUID,
>         .device_probe   =3D connection_register,
> @@ -132,6 +133,7 @@ static struct btd_profile panu_profile =3D {
>
>  static struct btd_profile gn_profile =3D {
>         .name           =3D "network-gn",
> +       .bearer         =3D BTD_PROFILE_BEARER_BREDR,
>         .local_uuid     =3D PANU_UUID,
>         .remote_uuid    =3D GN_UUID,
>         .device_probe   =3D connection_register,
> @@ -144,6 +146,7 @@ static struct btd_profile gn_profile =3D {
>
>  static struct btd_profile nap_profile =3D {
>         .name           =3D "network-nap",
> +       .bearer         =3D BTD_PROFILE_BEARER_BREDR,
>         .local_uuid     =3D PANU_UUID,
>         .remote_uuid    =3D NAP_UUID,
>         .device_probe   =3D connection_register,
> diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
> index 1c531773740c847e970ac45b7fbda2c0c9501ded..1cc8ef0a60f107b6a225eb8f1=
9cda6b8cc5a57df 100644
> --- a/profiles/scanparam/scan.c
> +++ b/profiles/scanparam/scan.c
> @@ -259,6 +259,7 @@ static int scan_param_probe(struct btd_service *servi=
ce)
>
>  static struct btd_profile scan_profile =3D {
>         .name =3D "Scan Parameters Client Driver",
> +       .bearer         =3D BTD_PROFILE_BEARER_LE,
>         .remote_uuid =3D SCAN_PARAMETERS_UUID,
>         .device_probe =3D scan_param_probe,
>         .device_remove =3D scan_param_remove,
> diff --git a/src/bearer.c b/src/bearer.c
> index 9723b59e2e7b39b2974e258363aa0ace95862651..9745c4acf8fcd907ca2841866=
ce8e3201871181a 100644
> --- a/src/bearer.c
> +++ b/src/bearer.c
> @@ -25,23 +25,43 @@
>
>  #include "bluetooth/bluetooth.h"
>  #include "bluetooth/mgmt.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>  #include "src/shared/util.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/timeout.h"
>
>  #include "log.h"
>  #include "error.h"
>  #include "adapter.h"
>  #include "device.h"
> +#include "profile.h"
> +#include "service.h"
>  #include "dbus-common.h"
>  #include "bearer.h"
>
> +#define DISCONNECT_TIMER       2
> +
>  struct btd_bearer {
>         struct btd_device *device;
>         uint8_t type;
>         const char *path;
> +       unsigned int disconn_timer;
> +       struct queue *disconnects; /* disconnects message */
> +
> +       /* Connect() is defined as a single in-flight operation. To prese=
rve
> +        * the API semantics of org.bluez.Device1.Connect(), we do not qu=
eue
> +        * additional connect messages.
> +        */
> +       DBusMessage *connect; /* connect message */
>  };
>
> +static void bearer_free_dbus_message(void *data)
> +{
> +    dbus_message_unref((DBusMessage *)data);
> +}
> +
>  static void bearer_free(void *data)
>  {
>         struct btd_bearer *bearer =3D data;
> @@ -49,17 +69,153 @@ static void bearer_free(void *data)
>         free(bearer);
>  }
>
> +static void bearer_disconnect_service(struct btd_service *service, void =
*user_data)
> +{
> +       uint8_t bdaddr_type =3D *(uint8_t *)user_data;
> +       struct btd_profile *profile =3D btd_service_get_profile(service);
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       bool le_connected;
> +
> +       if (!profile || !device)
> +               return;
> +
> +       le_connected =3D
> +               btd_device_bdaddr_type_connected(device, BDADDR_LE_PUBLIC=
) ||
> +               btd_device_bdaddr_type_connected(device, BDADDR_LE_RANDOM=
);
> +
> +       switch (bdaddr_type) {
> +
> +       case BDADDR_LE_PUBLIC:
> +       case BDADDR_LE_RANDOM:
> +               /* Disconnecting LE bearer: disconnect profiles marked as
> +                * BTD_PROFILE_BEARER_LE or BTD_PROFILE_BEARER_ANY.
> +                */
> +               if (profile->bearer =3D=3D BTD_PROFILE_BEARER_BREDR)
> +                       return;
> +               break;
> +
> +       case BDADDR_BREDR:
> +               if (le_connected) {
> +                       /* Disconnecting BREDR bearer but LE link exists:
> +                        * only disconnect profiles marked as
> +                        * BTD_PROFILE_BEARER_BREDR.
> +                        */
> +                       if (profile->bearer !=3D BTD_PROFILE_BEARER_BREDR=
)
> +                               return;
> +               } else {
> +                       /* No LE link: disconnect profiles marked as
> +                        * BTD_PROFILE_BEARER_BREDR or BTD_PROFILE_BEARER=
_ANY.
> +                        */
> +                       if (profile->bearer =3D=3D BTD_PROFILE_BEARER_LE)
> +                               return;
> +               }
> +               break;
> +       }
> +
> +       DBG("Disconnecting profile %s for bearer addr type %u",
> +       profile->name ?: "(unknown)", bdaddr_type);
> +
> +       btd_service_disconnect(service);
> +}
> +
> +
> +static bool bearer_disconnect_link(gpointer user_data)
> +{
> +       struct btd_bearer *bearer =3D user_data;
> +       struct btd_device *device =3D bearer->device;
> +
> +       bearer->disconn_timer =3D 0;
> +
> +       if (btd_device_bdaddr_type_connected(device, bearer->type))
> +               btd_adapter_disconnect_device(device_get_adapter(device),
> +                                               device_get_address(device=
),
> +                                               bearer->type);
> +       return FALSE;
> +}
> +
>  static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *ms=
g,
>                                                         void *user_data)
>  {
> -       /* TODO */
> +       struct btd_bearer *bearer =3D user_data;
> +       struct btd_device *device =3D bearer->device;
> +       int err;
> +
> +       if (btd_device_bdaddr_type_connected(device, bearer->type)) {
> +               if (msg)
> +                       return btd_error_already_connected(msg);
> +               return NULL;
> +       }
> +
> +       if (device_is_bonding(device, NULL)) {
> +               if (msg)
> +                       return btd_error_in_progress(msg);
> +               return NULL;
> +       }
> +
> +       if (device_is_connecting(device) ||
> +               bearer->connect) {
> +               if (msg)
> +                       return btd_error_in_progress(msg);
> +               return NULL;
> +       }
> +
> +       if (msg)
> +               bearer->connect =3D dbus_message_ref(msg);
> +
> +       if (bearer->type =3D=3D BDADDR_BREDR)
> +               return device_connect_profiles(device, BDADDR_BREDR,
> +                                                               msg, NULL=
);
> +       else {
> +               btd_device_set_temporary(device, false);
> +               err =3D device_connect_le(device);
> +               if (err < 0)
> +                       return btd_error_failed(msg, strerror(-err));
> +       }
> +
>         return NULL;
>  }
>
>  static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage =
*msg,
>                                                         void *user_data)
>  {
> -       /* TODO */
> +       struct btd_bearer *bearer =3D user_data;
> +       struct btd_device *device =3D bearer->device;
> +
> +       if (!btd_device_bdaddr_type_connected(device, bearer->type)) {
> +               if (msg)
> +                       return btd_error_not_connected(msg);
> +               return NULL;
> +       }
> +
> +       /* org.bluez.Device1.Disconnect() is in progress. Since it tears =
down
> +        * both LE and BR/EDR bearers, it takes precedence over bearer-le=
vel
> +        * disconnects. Ignore any bearer-specific disconnect requests he=
re.
> +        */
> +       if (device_is_disconnecting(device)) {
> +               if (msg)
> +                       return btd_error_in_progress(msg);
> +               return NULL;
> +       }
> +
> +       if (msg)
> +               queue_push_tail(bearer->disconnects, dbus_message_ref(msg=
));
> +
> +       device_cancel_bonding(device, MGMT_STATUS_DISCONNECTED);
> +
> +       device_cancel_browse(device, bearer->type);
> +
> +       btd_device_foreach_service(device, bearer_disconnect_service,
> +                                                       &bearer->type);
> +
> +       device_remove_pending_services(device, bearer->type);
> +
> +       if (bearer->disconn_timer)
> +               return NULL;
> +
> +       bearer->disconn_timer =3D timeout_add_seconds(DISCONNECT_TIMER,
> +                                                       bearer_disconnect=
_link,
> +                                                       bearer, NULL);
> +
>         return NULL;
>  }
>
> @@ -151,6 +307,7 @@ struct btd_bearer *btd_bearer_new(struct btd_device *=
device, uint8_t type)
>         bearer->device =3D device;
>         bearer->type =3D type;
>         bearer->path =3D device_get_path(device);
> +       bearer->disconnects =3D queue_new();
>
>         if (!g_dbus_register_interface(btd_get_dbus_connection(),
>                                         bearer->path, bearer_interface(ty=
pe),
> @@ -174,6 +331,16 @@ void btd_bearer_destroy(struct btd_bearer *bearer)
>                 return;
>         }
>
> +       if (bearer->disconnects) {
> +               queue_destroy(bearer->disconnects, bearer_free_dbus_messa=
ge);
> +               bearer->disconnects =3D NULL;
> +       }
> +
> +       if (bearer->connect) {
> +               dbus_message_unref(bearer->connect);
> +               bearer->connect =3D NULL;
> +       }
> +
>         g_dbus_unregister_interface(btd_get_dbus_connection(), bearer->pa=
th,
>                                         bearer_interface(bearer->type));
>  }
> @@ -203,6 +370,13 @@ void btd_bearer_connected(struct btd_bearer *bearer)
>         if (!bearer || !bearer->path)
>                 return;
>
> +       if (bearer->connect) {
> +               g_dbus_send_reply(btd_get_dbus_connection(), bearer->conn=
ect,
> +                                               DBUS_TYPE_INVALID);
> +               dbus_message_unref(bearer->connect);
> +               bearer->connect =3D NULL;
> +       }
> +
>         g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->p=
ath,
>                                         bearer_interface(bearer->type),
>                                         "Connected");
> @@ -212,10 +386,24 @@ void btd_bearer_disconnected(struct btd_bearer *bea=
rer, uint8_t reason)
>  {
>         const char *name;
>         const char *message;
> +       DBusMessage *msg;
> +       const struct queue_entry *entry;
>
>         if (!bearer || !bearer->path)
>                 return;
>
> +       if (!btd_device_is_connected(bearer->device))
> +               device_disconnect_watches_callback(bearer->device);
> +
> +       while (!queue_isempty(bearer->disconnects)) {
> +               entry =3D queue_get_entries(bearer->disconnects);
> +               msg =3D entry->data;
> +               g_dbus_send_reply(btd_get_dbus_connection(), msg,
> +                                               DBUS_TYPE_INVALID);
> +               queue_remove(bearer->disconnects, msg);
> +               dbus_message_unref(msg);
> +       }
> +
>         g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->p=
ath,
>                                         bearer_interface(bearer->type),
>                                         "Connected");
> diff --git a/src/device.c b/src/device.c
> index 91b6cc0c65eaae8058cd445c0942ffee57289f0d..1e82bd7a8b64bb3ff6ef599da=
47b594e14d254e4 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2022,6 +2022,28 @@ static void dev_disconn_service(gpointer a, gpoint=
er b)
>         btd_service_disconnect(a);
>  }
>
> +void device_disconnect_watches_callback(struct btd_device *device)
> +{
> +       if (!device || !device->watches)
> +               return;
> +
> +       while (device->watches) {
> +               struct btd_disconnect_data *data =3D device->watches->dat=
a;
> +
> +               if (data->watch)
> +                       /* temporary is set if device is going to be remo=
ved */
> +                       data->watch(device, device->temporary,
> +                                                       data->user_data);
> +
> +               /* Check if the watch has been removed by callback functi=
on */
> +               if (!g_slist_find(device->watches, data))
> +                       continue;
> +
> +               device->watches =3D g_slist_remove(device->watches, data)=
;
> +               g_free(data);
> +       }
> +}
> +
>  void device_request_disconnect(struct btd_device *device, DBusMessage *m=
sg)
>  {
>         if (device->bonding)
> @@ -2063,21 +2085,7 @@ void device_request_disconnect(struct btd_device *=
device, DBusMessage *msg)
>         g_slist_free(device->pending);
>         device->pending =3D NULL;
>
> -       while (device->watches) {
> -               struct btd_disconnect_data *data =3D device->watches->dat=
a;
> -
> -               if (data->watch)
> -                       /* temporary is set if device is going to be remo=
ved */
> -                       data->watch(device, device->temporary,
> -                                                       data->user_data);
> -
> -               /* Check if the watch has been removed by callback functi=
on */
> -               if (!g_slist_find(device->watches, data))
> -                       continue;
> -
> -               device->watches =3D g_slist_remove(device->watches, data)=
;
> -               g_free(data);
> -       }
> +       device_disconnect_watches_callback(device);
>
>         if (!btd_device_is_connected(device)) {
>                 if (msg)
> @@ -2095,6 +2103,11 @@ bool device_is_disconnecting(struct btd_device *de=
vice)
>         return device->disconn_timer > 0;
>  }
>
> +bool device_is_connecting(struct btd_device *device)
> +{
> +       return device->connect !=3D NULL;
> +}
> +
>  static void add_set(void *data, void *user_data)
>  {
>         struct sirk_info *sirk =3D data;
> @@ -2712,8 +2725,8 @@ int btd_device_connect_services(struct btd_device *=
dev, GSList *services)
>         return connect_next(dev);
>  }
>
> -static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bda=
ddr_type,
> -                                       DBusMessage *msg, const char *uui=
d)
> +DBusMessage *device_connect_profiles(struct btd_device *dev,
> +               uint8_t bdaddr_type, DBusMessage *msg, const char *uuid)
>  {
>         struct bearer_state *state =3D get_state(dev, bdaddr_type);
>         int err;
> @@ -2826,7 +2839,7 @@ static DBusMessage *dev_connect(DBusConnection *con=
n, DBusMessage *msg,
>                 return NULL;
>         }
>
> -       return connect_profiles(dev, bdaddr_type, msg, NULL);
> +       return device_connect_profiles(dev, bdaddr_type, msg, NULL);
>  }
>
>  static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *m=
sg,
> @@ -2848,7 +2861,7 @@ static DBusMessage *connect_profile(DBusConnection =
*conn, DBusMessage *msg,
>                 return btd_error_invalid_args_str(msg,
>                                         ERR_BREDR_CONN_INVALID_ARGUMENTS)=
;
>
> -       reply =3D connect_profiles(dev, BDADDR_BREDR, msg, uuid);
> +       reply =3D device_connect_profiles(dev, BDADDR_BREDR, msg, uuid);
>         free(uuid);
>
>         return reply;
> @@ -3421,7 +3434,7 @@ static DBusMessage *new_authentication_return(DBusM=
essage *msg, uint8_t status)
>         }
>  }
>
> -static void device_cancel_bonding(struct btd_device *device, uint8_t sta=
tus)
> +void device_cancel_bonding(struct btd_device *device, uint8_t status)
>  {
>         struct bonding_req *bonding =3D device->bonding;
>         DBusMessage *reply;
> @@ -6629,6 +6642,38 @@ static int device_browse_sdp(struct btd_device *de=
vice, DBusMessage *msg)
>         return err;
>  }
>
> +static gboolean device_is_browsing(struct btd_device *device, uint8_t bd=
addr_type)
> +{
> +       if (!device->browse)
> +               return FALSE;
> +
> +       if (bdaddr_type =3D=3D BDADDR_BREDR && device->browse->type =3D=
=3D BROWSE_SDP)
> +               return TRUE;
> +
> +       if (bdaddr_type !=3D BDADDR_BREDR && device->browse->type =3D=3D =
BROWSE_GATT)
> +               return TRUE;
> +
> +       return FALSE;
> +}
> +
> +void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type=
)
> +{
> +       struct btd_adapter *adapter =3D device->adapter;
> +
> +       DBG("");
> +
> +       if (!device_is_browsing(device, bdaddr_type))
> +               return;
> +
> +       if (bdaddr_type =3D=3D BDADDR_BREDR)
> +               bt_cancel_discovery(btd_adapter_get_address(adapter),
> +                                                       &device->bdaddr);
> +       else
> +               attio_cleanup(device);
> +
> +       browse_request_free(device->browse);
> +}
> +
>  int device_discover_services(struct btd_device *device)
>  {
>         int err;
> @@ -8088,3 +8133,76 @@ void btd_device_foreach_service_data(struct btd_de=
vice *dev, bt_ad_func_t func,
>  {
>         bt_ad_foreach_service_data(dev->ad, func, data);
>  }
> +
> +
> +void btd_device_foreach_service(struct btd_device *dev,
> +                               btd_device_service_func_t func,
> +                               void *user_data)
> +{
> +       GSList *l;
> +
> +       for (l =3D dev->services; l; l =3D l->next)
> +               func(l->data, user_data);
> +}
> +
> +void device_remove_pending_services(struct btd_device *dev,
> +                                       uint8_t bdaddr_type)
> +{
> +       GSList *l =3D dev->pending;
> +       GSList *next;
> +       struct btd_service *service;
> +       struct btd_profile *profile;
> +       bool le_connected;
> +
> +       le_connected =3D
> +               btd_device_bdaddr_type_connected(dev, BDADDR_LE_PUBLIC) |=
|
> +               btd_device_bdaddr_type_connected(dev, BDADDR_LE_RANDOM);
> +
> +       while (l) {
> +               next =3D l->next;
> +               service =3D l->data;
> +
> +               profile =3D btd_service_get_profile(service);
> +               if (!profile)
> +                       goto next;
> +
> +               switch (bdaddr_type) {
> +
> +               case BDADDR_LE_PUBLIC:
> +               case BDADDR_LE_RANDOM:
> +                       /* Disconnecting LE bearer: disconnect profiles m=
arked
> +                        * as BTD_PROFILE_BEARER_LE or BTD_PROFILE_BEARER=
_ANY.
> +                        */
> +                       if (profile->bearer =3D=3D BTD_PROFILE_BEARER_BRE=
DR)
> +                               goto next;
> +                       break;
> +
> +               case BDADDR_BREDR:
> +                       if (le_connected) {
> +                               /* Disconnecting BREDR bearer but LE link
> +                                * exists:only disconnect profiles marked=
 as
> +                                * BTD_PROFILE_BEARER_BREDR.
> +                                */
> +                               if (profile->bearer !=3D BTD_PROFILE_BEAR=
ER_BREDR)
> +                                       goto next;
> +                       } else {
> +                               /* No LE link: disconnect profiles marked=
 as
> +                                * BTD_PROFILE_BEARER_BREDR or
> +                                * BTD_PROFILE_BEARER_ANY.
> +                                */
> +                               if (profile->bearer =3D=3D BTD_PROFILE_BE=
ARER_LE)
> +                                       goto next;
> +                       }
> +                       break;
> +
> +               default:
> +                       goto next;
> +               }
> +
> +               /* Matched: remove from pending list */
> +               dev->pending =3D g_slist_remove(dev->pending, service);
> +
> +       next:
> +               l =3D next;
> +       }
> +}
> diff --git a/src/device.h b/src/device.h
> index 6ed8affa0d4a9274d30cac9b48e8a6826edefd64..fee1ad50dc9c7ae248acd819d=
ae07762c783ac35 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -120,6 +120,7 @@ void device_bonding_complete(struct btd_device *devic=
e, uint8_t bdaddr_type,
>  gboolean device_is_bonding(struct btd_device *device, const char *sender=
);
>  void device_bonding_attempt_failed(struct btd_device *device, uint8_t st=
atus);
>  void device_bonding_failed(struct btd_device *device, uint8_t status);
> +void device_cancel_bonding(struct btd_device *device, uint8_t status);
>  struct btd_adapter_pin_cb_iter *device_bonding_iter(struct btd_device *d=
evice);
>  int device_bonding_attempt_retry(struct btd_device *device);
>  long device_bonding_last_duration(struct btd_device *device);
> @@ -134,6 +135,9 @@ int device_notify_pincode(struct btd_device *device, =
gboolean secure,
>                                                         const char *pinco=
de);
>  void device_cancel_authentication(struct btd_device *device, gboolean ab=
orted);
>  gboolean device_is_authenticating(struct btd_device *device);
> +
> +void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type=
);
> +
>  void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
>                                                         uint32_t flags);
>  void device_remove_connection(struct btd_device *device, uint8_t bdaddr_=
type,
> @@ -141,6 +145,7 @@ void device_remove_connection(struct btd_device *devi=
ce, uint8_t bdaddr_type,
>                                                         uint8_t reason);
>  void device_request_disconnect(struct btd_device *device, DBusMessage *m=
sg);
>  bool device_is_disconnecting(struct btd_device *device);
> +bool device_is_connecting(struct btd_device *device);
>  void device_set_ltk(struct btd_device *device, const uint8_t val[16],
>                                 bool central, uint8_t enc_size);
>  bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
> @@ -170,6 +175,7 @@ guint device_add_disconnect_watch(struct btd_device *=
device,
>                                 disconnect_watch watch, void *user_data,
>                                 GDestroyNotify destroy);
>  void device_remove_disconnect_watch(struct btd_device *device, guint id)=
;
> +void device_disconnect_watches_callback(struct btd_device *device);
>  int device_get_appearance(struct btd_device *device, uint16_t *value);
>  void device_set_appearance(struct btd_device *device, uint16_t value);
>
> @@ -184,6 +190,9 @@ void btd_device_set_pnpid(struct btd_device *device, =
uint16_t source,
>
>  int device_connect_le(struct btd_device *dev);
>
> +DBusMessage *device_connect_profiles(struct btd_device *dev,
> +               uint8_t bdaddr_type, DBusMessage *msg, const char *uuid);
> +
>  typedef void (*device_svc_cb_t) (struct btd_device *dev, int err,
>                                                         void *user_data);
>
> @@ -225,3 +234,11 @@ void btd_device_set_conn_param(struct btd_device *de=
vice, uint16_t min_interval,
>  void btd_device_foreach_service_data(struct btd_device *dev,
>                                         bt_device_ad_func_t func,
>                                         void *data);
> +
> +typedef void (*btd_device_service_func_t)(struct btd_service *service,
> +                                       void *user_data);
> +void btd_device_foreach_service(struct btd_device *dev,
> +                               btd_device_service_func_t func,
> +                               void *user_data);
> +void device_remove_pending_services(struct btd_device *dev,
> +                                       uint8_t bdaddr_type);
> \ No newline at end of file
> diff --git a/src/profile.h b/src/profile.h
> index 424ce55ad65748ead13b1a38d67fbad6beb2b828..16eeccb561b0bc9d6c7da20b6=
113f22ecc3f2c6b 100644
> --- a/src/profile.h
> +++ b/src/profile.h
> @@ -12,12 +12,22 @@
>  #define BTD_PROFILE_PRIORITY_MEDIUM    1
>  #define BTD_PROFILE_PRIORITY_HIGH      2
>
> +#define BTD_PROFILE_BEARER_ANY         0
> +#define BTD_PROFILE_BEARER_LE          1
> +#define BTD_PROFILE_BEARER_BREDR       2
> +
>  struct btd_service;
>
>  struct btd_profile {
>         const char *name;
>         int priority;
>
> +       /* Indicates which bearer type this profile belongs to. Some prof=
iles
> +        * may exist in both BR/EDR and LE. So we need to declare them as
> +        * BTD_PROFILE_BEARER_ANY when registering profiles.
> +        */
> +       int bearer;

Please split this change into another patch, so first introduce the
bearer support can update the existing profiles on its own commit
followed by the commit with bearer Connect/Disconnect implementation.

>         const char *local_uuid;
>         const char *remote_uuid;
>
>
> ---
> base-commit: 5e41d1e1d361e7288964e4c2c5ed90736025662f
> change-id: 20251111-bearer-impl-5f7e396174aa
>
> Best regards,
> --
> Ye He <ye.he@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz

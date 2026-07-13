Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA65437451
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951243; cv=pass; b=s6z/YaM3LRvuXIpKFs5WgBT4AOiFEtoq3ghBIz3f4QjEmvk3cdP0X4cv3W42rhaLrVrGx2d+IYFD01aoI/iIewA1md0ncJ+bGM2iblqeM8eXFIgV0qYzGEAywJixNsqFUHSa4BucOg0tO+Z88F8F8pPzmxsKIQGKWJYAzt6W1io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951243; c=relaxed/simple;
	bh=fg2Z8gaLDa3vs/K4EHOJO1xgJdokcwbLDICdq0EmYz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oy51w0xFMwneTSja663f0p7zv2Cb10eg9vDkUD6bB+H0rkOOTuYn2hi+yb/yGl2CPni8SucWuLxjBRkHhwYOh+s98U0qAC+eR3szcq59RMtYGYCCt/yaUygjrsu+yS9VL1ZwXnpr9qTgIkNXJ8EUyn+jGZkt4fTGJeUKikJ1nLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qS40A0nS; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS40A0nS"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66771ded50aso5064093d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 07:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951241; cv=none;
        d=google.com; s=arc-20260327;
        b=hqWnK+BlVa8DDhAkRz6dp8Hzps1+yH6SgfSmV1NUjKQrICfv3AKLAYY4YPmaPoqYk6
         gE5EtItdSdb+eDp/P5hyLxioXomeyY0rKwLJoPS5gH+XJGY65O4sSv6XXBgysqEJVIbC
         jqyrBCLQymTJ2+pto1lpNBWSt9KTiNJicPf+FPgNnUny2wRWHSFoJCSzNohNP7/GysHZ
         4ZNKRlTcpOWyJDgZbW1Q+7jCP1N6on15IHd6s8+86KE6TzKY3mFhNaiOD/cr7pMXb631
         YPWpUSth23qGkoAwnXvpgLHl5rpOrpXmGP66KZJkVim+GvLX1qjzDK9OzJ51tudiAc6k
         GWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ytvSfPezMzozz2pHN90oslvwQ6mYc/Imt7ZobMq9mY8=;
        fh=VivHsFtFlY+HkAqtwm9F7J0CUAmqA+2AB8dbndlnZRI=;
        b=IAbLCj77cCCPq+7FmQu7NvWPwMb5ODaoU6NXVuR+ZKErhPDQoSHZvQ9vIUmn3tQES4
         4cECv0zVWTDq4dFFo1IYDiSfsgZlopUERXcnVIcPH+64s6nNUmeJv71t7q+lrSQOsHZA
         2CH6xrFyA0WjMgeG7eu9VFNNws+O/3qKKVNN9QfNDBtlIGP2m9I70ioz5gfxe0VxZPqY
         YEW0BFdVoSL4//JwxJ6lX4av1A4E9DhQt9GuT25WF7p/hyL294VlGoNTUfNozi3VHfs9
         2dHOigpOsKwCqRhTLvxSQLHJXihbK2ZAf/iyXC8Lh32/ZfLafBK3t1XQ8cXvCKyfvzl9
         U4yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951241; x=1784556041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ytvSfPezMzozz2pHN90oslvwQ6mYc/Imt7ZobMq9mY8=;
        b=qS40A0nSaxR2jsr9zFHruytfAaNKaVQmrcu8jYTwtN7nPiEfri2LFbuwWB+YJvMvs/
         8m3UoyLdEm3htvaGB8RwfHXKqdWpgYC8xmyFesOJea8bFqgmHlCEpAwMvEgok0vBDXht
         hfWnY2rDn2oQRfpnntq+/Gb6nXbMjIfjQmep/PhdsuKEJwS4Y1wpNdV5K160SvACcTwi
         M1iJWiKohr9oSomw0msa8RWFifuIN7xHYnTzETQOPuooC6DRe1/G9Tv3oG7o2zi2U9ne
         pSk73xG7GjLg9M0/px19SUJ3t2uYIx1eZ3ZNqvA9MaG1kMcr1RbGp+93ri/kqB2gbK5K
         OD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951241; x=1784556041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ytvSfPezMzozz2pHN90oslvwQ6mYc/Imt7ZobMq9mY8=;
        b=qhr3v0rvIlBhNsMZ44g6ZR4rxTlMVmWJDIWd1DLAHKc0yYX3CRlzOKQXukRNKRy/vm
         XH+ZqU00kDfgF0WWb7s1AxUEUFukVl1GodbRQoH5z7homDRqUlwnQKaxbymp2HI/2oCe
         sDGTVuedvsmvQaX3pPuf64OxyVOsnMKJ/dtTLFWDwJA7OfR+wpzvBTRklxGvyDUO+5yj
         1oYJ3VuBa1bB9F6xAhNsxvklhrPP64W4xTwNYkKLBBbbR+yauJnvCERH6EBdbznfP++t
         rGoP7CNZkYTPN1bjgkwlVEJQ2sbTZ2LGKflyxGE6bMWj8TgafZw324eT5Y3Fq02u11JW
         10oA==
X-Forwarded-Encrypted: i=1; AHgh+RqXjfNtTk+TDVcrgxn8q2MSS8tFN8MaHiDDfbbSwamU+XM2Dnndk27BX7SBqGTjci1kb03idkVoaKPlrYD5qdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznIrcz1Sd8CWB+rcbs7cc5wbgyhuTJ0f3338EBxX5wlDl1rnHA
	NHkm+Nj2SpEnn1bkadM84rxdln3eWVQrhvB6xylnSXBPy1yOV+QXyHu/vlQNdzC4ObY/JucwkPS
	dFQdTqw1K8tebltv3A8ROkCmJg2ctY54=
X-Gm-Gg: AfdE7cmRVQC5m6lheKRolEr9pDDiuFTlVDbHKB+dZsvOtOmFO/JvnVZfs0toUFRkmLm
	OurV5cR2UoQa3DTeAmJOR+eNv/KH6HNXLK2jOXnDgTTp+v41DgV04zc9KEFDKs5dSxOnzkO7AXl
	kvudSLl8xzUxqoHFTXAaO1Uxq/x8bz+a/vATp51AMu11cVaNoTViCogHzhfFTdqcYxeVxPD3UnW
	OuY7r1h/Fsn0KMJiMZ0ot0WjXxFVbwZDi8hjUjTJuZO/ejIm9p82ajBRjbdF2B2YrL04nGnv4k1
	AKkMzSxvqN195q8Wykbt82PL9Asc53W9llRJ1N2MZtL2eprACZi9suW6HcI=
X-Received: by 2002:a05:690e:c4e:b0:667:e04a:8a63 with SMTP id
 956f58d0204a3-667e04a97e3mr5289349d50.19.1783951238618; Mon, 13 Jul 2026
 07:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
 <CABBYNZJrrQO5XU1yC-HOry1eEaF8fBKV_jK4g3A+qJTAtw0Qqg@mail.gmail.com> <0b6a3ae6-d8a8-409d-844b-be4be14917d3@oss.qualcomm.com>
In-Reply-To: <0b6a3ae6-d8a8-409d-844b-be4be14917d3@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Jul 2026 11:00:26 -0300
X-Gm-Features: AVVi8Ce8Dp0tC8yu74einqn_vRdads2YN-08_asUlI-J3hk_HzYL6tF15yniAZY
Message-ID: <CABBYNZ+-ybGUPPtQ3xuwHfewt4w6C4CTf0cYXbo3AZ9+vqDGxA@mail.gmail.com>
Subject: Re: [PATCH v1] gdbus: Skip BLE random-address devices and remove
 broad match rule
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev, linux-bluetooth@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiuzhuo,

On Mon, Jul 13, 2026 at 3:03=E2=80=AFAM Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> wrote:
>
>
>
> On 7/10/2026 10:12 PM, Luiz Augusto von Dentz wrote:
> > Hi Xiuzhuo,
> >
> > On Fri, Jul 10, 2026 at 3:55=E2=80=AFAM Xiuzhuo Shang
> > <xiuzhuo.shang@oss.qualcomm.com> wrote:
> >>
> >> Two related changes to reduce dbus-daemon load caused by high-rate
> >> BLE advertising signals:
> >>
> >> 1. In parse_properties(), skip creating a GDBusProxy for Device1
> >>    objects whose AddressType is 'random' (BLE-only devices). Each
> >>    proxy registers a per-device PropertiesChanged watch via
> >>    g_dbus_add_properties_watch(); with hundreds of BLE peripherals
> >>    advertising simultaneously, this results in hundreds of match rules
> >>    and dbus-daemon routing thousands of RSSI PropertiesChanged signals
> >>    per second to ofono, none of which ofono processes. The
> >>    AddressType property is available in the InterfacesAdded dict at
> >>    the time parse_properties() is called, so the check is reliable
> >>    and race-free.
> >>
> >>    BR/EDR devices (AddressType=3D'public') are unaffected: their proxi=
es
> >>    are created as before, and the property_changed callback continues
> >>    to receive Paired and ServicesResolved updates needed for HFP/HSP.
> >>
> >> 2. In g_dbus_client_new_full(), remove the broad
> >>    type=3D'signal',sender=3D<service>,path_namespace=3D<path> match ru=
le.
> >>    This rule was the sole feeder for the signal_func path in
> >>    message_filter(). ofono never calls g_dbus_client_set_signal_watch(=
)
> >>    so signal_func is always NULL; the broad rule therefore served no
> >>    purpose and caused dbus-daemon to route every bluetoothd signal
> >>    (including all BLE PropertiesChanged) to ofono.
> >>
> >>    InterfacesAdded and InterfacesRemoved are already covered by the
> >>    precise watches registered via g_dbus_add_signal_watch() earlier in
> >>    g_dbus_client_new_full(), so no functionality is lost.
> >
> > Looks like this is on ofono though, why are you chaning the BlueZ side?
>
> Regarding your suggestion to move the BLE filter to hfp_hf_bluez5.c: filt=
ering in proxy_added()
> would only prevent ofono from processing BLE devices at the application l=
evel. The per-device
> PropertiesChanged watch is registered inside proxy_new(), which is called=
 before proxy_added(). So
> dbus-daemon would still route all RSSI signals to the process =E2=80=94 t=
he D-Bus pressure problem would
> remain unchanged.
>
> I will drop the change from the gdbus patch per your feedback
>
> >
> >> Together these two changes prevent dbus-daemon from routing BLE
> >> advertising PropertiesChanged signals to ofono entirely, eliminating
> >> the dbus-daemon memory growth and bluetoothd socket backpressure seen
> >> after hours of BLE scanning.
> >>
> >> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> >> ---
> >>  gdbus/client.c | 46 ++++++++++++++++++++++++++++++++++++++--------
> >>  1 file changed, 38 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/gdbus/client.c b/gdbus/client.c
> >> index 48711ae8..dd3c17f9 100644
> >> --- a/gdbus/client.c
> >> +++ b/gdbus/client.c
> >> @@ -937,6 +937,44 @@ static void parse_properties(GDBusClient *client,=
 const char *path,
> >>         if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) =3D=3D T=
RUE)
> >>                 return;
> >>
> >> +       /*
> >> +        * Skip BLE devices (AddressType=3D'random') to avoid register=
ing a
> >> +        * per-device PropertiesChanged watch for every advertising BL=
E
> >> +        * peripheral. ofono only needs BR/EDR devices for HFP/HSP; th=
e
> >> +        * high-rate RSSI PropertiesChanged signals from BLE scanners =
cause
> >> +        * dbus-daemon memory bloat and socket backpressure in bluetoo=
thd.
> >> +        *
> >> +        * The AddressType property is present in the InterfacesAdded =
dict
> >> +        * (iter) at this point, so it can be checked before proxy_new=
().
> >> +        */
> >> +       if (g_str_equal(interface, "org.bluez.Device1") =3D=3D TRUE) {
> >> +               DBusMessageIter props, entry;
> >> +               DBusMessageIter copy =3D *iter;
> >> +
> >> +               if (dbus_message_iter_get_arg_type(&copy) =3D=3D DBUS_=
TYPE_ARRAY) {
> >> +                       dbus_message_iter_recurse(&copy, &props);
> >> +                       while (dbus_message_iter_get_arg_type(&props) =
=3D=3D
> >> +                                               DBUS_TYPE_DICT_ENTRY) =
{
> >> +                               const char *key;
> >> +                               dbus_message_iter_recurse(&props, &ent=
ry);
> >> +                               dbus_message_iter_get_basic(&entry, &k=
ey);
> >> +                               if (g_str_equal(key, "AddressType") =
=3D=3D TRUE) {
> >> +                                       DBusMessageIter var;
> >> +                                       const char *addr_type;
> >> +                                       dbus_message_iter_next(&entry)=
;
> >> +                                       dbus_message_iter_recurse(&ent=
ry, &var);
> >> +                                       dbus_message_iter_get_basic(&v=
ar,
> >> +                                                               &addr_=
type);
> >> +                                       if (g_str_equal(addr_type,
> >> +                                                       "random") =3D=
=3D TRUE)
> >> +                                               return;
> >> +                                       break;
> >> +                               }
> >> +                               dbus_message_iter_next(&props);
> >> +                       }
> >> +               }
> >> +       }
> >
> > Nack, not going to introduce BlueZ specific logic into gdbus like
> > this. If we need to rate limit the RSSI notification then it means
> > it's not suitable to be a property, but I believe we have a threshold
> > logic in the likes of device_set_rssi_with_delta so perhaps we shall
> > check why it is not working in your case.
>
> I investigated why device_set_rssi_with_delta is not working in our case.
>
> Root cause in BlueZ
>
>   The customer scans with the following bluetoothctl sequence:
>
>   menu scan =E2=86=92 transport le =E2=86=92 duplicate-data off =E2=86=92=
 back =E2=86=92 scan le

Ok, that is 1 not the default behavior and 2 if they are setting
duplicate-data off that means they want to see all advertisements, so
this is working as intended.

>   scan le calls SetDiscoveryFilter({'Transport': 'le'}) =E2=80=94 a trans=
port-only filter with no RSSI or
>   pathloss condition. In btd_adapter_device_found() (src/adapter.c):
>
>   if (adapter->filtered_discovery)
>       device_set_rssi_with_delta(dev, rssi, 0);   /* delta forced to 0 */
>   else
>       device_set_rssi(dev, rssi);                  /* delta =3D RSSI_THRE=
SHOLD =3D 8 */
>
>   filtered_discovery is set true whenever current_discovery_filter is non=
-NULL (adapter.c:1872), which
>    happens for any SetDiscoveryFilter() call =E2=80=94 including a transp=
ort-only filter. With
>   delta_threshold=3D0, the condition delta < 0 is never true, so g_dbus_e=
mit_property_changed("RSSI")
>   fires on every BLE advertisement regardless of whether the RSSI value c=
hanged. With 280+ BLE devices
>    advertising continuously, this produces ~95 PropertiesChanged(RSSI) si=
gnals per second that flood
>   dbus-daemon.

Yeah, that is what you get to set duplicate-data off, that said ~95
PropertiesChanged per seconds in not a lot of data, perhaps you are
hitting a process that don't consume the events immediately as it
should then the D-Bus daemon have to queue more and more memory?

>   The delta=3D0 path was presumably intended for clients that set RSSI/pa=
thloss proximity filters, so
>   that is_filter_match() gets precise RSSI tracking. A transport-only fil=
ter does not involve any
>   proximity condition, so forcing delta=3D0 is unnecessary in that case.
>
> Proposed BlueZ fix direction
>
>   Only apply delta=3D0 when at least one active client filter has a real =
proximity condition (RSSI or
>   pathloss):
>
>   static bool discovery_filter_has_proximity(struct btd_adapter *adapter)
>   {
>       GSList *l;
>       for (l =3D adapter->discovery_list; l; l =3D g_slist_next(l)) {
>           struct discovery_client *client =3D l->data;
>           struct discovery_filter *item =3D client->discovery_filter;
>           if (item && (item->rssi !=3D DISTANCE_VAL_INVALID ||
>                        item->pathloss !=3D DISTANCE_VAL_INVALID))
>               return true;
>       }
>       return false;
>   }

Duplicate data does consider RSSI as well, so the real problem seems
to be why disabling duplicate filtering is required since that is what
causes the RSSI threshold logic not to be used. Or perhaps you don't
trust your controller to do duplicate filtering. If so, we've gone
full circle because if something causes too much spamming, it's also
bad at the HCI driver, into the mgmt interface, etc, until it reaches
D-Bus, which is why BlueZ defaults to duplicate filtering.

>   /* in btd_adapter_device_found() */
>   if (adapter->filtered_discovery &&
>       discovery_filter_has_proximity(adapter))
>       device_set_rssi_with_delta(dev, rssi, 0);
>   else
>       device_set_rssi(dev, rssi);
>
>   Could you advise whether this is the right approach, or if there is a b=
etter place to fix this?
>
>   then I will Submit a separate BlueZ patch for the delta=3D0 fix once we=
 agree on the approach.
>
> >
> >>         proxy =3D proxy_lookup(client, path, interface);
> >>         if (proxy) {
> >>                 update_properties(proxy, iter, FALSE);
> >> @@ -1255,14 +1293,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnect=
ion *connection,
> >>                                                 "InterfacesRemoved",
> >>                                                 interfaces_removed,
> >>                                                 client, NULL);
> >> -       g_ptr_array_add(client->match_rules, g_strdup_printf("type=3D'=
signal',"
> >> -                               "sender=3D'%s',path_namespace=3D'%s'",
> >> -                               client->service_name, client->base_pat=
h));
> >> -
> >> -       for (i =3D 0; i < client->match_rules->len; i++) {
> >> -               modify_match(client->dbus_conn, "AddMatch",
> >> -                               g_ptr_array_index(client->match_rules,=
 i));
> >> -       }
> >
> > This perhaps has a merit, but I can't recall what this watch was for.
> > Is it matching every signal from the sender? It seems it was introduce
> > before the watch infra existed, so if we can safely remove it we can
> > perhaps remove the whole client-->match_rules.
> >
> >>         return g_dbus_client_ref(client);
> >>  }
> >> --
> >> 2.43.0
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz

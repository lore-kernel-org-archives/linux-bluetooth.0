Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0044160F
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037724; cv=pass; b=bKRY0DPiKJknrYdQQkCq7nIRt/hPm0Eg9mjmoYm8EKIyRa77/S6LqjUuNbmp5DMNo1NfYsI72FCFTcmyUXWZeqTqJ+bxwaThQL+XeGZy55UdAsb/tqDE+5SnEZF4ga42dgIvTpPxzHkVU8AZZwuSVaWVbzaKkCZ+i8QBNJJTuH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037724; c=relaxed/simple;
	bh=H5clIGsDSvStAnlL3yRqmSFSPnUeHkI5WBq2oFXt43E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKct4K9xPzknMfFRiTUFfOQbNjfjOAxvBQul47TYbChRbCcApHpaoRgjVkACcwVBVo3TL86EoW/N1PAwzZCNPdIbOoql+nbTiEzVu7Pz+IvaTx+wF3W4zIh4zFyYRpWwzNAmwgw12/kIaB/vOZJUg1ee2zt0Bm4VAXMYIWYQta8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwwyZgzK; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwwyZgzK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ea9f974ebso9149877b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 07:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784037722; cv=none;
        d=google.com; s=arc-20260327;
        b=G3TfJ4v01qktv7npjbQ3SQsKwFnXNCSH907+p5Su13P3dKJif+AWDC0WTV0Qex2pWr
         u//3PQsQR6hbzJ4q4ATrzExO0x4616vhRFST9SkEDSQuy0PYZf7DkC31zqod7qSm4q0q
         t/fRkBCEH9esQFngtHGZ5IrsEd7FJqF1r4uQl5T9ms7n5r2iIoYR3LeU85rxRBvplLgH
         Yq0ZLSFQXHhuGWbdaSpilQgpZD35AEKYz/vzDS/EPr9oUg7gQTbszFvvrwvg+aLutBGz
         GvBjtE/KUMVJ+q6xsyayj7bpGR0aWMJkT+S7OVXA4v3l0oNYA3sIowZ0ZydhNQN4yQD4
         cdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=soQCRG722xFVOeMqTtH9bFi/uiaVCTeHKqOWsx03Dlk=;
        fh=gCFuju7P+mUa5m9TnnOfYZWEkcFRX8LJrGxZXeugPQY=;
        b=eryBrX/zkQq0uIhgKEal7FOc2jY00p5aZz5yA3Jk23AQe6D8Vhmro6L25uF1f7Fk0t
         XDKXCuO3ZuddBhR/bD9D7t8jDvAv6e66V4ipW5K2apAWdsDNYQhpmQlD32MmeDiTxE8x
         P+Ppvfh3P+527e/iXH4TruMdUZ9dfkI2PxYaAACRL/sDDe+7HqK0Iz2oZJqEOeLXts8i
         ht0kOAEgzlGY27Xz/WSYeQVUXebWEHTers7+VJhIb9TLkYrrqNjxbRlCacgJ/wp+BaK+
         PEgXYPcwApg/l5KZJtrhC2ELmO548mp1Anf6OCREJbVke7kLaPOQF/4OG/HzQKxWR4As
         f12Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784037722; x=1784642522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=soQCRG722xFVOeMqTtH9bFi/uiaVCTeHKqOWsx03Dlk=;
        b=HwwyZgzKp963otHhItwnIKcnSEKkZ3LJp5IL1avbwvvEkM+SxUgWib+UolMtwQ+Sao
         vE8Krti/2pO2uGzhj51seuizDTajQiHYCgJ3P8nBzHNtfekRPXVvE6Ih7XLWM1dghAK0
         xxiuuYoGIdak6zoZctQYKLeAcuDUxsKb/8I5Ztyo5vh9DxvlyPrC0pAZA4Y6FFt69z/i
         0D+zpxnNwrf85I8EhoALCo5rTho4Fy+lXGP465z0H8HSe+9cZZMQDUzSNQU0YjzacNtf
         yoBkCWG4HuTAKQJQmoubwvAUy4Ss8V+02T0S3CDI1T9xfJ7iY31d5uVMmcF/WedwZfqv
         v7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784037722; x=1784642522;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=soQCRG722xFVOeMqTtH9bFi/uiaVCTeHKqOWsx03Dlk=;
        b=bY9gC/IeB7sev4EUwGg/Y9KiHo9Bk2L1NUD50+AGgqlRDPo/ugwRamm2FmQti+ZZ+5
         Ln2vaFfP/IpovYvCI0Rnf7Q1WctY4TM7KPzH92HrVmZ0h4COQrxWubosWemZDIzIlpze
         npqWxk9FWphvoyhpeqRLyT/l4P2BELlOKUCWHmq0eT8XDEXf6BG0tsok3F3j5PruvrhQ
         kfLOMQfg3SXFPKUBW+oqaEqLwqq7B17aSsGz8f8+rJPWDeRwcVkLL5FQ1WT5DN8YDdeN
         GgUIJZFV5WkidAATg9sej/4oHujsS1azEgDGGofJ+Il3UK7uui4yp+xg+sugt+7sBn/m
         ZtpA==
X-Forwarded-Encrypted: i=1; AHgh+RqHaIaC30MUeijXLIuz1FVoba0nOXxEhZoF39JLWyP8eq+j/EKq5MDkjtp1kF2BeGCU6NNvoDDapr/mRT7BJqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk4g6zmYLaonj0B00E/e22AdhFcva93gr1YPKdT9w8l+eQorsS
	1XMbjlqioc58bVew/Yr1MwMyLwkJlOTX5Zf4lnW8LRSJ+2YKEdZ0CRUMOWx2wBmEHEjiMLQq7cl
	S4jo7LO2CtlQADBgHCco5CO6/+TnZSDY=
X-Gm-Gg: AfdE7ckKYh0H32sNU+FbGBsqOHtPNhKoEKP8Eo94vlAEqc/PBjNooAactCqHyKlHe98
	JuDPOTN0xHkoxjlWYR/sO3kOhZttVZxtcy9zEiZF2wSr/LNFdQj8UeFC9scPSc2yy1m0oYOVMyq
	BjhvTA5RgW02PCzvASZZMnAll1Zc1vgPfEquNR1CwQreCYIQZqyOL9FwCdtAyzwd8E3ocokchKe
	ZxtEfkXT7zZIEIvZAfJbCY4pZEQLDmfwG7ZPKKXBiT/SGFTXp3xApRCAm/+JOLbOMs/snFOEhIG
	iMafZkyeNGKbdkU0KeY7WHiqTru9ipHlgvNUIG0tG0U6ny/NZ0YCW928
X-Received: by 2002:a05:690c:e0c5:10b0:81e:bee4:2c1c with SMTP id
 00721157ae682-81ebee42dc7mr13312417b3.63.1784037719124; Tue, 14 Jul 2026
 07:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
 <CABBYNZJrrQO5XU1yC-HOry1eEaF8fBKV_jK4g3A+qJTAtw0Qqg@mail.gmail.com>
 <0b6a3ae6-d8a8-409d-844b-be4be14917d3@oss.qualcomm.com> <CABBYNZ+-ybGUPPtQ3xuwHfewt4w6C4CTf0cYXbo3AZ9+vqDGxA@mail.gmail.com>
 <81ef5f5e-8be5-4736-9d48-d4b3f6611e44@oss.qualcomm.com>
In-Reply-To: <81ef5f5e-8be5-4736-9d48-d4b3f6611e44@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Jul 2026 10:01:47 -0400
X-Gm-Features: AUfX_mxwj7LN_0FCy8leLCimg0TjE1lrKSRly0vkWuUVZdnZFB9V9e_uI-Rt8Ig
Message-ID: <CABBYNZK8M-mRXvA5eMWwC9r4mBgxSH_6sU06EsVgxKoSWaVsJw@mail.gmail.com>
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

On Tue, Jul 14, 2026 at 7:04=E2=80=AFAM Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> wrote:
>
>
>
> On 7/13/2026 10:00 PM, Luiz Augusto von Dentz wrote:
> > Hi Xiuzhuo,
> >
> > On Mon, Jul 13, 2026 at 3:03=E2=80=AFAM Xiuzhuo Shang
> > <xiuzhuo.shang@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 7/10/2026 10:12 PM, Luiz Augusto von Dentz wrote:
> >>> Hi Xiuzhuo,
> >>>
> >>> On Fri, Jul 10, 2026 at 3:55=E2=80=AFAM Xiuzhuo Shang
> >>> <xiuzhuo.shang@oss.qualcomm.com> wrote:
> >>>>
> >>>> Two related changes to reduce dbus-daemon load caused by high-rate
> >>>> BLE advertising signals:
> >>>>
> >>>> 1. In parse_properties(), skip creating a GDBusProxy for Device1
> >>>>    objects whose AddressType is 'random' (BLE-only devices). Each
> >>>>    proxy registers a per-device PropertiesChanged watch via
> >>>>    g_dbus_add_properties_watch(); with hundreds of BLE peripherals
> >>>>    advertising simultaneously, this results in hundreds of match rul=
es
> >>>>    and dbus-daemon routing thousands of RSSI PropertiesChanged signa=
ls
> >>>>    per second to ofono, none of which ofono processes. The
> >>>>    AddressType property is available in the InterfacesAdded dict at
> >>>>    the time parse_properties() is called, so the check is reliable
> >>>>    and race-free.
> >>>>
> >>>>    BR/EDR devices (AddressType=3D'public') are unaffected: their pro=
xies
> >>>>    are created as before, and the property_changed callback continue=
s
> >>>>    to receive Paired and ServicesResolved updates needed for HFP/HSP=
.
> >>>>
> >>>> 2. In g_dbus_client_new_full(), remove the broad
> >>>>    type=3D'signal',sender=3D<service>,path_namespace=3D<path> match =
rule.
> >>>>    This rule was the sole feeder for the signal_func path in
> >>>>    message_filter(). ofono never calls g_dbus_client_set_signal_watc=
h()
> >>>>    so signal_func is always NULL; the broad rule therefore served no
> >>>>    purpose and caused dbus-daemon to route every bluetoothd signal
> >>>>    (including all BLE PropertiesChanged) to ofono.
> >>>>
> >>>>    InterfacesAdded and InterfacesRemoved are already covered by the
> >>>>    precise watches registered via g_dbus_add_signal_watch() earlier =
in
> >>>>    g_dbus_client_new_full(), so no functionality is lost.
> >>>
> >>> Looks like this is on ofono though, why are you chaning the BlueZ sid=
e?
> >>
> >> Regarding your suggestion to move the BLE filter to hfp_hf_bluez5.c: f=
iltering in proxy_added()
> >> would only prevent ofono from processing BLE devices at the applicatio=
n level. The per-device
> >> PropertiesChanged watch is registered inside proxy_new(), which is cal=
led before proxy_added(). So
> >> dbus-daemon would still route all RSSI signals to the process =E2=80=
=94 the D-Bus pressure problem would
> >> remain unchanged.
> >>
> >> I will drop the change from the gdbus patch per your feedback
> >>
> >>>
> >>>> Together these two changes prevent dbus-daemon from routing BLE
> >>>> advertising PropertiesChanged signals to ofono entirely, eliminating
> >>>> the dbus-daemon memory growth and bluetoothd socket backpressure see=
n
> >>>> after hours of BLE scanning.
> >>>>
> >>>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> >>>> ---
> >>>>  gdbus/client.c | 46 ++++++++++++++++++++++++++++++++++++++--------
> >>>>  1 file changed, 38 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/gdbus/client.c b/gdbus/client.c
> >>>> index 48711ae8..dd3c17f9 100644
> >>>> --- a/gdbus/client.c
> >>>> +++ b/gdbus/client.c
> >>>> @@ -937,6 +937,44 @@ static void parse_properties(GDBusClient *clien=
t, const char *path,
> >>>>         if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) =3D=3D=
 TRUE)
> >>>>                 return;
> >>>>
> >>>> +       /*
> >>>> +        * Skip BLE devices (AddressType=3D'random') to avoid regist=
ering a
> >>>> +        * per-device PropertiesChanged watch for every advertising =
BLE
> >>>> +        * peripheral. ofono only needs BR/EDR devices for HFP/HSP; =
the
> >>>> +        * high-rate RSSI PropertiesChanged signals from BLE scanner=
s cause
> >>>> +        * dbus-daemon memory bloat and socket backpressure in bluet=
oothd.
> >>>> +        *
> >>>> +        * The AddressType property is present in the InterfacesAdde=
d dict
> >>>> +        * (iter) at this point, so it can be checked before proxy_n=
ew().
> >>>> +        */
> >>>> +       if (g_str_equal(interface, "org.bluez.Device1") =3D=3D TRUE)=
 {
> >>>> +               DBusMessageIter props, entry;
> >>>> +               DBusMessageIter copy =3D *iter;
> >>>> +
> >>>> +               if (dbus_message_iter_get_arg_type(&copy) =3D=3D DBU=
S_TYPE_ARRAY) {
> >>>> +                       dbus_message_iter_recurse(&copy, &props);
> >>>> +                       while (dbus_message_iter_get_arg_type(&props=
) =3D=3D
> >>>> +                                               DBUS_TYPE_DICT_ENTRY=
) {
> >>>> +                               const char *key;
> >>>> +                               dbus_message_iter_recurse(&props, &e=
ntry);
> >>>> +                               dbus_message_iter_get_basic(&entry, =
&key);
> >>>> +                               if (g_str_equal(key, "AddressType") =
=3D=3D TRUE) {
> >>>> +                                       DBusMessageIter var;
> >>>> +                                       const char *addr_type;
> >>>> +                                       dbus_message_iter_next(&entr=
y);
> >>>> +                                       dbus_message_iter_recurse(&e=
ntry, &var);
> >>>> +                                       dbus_message_iter_get_basic(=
&var,
> >>>> +                                                               &add=
r_type);
> >>>> +                                       if (g_str_equal(addr_type,
> >>>> +                                                       "random") =
=3D=3D TRUE)
> >>>> +                                               return;
> >>>> +                                       break;
> >>>> +                               }
> >>>> +                               dbus_message_iter_next(&props);
> >>>> +                       }
> >>>> +               }
> >>>> +       }
> >>>
> >>> Nack, not going to introduce BlueZ specific logic into gdbus like
> >>> this. If we need to rate limit the RSSI notification then it means
> >>> it's not suitable to be a property, but I believe we have a threshold
> >>> logic in the likes of device_set_rssi_with_delta so perhaps we shall
> >>> check why it is not working in your case.
> >>
> >> I investigated why device_set_rssi_with_delta is not working in our ca=
se.
> >>
> >> Root cause in BlueZ
> >>
> >>   The customer scans with the following bluetoothctl sequence:
> >>
> >>   menu scan =E2=86=92 transport le =E2=86=92 duplicate-data off =E2=86=
=92 back =E2=86=92 scan le
> >
> > Ok, that is 1 not the default behavior and 2 if they are setting
> > duplicate-data off that means they want to see all advertisements, so
> > this is working as intended.
>
> Hi Luiz,
>
> Thank you for the clarification. I need to correct some points
> regarding duplicate-data off and the actual signal rate.
>
> What DuplicateData does in BlueZ vs. the controller
>
> BlueZ's DuplicateData parameter in SetDiscoveryFilter and the
> controller's hardware duplicate filter are two independent mechanisms:
>
> - The controller hardware duplicate filter (filter_dup in
>   hci_le_set_scan_enable) is controlled by the kernel (hci_sync.c),
>   defaulting to LE_SCAN_FILTER_DUP_ENABLE. It is only disabled for
>   specific cases (AdvMonitor, Mesh, or
>   HCI_QUIRK_STRICT_DUPLICATE_FILTER).
>   SetDiscoveryFilter.DuplicateData does NOT directly control this.
>
> - BlueZ's DuplicateData=3Dtrue flag (parse_duplicate_data() in
>   src/adapter.c:2680) controls only whether device EIR data
>   (manufacturer data, service data) is updated on duplicate
>   advertisements at the application layer
>   (device_set_manufacturer_data(), device_set_service_data(),
>   src/adapter.c:7392).
>
> duplicate-data off has no effect
>
> In bluetoothctl, duplicate-data off sets filter.duplicate =3D false
> (client/main.c:1449). In set_discovery_filter_setup()
> (client/main.c:1251):
>
>   if (args->duplicate)    /* false -> DuplicateData is NOT sent */
>       g_dbus_dict_append_entry(&dict, "DuplicateData", ...);
>
> Since false is the default, DuplicateData is never included in the
> SetDiscoveryFilter call. The customer's duplicate-data off step has
> no effect =E2=80=94 the controller hardware duplicate filter remains enab=
led
> throughout.
>
> Why RSSI delta=3D0 occurs
>
> The root cause is Transport=3Dle on a dual-mode adapter
> (src/adapter.c:85):
>
>   #define SCAN_TYPE_LE   ((1 << BDADDR_LE_PUBLIC) |
>                           (1 << BDADDR_LE_RANDOM))  /* =3D 6 */
>   #define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE) /* =3D 7 */
>
> get_scan_type(adapter) returns 7 (DUAL) since the adapter supports
> both BR/EDR and LE. When Transport=3Dle is set, filter->type =3D 6. In
> merge_discovery_filters() (src/adapter.c:2254):
>
>   item->type =3D=3D adapter_scan_type    /* 6 !=3D 7 -> condition fails *=
/
>
> This triggers has_filtered_discovery =3D true -> filtered_discovery =3D
> true -> device_set_rssi_with_delta(dev, rssi, 0)
> (src/adapter.c:7362). With delta_threshold=3D0, every advertisement
> emits PropertiesChanged(RSSI) regardless of RSSI change.
>
> We have captured a bluetoothd debug log (QCS6490 board, BlueZ 5.72)
> that directly confirms this sequence. The following lines are from
> the log with the customer's exact scan sequence
> (menu scan -> transport le -> duplicate-data off -> back -> scan le):
>
>   # SetDiscoveryFilter called with Transport=3Dle only, no RSSI/pathloss
>   adapter.c:parse_discovery_filter_dict() filtered discovery params:
>       transport: 6  rssi: 32767  pathloss: 32767
>       duplicate data: false  discoverable false  pattern (null)
>
>   # current_discovery_filter is non-NULL =E2=80=94 confirms filtered_disc=
overy
>   # will be set to true in start_discovery_complete()
>   adapter.c:start_discovery_timeout() adapter->current_discovery_filter =
=3D=3D 1
>
>   # filtered_discovery=3D1 directly confirmed by our added debug print
>   adapter.c:start_discovery_complete() filtered_discovery=3D1 (current_di=
scovery_filter=3Dset)
>
>   # delta_threshold=3D0 directly confirmed =E2=80=94 every advertisement =
emits
>   # PropertiesChanged(RSSI) regardless of whether RSSI changed
>   device.c:device_set_rssi_with_delta() rssi=3D-86 delta_threshold=3D0
>   device.c:device_set_rssi_with_delta() rssi=3D-79 delta_threshold=3D0
>   device.c:device_set_rssi_with_delta() rssi=3D-72 delta_threshold=3D0
>   ...
>
> The log shows delta_threshold=3D0 on every single call. With hundreds
> of BLE devices advertising, this produces an unthrottled stream of
> PropertiesChanged(RSSI) signals.
>
>
> >
> >>   scan le calls SetDiscoveryFilter({'Transport': 'le'}) =E2=80=94 a tr=
ansport-only filter with no RSSI or
> >>   pathloss condition. In btd_adapter_device_found() (src/adapter.c):
> >>
> >>   if (adapter->filtered_discovery)
> >>       device_set_rssi_with_delta(dev, rssi, 0);   /* delta forced to 0=
 */
> >>   else
> >>       device_set_rssi(dev, rssi);                  /* delta =3D RSSI_T=
HRESHOLD =3D 8 */
> >>
> >>   filtered_discovery is set true whenever current_discovery_filter is =
non-NULL (adapter.c:1872), which
> >>    happens for any SetDiscoveryFilter() call =E2=80=94 including a tra=
nsport-only filter. With
> >>   delta_threshold=3D0, the condition delta < 0 is never true, so g_dbu=
s_emit_property_changed("RSSI")
> >>   fires on every BLE advertisement regardless of whether the RSSI valu=
e changed. With 280+ BLE devices
> >>    advertising continuously, this produces ~95 PropertiesChanged(RSSI)=
 signals per second that flood
> >>   dbus-daemon.
> >
> > Yeah, that is what you get to set duplicate-data off, that said ~95
> > PropertiesChanged per seconds in not a lot of data, perhaps you are
> > hitting a process that don't consume the events immediately as it
> > should then the D-Bus daemon have to queue more and more memory?
>
>
> Actual signal rate from the captured log
>
> The log (30_Jun_2026/bluetooth.log.gz) shows duplicate data: true
> with Transport=3Dle. The device_found_callback distribution over 1200
> active seconds is:
>
>     0-99  events/s :   69 seconds  (6%)
>   100-199 events/s :  187 seconds (16%)
>   200-299 events/s :   75 seconds  (6%)
>   300+    events/s :  869 seconds (72%)  <- burst, peak 392/s
>
> The average is ~95/s but that conceals the burst pattern: 72% of the
> time the rate exceeds 300/s. With 280+ BLE devices advertising,
> delta=3D0 means every single device_found_callback unconditionally
> emits a PropertiesChanged(RSSI) signal =E2=80=94 including during bursts =
at
> 392/s.

Are we talking about an embedded device here? How come it takes
seconds to process hundreds of events, or is it simply running out of
memory and lacking swap space? If this were a general problem we would
have seen this before. Even with hundreds of devices in the vicinity,
it never took this much time to process.

> The actual bottleneck
>
> As you pointed out, ~95/s average may not seem large. The real
> bottleneck is that WirePlumber and ofono both register a broad
> path_namespace=3D'/' match rule, causing dbus-daemon to route all
> these signals to processes that immediately discard them
> (message_filter() drops PropertiesChanged silently). Over 8 hours,
> dbus-daemon's routing table grows to 357 MB, making routing
> progressively slower until bluetoothd's socket fills and its
> GMainLoop stalls.

That sounds like a process that is not dropping its messages; even if
we generate fewer messages, it will eventually stop working because
too many messages are cached or something similar.

> How do you think the logic of bluez about delta_threshold =3D 0
> when just Transport=3Dle?

It sounds like another problem is at hand=E2=80=94not just too many signals
but them not being consumed. Over time, this issue will recur if not
fixed properly.

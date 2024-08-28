Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8219ADBA
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855889; cv=none; b=USfdy436WFOU1iYLAYspV7qWXZIwAPylIeMZwN+ky23cmTGytVJZk8RAKnmTxrpjLfgqpthwHrkBsPnIYIAWFdCsiY2B8R0XhzIHmMlNHTsft5OnE05gYkLhu91X9CJL4kvTasrspbjz+kab4+60dGYWCaehbizq+uw5EdHn8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855889; c=relaxed/simple;
	bh=eAM7AMMCa95VG08/ejob1sZXAIgQaSgFFMd58BdAhRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUYSCRdMAEa12W0108n7Tgi49K6rusQhS0GDmetNJRI9NmP1LjBQ7UrUDJcifb7qflOpdwNW66TcvH7jznVzeOscrqmXPXGdEVOuetdWQYSWl94PN1GA43D/3tr2xOqTpoiLj0MOYIY2x1Crq6oYHyzjV7z9v2C6V7/WIY2e3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNhfXjBG; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNhfXjBG"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f50966c469so44119711fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724855885; x=1725460685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9aw2j2kZNJxtLUWPp4lvHWznejwaPgRJVG3LQbPAHk=;
        b=LNhfXjBGJCenxVkn6I+YDXCFLdl9q9x8I+wFvwdPt/BmZs16MaqcUQCUnJDZQ8nkLW
         8ZGuvtZJnReP0XqXapxkkmvdNaMOC1OVTqt1ydsegPIzkJsVa39AVXVuzZQiA26E+mRz
         +fkqgv1DJ8xjJZhXLopFq2URu7VjFoqwzypeu9Q23AQnqnh/H8ENUnjUdWgujR4XEJVQ
         zZKEeZoeZ2S4/e4lRnIhZOkaZAIhKhpfAEcKRWWo9IlMALBiNio3s+e3kDS8xzPaxFxe
         93/n3xAo4Liyh5+JrRR76a5qK8fhc1+zdKRQnGMoEoPfIh2aOnVZ6XblcPR+IHt9Z1A/
         YDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724855885; x=1725460685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9aw2j2kZNJxtLUWPp4lvHWznejwaPgRJVG3LQbPAHk=;
        b=Wf6ZsHVShMijxwmxaig0rECB7M6qqgl7Q7tS/801FMxnKcDgafoK8HRvJ8ZlbcnJyz
         w5J57cDIp/fmx7Bce5P6TwXJnx/7/5nlQi7wb9huo5VZLq1Rv3LwHND3ObeO71oCRW7R
         4kRqfm8Z/Dm4LJjGfAVpn70Uhv+NkoEr+9KZxVYaYc2+KQY2t5nJXxzqJXkYP0tHKjFj
         91C4h0DjbxqOIIB8MfJQLBW9Il69YrzrGsJTf6cSS0MVBT+y8fDmBOciVeQCg0B8TjMP
         W5ZgdzhzH2A6WOphZLyDhnOCzZD4B9geyVpoy59S/sxNtRarXwaftwfop+bv7Wn1XQ10
         DrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjehLavwK7yQ/1jxJTiv4tVuIyZDtctqpbVv2TISBI6vuR8KyPb60OdGF6VcscO0CMVe29J97H7xPGv2zRg5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMzSo7a+0rG55tOt2iPB2y9ynQn6B3UaM8w9CCV7t6VGr8zWJ
	i/tzlyQt/ma9BSeKARBbuk5RAeSqhTN8uVrBBT0m/l1adhz5AurgiSxRAG2L7fnwN4qxnRDw0m2
	YPBP7EaVqFlm5LKyijfzwIjpFinU=
X-Google-Smtp-Source: AGHT+IGXuWdYphvT0nkMYHBvYTN4wq9C6uBzZ8Tyc+S1sVPxpHKypzD+tgtl3KET/p2DbfaGorpUTeQrgti5HbyvMZo=
X-Received: by 2002:a2e:b8c2:0:b0:2f3:f111:9bc4 with SMTP id
 38308e7fff4ca-2f4f57aa53emr126088241fa.43.1724855883934; Wed, 28 Aug 2024
 07:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
 <55903fdb-e970-4b89-b620-daa93bad7811@archlinux.org> <CABBYNZ+X1gWovfui7Vyaag80PFz_1q4A_F7r=wpgF_gm9f9orA@mail.gmail.com>
 <e4be48f5-1139-4871-a229-8dae7a7d745f@126.com> <CABBYNZK6qYdvAkKJDTfgxOxC2+qBxRriaprH3ooxV0jRMsf8fQ@mail.gmail.com>
 <4b897b9f-8ea5-45ad-9a41-faae01d2ed18@126.com> <CABBYNZLvA+ParxAny3KGiTEN1AXi64pG1ZtOz7aMvXDFubDp9Q@mail.gmail.com>
 <588714fa-ffa0-4e5a-9d06-00c198e0700b@126.com> <CABBYNZ+G3xpV+C5JPeXGu=rxjwexEV+0mTr9OMw_UxEV9K5CPA@mail.gmail.com>
 <0b172ceb-6f8b-44f8-a861-a8480b62f6ca@126.com>
In-Reply-To: <0b172ceb-6f8b-44f8-a861-a8480b62f6ca@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Aug 2024 10:37:50 -0400
Message-ID: <CABBYNZK9O7udF=xMj5O+LHZDspgjp-PXwTt1epb73uKB7R-RJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] adapter: Fix addr_type for smp_irk/ltk_info/link_key
To: Yao Xiao <xiaokeqinhealth@126.com>
Cc: Robin Candau <antiz@archlinux.org>, quic_chejiang@quicinc.com, 
	linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 28, 2024 at 6:03=E2=80=AFAM Yao Xiao <xiaokeqinhealth@126.com> =
wrote:
>
> Hi Luiz,
>
> On 2024/8/28 2:30, Luiz Augusto von Dentz wrote:
> > Hi Yao,
> >
> > On Tue, Aug 27, 2024 at 2:03=E2=80=AFPM Yao Xiao <xiaokeqinhealth@126.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> On 2024/8/27 23:47, Luiz Augusto von Dentz wrote:
> >>> Hi,
> >>>
> >>> On Tue, Aug 27, 2024 at 10:33=E2=80=AFAM Yao Xiao <xiaokeqinhealth@12=
6.com> wrote:
> >>>>
> >>>> Hi Luiz,
> >>>>
> >>>> On 2024/8/27 20:52, Luiz Augusto von Dentz wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On Tue, Aug 27, 2024 at 3:41=E2=80=AFAM Yao Xiao <xiaokeqinhealth@1=
26.com> wrote:
> >>>>>>
> >>>>>> Hi luiz,
> >>>>>> The kernel should always report the correct address type for all k=
inds
> >>>>>> of keys. Older kernels ignore the derivation of keys, which preven=
ts the
> >>>>>> user layer from knowing the correct address type. This can cause a=
 lot
> >>>>>> of confusion for users. For example, when a user connects to a
> >>>>>> traditional Bluetooth audio device, due to the default activation =
of key
> >>>>>> derivation, bluetoothd reports both BREDR and BLE pairing and bind=
ing,
> >>>>>> and the address is updated to LE public. When the user actively ca=
lls
> >>>>>> the Connect method of org.bluez.Device1 to reconnect, sometimes th=
e
> >>>>>> address type is set to LE public, leading to a failed connection, =
and
> >>>>>> vice versa.
> >>>>>
> >>>>> The correct address type can only be the ones listed on mgmt-api
> >>>>> otherwise we are breaking APIs, also except if there are some new c=
ase
> >>>>> I don't know and Load Keys and Load LTK are bearer specific.
> >>>>>
> >>>>>> We should enable bluetoothd to know the reason for the generation =
of
> >>>>>> keys as much as possible. Older kernels always assume the address =
type
> >>>>>> of linkey is BREDR, and ltk/irk/csrk are LE public. Therefore, we =
can
> >>>>>> use this as a basis for judgment, allowing bluetoothd to handle va=
rious
> >>>>>> issues, such as reloading keys and handling unpaired devices. Belo=
w is a
> >>>>>> pseudo-code that is not running in practice but just a thought. Pl=
ease
> >>>>>> help review it.
> >>>>>
> >>>>> Yeah, and what exactly was wrong with that? What you mention about
> >>>>> having keys for both BR/EDR and LE public is not an issue, that
> >>>>> basically the very definition of a dual-mode device and bluetoothd
> >>>>> shall be able to tell when to connect to BR/EDR and LE public, if i=
t
> >>>>> doesn't we shall fix that and not start breaking APIs.
> >>>> Returning to my original issue: When BlueZ acts as a sink device and=
 a
> >>>> phone connects to it, pairs successfully, and derives related keys,
> >>>> BlueZ reports to the user layer that bonded (both bredr_state.bonded=
 and
> >>>> dev->le_state.bonded) are true, and addr_type is LE_PUBLIC. If the
> >>>> device restarts and the org.bluez.Device1:Connect method is called t=
o
> >>>> reconnect to the phone, according to the rules in select_conn_bearer=
,
> >>>> addr_type will be set to LE_PUBLIC, leading to a failed reconnection
> >>>> when device_connect_le is called.
> >>>
> >>> If I recall this correctly we do reconnect based on the last seen
> >>> bearer, also the addr_type is only really relevant for LE bearer,
> >>> BR/EDR shall be detected via bearer state alone. Anyway there was a
> >>> discussion regarding having bearer specific API's as alternative to
> >>> org.bluez.Device1.Connect to pickup a bearer, but in some cases, like
> >>> when acting as a peripheral, perhaps we need a different policy, in
> >>> the specific case of being a A2DP sink though, we could detect that L=
E
> >>> keys are for a peripheral and in that case advertisement shall be use=
d
> >>> for connecting the LE bearer thus the BR/EDR shall be chosen which
> >>> shall fix this behavior.
> >>>
> >>>> In this situation, how should bluetoothd choose the correct address =
type
> >>>> when it doesn't know the physical bearer layer? Should there be a
> >>>> configuration option to turn key derivation on or off? Additionally,
> >>>> there's another use case: When a phone connects to a BlueZ device, i=
t
> >>>> continuously transmits custom data via BLE and music via traditional
> >>>> Bluetooth (BREDR). If the user only wants to unpair the BREDR, it ma=
y
> >>>> cause the BLE connection to be disconnected as well, leading to data
> >>>> transmission interruption. Should we also consider turning off key
> >>>> derivation in this scenario?
> >>>
> >>> Device API is not bearer specific though, so one cannot really unpair
> >>> BR/EDR alone, in fact I would be surprised if any stack implements
> >>> this that way because depending on what bearer is connected it may
> >>> trigger a missing link key which could possibly lead to repairing
> >>> procedure which will most likely having to replace the other bearer
> >>> keys as well, if the idea is you only really need BR/EDR then you
> >>> might as well disable LE completely.
> >>
> >> Could we possibly implement a configuration that allows for the enabli=
ng
> >> or disabling of key derivation? Currently, a significant portion of
> >> devices only require either BR/EDR or BLE functionality independently
> >> and do not need key derivation, which can cause some confusion and
> >> issues for users. Additionally, as I understand, there are some
> >> proprietary RTOS Bluetooth protocol stacks that have disabled key
> >> derivation and support separate management of pairing keys for BR/EDR
> >> and BLE devices. For example, an IoT device that supports both BR/EDR
> >> and BLE could be detected as two separate devices by an iPhone, sharin=
g
> >> the same address=E2=80=94one for BLE used for ANCS notifications (Appl=
e
> >> Notification Center Service (ANCS) Specification) and the other for
> >> A2DP. The phone could connect to or remove either device without
> >> interference between the two.
> >
> > That will likely require a lot of work to get working since we would
> > endup with the same device object, if this really exists in real life
> > Im afraid it breaks a lot of things in the process and it will never
> > be backwards compatible, so I'm really not convinced this is the right
> > thing to do, in fact Id claim that if a device wants to have separate
> > pairing/bonding procedures then it must use different addresses which
> > means the LE bearer shall probably use a random static address rather
> > than attempt to reuse the same identity address of BR/EDR, afterall it
> > want to have distinct devices so it really makes no sense to keep
> > using the same address.
>
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 6, Part B
> 1.3 DEVICE ADDRESS
> Devices are identified using a device address and an address type;
> Whenever two device addresses are compared, the comparison shall include
> the device address type (i.e. if the two addresses have different types,
> they are different even if the two 48-bit addresses are the same).

Yeah, but it doesn't make any difference if both BREDR and LE address
type is a public identity address, which must be the case since BREDR
can only be a public address, or are you talking about giving a random
static the same address to a public? While possible I would argue that
is a self inflicted pain because the device should attempt to generate
a unique address exactly for the purpose of not allocating addresses
which may belong to another company (OUI):

https://www.wireshark.org/tools/oui-lookup.html

And no, as far as MAC address is concerned there is no address type,
this is something that Bluetooth invented and that I very much dislike
since it completely disregards things like OUI exists.

> According to the specification, even if the addresses are the same, as
> long as the address types are different, they are considered two
> different devices; the iPhone(iOS) can scan for two devices: they have
> the same address but different address types, and can be paired and
> unpaired independently.

That is fair enough when the devices are from different manufacturers,
what I'm questioning is why someone would deliberately have the same
address with different address types? Btw, are these devices on the
market already?

>
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> -------------------------------------------
> >>>>>> diff --git a/src/adapter.c b/src/adapter.c
> >>>>>> index 85ddfc165..babe7c9b2 100644
> >>>>>> --- a/src/adapter.c
> >>>>>> +++ b/src/adapter.c
> >>>>>> @@ -4958,6 +4958,7 @@ static void load_devices(struct btd_adapter =
*adapter)
> >>>>>>              struct irk_info *irk_info;
> >>>>>>              struct conn_param *param;
> >>>>>>              uint8_t bdaddr_type;
> >>>>>> +        bool derived_key;
> >>>>>>
> >>>>>>              if (entry->d_type =3D=3D DT_UNKNOWN)
> >>>>>>                  entry->d_type =3D util_get_dt(dirname, entry->d_n=
ame);
> >>>>>> @@ -4976,10 +4977,21 @@ static void load_devices(struct btd_adapte=
r
> >>>>>> *adapter)
> >>>>>>                  g_clear_error(&gerr);
> >>>>>>              }
> >>>>>>
> >>>>>> +        derived_key =3D g_key_file_get_boolean(key_file, "General=
",
> >>>>>> +                                "DerivedKey", NULL);
> >>>>>> +
> >>>>>> +        /* For link key */
> >>>>>>              bdaddr_type =3D get_addr_type(key_file);
> >>>>>> +        if (!derived_key)
> >>>>>> +            bdaddr_type =3D BDADDR_BREDR;
> >>>>>>
> >>>>>>              key_info =3D get_key_info(key_file, entry->d_name, bd=
addr_type);
> >>>>>>
> >>>>>> +        /* For ltk/irk/csrk */
> >>>>>> +        bdaddr_type =3D get_addr_type(key_file);
> >>>>>> +        if (!derived_key)
> >>>>>> +            bdaddr_type =3D BDADDR_LE_PUBLIC;
> >>>>>> +
> >>>>>>              ltk_info =3D get_ltk_info(key_file, entry->d_name, bd=
addr_type);
> >>>>>>
> >>>>>>              peripheral_ltk_info =3D get_peripheral_ltk_info(key_f=
ile,
> >>>>>> @@ -8673,6 +8685,12 @@ static void new_link_key_callback(uint16_t =
index,
> >>>>>> uint16_t length,
> >>>>>>              return;
> >>>>>>          }
> >>>>>>
> >>>>>> +    /*
> >>>>>> +     * For older kernels, the address type is always BREDR.
> >>>>>> +     */
> >>>>>> +    if (addr->type =3D=3D BDADDR_LE_PUBLIC)
> >>>>>> +        device->derived_key =3D true;
> >>>>>> +
> >>>>>>          if (ev->store_hint) {
> >>>>>>              const struct mgmt_link_key_info *key =3D &ev->key;
> >>>>>>
> >>>>>> @@ -8791,6 +8809,12 @@ static void new_long_term_key_callback(uint=
16_t
> >>>>>> index, uint16_t length,
> >>>>>>              return;
> >>>>>>          }
> >>>>>>
> >>>>>> +    /*
> >>>>>> +     * For older kernels, the address type is always BDADDR_LE_PU=
BLIC.
> >>>>>> +     */
> >>>>>> +    if (addr->type =3D=3D BDADDR_BREDR)
> >>>>>> +        device->derived_key =3D true;
> >>>>>> +
> >>>>>>          /*
> >>>>>>           * Some older kernel versions set store_hint for long ter=
m keys
> >>>>>>           * from resolvable and unresolvable random addresses, but=
 there
> >>>>>> @@ -8855,6 +8879,9 @@ static void new_csrk_callback(uint16_t index=
,
> >>>>>> uint16_t length,
> >>>>>>              return;
> >>>>>>          }
> >>>>>>
> >>>>>> +    if (addr->type =3D=3D BDADDR_BREDR)
> >>>>>> +        device->derived_key =3D true;
> >>>>>> +
> >>>>>>          device_set_csrk(device, key->val, 0, key->type, ev->store=
_hint);
> >>>>>>      }
> >>>>>>
> >>>>>> @@ -8941,6 +8968,9 @@ static void new_irk_callback(uint16_t index,
> >>>>>> uint16_t length,
> >>>>>>              return;
> >>>>>>          }
> >>>>>>
> >>>>>> +    if (addr->type =3D=3D BDADDR_BREDR)
> >>>>>> +        device->derived_key =3D true;
> >>>>>> +
> >>>>>>          device_update_addr(device, &addr->bdaddr, addr->type);
> >>>>>>
> >>>>>>          if (duplicate)
> >>>>>> diff --git a/src/device.c b/src/device.c
> >>>>>> index a1dc0750c..062b9c49d 100644
> >>>>>> --- a/src/device.c
> >>>>>> +++ b/src/device.c
> >>>>>> @@ -272,6 +272,7 @@ struct btd_device {
> >>>>>>          struct csrk_info *remote_csrk;
> >>>>>>          struct ltk_info *ltk;
> >>>>>>          struct queue    *sirks;
> >>>>>> +    bool        derived_key;            /* key is derived. */
> >>>>>>
> >>>>>>          sdp_list_t    *tmp_records;
> >>>>>>
> >>>>>> @@ -482,6 +483,9 @@ static gboolean store_device_info_cb(gpointer =
user_data)
> >>>>>>          g_key_file_set_boolean(key_file, "General", "Blocked",
> >>>>>>                                  device->blocked);
> >>>>>>
> >>>>>> +    g_key_file_set_boolean(key_file, "General", "DerivedKey",
> >>>>>> +                            device->derived_key);
> >>>>>> +
> >>>>>>          if (device->wake_override !=3D WAKE_FLAG_DEFAULT) {
> >>>>>>              g_key_file_set_boolean(key_file, "General", "WakeAllo=
wed",
> >>>>>>                             device->wake_override =3D=3D
> >>>>>> @@ -1829,7 +1833,11 @@ static void bonding_request_cancel(struct
> >>>>>> bonding_req *bonding)
> >>>>>>          struct btd_device *device =3D bonding->device;
> >>>>>>          struct btd_adapter *adapter =3D device->adapter;
> >>>>>>
> >>>>>> -    adapter_cancel_bonding(adapter, &device->bdaddr, device->bdad=
dr_type);
> >>>>>> +    if (device->derived_key) {
> >>>>>> +        adapter_cancel_bonding(adapter, &device->bdaddr, BDADDR_B=
REDR);
> >>>>>> +        adapter_cancel_bonding(adapter, &device->bdaddr, BDADDR_L=
E_PUBLIC);
> >>>>>> +    } else
> >>>>>> +        adapter_cancel_bonding(adapter, &device->bdaddr,
> >>>>>> device->bdaddr_type);
> >>>>>>      }
> >>>>>>
> >>>>>>      static void dev_disconn_service(gpointer a, gpointer b)
> >>>>>> @@ -3196,12 +3204,19 @@ static DBusMessage
> >>>>>> *cancel_pairing(DBusConnection *conn, DBusMessage *msg,
> >>>>>>      {
> >>>>>>          struct btd_device *device =3D data;
> >>>>>>          struct bonding_req *req =3D device->bonding;
> >>>>>> +    uint8_t bdaddr_type;
> >>>>>>
> >>>>>>          DBG("");
> >>>>>>
> >>>>>>          if (!req) {
> >>>>>> -        btd_adapter_remove_bonding(device->adapter, &device->bdad=
dr,
> >>>>>> -                        device->bdaddr_type);
> >>>>>> +        if (device->derived_key) {
> >>>>>> +            btd_adapter_remove_bonding(device->adapter, &device->=
bdaddr,
> >>>>>> +                            BDADDR_BREDR);
> >>>>>> +            btd_adapter_remove_bonding(device->adapter, &device->=
bdaddr,
> >>>>>> +                            BDADDR_LE_PUBLIC);
> >>>>>> +        } else
> >>>>>> +            btd_adapter_remove_bonding(device->adapter, &device->=
bdaddr,
> >>>>>> +                            device->bdaddr_type);
> >>>>>>              return btd_error_does_not_exist(msg);
> >>>>>>          }
> >>>>>>
> >>>>>> @@ -3833,6 +3848,9 @@ next:
> >>>>>>              gerr =3D NULL;
> >>>>>>          }
> >>>>>>
> >>>>>> +    device->derived_key =3D g_key_file_get_boolean(key_file, "Gen=
eral",
> >>>>>> +                            "DerivedKey", NULL);
> >>>>>> +
> >>>>>>          if (store_needed)
> >>>>>>              store_device_info(device);
> >>>>>>      }
> >>>>>>
> >>>>>> On 2024/8/27 5:12, Luiz Augusto von Dentz wrote:
> >>>>>>> Hi Xiao,
> >>>>>>>
> >>>>>>> On Fri, Dec 15, 2023 at 8:06=E2=80=AFPM Robin Candau <antiz@archl=
inux.org> wrote:
> >>>>>>>>
> >>>>>>>> On 12/11/23 17:27, Xiao Yao wrote:
> >>>>>>>>
> >>>>>>>> From: Xiao Yao <xiaoyao@rock-chips.com>
> >>>>>>>>
> >>>>>>>> According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3,
> >>>>>>>> Part H, 2.4.24/2.4.25, The LE LTK and BR/EDR link keys can be
> >>>>>>>> converted between each other, so the addr type can be either
> >>>>>>>> BREDR or LE, so fix it.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> >>>>>>>> ---
> >>>>>>>>      src/adapter.c | 20 ++++++++++++++------
> >>>>>>>>      1 file changed, 14 insertions(+), 6 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/src/adapter.c b/src/adapter.c
> >>>>>>>> index 86fff72bc..ee70b00d2 100644
> >>>>>>>> --- a/src/adapter.c
> >>>>>>>> +++ b/src/adapter.c
> >>>>>>>> @@ -170,6 +170,7 @@ static GSList *conn_fail_list =3D NULL;
> >>>>>>>>
> >>>>>>>>      struct link_key_info {
> >>>>>>>>       bdaddr_t bdaddr;
> >>>>>>>> + uint8_t bdaddr_type;
> >>>>>>>>       unsigned char key[16];
> >>>>>>>>       uint8_t type;
> >>>>>>>>       uint8_t pin_len;
> >>>>>>>> @@ -3964,7 +3965,9 @@ static bool is_blocked_key(uint8_t key_typ=
e, uint8_t *key_value)
> >>>>>>>>       return false;
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> -static struct link_key_info *get_key_info(GKeyFile *key_file, c=
onst char *peer)
> >>>>>>>> +static struct link_key_info *get_key_info(GKeyFile *key_file, c=
onst char *peer,
> >>>>>>>> + uint8_t bdaddr_type)
> >>>>>>>> +
> >>>>>>>>      {
> >>>>>>>>       struct link_key_info *info =3D NULL;
> >>>>>>>>       char *str;
> >>>>>>>> @@ -3976,6 +3979,7 @@ static struct link_key_info *get_key_info(=
GKeyFile *key_file, const char *peer)
> >>>>>>>>       info =3D g_new0(struct link_key_info, 1);
> >>>>>>>>
> >>>>>>>>       str2ba(peer, &info->bdaddr);
> >>>>>>>> + info->bdaddr_type =3D bdaddr_type;
> >>>>>>>>
> >>>>>>>>       if (!strncmp(str, "0x", 2))
> >>>>>>>>       str2buf(&str[2], info->key, sizeof(info->key));
> >>>>>>>> @@ -4343,7 +4347,7 @@ static void load_link_keys(struct btd_adap=
ter *adapter, GSList *keys,
> >>>>>>>>       struct link_key_info *info =3D l->data;
> >>>>>>>>
> >>>>>>>>       bacpy(&key->addr.bdaddr, &info->bdaddr);
> >>>>>>>> - key->addr.type =3D BDADDR_BREDR;
> >>>>>>>> + key->addr.type =3D info->bdaddr_type;
> >>>>>>>>       key->type =3D info->type;
> >>>>>>>>       memcpy(key->val, info->key, 16);
> >>>>>>>>       key->pin_len =3D info->pin_len;
> >>>>>>>> @@ -4598,14 +4602,18 @@ static void load_conn_params(struct btd_=
adapter *adapter, GSList *params)
> >>>>>>>>       btd_error(adapter->dev_id, "Load connection parameters fai=
led");
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> -static uint8_t get_le_addr_type(GKeyFile *keyfile)
> >>>>>>>> +static uint8_t get_addr_type(GKeyFile *keyfile)
> >>>>>>>>      {
> >>>>>>>>       uint8_t addr_type;
> >>>>>>>>       char *type;
> >>>>>>>>
> >>>>>>>> + /* The AddressType is written to file only When dev->le is
> >>>>>>>> + * set to true, as referenced in the update_technologies().
> >>>>>>>> + * Therefore, When type is NULL, it default to BDADDR_BREDR.
> >>>>>>>> + */
> >>>>>>>>       type =3D g_key_file_get_string(keyfile, "General", "Addres=
sType", NULL);
> >>>>>>>>       if (!type)
> >>>>>>>> - return BDADDR_LE_PUBLIC;
> >>>>>>>> + return BDADDR_BREDR;
> >>>>>>>>
> >>>>>>>>       if (g_str_equal(type, "public"))
> >>>>>>>>       addr_type =3D BDADDR_LE_PUBLIC;
> >>>>>>>> @@ -4914,9 +4922,9 @@ static void load_devices(struct btd_adapte=
r *adapter)
> >>>>>>>>       g_clear_error(&gerr);
> >>>>>>>>       }
> >>>>>>>>
> >>>>>>>> - key_info =3D get_key_info(key_file, entry->d_name);
> >>>>>>>> + bdaddr_type =3D get_addr_type(key_file);
> >>>>>>>>
> >>>>>>>> - bdaddr_type =3D get_le_addr_type(key_file);
> >>>>>>>> + key_info =3D get_key_info(key_file, entry->d_name, bdaddr_type=
);
> >>>>>>>>
> >>>>>>>>       ltk_info =3D get_ltk_info(key_file, entry->d_name, bdaddr_=
type);
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Hello,
> >>>>>>>>
> >>>>>>>> It seems like the above commit introduced a regression where the=
 initial auto-connect for Bluetooth devices doesn't work anymore.
> >>>>>>>>
> >>>>>>>> Indeed, at system startup, starting a Bluetooth device will caus=
e it to go in a "connected/disconnected" state loop, requiring to initializ=
e a manual connection first (with sometimes multiple attempts needed) befor=
e getting it connected correctly and working as intended.
> >>>>>>>>
> >>>>>>>> `systemctl status bluetooth` reports the following error:
> >>>>>>>>
> >>>>>>>> [...]
> >>>>>>>> d=C3=A9c. 15 11:03:18 Arch-Desktop bluetoothd[592]: Failed to lo=
ad link keys for hci0: Invalid Parameters (0x0d)
> >>>>>>>> [...]
> >>>>>>>>
> >>>>>>>> I bisected the bug with `git bisect` and it pointed out this com=
mit [1] as the "faulty" one.
> >>>>>>>> I can confirm that reverting it solves the issue.
> >>>>>>>>
> >>>>>>>> I reported this bug including details in the GitHub repo [2].
> >>>>>>>>
> >>>>>>>> I remain available if any additional information are needed.
> >>>>>>>>
> >>>>>>>> [1] https://github.com/bluez/bluez/commit/d5536e0cd431e22be9a113=
2be6d4af2445590633
> >>>>>>>> [2] https://github.com/bluez/bluez/issues/686
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> Regards,
> >>>>>>>> Robin Candau / Antiz
> >>>>>>>
> >>>>>>> Perhaps related to:
> >>>>>>> https://github.com/bluez/bluez/issues/875#issuecomment-2311100872=
?
> >>>>>>
> >>>>>
> >>>>>
> >>>>
> >>>
> >>>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz

Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83EF242D70
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976343; cv=pass; b=EiGHS/wH6mhHhy8pGi+iUnNs2qE7OUilM2g1GTZlY5KYZhHpzDk282N3htP3mW/UWGfnA5IIF8Nn/E4SvfCyrTnhRwpdbo9gAyBHtumZIdGif4J/4TLGMP5s6B64FOXqGRO20tEFP1cJoG0P8b3B94WRJKH/gNGFYpxuWZsJHvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976343; c=relaxed/simple;
	bh=MrADaeTCBL5NKlF6RmpdBqcdo0YwpOS6R1YDLUdOIDE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=UEozvCACxRsh8CVvq13nSI7pRJwl5cLED2pMuLcFKZNttSV/wCxqE8dyLLyYJn95tzkxaZfBPodrbq+t9lbbiuKpHXH6VrUEuVSdh72bFmBniXRVOEhJdyewRLJEup9E2ug3pny8KLbpG0j4k0P4E3fs3g6lh/I35O5CRBuDktw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=FIOekFHf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="FIOekFHf"
ARC-Seal: i=1; a=rsa-sha256; t=1776976337; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vt/ajSMeUGjgxvKYKJ9ZJm8CEN+M6KRcetMT8CLuA3Vnf0vnzw5R/eMb1hLXS+VPoBhnmZ+faLxEN/1adiIH0YGvmzva7PpVGadVux63FzmX64QrFU7Ge4QoFXOICJG+DJath15IecWEOJzNR31QEXwf3UDowkUMohilikSWp7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776976337; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tzsmULadt6WnZJ487eerS0TZnWL6I2Digz2btENqzBw=; 
	b=PbaGhb5njIg+kO/sxaL4cBsNQGuzZY0c9DvycteJvyNP8euwV+MtwkXiWN1IkWRTW7+z08pyWKIcbn6hDa2MqoQTGwuJFJtrwnf7V4RUPFoBju47TvVD9Ds1zeDBbwOP+Ve+k08QjLkb0bWNsn80h5tePWoq6UGjGBc0X1+Rt+w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776976337;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Content-Type:Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Message-Id:Reply-To;
	bh=tzsmULadt6WnZJ487eerS0TZnWL6I2Digz2btENqzBw=;
	b=FIOekFHf4IvMB6MgxL+WnTzAJ3ogK9QcU8uVgzpCL1JeXPPxBAK5dn3Q5S7lJCRN
	jWUygr/PRIq2R09G0Dd4bo/KkF2OiU/9PK9SOQpWZ2koKuosFwtuAJUNgVA+CEdQWHh
	eQVjk9I5Elx4foLBgwzwOLQmb9nXF7C9VD/f0zpM=
Received: by mx.zohomail.com with SMTPS id 1776976334997839.3980825659667;
	Thu, 23 Apr 2026 13:32:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------RdMapeDQjbOZjRreQhiva14u"
Message-ID: <4834629e-72f0-4917-870b-0e5929d36796@collabora.com>
Date: Thu, 23 Apr 2026 22:32:12 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 1/3] audio: Add ability to force CIS transport
 Links property
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20260423075309.493820-1-frederic.danis@collabora.com>
 <CABBYNZKiNU88wK+oMT2Q7nKOr7NsngFD4+C35-agcbntJXsJ2g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZKiNU88wK+oMT2Q7nKOr7NsngFD4+C35-agcbntJXsJ2g@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/276.955.47
X-ZohoMailClient: External

This is a multi-part message in MIME format.
--------------RdMapeDQjbOZjRreQhiva14u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 23/04/2026 19:08, Luiz Augusto von Dentz wrote:
> Hi Frederic,
>
> On Thu, Apr 23, 2026 at 3:53 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> If bluetoothd is started in testing mode the Links property for CIS
>> is readwrite and can be used to force transport objects Links.
>> This can used to unlink transport objects by sending an empty array.
>>
>> For unlinked transport objects, each transports needs to be acquired
>> separately.
>>
>> This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.
>> ---
>> v1 -> v2:
>>    - Add testing mode check in bap_connect_io_cb()
>>    - Replace stream state check by checking that the stream is not linked
>>      before passing the connect event to all streams belonging to same
>>      CIG/CIS.
>>
>>   profiles/audio/bap.c       | 46 ++++++++++++++++++++++++++++++
>>   profiles/audio/transport.c | 57 +++++++++++++++++++++++++++++++-------
>>   2 files changed, 95 insertions(+), 10 deletions(-)
>>
>> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
>> index 5333267f7..e20456436 100644
>> --- a/profiles/audio/bap.c
>> +++ b/profiles/audio/bap.c
>> @@ -2655,13 +2655,61 @@ static void bap_connect_bcast_io_cb(GIOChannel *chan, GError *err,
>>          iso_connect_bcast_cb(chan, err, setup->stream);
>>   }
>>
>> +struct connect_io_data {
>> +       GIOChannel *chan;
>> +       GError *err;
>> +       uint8_t cig_id;
>> +       uint8_t cis_id;
>> +};
>> +
>> +static void connect_stream(void *data, void *user_data)
>> +{
>> +       struct bap_setup *setup = data;
>> +       struct connect_io_data *d = user_data;
>> +       uint8_t state;
>> +
>> +       /* Check stream state to only pass the connect event managed
>> +        * by bap_stream_set_io() */
>> +       state = bt_bap_stream_get_state(setup->stream);
>> +       if ((state == BT_BAP_STREAM_STATE_ENABLING ||
>> +                       state == BT_BAP_STREAM_STATE_DISABLING) &&
>> +                       setup->qos.ucast.cig_id == d->cig_id &&
>> +                       setup->qos.ucast.cis_id == d->cis_id)
>> +               iso_connect_cb(d->chan, d->err, setup->stream);
>  From the discussion we had Ive assume we wouldn't be checking the
> state here, since we don't check on bap_connect_io_cb either.
If the state is not checked this prevents to complete the transport 
acquire, ending with:
- for BV-543-C: profiles/audio/bap.c:setup_connect_io() setup 
0x50f000007a20 stream 0x50e000010dc0 io already up
- for BV-546-C: profiles/audio/bap.c:bap_state() stream 0x50e00000a5a0: 
enabling(3) -> disabling(5)
see attached files.
>
>> +}
>> +
>> +static void connect_ep(void *data, void *user_data)
>> +{
>> +       struct bap_ep *ep = data;
>> +
>> +       if (ep->setups)
>> +               queue_foreach(ep->setups, connect_stream, user_data);
>> +}
>> +
>>   static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer user_data)
>>   {
>>          struct bap_setup *setup = user_data;
>> +       struct connect_io_data data;
>>
>>          if (!setup->stream)
>>                  return;
>>
>> +       if (queue_isempty(bt_bap_stream_io_get_links(setup->stream)) &&
>> +               btd_opts.testing) {
>> +               /* The stream may have manually been unliked for PTS tests,
>> +                * e.g. BAP/UCL/STR/BV-543-C or BAP/UCL/STR/BV-546-C,
>> +                * in this case send the connect event to all streams
>> +                * belonging to the same CIG/CIS.
>> +                */
>> +               data.chan = chan;
>> +               data.err = err;
>> +               data.cig_id = setup->qos.ucast.cig_id;
>> +               data.cis_id = setup->qos.ucast.cis_id;
>> +               queue_foreach(setup->ep->data->snks, connect_ep, &data);
>> +               queue_foreach(setup->ep->data->srcs, connect_ep, &data);
>> +               return;
>> +       }
>> +
>>          iso_connect_cb(chan, err, setup->stream);
>>   }
>>
>> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
>> index 5c2a2777e..b6a5dd1fd 100644
>> --- a/profiles/audio/transport.c
>> +++ b/profiles/audio/transport.c
>> @@ -37,6 +37,7 @@
>>   #include "src/shared/bap.h"
>>   #include "src/shared/bass.h"
>>   #include "src/shared/io.h"
>> +#include "src/btd.h"
>>
>>   #ifdef HAVE_A2DP
>>   #include "avdtp.h"
>> @@ -114,6 +115,7 @@ struct bap_transport {
>>   struct media_transport_ops {
>>          const char *uuid;
>>          const GDBusPropertyTable *properties;
>> +       const GDBusPropertyTable *test_properties;
>>          void (*set_owner)(struct media_transport *transport,
>>                                  struct media_owner *owner);
>>          void (*remove_owner)(struct media_transport *transport,
>> @@ -1419,6 +1421,9 @@ static struct media_transport *find_transport_by_path(const char *path)
>>          return NULL;
>>   }
>>
>> +static void bap_update_links(const struct media_transport *transport);
>> +static void transport_unlink(void *data, void *user_data);
>> +
>>   static void set_links(const GDBusPropertyTable *property,
>>                                  DBusMessageIter *iter,
>>                                  GDBusPendingPropertySet id, void *user_data)
>> @@ -1436,6 +1441,16 @@ static void set_links(const GDBusPropertyTable *property,
>>
>>          dbus_message_iter_recurse(iter, &array);
>>
>> +       if (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_INVALID) {
>> +               struct queue *links = bt_bap_stream_io_get_links(bap->stream);
>> +
>> +               /* Unlink stream from all its links */
>> +               queue_foreach(links, transport_unlink, bap->stream);
>> +
>> +               bt_bap_stream_io_unlink(bap->stream, NULL);
>> +               bap_update_links(transport);
>> +       }
>> +
>>          while (dbus_message_iter_get_arg_type(&array) ==
>>                                                  DBUS_TYPE_OBJECT_PATH) {
>>                  struct media_transport *link;
>> @@ -1486,6 +1501,21 @@ static const GDBusPropertyTable transport_bap_uc_properties[] = {
>>          { }
>>   };
>>
>> +static const GDBusPropertyTable transport_bap_uc_test_properties[] = {
>> +       { "Device", "o", get_device },
>> +       { "UUID", "s", get_uuid },
>> +       { "Codec", "y", get_codec },
>> +       { "Configuration", "ay", get_configuration },
>> +       { "State", "s", get_state },
>> +       { "QoS", "a{sv}", get_ucast_qos, NULL, qos_ucast_exists },
>> +       { "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
>> +       { "Location", "u", get_location },
>> +       { "Metadata", "ay", get_metadata, set_metadata },
>> +       { "Links", "ao", get_links, set_links, links_exists },
>> +       { "Volume", "q", get_volume, set_volume, volume_exists },
>> +       { }
>> +};
>> +
>>   static gboolean get_bcast_qos(const GDBusPropertyTable *property,
>>                                          DBusMessageIter *iter, void *data)
>>   {
>> @@ -1884,8 +1914,6 @@ static void bap_resume_complete(struct media_transport *transport)
>>          transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
>>   }
>>
>> -static void bap_update_links(const struct media_transport *transport);
>> -
>>   static bool match_link_transport(const void *data, const void *user_data)
>>   {
>>          const struct bt_bap_stream *stream = data;
>> @@ -2540,10 +2568,11 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
>>   #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
>>                        _resume, _suspend, _cancel, _set_state, _get_stream, \
>>                        _get_volume, _set_volume, _set_delay, _update_links, \
>> -                     _destroy) \
>> +                     _destroy, _test_props) \
>>   { \
>>          .uuid = _uuid, \
>>          .properties = _props, \
>> +       .test_properties = _test_props, \
>>          .set_owner = _set_owner, \
>>          .remove_owner = _remove_owner, \
>>          .init = _init, \
>> @@ -2565,26 +2594,28 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
>>                          transport_a2dp_resume, transport_a2dp_suspend, \
>>                          transport_a2dp_cancel, NULL, \
>>                          transport_a2dp_get_stream, transport_a2dp_get_volume, \
>> -                       _set_volume, _set_delay, NULL, _destroy)
>> +                       _set_volume, _set_delay, NULL, _destroy, NULL)
>>
>>   #define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links, \
>> -               _set_state) \
>> +               _set_state, _test_props) \
>>          TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner,\
>>                          transport_bap_init, \
>>                          transport_bap_resume, transport_bap_suspend, \
>>                          transport_bap_cancel, _set_state, \
>>                          transport_bap_get_stream, transport_bap_get_volume, \
>>                          transport_bap_set_volume, NULL, \
>> -                       _update_links, transport_bap_destroy)
>> +                       _update_links, transport_bap_destroy, _test_props)
>>
>>   #define BAP_UC_OPS(_uuid) \
>>          BAP_OPS(_uuid, transport_bap_uc_properties, \
>>                          transport_bap_set_owner, transport_bap_remove_owner, \
>> -                       transport_bap_update_links_uc, transport_bap_set_state)
>> +                       transport_bap_update_links_uc, \
>> +                       transport_bap_set_state, \
>> +                       transport_bap_uc_test_properties)
>>
>>   #define BAP_BC_OPS(_uuid) \
>>          BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL, \
>> -                       transport_bap_update_links_bc, NULL)
>> +                       transport_bap_update_links_bc, NULL, NULL)
>>
>>   #define ASHA_OPS(_uuid) \
>>          TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
>> @@ -2592,7 +2623,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
>>                          transport_asha_resume, transport_asha_suspend, \
>>                          transport_asha_cancel, NULL, NULL, \
>>                          transport_asha_get_volume, transport_asha_set_volume, \
>> -                       NULL, NULL, NULL)
>> +                       NULL, NULL, NULL, NULL)
>>
>>   static const struct media_transport_ops transport_ops[] = {
>>   #ifdef HAVE_A2DP
>> @@ -2647,6 +2678,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
>>          struct media_transport *transport;
>>          const struct media_transport_ops *ops;
>>          int fd;
>> +       const GDBusPropertyTable *properties;
>>
>>          transport = g_new0(struct media_transport, 1);
>>          if (device)
>> @@ -2701,9 +2733,14 @@ struct media_transport *media_transport_create(struct btd_device *device,
>>                          goto fail;
>>          }
>>
>> +       if (btd_opts.testing && ops->test_properties)
>> +               properties = ops->test_properties;
>> +       else
>> +               properties = ops->properties;
>> +
>>          if (g_dbus_register_interface(btd_get_dbus_connection(),
>>                                  transport->path, MEDIA_TRANSPORT_INTERFACE,
>> -                               transport_methods, NULL, ops->properties,
>> +                               transport_methods, NULL, properties,
>>                                  transport, media_transport_free) == FALSE) {
>>                  error("Could not register transport %s", transport->path);
>>                  goto fail;
>> --
>> 2.43.0
>>
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


--------------RdMapeDQjbOZjRreQhiva14u
Content-Type: text/x-log; charset=UTF-8; name="no-state-check-543.log"
Content-Disposition: attachment; filename="no-state-check-543.log"
Content-Transfer-Encoding: base64

Ymx1ZXRvb3RoZFs0ODc3MjZdOiBbOjEuNTMwNDptZXRob2RfY2FsbF0gPiBvcmcuYmx1ZXou
TWVkaWFUcmFuc3BvcnQxLkFjcXVpcmUgWyMxMDFdCmJsdWV0b290aGRbNDg3NzI2XTogcHJv
ZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfb3duZXJfY3JlYXRlKCkgT3duZXIgY3Jl
YXRlZDogc2VuZGVyPToxLjUzMDQKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRp
by90cmFuc3BvcnQuYzptZWRpYV90cmFuc3BvcnRfcmVzdW1lKCkgVHJhbnNwb3J0IC9vcmcv
Ymx1ZXovaGNpMC9kZXZfOUNfNDdfMkFfMzlfNTZfRkUvcGFjX3NpbmswL2ZkMCBPd25lciA6
MS41MzA0CmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBfcXVldWVf
cmVxKCkgcmVxIDB4NTA2MDAwMDhjMzYwIChvcCAweDAzKSBxdWV1ZSAweDUwMzAwMDBiYzY1
MApibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOnRyYW5z
cG9ydF9zZXRfc3RhdGUoKSBTdGF0ZSBjaGFuZ2VkIC9vcmcvYmx1ZXovaGNpMC9kZXZfOUNf
NDdfMkFfMzlfNTZfRkUvcGFjX3NpbmswL2ZkMDogVFJBTlNQT1JUX1NUQVRFX0lETEUgLT4g
VFJBTlNQT1JUX1NUQVRFX1JFUVVFU1RJTkcKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxl
cy9hdWRpby90cmFuc3BvcnQuYzptZWRpYV9yZXF1ZXN0X2NyZWF0ZSgpIFJlcXVlc3QgY3Jl
YXRlZDogbWV0aG9kPUFjcXVpcmUgaWQ9MjMKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxl
cy9hdWRpby90cmFuc3BvcnQuYzptZWRpYV9vd25lcl9hZGQoKSBPd25lciA6MS41MzA0IFJl
cXVlc3QgQWNxdWlyZQpibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5z
cG9ydC5jOm1lZGlhX3RyYW5zcG9ydF9zZXRfb3duZXIoKSBUcmFuc3BvcnQgL29yZy9ibHVl
ei9oY2kwL2Rldl85Q180N18yQV8zOV81Nl9GRS9wYWNfc2luazAvZmQwIE93bmVyIDoxLjUz
MDQKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMvc2hhcmVkL2JhcC5jOmJhcF9wcm9jZXNzX3F1
ZXVlKCkgCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBfc2VuZCgp
IHJlcSAweDUwNjAwMDA4YzM2MCBsZW4gOApibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9zaGFy
ZWQvYXR0LmM6Y2FuX3JlYWRfZGF0YSgpIChjaGFuIDB4NTA4MDAwMDE2MmEwKSBBVFQgUERV
IHJlY2VpdmVkOiAweDFiCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpi
YXBfcHJvY2Vzc19xdWV1ZSgpIApibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9zaGFyZWQvYXR0
LmM6Y2FuX3JlYWRfZGF0YSgpIChjaGFuIDB4NTA4MDAwMDE2MmEwKSBBVFQgUERVIHJlY2Vp
dmVkOiAweDFiCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBfZXBf
c2V0X3N0YXR1cygpIEFTRSBzdGF0dXM6IGVwIDB4NTA0MDAwMDU5NjkwIGlkIDB4MDEgaGFu
ZGxlIDB4MDEyMSBzdGF0ZSBlbmFibGluZyBsZW4gNwpibHVldG9vdGhkWzQ4NzcyNl06IHNy
Yy9zaGFyZWQvYmFwLmM6ZXBfc3RhdHVzX21ldGFkYXRhKCkgQ0lTIDB4MDAgQ0lHIDB4MDAg
bWV0YWRhdGEgbGVuIDQKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9iYXAu
YzpiYXBfc3RhdGUoKSBzdHJlYW0gMHg1MGUwMDAwMTBlYTA6IHFvcygyKSAtPiBlbmFibGlu
ZygzKQpibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOmJh
cF9zdGF0ZV9jaGFuZ2VkKCkgc3RyZWFtIDB4NTBlMDAwMDEwZWEwOiBxb3MoMikgLT4gZW5h
YmxpbmcoMykKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9iYXAuYzpiYXBf
dXBkYXRlX2NpZygpIGFkYXB0ZXIgMHg1MTMwMDAwMDAyMDAgQ0lHIDB4MApibHVldG9vdGhk
WzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2JhcC5jOnVwZGF0ZV9jaWdfc2V0dXBfZW5hYmxl
KCkgMHg1MGYwMDAwMDc5MzAKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9i
YXAuYzpzZXR1cF9jcmVhdGVfaW8oKSBzZXR1cCAweDUwZjAwMDAwNzkzMCBzdHJlYW0gMHg1
MGUwMDAwMTBlYTAgZGVmZXIgZmFsc2UKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMvc2hhcmVk
L2JhcC5jOmJ0X2JhcF9zdHJlYW1faW9fZ2V0X3FvcygpIGluIChuaWwpIG91dCAweDUwZTAw
MDAxMGVkOApibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2JhcC5jOnNldHVw
X2FjY2VwdF9pbygpIHN0cmVhbSAweDUwZTAwMDAxMGVhMCBmZCAyNiBkZWZlciB0cnVlCmJs
dWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vYmFwLmM6aXNvX2Nvbm5lY3RfY2Io
KSBJU08gY29ubmVjdGVkCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vYmFw
LmM6aXNvX2Nvbm5lY3RfY2IoKSBJU08gY29ubmVjdGVkCmJsdWV0b290aGRbNDg3NzI2XTog
cHJvZmlsZXMvYXVkaW8vYmFwLmM6aXNvX2Nvbm5lY3RfY2IoKSBVbmFibGUgdG8gc2V0IElP
CmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBfc3RyZWFtX2lvX2Rl
dGFjaCgpIHN0cmVhbSAweDUwZTAwMDAxMGRjMApibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9z
aGFyZWQvYXR0LmM6Y2FuX3JlYWRfZGF0YSgpIChjaGFuIDB4NTA4MDAwMDE2MmEwKSBBVFQg
UERVIHJlY2VpdmVkOiAweDFiCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAu
YzpiYXBfZXBfc2V0X3N0YXR1cygpIEFTRSBzdGF0dXM6IGVwIDB4NTA0MDAwMDU5NjkwIGlk
IDB4MDEgaGFuZGxlIDB4MDEyMSBzdGF0ZSBzdHJlYW1pbmcgbGVuIDcKYmx1ZXRvb3RoZFs0
ODc3MjZdOiBzcmMvc2hhcmVkL2JhcC5jOmVwX3N0YXR1c19tZXRhZGF0YSgpIENJUyAweDAw
IENJRyAweDAwIG1ldGFkYXRhIGxlbiA0CmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMv
YXVkaW8vYmFwLmM6YmFwX3N0YXRlKCkgc3RyZWFtIDB4NTBlMDAwMDEwZWEwOiBlbmFibGlu
ZygzKSAtPiBzdHJlYW1pbmcoNCkKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRp
by90cmFuc3BvcnQuYzpiYXBfc3RhdGVfY2hhbmdlZCgpIHN0cmVhbSAweDUwZTAwMDAxMGVh
MDogZW5hYmxpbmcoMykgLT4gc3RyZWFtaW5nKDQpCmJsdWV0b290aGRbNDg3NzI2XTogcHJv
ZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6YmFwX21ldGFkYXRhX2NoYW5nZWQoKSBzdHJlYW0g
MHg1MGUwMDAwMTBlYTA6IG1ldGFkYXRhIDB4NTAyMDAwMGY0OTEwIG9sZCAobmlsKQpibHVl
dG9vdGhkWzQ4NzcyNl06IC9vcmcvYmx1ZXovaGNpMC9kZXZfOUNfNDdfMkFfMzlfNTZfRkUv
cGFjX3NpbmswL2ZkMDogZmQoMjYpIHJlYWR5CmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmls
ZXMvYXVkaW8vdHJhbnNwb3J0LmM6dHJhbnNwb3J0X3VwZGF0ZV9wbGF5aW5nKCkgL29yZy9i
bHVlei9oY2kwL2Rldl85Q180N18yQV8zOV81Nl9GRS9wYWNfc2luazAvZmQwIFN0YXRlPVRS
QU5TUE9SVF9TVEFURV9SRVFVRVNUSU5HIFBsYXlpbmc9MQpibHVldG9vdGhkWzQ4NzcyNl06
IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOmJhcF9yZXN1bWVfY29tcGxldGUoKSBzdHJl
YW0gMHg1MGUwMDAwMTBlYTAgb3duZXIgMHg1MDMwMDAwZDg3MDAgcmVzdW1lIGNvbXBsZXRl
CmJsdWV0b290aGRbNDg3NzI2XTogW3NpZ25hbF0gb3JnLmZyZWVkZXNrdG9wLkRCdXMuUHJv
cGVydGllcy5Qcm9wZXJ0aWVzQ2hhbmdlZApibHVldG9vdGhkWzQ4NzcyNl06IFs6MS41MzA0
Om1ldGhvZF9yZXR1cm5dIDwgWyMxMDFdCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMv
YXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfb3duZXJfcmVtb3ZlKCkgT3duZXIgOjEuNTMwNCBS
ZXF1ZXN0IEFjcXVpcmUKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby90cmFu
c3BvcnQuYzp0cmFuc3BvcnRfc2V0X3N0YXRlKCkgU3RhdGUgY2hhbmdlZCAvb3JnL2JsdWV6
L2hjaTAvZGV2XzlDXzQ3XzJBXzM5XzU2X0ZFL3BhY19zaW5rMC9mZDA6IFRSQU5TUE9SVF9T
VEFURV9SRVFVRVNUSU5HIC0+IFRSQU5TUE9SVF9TVEFURV9BQ1RJVkUKYmx1ZXRvb3RoZFs0
ODc3MjZdOiBbc2lnbmFsXSBvcmcuZnJlZWRlc2t0b3AuREJ1cy5Qcm9wZXJ0aWVzLlByb3Bl
cnRpZXNDaGFuZ2VkCmJsdWV0b290aGRbNDg3NzI2XTogWzoxLjUzMDQ6bWV0aG9kX2NhbGxd
ID4gb3JnLmJsdWV6Lk1lZGlhVHJhbnNwb3J0MS5BY3F1aXJlIFsjMTAyXQpibHVldG9vdGhk
WzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOm1lZGlhX293bmVyX2NyZWF0
ZSgpIE93bmVyIGNyZWF0ZWQ6IHNlbmRlcj06MS41MzA0CmJsdWV0b290aGRbNDg3NzI2XTog
cHJvZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfdHJhbnNwb3J0X3Jlc3VtZSgpIFRy
YW5zcG9ydCAvb3JnL2JsdWV6L2hjaTAvZGV2XzlDXzQ3XzJBXzM5XzU2X0ZFL3BhY19zb3Vy
Y2UwL2ZkMSBPd25lciA6MS41MzA0CmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9i
YXAuYzpiYXBfcXVldWVfcmVxKCkgcmVxIDB4NTA2MDAwMDhjOGEwIChvcCAweDAzKSBxdWV1
ZSAweDUwMzAwMDBiYzY1MApibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3Ry
YW5zcG9ydC5jOnRyYW5zcG9ydF9zZXRfc3RhdGUoKSBTdGF0ZSBjaGFuZ2VkIC9vcmcvYmx1
ZXovaGNpMC9kZXZfOUNfNDdfMkFfMzlfNTZfRkUvcGFjX3NvdXJjZTAvZmQxOiBUUkFOU1BP
UlRfU1RBVEVfSURMRSAtPiBUUkFOU1BPUlRfU1RBVEVfUkVRVUVTVElORwpibHVldG9vdGhk
WzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOm1lZGlhX3JlcXVlc3RfY3Jl
YXRlKCkgUmVxdWVzdCBjcmVhdGVkOiBtZXRob2Q9QWNxdWlyZSBpZD0yNApibHVldG9vdGhk
WzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOm1lZGlhX293bmVyX2FkZCgp
IE93bmVyIDoxLjUzMDQgUmVxdWVzdCBBY3F1aXJlCmJsdWV0b290aGRbNDg3NzI2XTogcHJv
ZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfdHJhbnNwb3J0X3NldF9vd25lcigpIFRy
YW5zcG9ydCAvb3JnL2JsdWV6L2hjaTAvZGV2XzlDXzQ3XzJBXzM5XzU2X0ZFL3BhY19zb3Vy
Y2UwL2ZkMSBPd25lciA6MS41MzA0CmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9i
YXAuYzpiYXBfcHJvY2Vzc19xdWV1ZSgpIApibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9zaGFy
ZWQvYmFwLmM6YmFwX3NlbmQoKSByZXEgMHg1MDYwMDAwOGM4YTAgbGVuIDgKYmx1ZXRvb3Ro
ZFs0ODc3MjZdOiBzcmMvc2hhcmVkL2F0dC5jOmNhbl9yZWFkX2RhdGEoKSAoY2hhbiAweDUw
ODAwMDAxNjJhMCkgQVRUIFBEVSByZWNlaXZlZDogMHgxYgpibHVldG9vdGhkWzQ4NzcyNl06
IHNyYy9zaGFyZWQvYmFwLmM6YmFwX3Byb2Nlc3NfcXVldWUoKSAKYmx1ZXRvb3RoZFs0ODc3
MjZdOiBzcmMvc2hhcmVkL2F0dC5jOmNhbl9yZWFkX2RhdGEoKSAoY2hhbiAweDUwODAwMDAx
NjJhMCkgQVRUIFBEVSByZWNlaXZlZDogMHgxYgpibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9z
aGFyZWQvYmFwLmM6YmFwX2VwX3NldF9zdGF0dXMoKSBBU0Ugc3RhdHVzOiBlcCAweDUwNDAw
MDA1OTc5MCBpZCAweDBhIGhhbmRsZSAweDAxMjcgc3RhdGUgZW5hYmxpbmcgbGVuIDcKYmx1
ZXRvb3RoZFs0ODc3MjZdOiBzcmMvc2hhcmVkL2JhcC5jOmVwX3N0YXR1c19tZXRhZGF0YSgp
IENJUyAweDAwIENJRyAweDAwIG1ldGFkYXRhIGxlbiA0CmJsdWV0b290aGRbNDg3NzI2XTog
cHJvZmlsZXMvYXVkaW8vYmFwLmM6YmFwX3N0YXRlKCkgc3RyZWFtIDB4NTBlMDAwMDEwZGMw
OiBxb3MoMikgLT4gZW5hYmxpbmcoMykKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9h
dWRpby90cmFuc3BvcnQuYzpiYXBfc3RhdGVfY2hhbmdlZCgpIHN0cmVhbSAweDUwZTAwMDAx
MGRjMDogcW9zKDIpIC0+IGVuYWJsaW5nKDMpCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmls
ZXMvYXVkaW8vYmFwLmM6YmFwX3VwZGF0ZV9jaWcoKSBhZGFwdGVyIDB4NTEzMDAwMDAwMjAw
IENJRyAweDAKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9iYXAuYzpiYXBf
dXBkYXRlX2NpZygpIHNldHVwIDB4NTBmMDAwMDA3OTMwIHN0cmVhbSAweDUwZTAwMDAxMGVh
MCBidXN5CmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vYmFwLmM6dXBkYXRl
X2NpZ19zZXR1cF9lbmFibGUoKSAweDUwZjAwMDAwN2EyMApibHVldG9vdGhkWzQ4NzcyNl06
IHByb2ZpbGVzL2F1ZGlvL2JhcC5jOnNldHVwX2NyZWF0ZV9pbygpIHNldHVwIDB4NTBmMDAw
MDA3YTIwIHN0cmVhbSAweDUwZTAwMDAxMGRjMCBkZWZlciBmYWxzZQpibHVldG9vdGhkWzQ4
NzcyNl06IHNyYy9zaGFyZWQvYmFwLmM6YnRfYmFwX3N0cmVhbV9pb19nZXRfcW9zKCkgaW4g
MHg1MGUwMDAwMTBkZjggb3V0IChuaWwpCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMv
YXVkaW8vYmFwLmM6c2V0dXBfY29ubmVjdF9pbygpIHNldHVwIDB4NTBmMDAwMDA3YTIwIHN0
cmVhbSAweDUwZTAwMDAxMGRjMCBpbyBhbHJlYWR5IHVwCgpibHVldG9vdGhkWzQ4NzcyNl06
IFs6MS40OTM6bWV0aG9kX2NhbGxdID4gb3JnLmJsdWV6LkRldmljZTEuRGlzY29ubmVjdCBb
IzQ5NTQ3XQpibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9kZXZpY2UuYzpkZXZpY2Vfc2V0X2F1
dG9fY29ubmVjdCgpIDlDOjQ3OjJBOjM5OjU2OkZFIGF1dG8gY29ubmVjdDogMApibHVldG9v
dGhkWzQ4NzcyNl06IHNyYy9zZXJ2aWNlLmM6Y2hhbmdlX3N0YXRlKCkgMHg1MDYwMDAwNzVk
NDA6IGRldmljZSA5Qzo0NzoyQTozOTo1NjpGRSBwcm9maWxlIHJhcCBzdGF0ZSBjaGFuZ2Vk
OiBjb25uZWN0ZWQgLT4gZGlzY29ubmVjdGluZyAoMCkKYmx1ZXRvb3RoZFs0ODc3MjZdOiBw
cm9maWxlcy9yYW5naW5nL3JhcC5jOnJhcF9kaXNjb25uZWN0KCkgIApibHVldG9vdGhkWzQ4
NzcyNl06IHNyYy9zZXJ2aWNlLmM6Y2hhbmdlX3N0YXRlKCkgMHg1MDYwMDAwNzVkNDA6IGRl
dmljZSA5Qzo0NzoyQTozOTo1NjpGRSBwcm9maWxlIHJhcCBzdGF0ZSBjaGFuZ2VkOiBkaXNj
b25uZWN0aW5nIC0+IGRpc2Nvbm5lY3RlZCAoMCkKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMv
c2VydmljZS5jOmNoYW5nZV9zdGF0ZSgpIDB4NTA2MDAwMDc1ZjIwOiBkZXZpY2UgOUM6NDc6
MkE6Mzk6NTY6RkUgcHJvZmlsZSBiYXAgc3RhdGUgY2hhbmdlZDogY29ubmVjdGVkIC0+IGRp
c2Nvbm5lY3RpbmcgKDApCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vYmFw
LmM6ZXBfdW5yZWdpc3RlcigpIGVwIDB4NTA2MDAwMDg5MWUwIHBhdGggL29yZy9ibHVlei9o
Y2kwL2Rldl85Q180N18yQV8zOV81Nl9GRS9wYWNfc2luazAKYmx1ZXRvb3RoZFs0ODc3MjZd
OiBwcm9maWxlcy9hdWRpby9iYXAuYzpzZXR1cF9mcmVlKCkgMHg1MGYwMDAwMDc5MzAKYmx1
ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9iYXAuYzpzZXR1cF9pb19jbG9zZSgp
IHNldHVwIDB4NTBmMDAwMDA3OTMwCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9i
YXAuYzpiYXBfc3RyZWFtX2lvX2RldGFjaCgpIHN0cmVhbSAweDUwZTAwMDAxMGVhMApibHVl
dG9vdGhkWzQ4NzcyNl06IHNyYy9zaGFyZWQvYmFwLmM6c3RyZWFtX2lvX2ZyZWUoKSBmZCAy
NgpibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9zaGFyZWQvYmFwLmM6YmFwX3F1ZXVlX3JlcSgp
IHJlcSAweDUwNjAwMDA4Y2M2MCAob3AgMHgwOCkgcXVldWUgMHg1MDMwMDAwYmM2NTAKYmx1
ZXRvb3RoZFs0ODc3MjZdOiBbc2lnbmFsXSBvcmcuZnJlZWRlc2t0b3AuREJ1cy5PYmplY3RN
YW5hZ2VyLkludGVyZmFjZXNSZW1vdmVkCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMv
YXVkaW8vYmFwLmM6ZXBfdW5yZWdpc3RlcigpIGVwIDB4NTA2MDAwMDg4ZjQwIHBhdGggL29y
Zy9ibHVlei9oY2kwL2Rldl85Q180N18yQV8zOV81Nl9GRS9wYWNfc291cmNlMApibHVldG9v
dGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2JhcC5jOnNldHVwX2ZyZWUoKSAweDUwZjAw
MDAwN2EyMApibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2JhcC5jOnNldHVw
X2lvX2Nsb3NlKCkgc2V0dXAgMHg1MGYwMDAwMDdhMjAKYmx1ZXRvb3RoZFs0ODc3MjZdOiBz
cmMvc2hhcmVkL2JhcC5jOmJhcF9xdWV1ZV9yZXEoKSByZXEgMHg1MDYwMDAwOGNkZTAgKG9w
IDB4MDgpIHF1ZXVlIDB4NTAzMDAwMGQ5NmYwCmJsdWV0b290aGRbNDg3NzI2XTogW3NpZ25h
bF0gb3JnLmZyZWVkZXNrdG9wLkRCdXMuT2JqZWN0TWFuYWdlci5JbnRlcmZhY2VzUmVtb3Zl
ZApibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9zaGFyZWQvYmFwLmM6YnRfYmFwX2RldGFjaCgp
IDB4NTEwMDAwMDA0MjQwCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpi
YXBfdWNhc3RfZGV0YWNoKCkgc3RyZWFtIDB4NTBlMDAwMDEwZGMwIGVwIDB4NTA0MDAwMDU5
NzkwCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vbWVkaWEuYzpwYWNfY2xl
YXIoKSBlbmRwb2ludCAweDUwZjAwMDAwNWE0MCBzdHJlYW0gMHg1MGUwMDAwMTBkYzAKYmx1
ZXRvb3RoZFs0ODc3MjZdOiBbOjEuNTMwNDptZXRob2RfY2FsbF0gPCBvcmcuYmx1ZXouTWVk
aWFFbmRwb2ludDEuQ2xlYXJDb25maWd1cmF0aW9uCmJsdWV0b290aGRbNDg3NzI2XTogcHJv
ZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfdHJhbnNwb3J0X3JlbW92ZV9vd25lcigp
IFRyYW5zcG9ydCAvb3JnL2JsdWV6L2hjaTAvZGV2XzlDXzQ3XzJBXzM5XzU2X0ZFL3BhY19z
b3VyY2UwL2ZkMSBPd25lciA6MS41MzA0CmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMv
YXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfcmVxdWVzdF9yZXBseSgpIFJlcXVlc3QgQWNxdWly
ZSBSZXBseSBJbnB1dC9vdXRwdXQgZXJyb3IKYmx1ZXRvb3RoZFs0ODc3MjZdOiBbOjEuNTMw
NDplcnJvcl0gPCBvcmcuYmx1ZXouRXJyb3IuRmFpbGVkIFsjMTAyXQpibHVldG9vdGhkWzQ4
NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOm1lZGlhX293bmVyX2ZyZWUoKSBP
d25lciA6MS41MzA0CmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vdHJhbnNw
b3J0LmM6bWVkaWFfb3duZXJfcmVtb3ZlKCkgT3duZXIgOjEuNTMwNCBSZXF1ZXN0IEFjcXVp
cmUKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby90cmFuc3BvcnQuYzptZWRp
YV90cmFuc3BvcnRfc3VzcGVuZCgpIFRyYW5zcG9ydCAvb3JnL2JsdWV6L2hjaTAvZGV2XzlD
XzQ3XzJBXzM5XzU2X0ZFL3BhY19zb3VyY2UwL2ZkMSBPd25lciAKYmx1ZXRvb3RoZFs0ODc3
MjZdOiBwcm9maWxlcy9hdWRpby90cmFuc3BvcnQuYzp0cmFuc3BvcnRfc2V0X3N0YXRlKCkg
U3RhdGUgY2hhbmdlZCAvb3JnL2JsdWV6L2hjaTAvZGV2XzlDXzQ3XzJBXzM5XzU2X0ZFL3Bh
Y19zb3VyY2UwL2ZkMTogVFJBTlNQT1JUX1NUQVRFX1JFUVVFU1RJTkcgLT4gVFJBTlNQT1JU
X1NUQVRFX0lETEUKYmx1ZXRvb3RoZFs0ODc3MjZdOiBbc2lnbmFsXSBvcmcuZnJlZWRlc2t0
b3AuREJ1cy5PYmplY3RNYW5hZ2VyLkludGVyZmFjZXNSZW1vdmVkCmJsdWV0b290aGRbNDg3
NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBfdWNhc3RfZGV0YWNoKCkgc3RyZWFtIDB4NTBl
MDAwMDEwZWEwIGVwIDB4NTA0MDAwMDU5NjkwCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmls
ZXMvYXVkaW8vbWVkaWEuYzpwYWNfY2xlYXIoKSBlbmRwb2ludCAweDUwZjAwMDAwNTk1MCBz
dHJlYW0gMHg1MGUwMDAwMTBlYTAKYmx1ZXRvb3RoZFs0ODc3MjZdOiBbOjEuNTMwNDptZXRo
b2RfY2FsbF0gPCBvcmcuYmx1ZXouTWVkaWFFbmRwb2ludDEuQ2xlYXJDb25maWd1cmF0aW9u
CmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFf
dHJhbnNwb3J0X3JlbW92ZV9vd25lcigpIFRyYW5zcG9ydCAvb3JnL2JsdWV6L2hjaTAvZGV2
XzlDXzQ3XzJBXzM5XzU2X0ZFL3BhY19zaW5rMC9mZDAgT3duZXIgOjEuNTMwNApibHVldG9v
dGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOm1lZGlhX293bmVyX2Zy
ZWUoKSBPd25lciA6MS41MzA0CmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8v
dHJhbnNwb3J0LmM6bWVkaWFfdHJhbnNwb3J0X3N1c3BlbmQoKSBUcmFuc3BvcnQgL29yZy9i
bHVlei9oY2kwL2Rldl85Q180N18yQV8zOV81Nl9GRS9wYWNfc2luazAvZmQwIE93bmVyIApi
bHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOnRyYW5zcG9y
dF9zZXRfc3RhdGUoKSBTdGF0ZSBjaGFuZ2VkIC9vcmcvYmx1ZXovaGNpMC9kZXZfOUNfNDdf
MkFfMzlfNTZfRkUvcGFjX3NpbmswL2ZkMDogVFJBTlNQT1JUX1NUQVRFX0FDVElWRSAtPiBU
UkFOU1BPUlRfU1RBVEVfSURMRQpibHVldG9vdGhkWzQ4NzcyNl06IFtzaWduYWxdIG9yZy5m
cmVlZGVza3RvcC5EQnVzLk9iamVjdE1hbmFnZXIuSW50ZXJmYWNlc1JlbW92ZWQKYmx1ZXRv
b3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9iYXNzLmM6YmFwX2RldGFjaGVkKCkgMHg1
MTAwMDAwMDQyNDAKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9iYXAuYzpi
YXBfZGV0YWNoZWQoKSAweDUxMDAwMDAwNDI0MApibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9z
ZXJ2aWNlLmM6Y2hhbmdlX3N0YXRlKCkgMHg1MDYwMDAwNzVmMjA6IGRldmljZSA5Qzo0Nzoy
QTozOTo1NjpGRSBwcm9maWxlIGJhcCBzdGF0ZSBjaGFuZ2VkOiBkaXNjb25uZWN0aW5nIC0+
IGRpc2Nvbm5lY3RlZCAoMCkKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMvc2VydmljZS5jOmNo
YW5nZV9zdGF0ZSgpIDB4NTA2MDAwMDc2ZDYwOiBkZXZpY2UgOUM6NDc6MkE6Mzk6NTY6RkUg
cHJvZmlsZSBiYXNzIHN0YXRlIGNoYW5nZWQ6IGNvbm5lY3RlZCAtPiBkaXNjb25uZWN0aW5n
ICgwKQpibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2Jhc3MuYzpiYXNzX2Rp
c2Nvbm5lY3QoKSA5Qzo0NzoyQTozOTo1NjpGRQpibHVldG9vdGhkWzQ4NzcyNl06IHByb2Zp
bGVzL2F1ZGlvL2Jhc3MuYzpiYXNzX2RldGFjaGVkKCkgMHg1MGIwMDAwNDc0ZDAKYmx1ZXRv
b3RoZFs0ODc3MjZdOiBzcmMvc2VydmljZS5jOmNoYW5nZV9zdGF0ZSgpIDB4NTA2MDAwMDc2
ZDYwOiBkZXZpY2UgOUM6NDc6MkE6Mzk6NTY6RkUgcHJvZmlsZSBiYXNzIHN0YXRlIGNoYW5n
ZWQ6IGRpc2Nvbm5lY3RpbmcgLT4gZGlzY29ubmVjdGVkICgwKQpibHVldG9vdGhkWzQ4Nzcy
Nl06IHNyYy9zZXJ2aWNlLmM6Y2hhbmdlX3N0YXRlKCkgMHg1MDYwMDAwNzcxZTA6IGRldmlj
ZSA5Qzo0NzoyQTozOTo1NjpGRSBwcm9maWxlIGdhcC1wcm9maWxlIHN0YXRlIGNoYW5nZWQ6
IGNvbm5lY3RlZCAtPiBkaXNjb25uZWN0aW5nICgwKQpibHVldG9vdGhkWzQ4NzcyNl06IHNy
Yy9zZXJ2aWNlLmM6Y2hhbmdlX3N0YXRlKCkgMHg1MDYwMDAwNzcxZTA6IGRldmljZSA5Qzo0
NzoyQTozOTo1NjpGRSBwcm9maWxlIGdhcC1wcm9maWxlIHN0YXRlIGNoYW5nZWQ6IGRpc2Nv
bm5lY3RpbmcgLT4gZGlzY29ubmVjdGVkICgwKQpibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9z
ZXJ2aWNlLmM6Y2hhbmdlX3N0YXRlKCkgMHg1MDYwMDAwNzc0ODA6IGRldmljZSA5Qzo0Nzoy
QTozOTo1NjpGRSBwcm9maWxlIGRldmljZWluZm8gc3RhdGUgY2hhbmdlZDogY29ubmVjdGVk
IC0+IGRpc2Nvbm5lY3RpbmcgKDApCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NlcnZpY2Uu
YzpjaGFuZ2Vfc3RhdGUoKSAweDUwNjAwMDA3NzQ4MDogZGV2aWNlIDlDOjQ3OjJBOjM5OjU2
OkZFIHByb2ZpbGUgZGV2aWNlaW5mbyBzdGF0ZSBjaGFuZ2VkOiBkaXNjb25uZWN0aW5nIC0+
IGRpc2Nvbm5lY3RlZCAoMCkKCg==
--------------RdMapeDQjbOZjRreQhiva14u
Content-Type: text/x-log; charset=UTF-8; name="no-state-check-546.log"
Content-Disposition: attachment; filename="no-state-check-546.log"
Content-Transfer-Encoding: base64

Ymx1ZXRvb3RoZFs0ODc3MjZdOiBbOjEuNTI4OTptZXRob2RfY2FsbF0gPiBvcmcuYmx1ZXou
TWVkaWFUcmFuc3BvcnQxLkFjcXVpcmUgWyMyMTJdCmJsdWV0b290aGRbNDg3NzI2XTogcHJv
ZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfb3duZXJfY3JlYXRlKCkgT3duZXIgY3Jl
YXRlZDogc2VuZGVyPToxLjUyODkKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRp
by90cmFuc3BvcnQuYzptZWRpYV90cmFuc3BvcnRfcmVzdW1lKCkgVHJhbnNwb3J0IC9vcmcv
Ymx1ZXovaGNpMC9kZXZfOUNfNDdfMkFfMzlfNTZfRkUvcGFjX3NvdXJjZTAvZmQxIE93bmVy
IDoxLjUyODkKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMvc2hhcmVkL2JhcC5jOmJhcF9xdWV1
ZV9yZXEoKSByZXEgMHg1MDYwMDAwNjUxMjAgKG9wIDB4MDMpIHF1ZXVlIDB4NTAzMDAwMDgz
ZDQwCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6dHJh
bnNwb3J0X3NldF9zdGF0ZSgpIFN0YXRlIGNoYW5nZWQgL29yZy9ibHVlei9oY2kwL2Rldl85
Q180N18yQV8zOV81Nl9GRS9wYWNfc291cmNlMC9mZDE6IFRSQU5TUE9SVF9TVEFURV9JRExF
IC0+IFRSQU5TUE9SVF9TVEFURV9SRVFVRVNUSU5HCmJsdWV0b290aGRbNDg3NzI2XTogcHJv
ZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfcmVxdWVzdF9jcmVhdGUoKSBSZXF1ZXN0
IGNyZWF0ZWQ6IG1ldGhvZD1BY3F1aXJlIGlkPTE0CmJsdWV0b290aGRbNDg3NzI2XTogcHJv
ZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6bWVkaWFfb3duZXJfYWRkKCkgT3duZXIgOjEuNTI4
OSBSZXF1ZXN0IEFjcXVpcmUKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby90
cmFuc3BvcnQuYzptZWRpYV90cmFuc3BvcnRfc2V0X293bmVyKCkgVHJhbnNwb3J0IC9vcmcv
Ymx1ZXovaGNpMC9kZXZfOUNfNDdfMkFfMzlfNTZfRkUvcGFjX3NvdXJjZTAvZmQxIE93bmVy
IDoxLjUyODkKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMvc2hhcmVkL2JhcC5jOmJhcF9wcm9j
ZXNzX3F1ZXVlKCkgCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBf
c2VuZCgpIHJlcSAweDUwNjAwMDA2NTEyMCBsZW4gOApibHVldG9vdGhkWzQ4NzcyNl06IHNy
Yy9zaGFyZWQvYXR0LmM6Y2FuX3JlYWRfZGF0YSgpIChjaGFuIDB4NTA4MDAwMDEwNmEwKSBB
VFQgUERVIHJlY2VpdmVkOiAweDFiCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9i
YXAuYzpiYXBfcHJvY2Vzc19xdWV1ZSgpIApibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9zaGFy
ZWQvYXR0LmM6Y2FuX3JlYWRfZGF0YSgpIChjaGFuIDB4NTA4MDAwMDEwNmEwKSBBVFQgUERV
IHJlY2VpdmVkOiAweDFiCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpi
YXBfZXBfc2V0X3N0YXR1cygpIEFTRSBzdGF0dXM6IGVwIDB4NTA0MDAwMDNlYjEwIGlkIDB4
MGEgaGFuZGxlIDB4MDEyNyBzdGF0ZSBlbmFibGluZyBsZW4gNwpibHVldG9vdGhkWzQ4Nzcy
Nl06IHNyYy9zaGFyZWQvYmFwLmM6ZXBfc3RhdHVzX21ldGFkYXRhKCkgQ0lTIDB4MDAgQ0lH
IDB4MDAgbWV0YWRhdGEgbGVuIDQKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRp
by9iYXAuYzpiYXBfc3RhdGUoKSBzdHJlYW0gMHg1MGUwMDAwMGE1YTA6IHFvcygyKSAtPiBl
bmFibGluZygzKQpibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9y
dC5jOmJhcF9zdGF0ZV9jaGFuZ2VkKCkgc3RyZWFtIDB4NTBlMDAwMDBhNWEwOiBxb3MoMikg
LT4gZW5hYmxpbmcoMykKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9iYXAu
YzpiYXBfdXBkYXRlX2NpZygpIGFkYXB0ZXIgMHg1MTMwMDAwMDAyMDAgQ0lHIDB4MApibHVl
dG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2JhcC5jOnVwZGF0ZV9jaWdfc2V0dXBf
ZW5hYmxlKCkgMHg1MGYwMDAwMDU2ODAKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9h
dWRpby9iYXAuYzpzZXR1cF9jcmVhdGVfaW8oKSBzZXR1cCAweDUwZjAwMDAwNTY4MCBzdHJl
YW0gMHg1MGUwMDAwMGE1YTAgZGVmZXIgZmFsc2UKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMv
c2hhcmVkL2JhcC5jOmJ0X2JhcF9zdHJlYW1faW9fZ2V0X3FvcygpIGluIDB4NTBlMDAwMDBh
NWQ4IG91dCAobmlsKQpibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2JhcC5j
OnNldHVwX2FjY2VwdF9pbygpIHN0cmVhbSAweDUwZTAwMDAwYTVhMCBmZCAyNiBkZWZlciB0
cnVlCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vYmFwLmM6aXNvX2Nvbm5l
Y3RfY2IoKSBJU08gY29ubmVjdGVkCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVk
aW8vYmFwLmM6aXNvX2Nvbm5lY3RfY2IoKSBJU08gY29ubmVjdGVkCmJsdWV0b290aGRbNDg3
NzI2XTogcHJvZmlsZXMvYXVkaW8vYmFwLmM6aXNvX2Nvbm5lY3RfY2IoKSBVbmFibGUgdG8g
c2V0IElPCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBfc3RyZWFt
X2lvX2RldGFjaCgpIHN0cmVhbSAweDUwZTAwMDAwYTVhMApibHVldG9vdGhkWzQ4NzcyNl06
IHNyYy9zaGFyZWQvYmFwLmM6YmFwX3F1ZXVlX3JlcSgpIHJlcSAweDUwNjAwMDA2NTQ4MCAo
b3AgMHgwNSkgcXVldWUgMHg1MDMwMDAwODNkNDAKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMv
c2hhcmVkL2JhcC5jOmJhcF9wcm9jZXNzX3F1ZXVlKCkgCmJsdWV0b290aGRbNDg3NzI2XTog
c3JjL3NoYXJlZC9iYXAuYzpiYXBfc2VuZCgpIHJlcSAweDUwNjAwMDA2NTQ4MCBsZW4gMwpi
bHVldG9vdGhkWzQ4NzcyNl06IHNyYy9zaGFyZWQvYXR0LmM6Y2FuX3JlYWRfZGF0YSgpIChj
aGFuIDB4NTA4MDAwMDEwNmEwKSBBVFQgUERVIHJlY2VpdmVkOiAweDFiCmJsdWV0b290aGRb
NDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBfcHJvY2Vzc19xdWV1ZSgpIApibHVldG9v
dGhkWzQ4NzcyNl06IHNyYy9zaGFyZWQvYXR0LmM6Y2FuX3JlYWRfZGF0YSgpIChjaGFuIDB4
NTA4MDAwMDEwNmEwKSBBVFQgUERVIHJlY2VpdmVkOiAweDFiCmJsdWV0b290aGRbNDg3NzI2
XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBfZXBfc2V0X3N0YXR1cygpIEFTRSBzdGF0dXM6IGVw
IDB4NTA0MDAwMDNlYjEwIGlkIDB4MGEgaGFuZGxlIDB4MDEyNyBzdGF0ZSBkaXNhYmxpbmcg
bGVuIDcKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMvc2hhcmVkL2JhcC5jOmVwX3N0YXR1c19t
ZXRhZGF0YSgpIENJUyAweDAwIENJRyAweDAwIG1ldGFkYXRhIGxlbiA0CmJsdWV0b290aGRb
NDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vYmFwLmM6YmFwX3N0YXRlKCkgc3RyZWFtIDB4NTBl
MDAwMDBhNWEwOiBlbmFibGluZygzKSAtPiBkaXNhYmxpbmcoNSkKYmx1ZXRvb3RoZFs0ODc3
MjZdOiBwcm9maWxlcy9hdWRpby90cmFuc3BvcnQuYzpiYXBfc3RhdGVfY2hhbmdlZCgpIHN0
cmVhbSAweDUwZTAwMDAwYTVhMDogZW5hYmxpbmcoMykgLT4gZGlzYWJsaW5nKDUpCmJsdWV0
b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBfcXVldWVfcmVxKCkgcmVxIDB4
NTA2MDAwMDY1NWEwIChvcCAweDA2KSBxdWV1ZSAweDUwMzAwMDA4M2Q0MApibHVldG9vdGhk
WzQ4NzcyNl06IHNyYy9zaGFyZWQvYXR0LmM6Y2FuX3JlYWRfZGF0YSgpIChjaGFuIDB4NTA4
MDAwMDEwNmEwKSBBVFQgUERVIHJlY2VpdmVkOiAweDFiCmJsdWV0b290aGRbNDg3NzI2XTog
c3JjL3NoYXJlZC9iYXAuYzpiYXBfZXBfc2V0X3N0YXR1cygpIEFTRSBzdGF0dXM6IGVwIDB4
NTA0MDAwMDNlYjEwIGlkIDB4MGEgaGFuZGxlIDB4MDEyNyBzdGF0ZSBxb3MgbGVuIDE1CmJs
dWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzplcF9zdGF0dXNfcW9zKCkgQ0lH
IDB4MDAgQ0lTIDB4MDAgaW50ZXJ2YWwgMTAwMDAgZnJhbWluZyAweDAwIHBoeXMgMHgwMiBy
dG4gMiBsYXRlbmN5IDEwIHBkIDQwMDAwCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJl
ZC9iYXAuYzpiYXBfc3RyZWFtX3VwZGF0ZV9pb19saW5rcygpIHN0cmVhbSAweDUwZTAwMDAw
YTVhMApibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9zaGFyZWQvYmFwLmM6YmFwX3VjYXN0X2lv
X2xpbmsoKSBzdHJlYW0gMHg1MGUwMDAwMGE2ODAgbGluayAweDUwZTAwMDAwYTVhMApibHVl
dG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2JhcC5jOmJhcF9zdGF0ZSgpIHN0cmVh
bSAweDUwZTAwMDAwYTVhMDogZGlzYWJsaW5nKDUpIC0+IHFvcygyKQpibHVldG9vdGhkWzQ4
NzcyNl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOmJhcF9zdGF0ZV9jaGFuZ2VkKCkg
c3RyZWFtIDB4NTBlMDAwMDBhNWEwOiBkaXNhYmxpbmcoNSkgLT4gcW9zKDIpCmJsdWV0b290
aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vYmFwLmM6YmFwX3VwZGF0ZV9jaWcoKSBhZGFw
dGVyIDB4NTEzMDAwMDAwMjAwIENJRyAweDAKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxl
cy9hdWRpby9iYXAuYzpiYXBfdXBkYXRlX2NpZygpIHNldHVwIDB4NTBmMDAwMDA1NjgwIHN0
cmVhbSAweDUwZTAwMDAwYTVhMCBidXN5CmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJl
ZC9iYXAuYzpiYXBfcHJvY2Vzc19xdWV1ZSgpIApibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9z
aGFyZWQvYmFwLmM6YmFwX3NlbmQoKSByZXEgMHg1MDYwMDAwNjU1YTAgbGVuIDMKYmx1ZXRv
b3RoZFs0ODc3MjZdOiBzcmMvc2hhcmVkL2F0dC5jOmNhbl9yZWFkX2RhdGEoKSAoY2hhbiAw
eDUwODAwMDAxMDZhMCkgQVRUIFBEVSByZWNlaXZlZDogMHgxYgpibHVldG9vdGhkWzQ4Nzcy
Nl06IHNyYy9zaGFyZWQvYmFwLmM6YmFwX3Byb2Nlc3NfcXVldWUoKSAKCmJsdWV0b290aGRb
NDg3NzI2XTogWzoxLjQ5MzptZXRob2RfY2FsbF0gPiBvcmcuYmx1ZXouRGV2aWNlMS5EaXNj
b25uZWN0IFsjNDk0MjhdCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL2RldmljZS5jOmRldmlj
ZV9zZXRfYXV0b19jb25uZWN0KCkgOUM6NDc6MkE6Mzk6NTY6RkUgYXV0byBjb25uZWN0OiAw
CmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NlcnZpY2UuYzpjaGFuZ2Vfc3RhdGUoKSAweDUw
NjAwMDA1MWIwMDogZGV2aWNlIDlDOjQ3OjJBOjM5OjU2OkZFIHByb2ZpbGUgcmFwIHN0YXRl
IGNoYW5nZWQ6IGNvbm5lY3RlZCAtPiBkaXNjb25uZWN0aW5nICgwKQpibHVldG9vdGhkWzQ4
NzcyNl06IHByb2ZpbGVzL3JhbmdpbmcvcmFwLmM6cmFwX2Rpc2Nvbm5lY3QoKSAgCmJsdWV0
b290aGRbNDg3NzI2XTogc3JjL3NlcnZpY2UuYzpjaGFuZ2Vfc3RhdGUoKSAweDUwNjAwMDA1
MWIwMDogZGV2aWNlIDlDOjQ3OjJBOjM5OjU2OkZFIHByb2ZpbGUgcmFwIHN0YXRlIGNoYW5n
ZWQ6IGRpc2Nvbm5lY3RpbmcgLT4gZGlzY29ubmVjdGVkICgwKQpibHVldG9vdGhkWzQ4Nzcy
Nl06IHNyYy9zZXJ2aWNlLmM6Y2hhbmdlX3N0YXRlKCkgMHg1MDYwMDAwNTFjZTA6IGRldmlj
ZSA5Qzo0NzoyQTozOTo1NjpGRSBwcm9maWxlIGJhcCBzdGF0ZSBjaGFuZ2VkOiBjb25uZWN0
ZWQgLT4gZGlzY29ubmVjdGluZyAoMCkKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9h
dWRpby9iYXAuYzplcF91bnJlZ2lzdGVyKCkgZXAgMHg1MDYwMDAwNjFmYTAgcGF0aCAvb3Jn
L2JsdWV6L2hjaTAvZGV2XzlDXzQ3XzJBXzM5XzU2X0ZFL3BhY19zaW5rMApibHVldG9vdGhk
WzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2JhcC5jOnNldHVwX2ZyZWUoKSAweDUwZjAwMDAw
NTU5MApibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2JhcC5jOnNldHVwX2lv
X2Nsb3NlKCkgc2V0dXAgMHg1MGYwMDAwMDU1OTAKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMv
c2hhcmVkL2JhcC5jOmJhcF9zdHJlYW1faW9fZGV0YWNoKCkgc3RyZWFtIDB4NTBlMDAwMDBh
NjgwCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJlZC9iYXAuYzpiYXBfc3RyZWFtX2lv
X2RldGFjaCgpIHN0cmVhbSAweDUwZTAwMDAwYTVhMApibHVldG9vdGhkWzQ4NzcyNl06IHNy
Yy9zaGFyZWQvYmFwLmM6c3RyZWFtX2lvX2ZyZWUoKSBmZCAyNgpibHVldG9vdGhkWzQ4Nzcy
Nl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOnRyYW5zcG9ydF9iYXBfdXBkYXRlX2xp
bmtzX3VjKCkgc3RyZWFtIDB4NTBlMDAwMDBhNWEwIGxpbmtlZCB0cnVlCmJsdWV0b290aGRb
NDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6dHJhbnNwb3J0X2JhcF91cGRh
dGVfbGlua3NfdWMoKSBzdHJlYW0gMHg1MGUwMDAwMGE2ODAgbGlua2VkIHRydWUKYmx1ZXRv
b3RoZFs0ODc3MjZdOiBzcmMvc2hhcmVkL2JhcC5jOmJhcF9xdWV1ZV9yZXEoKSByZXEgMHg1
MDYwMDAwNjU5YzAgKG9wIDB4MDgpIHF1ZXVlIDB4NTAzMDAwMDgzZDQwCmJsdWV0b290aGRb
NDg3NzI2XTogW3NpZ25hbF0gb3JnLmZyZWVkZXNrdG9wLkRCdXMuT2JqZWN0TWFuYWdlci5J
bnRlcmZhY2VzUmVtb3ZlZApibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL2Jh
cC5jOmVwX3VucmVnaXN0ZXIoKSBlcCAweDUwNjAwMDA2MWQwMCBwYXRoIC9vcmcvYmx1ZXov
aGNpMC9kZXZfOUNfNDdfMkFfMzlfNTZfRkUvcGFjX3NvdXJjZTAKYmx1ZXRvb3RoZFs0ODc3
MjZdOiBwcm9maWxlcy9hdWRpby9iYXAuYzpzZXR1cF9mcmVlKCkgMHg1MGYwMDAwMDU2ODAK
Ymx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9iYXAuYzpzZXR1cF9pb19jbG9z
ZSgpIHNldHVwIDB4NTBmMDAwMDA1NjgwCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NoYXJl
ZC9iYXAuYzpiYXBfcXVldWVfcmVxKCkgcmVxIDB4NTA2MDAwMDY1YjQwIChvcCAweDA4KSBx
dWV1ZSAweDUwMzAwMDBhMGEyMApibHVldG9vdGhkWzQ4NzcyNl06IFtzaWduYWxdIG9yZy5m
cmVlZGVza3RvcC5EQnVzLk9iamVjdE1hbmFnZXIuSW50ZXJmYWNlc1JlbW92ZWQKYmx1ZXRv
b3RoZFs0ODc3MjZdOiBzcmMvc2hhcmVkL2JhcC5jOmJ0X2JhcF9kZXRhY2goKSAweDUxMDAw
MDAwM2M0MApibHVldG9vdGhkWzQ4NzcyNl06IHNyYy9zaGFyZWQvYmFwLmM6YmFwX3VjYXN0
X2RldGFjaCgpIHN0cmVhbSAweDUwZTAwMDAwYTVhMCBlcCAweDUwNDAwMDAzZWIxMApibHVl
dG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlvL21lZGlhLmM6cGFjX2NsZWFyKCkgZW5k
cG9pbnQgMHg1MGYwMDAwMDM1YjAgc3RyZWFtIDB4NTBlMDAwMDBhNWEwCmJsdWV0b290aGRb
NDg3NzI2XTogW3NpZ25hbF0gb3JnLmZyZWVkZXNrdG9wLkRCdXMuUHJvcGVydGllcy5Qcm9w
ZXJ0aWVzQ2hhbmdlZApibHVldG9vdGhkWzQ4NzcyNl06IFtzaWduYWxdIG9yZy5mcmVlZGVz
a3RvcC5EQnVzLlByb3BlcnRpZXMuUHJvcGVydGllc0NoYW5nZWQKYmx1ZXRvb3RoZFs0ODc3
MjZdOiBbOjEuNTI4OTptZXRob2RfY2FsbF0gPCBvcmcuYmx1ZXouTWVkaWFFbmRwb2ludDEu
Q2xlYXJDb25maWd1cmF0aW9uCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8v
dHJhbnNwb3J0LmM6bWVkaWFfdHJhbnNwb3J0X3JlbW92ZV9vd25lcigpIFRyYW5zcG9ydCAv
b3JnL2JsdWV6L2hjaTAvZGV2XzlDXzQ3XzJBXzM5XzU2X0ZFL3BhY19zb3VyY2UwL2ZkMSBP
d25lciA6MS41Mjg5CmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vdHJhbnNw
b3J0LmM6bWVkaWFfcmVxdWVzdF9yZXBseSgpIFJlcXVlc3QgQWNxdWlyZSBSZXBseSBJbnB1
dC9vdXRwdXQgZXJyb3IKYmx1ZXRvb3RoZFs0ODc3MjZdOiBbOjEuNTI4OTplcnJvcl0gPCBv
cmcuYmx1ZXouRXJyb3IuRmFpbGVkIFsjMjEyXQpibHVldG9vdGhkWzQ4NzcyNl06IHByb2Zp
bGVzL2F1ZGlvL3RyYW5zcG9ydC5jOmxpbmtlZF90cmFuc3BvcnRfcmVtb3ZlX293bmVyKCkg
VHJhbnNwb3J0IC9vcmcvYmx1ZXovaGNpMC9kZXZfOUNfNDdfMkFfMzlfNTZfRkUvcGFjX3Np
bmswL2ZkMCBPd25lciA6MS41Mjg5CmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVk
aW8vdHJhbnNwb3J0LmM6bWVkaWFfb3duZXJfZnJlZSgpIE93bmVyIDoxLjUyODkKYmx1ZXRv
b3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby90cmFuc3BvcnQuYzptZWRpYV9vd25lcl9y
ZW1vdmUoKSBPd25lciA6MS41Mjg5IFJlcXVlc3QgQWNxdWlyZQpibHVldG9vdGhkWzQ4Nzcy
Nl06IHByb2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jOm1lZGlhX3RyYW5zcG9ydF9zdXNwZW5k
KCkgVHJhbnNwb3J0IC9vcmcvYmx1ZXovaGNpMC9kZXZfOUNfNDdfMkFfMzlfNTZfRkUvcGFj
X3NvdXJjZTAvZmQxIE93bmVyIApibHVldG9vdGhkWzQ4NzcyNl06IHByb2ZpbGVzL2F1ZGlv
L3RyYW5zcG9ydC5jOnRyYW5zcG9ydF9zZXRfc3RhdGUoKSBTdGF0ZSBjaGFuZ2VkIC9vcmcv
Ymx1ZXovaGNpMC9kZXZfOUNfNDdfMkFfMzlfNTZfRkUvcGFjX3NvdXJjZTAvZmQxOiBUUkFO
U1BPUlRfU1RBVEVfUkVRVUVTVElORyAtPiBUUkFOU1BPUlRfU1RBVEVfSURMRQpibHVldG9v
dGhkWzQ4NzcyNl06IFtzaWduYWxdIG9yZy5mcmVlZGVza3RvcC5EQnVzLk9iamVjdE1hbmFn
ZXIuSW50ZXJmYWNlc1JlbW92ZWQKYmx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMvc2hhcmVkL2Jh
cC5jOmJhcF91Y2FzdF9kZXRhY2goKSBzdHJlYW0gMHg1MGUwMDAwMGE2ODAgZXAgMHg1MDQw
MDAwM2VhMTAKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9tZWRpYS5jOnBh
Y19jbGVhcigpIGVuZHBvaW50IDB4NTBmMDAwMDAzNGMwIHN0cmVhbSAweDUwZTAwMDAwYTY4
MApibHVldG9vdGhkWzQ4NzcyNl06IFs6MS41Mjg5Om1ldGhvZF9jYWxsXSA8IG9yZy5ibHVl
ei5NZWRpYUVuZHBvaW50MS5DbGVhckNvbmZpZ3VyYXRpb24KYmx1ZXRvb3RoZFs0ODc3MjZd
OiBbc2lnbmFsXSBvcmcuZnJlZWRlc2t0b3AuREJ1cy5PYmplY3RNYW5hZ2VyLkludGVyZmFj
ZXNSZW1vdmVkCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmlsZXMvYXVkaW8vYmFzcy5jOmJh
cF9kZXRhY2hlZCgpIDB4NTEwMDAwMDAzYzQwCmJsdWV0b290aGRbNDg3NzI2XTogcHJvZmls
ZXMvYXVkaW8vYmFwLmM6YmFwX2RldGFjaGVkKCkgMHg1MTAwMDAwMDNjNDAKYmx1ZXRvb3Ro
ZFs0ODc3MjZdOiBzcmMvc2VydmljZS5jOmNoYW5nZV9zdGF0ZSgpIDB4NTA2MDAwMDUxY2Uw
OiBkZXZpY2UgOUM6NDc6MkE6Mzk6NTY6RkUgcHJvZmlsZSBiYXAgc3RhdGUgY2hhbmdlZDog
ZGlzY29ubmVjdGluZyAtPiBkaXNjb25uZWN0ZWQgKDApCmJsdWV0b290aGRbNDg3NzI2XTog
c3JjL3NlcnZpY2UuYzpjaGFuZ2Vfc3RhdGUoKSAweDUwNjAwMDA1MmIyMDogZGV2aWNlIDlD
OjQ3OjJBOjM5OjU2OkZFIHByb2ZpbGUgYmFzcyBzdGF0ZSBjaGFuZ2VkOiBjb25uZWN0ZWQg
LT4gZGlzY29ubmVjdGluZyAoMCkKYmx1ZXRvb3RoZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRp
by9iYXNzLmM6YmFzc19kaXNjb25uZWN0KCkgOUM6NDc6MkE6Mzk6NTY6RkUKYmx1ZXRvb3Ro
ZFs0ODc3MjZdOiBwcm9maWxlcy9hdWRpby9iYXNzLmM6YmFzc19kZXRhY2hlZCgpIDB4NTBi
MDAwMDBiOTMwCmJsdWV0b290aGRbNDg3NzI2XTogc3JjL3NlcnZpY2UuYzpjaGFuZ2Vfc3Rh
dGUoKSAweDUwNjAwMDA1MmIyMDogZGV2aWNlIDlDOjQ3OjJBOjM5OjU2OkZFIHByb2ZpbGUg
YmFzcyBzdGF0ZSBjaGFuZ2VkOiBkaXNjb25uZWN0aW5nIC0+IGRpc2Nvbm5lY3RlZCAoMCkK
Ymx1ZXRvb3RoZFs0ODc3MjZdOiBzcmMvc2VydmljZS5jOmNoYW5nZV9zdGF0ZSgpIDB4NTA2
MDAwMDUyZmEwOiBkZXZpY2UgOUM6NDc6MkE6Mzk6NTY6RkUgcHJvZmlsZSBnYXAtcHJvZmls
ZSBzdGF0ZSBjaGFuZ2VkOiBjb25uZWN0ZWQgLT4gZGlzY29ubmVjdGluZyAoMCkKYmx1ZXRv
b3RoZFs0ODc3MjZdOiBzcmMvc2VydmljZS5jOmNoYW5nZV9zdGF0ZSgpIDB4NTA2MDAwMDUy
ZmEwOiBkZXZpY2UgOUM6NDc6MkE6Mzk6NTY6RkUgcHJvZmlsZSBnYXAtcHJvZmlsZSBzdGF0
ZSBjaGFuZ2VkOiBkaXNjb25uZWN0aW5nIC0+IGRpc2Nvbm5lY3RlZCAoMCkKYmx1ZXRvb3Ro
ZFs0ODc3MjZdOiBzcmMvc2VydmljZS5jOmNoYW5nZV9zdGF0ZSgpIDB4NTA2MDAwMDUzMjQw
OiBkZXZpY2UgOUM6NDc6MkE6Mzk6NTY6RkUgcHJvZmlsZSBkZXZpY2VpbmZvIHN0YXRlIGNo
YW5nZWQ6IGNvbm5lY3RlZCAtPiBkaXNjb25uZWN0aW5nICgwKQpibHVldG9vdGhkWzQ4Nzcy
Nl06IHNyYy9zZXJ2aWNlLmM6Y2hhbmdlX3N0YXRlKCkgMHg1MDYwMDAwNTMyNDA6IGRldmlj
ZSA5Qzo0NzoyQTozOTo1NjpGRSBwcm9maWxlIGRldmljZWluZm8gc3RhdGUgY2hhbmdlZDog
ZGlzY29ubmVjdGluZyAtPiBkaXNjb25uZWN0ZWQgKDApCgo=

--------------RdMapeDQjbOZjRreQhiva14u--

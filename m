Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140814122850.GA10628@t440s>
References: <1408017189-15089-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<20140814122850.GA10628@t440s>
Date: Thu, 14 Aug 2014 14:43:52 +0200
Message-ID: <CAMv5Gbdmz+5njqV7o1Qi=0K=kadzPtB+c3yds8s+OE81XbbytQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] android/bluetooth: Add support for get remote
 service record property cmd
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 14 August 2014 14:28, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Grzegorz,
>
> On Thu, Aug 14, 2014, Grzegorz Kolodziejczyk wrote:
>> +             prop->channel = (uint16_t)channel;
>
> This typecast seems unnecessary to me. At least I don't get any compiler
> warnings/errors if I remove it.
>
>> +static void find_remote_sdp_rec_cb(sdp_list_t *recs, int err,
>> +                                                     gpointer user_data)
>> +{
>> +     uint8_t name_len = 0;
>> +     uint8_t status;
>> +     char name_buf[256];
>> +     int channel = 0;
>
> Since both name_len and channel are tied to the specific record that
> you're iterating it seems wrong to me to initialize these here.
>
Right
>> +     for ( ; recs; recs = recs->next) {
>> +             sdp_rec = recs->data;
>> +
>> +             switch (sdp_rec->svclass.type) {
>> +             case SDP_UUID16:
>> +                     sdp_uuid16_to_uuid128(&uuid128_sdp,
>> +                                                     &sdp_rec->svclass);
>> +                     break;
>> +             case SDP_UUID32:
>> +                     sdp_uuid32_to_uuid128(&uuid128_sdp,
>> +                                                     &sdp_rec->svclass);
>> +                     break;
>> +             case SDP_UUID128:
>> +                     break;
>> +             default:
>> +                     error("wrong sdp uuid type");
>> +                     goto done;
>> +             }
>> +
>> +             if (!sdp_get_access_protos(sdp_rec, &protos)) {
>> +                     channel = sdp_get_proto_port(protos, L2CAP_UUID);
>> +                     if (channel < 0)
>> +                             error("wrong channel");
>> +             }
>
> Probably this should be here:
>
>                 } else {
>                         channel = -1;
>                 }
>
I'll follow this idea
>> +             if (!sdp_get_service_name(sdp_rec, name_buf, sizeof(name_buf)))
>> +                     name_len = (uint8_t)strlen(name_buf);
>
> And here:
>
>                 else
>                         name_len = 0;
>
> Otherwise you'll end up including the name from previous records as the
> name of subsequent ones which don't have a service name attribute. Also,
> the (uint8_t) typecast seems unnecessary here (compiles fine for me
> without it).
>
yes, right. I'll fix it
>> +static uint8_t find_remote_sdp_rec(const bdaddr_t *addr,
>> +                                             const uint8_t *find_uuid)
>> +{
>> +     uuid_t uuid;
>> +     bdaddr_t *bdaddr;
>> +
>> +     /* from android we always get full 128bit length uuid */
>> +     sdp_uuid128_create(&uuid, find_uuid);
>> +
>> +     bdaddr = malloc(sizeof(*bdaddr));
>
> Could you tell me what's the rationale of choosing malloc vs g_malloc in
> this code. In most places this c-file is using the GLib allocators and
> having a mixed set is just begging for trouble (e.g. you might end up
> calling g_free on something allocated with malloc, or free for something
> allocated with g_malloc).
>
I'll change to Glib allocators
> Johan

BR,
Grzegorz

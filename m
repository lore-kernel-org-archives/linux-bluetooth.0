Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130503043602.GA3742@x220>
References: <1367533776-3987-1-git-send-email-vinicius.gomes@openbossa.org>
	<20130503043602.GA3742@x220>
Date: Mon, 6 May 2013 14:23:37 -0300
Message-ID: <CAE6HaMmDgfHuAEandfET7OXRMcdyEG-J2E-x=iaCEeH1DVob=g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profile: Create a service for incomming connections
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, May 3, 2013 at 1:36 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Vinicius,
>
> On Thu, May 02, 2013, Vinicius Costa Gomes wrote:
>> diff --git a/src/profile.c b/src/profile.c
>> index 0500983..2c35dc7 100644
>> --- a/src/profile.c
>> +++ b/src/profile.c
>> @@ -1045,6 +1045,7 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
>>  {
>>       struct btd_device *device;
>>       struct ext_io *conn;
>> +     struct btd_profile *profile;
>>       GIOCondition cond;
>>
>>       conn = g_new0(struct ext_io, 1);
>> @@ -1052,11 +1053,14 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
>>       conn->proto = server->proto;
>>       conn->ext = server->ext;
>>       conn->adapter = btd_adapter_ref(server->adapter);
>> +     profile = &server->ext->p;
>>
>>       device = adapter_find_device(server->adapter, dst);
>>
>> -     if (device)
>> +     if (device) {
>>               conn->device = btd_device_ref(device);
>> +             conn->service = service_create(device, profile);
>> +     }
>>
>>       cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
>>       conn->io_id = g_io_add_watch(io, cond, ext_io_disconnected, conn);
>
> How would the service show up in the list of services for the device
> object in question? To me it seems like src/device.c is the only place
> that should be calling service_create because of this. What does seem to
> be missing in profile.c is a call to btd_device_add_uuid for unexpected
> connections from a device which we did not yet know to support a certain
> UUID. The btd_device_add_uuid function should cause a new service to be
> created, but it may not yet be enough to get the service to be assigned
> to conn in profile.c.

The problem in question seems that the service is already created, but
it doesn't get associated with
the conn in my particular case of incomming connections (testing the
AG side of HFP, for the record).

I am looking into this.

>
> Johan


Cheers,
--
Vinicius

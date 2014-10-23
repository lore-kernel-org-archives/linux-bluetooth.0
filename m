Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25S3h=LjaXSFkJiz5X41JD9-1zNJiD1R7hQNfA3aSbO0sg@mail.gmail.com>
References: <CAHrH25S3h=LjaXSFkJiz5X41JD9-1zNJiD1R7hQNfA3aSbO0sg@mail.gmail.com>
Date: Thu, 23 Oct 2014 10:51:45 +0300
Message-ID: <CABBYNZLE_xxoaPXZ=9LY2AwT-Pa_mqEYRD8v4_TgMTdo77j-Qw@mail.gmail.com>
Subject: Re: Attribute security permissions and CCC descriptors in shared/gatt-server.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Marcin Kraglak <marcin.kraglak@tieto.com>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Oct 22, 2014 at 11:12 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi all,
>
> I have some unresolved questions about two aspects of
> shared/gatt-server and I thought it might be better to discuss them
> before moving on with the related parts of the implementation.
>
> *** 1. Who will be responsible for Attribute Permission checks? ***
>
> These mainly come in play when the remote end wants to read or write
> the value of a characteristic/descriptor. We currently have read &
> write callbacks that get assigned by the upper-layer to a
> characteristic/descriptor definition in shared/gatt-db. Since these
> callbacks already handle the read/write it initially made sense to me
> that this is where encryption/authentication/authorization permission
> checks can be performed. I then realized that there are cases where we
> may want to perform this check before we invoke the read/write
> callback. For instance, the Prepare Write request requires attribute
> permission checks to be performed, however (in the current design) we
> wouldn't actually call the write callback until a subsequent Execute
> Write request is received.

I believe this should be handle by the db, perhaps with a dedicated
prepare function that should probably call a callback so the
implementation can really tell when a write is about to happen. The
weird thing here is that the gatt_db_add_characteristic take
permissions but never really use it for anything except in
gatt_db_get_attribute_permissions, I thought the idea would be to do
the permission checks with it or Im missing something.

> The main problem here is the fact that shared/att is designed to be
> transport agnostic: it doesn't know whether the underlying connection
> is AF_BLUETOOTH or something else, so it can't make assumptions on the
> nature of the connection to obtain security level information. We
> could add some sort of delegate callback to this end, perhaps
> something like:

Then we should probably have some functions to set and get the
security level, but Im sure it needs to be a callback as it does not
looks like it gonna change without us noticing it, then we can
automatically check with security level against the permissions
provided by the profile when registering the characteristic.

> static uint8_t my_sec_handler(void *user_data)
> {
>         ....
>         return sec;
> }
> ...
> bt_att_register_security_handler(att, my_sec_handler);
>
> And then bt_gatt_server can obtain the current security level like this:
>
> uint8_t sec = bt_att_get_security_level(att);
>
> where bt_att_get_security_level is implemented as:
>
> static uint8_t bt_att_get_security_level(struct bt_att *att)
> {
>       if (!att || !att->security_callback)
>               return 0;
>
>       return att->security_callback(att->security_data);
> }
>
>
> I'm mostly thinking out loud here; would something like this make sense?
>
>
> *** 2. Is shared/gatt-server responsible for keeping track of Client
> Characteristic Configuration descriptor states for each bonded client?
> ***
>
> Currently, the descriptor read/write operations need to be handled by
> the upper layer via the read/write callbacks anyway, since the
> side-effects of a writing to a particular CCC descriptor need to be
> implemented by the related profile. In the bonding case, the
> read/write callbacks could determine what value to return and how to
> cache the value on a per-device basis without shared/gatt-db having a
> notion of "per-client CCC descriptors".

Well making gatt_db have the notion of CCC would make things a little
bit simpler for storing and reloading but it would probably force us
to rethink how the db access the values, perhaps the db could cache
CCC values per client so it could detect changes and send
notifications automatically whenever the profiles tell it values has
changed or when a write succeeds.

> Does this make sense? If so, is there a point of keeping the "bdaddr_t
> *bdaddr" arguments of gatt_db_read_t, gatt_db_write_t, gatt_db_read,
> and gatt_db_write? Note that I'm currently passing NULL to all of
> these calls for this parameter in shared/gatt-server, since bt_att
> doesn't have a notion of a BD_ADDR.

I guess this was inspired by Android, I would agree that if you
register a characteristic and set the permission properly then it does
not matter who is attempting to read/write as long as they are fulfill
the requirements it should be okay but perhaps Android have pushed the
notion of CCC up in the stack which force it to expose the remote
address. Anyway for unit test I will have to address it since that
will be using a socket pair, perhaps passing NULL is fine if we have
CCC caching but in case of Android I don't think we can do much about
it.


-- 
Luiz Augusto von Dentz

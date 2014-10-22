Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 22 Oct 2014 13:12:10 -0700
Message-ID: <CAHrH25S3h=LjaXSFkJiz5X41JD9-1zNJiD1R7hQNfA3aSbO0sg@mail.gmail.com>
Subject: Attribute security permissions and CCC descriptors in shared/gatt-server.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Marcin Kraglak <marcin.kraglak@tieto.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I have some unresolved questions about two aspects of
shared/gatt-server and I thought it might be better to discuss them
before moving on with the related parts of the implementation.

*** 1. Who will be responsible for Attribute Permission checks? ***

These mainly come in play when the remote end wants to read or write
the value of a characteristic/descriptor. We currently have read &
write callbacks that get assigned by the upper-layer to a
characteristic/descriptor definition in shared/gatt-db. Since these
callbacks already handle the read/write it initially made sense to me
that this is where encryption/authentication/authorization permission
checks can be performed. I then realized that there are cases where we
may want to perform this check before we invoke the read/write
callback. For instance, the Prepare Write request requires attribute
permission checks to be performed, however (in the current design) we
wouldn't actually call the write callback until a subsequent Execute
Write request is received.

The main problem here is the fact that shared/att is designed to be
transport agnostic: it doesn't know whether the underlying connection
is AF_BLUETOOTH or something else, so it can't make assumptions on the
nature of the connection to obtain security level information. We
could add some sort of delegate callback to this end, perhaps
something like:

static uint8_t my_sec_handler(void *user_data)
{
        ....
        return sec;
}
...
bt_att_register_security_handler(att, my_sec_handler);

And then bt_gatt_server can obtain the current security level like this:

uint8_t sec = bt_att_get_security_level(att);

where bt_att_get_security_level is implemented as:

static uint8_t bt_att_get_security_level(struct bt_att *att)
{
      if (!att || !att->security_callback)
              return 0;

      return att->security_callback(att->security_data);
}


I'm mostly thinking out loud here; would something like this make sense?


*** 2. Is shared/gatt-server responsible for keeping track of Client
Characteristic Configuration descriptor states for each bonded client?
***

Currently, the descriptor read/write operations need to be handled by
the upper layer via the read/write callbacks anyway, since the
side-effects of a writing to a particular CCC descriptor need to be
implemented by the related profile. In the bonding case, the
read/write callbacks could determine what value to return and how to
cache the value on a per-device basis without shared/gatt-db having a
notion of "per-client CCC descriptors".

Does this make sense? If so, is there a point of keeping the "bdaddr_t
*bdaddr" arguments of gatt_db_read_t, gatt_db_write_t, gatt_db_read,
and gatt_db_write? Note that I'm currently passing NULL to all of
these calls for this parameter in shared/gatt-server, since bt_att
doesn't have a notion of a BD_ADDR.

Thanks,
Arman

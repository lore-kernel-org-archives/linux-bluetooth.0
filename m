Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 1 Jun 2011 11:22:44 -0400
Message-ID: <BANLkTimqLNGow0wq2uWSqh5EVNp9Xsb0WQ@mail.gmail.com>
Subject: [RFC] New API for attribute read/write callback registration
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The current BlueZ mainline contains an initial API for attribute
callbacks which are called before reading and after writing to a ATT
attribute. This allows for filling attribute values which are not
static (or which come from an external source, e.g. battery level
measurements).

The current API works as this:

struct attribute *a;
a = attrib_db_add(<handle>, <uuid>, <read_permissions>,
<write_permissions>, <value>, <value_len>);
a->read_cb = <read_callback>;
a->write_cb = <write_callback>;
a->cb_user_data = <pointer_to_user_data>;

callbacks have signature:

        uint8_t (*read_cb)(struct attribute *a, gpointer user_data);
        uint8_t (*write_cb)(struct attribute *a, gpointer user_data);

This works well if attrib_db_add() is called from a point where we can
access the connection context data (i.e. GAttrib). This is most always
not the case, as attributes are registered during profile plugin load.

To allow to pass GAttrib to the read/write callbacks, we need to
decouple the callback information from struct attribute. This also
allows to easily extend with more operations other then read/write
(e.g. notifications). Therefore we plan to have this new API (already
implemented, and which we should send patches anytime soon):

struct attrib_cb *cb;
struct attribute *a;

a = attrib_db_add(<handle>, <uuid>, <read_permissions>,
<write_permissions>, <value>, <value_len>);
cb = g_new0(struct attrib_cb, 1);
/* event: ATTRIB_READ, ATTRIB_WRITE or ATTRIB_UPDATE */
cb->event = <event>;
/* cb->read, cb->write or cp->update, depending on the event type */
cb->write = <write_callback>;
attrib_add_callback(a, cb)

And the new signatures for callbacks:

                uint8_t (*read)(GAttrib *attrib, struct attribute *a);
                uint8_t (*write)(GAttrib *attrib, struct attribute *a);
                uint8_t (*update)(GAttrib *attrib, struct attribute *a);

We use a union for the callback field, allowing different signatures
for different events.

Currently, the main issue which prevents us from sending the migration
to this new API is that attrib_db_update() uses g_try_realloc(), which
may change the allocated pointer and invalidate references to the old
struct attribute pointer.

Suggestions/comments are welcome. Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

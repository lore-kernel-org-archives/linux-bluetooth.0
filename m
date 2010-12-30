Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 30 Dec 2010 19:42:44 -0400
Message-ID: <AANLkTimhYXuN8mo9oNB9RG+QX0BqFbmipYaQaxE-QToo@mail.gmail.com>
Subject: [RFC] BlueZ server side API for registering GATT services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

To be able to support multiple profiles on top of GATT, we need some
sort of internal API for registering services and characteristics. So
far, the API implemented in current code (src/attrib-server.c) works
at the attribute level:

int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
                                                const uint8_t *value, int len);
int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
                                                                int len);
int attrib_db_del(uint16_t handle);

I'd like to discuss/clarify a few topics regarding the GATT
implementation in BlueZ, and future development ideas.

High-level API for Characteristics and Services
===============================================

As we know, the entire GATT Profile hierarchy is built on top of ATT
attributes, so the current API would be enough for building complex
services. But there is also the issue that working at the attribute
level requires a lot of code. See, for instance, our example server
(attrib/example.c). It needs several attrib_db_add() calls to build
characteristics and services, and the attribute values are constructed
by hand.

The spec also defines the concept of "aggregated characteristic
values" (page 1906), which are characteristic descriptors whose value
is a list of attribute handles referring other characteristic
descriptors (namely "Characteristic Presentation Format"). Using the
current API, one would have to build the attribute values at the byte
level.

One idea would be to mirror the design we did for GATT on top of ATT,
and have higher level API to build characteristics, services etc. and
return a list of attributes to be inserted into the attribute
database. This would reduce a lot of code necessary for building more
complex profiles.

Notification/Indication
=======================

"Control-Point Attributes" (page 1838) can be used to activate
notifications/indications of device states or events. We need to
implement the necessary API so the profile implementation can know
which of its data needs to be notified/indicated. The core would take
care of managing the various notifications/indication clients.

To support characteristic with control-point attributes as values, we
need also to have "Client Characteristic Configuration" support. This
is a per-client characteristic descriptor. The management of client
characteristic configuration will be handled by the BlueZ core, and
notifications/indications will only be sent to those clients that
explicitly enabled them in their configuration descriptor.

One idea for a notification API is to have three functions: two
callbacks, which will be called by the BlueZ core when a
characteristic has notification/indication enabled or disabled; and a
function which will be called by the profile implementation when a
characteristic value has been changed. The API would be:

/* callbacks implemented by the profile */
static void foobar_register_notification(uuid_t *uuid)
{
...
}

static void foobar_unregister_notification(uuid_t *uuid)
{
...
}

struct btd_attrib_profile profile = {
...
.register_notification = foobar_register_notification,
.unregister_notification = foobar_unregister_notification,
...
};

/* function called by the profile if a characteristic value changes */
attrib_notify_chr_value(uuid_t *uuid, const uint8_t *value, int len);

The register/unregister callbacks are useful to avoid Profiles
unnecessarily calling attrib_notify_chr_value() when there is no
notification/indication enabled by any client.

Note that the purpose is that the profile implementation does not have
do distinguish between notification and indication. The handle value
confirmation sent by a successful indication will be handled by the
BlueZ core.

Attribute permissions and Characteristic properties
===================================================

On the current implementation, all attribute permission checks (read,
write and basic authentication are implemented; authorization is not
supported yet) are made by the "core" attribute server. Having a
single implementation point for these security features is the main
reason for this choice. Authorization is not supported yet, but the
plan is to reuse the same machinery used by the authorization agent on
BR/EDR. This can be kept on the "core" as well, so profiles don't need
to bother with implementation details.

Characteristic properties are currently ignored. Once we implement
support for them, they will define which procedures (notifications,
indications, read, write) are permitted for a given characteristic.
This will also be handled by the core.

To read/write characteristic values, there would be callbacks to be
implemented by profile implementations (similar to the
"register_notification" shown above, but with another signature).

Summary/Open Issues
===================

1) Create a high level API for registering GATT services/characteristics
2) Implement "Client Characteristic Configuration" support (needed for
notifications/indications)
3) Notification/Indication API
4) Authorization support for attribute permissions
5) Implement handling of characteristic properties
6) Characteristic Read/Write callbacks
7) "Service Changed" characteristic from GAP service: we do not
implement it yet, but most certainly it will be handled by BlueZ core.
Profiles will just update their service entries using the server API.
8) Identify which API functions may require "btd_" prefix

Suggestions or comments are welcome.

PS: Happy New Year!
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

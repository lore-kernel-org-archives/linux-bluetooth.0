Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH 00/15] Attribute server management API
Date: Wed, 16 Mar 2011 21:00:24 -0400
Message-Id: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This series represents a proposal for an "Attribute server management API". It
consists of a D-Bus interface for registering services, specified as XML. It
was inspired on the existing SDP plugin (plugins/service.c), but the XML format
is totally different because the "record" concept used for SDP is much simpler
and lower level than GATT services.

The XML format is currently not documented, but I expect it to be intuitive for
those familiar with the definition of GATT services (of course, we can properly
document it once the API is accepted). Additionally, the API is high level, in
a sense that it is not required to specify attributes individually.

It was implemented as a plugin, so it can be easily disabled. It was also built
on top of the existing (internal) attribute API, requiring only an additional
attrib_db_find_avail() function which is used to find free handle "slots"
inside the attribute database.

What is currently implemented:

* Register primary/secondary services and service includes
* Register characteristics and descriptors (only "User Description" and
  "Presentation Format" are supported), including initial values
* Automatically unregister services when the D-Bus client exits

Open issues or not yet implemented:

* Documentation of the plugin API and XML format
* Better handling of malformed XML
* Remaining characteristic descriptors: Extended Properties, Client
  Configuration, Server Configuration and Aggregate Format
* Set attribute permissions for characteristic value and descriptors which are
  not read-only (note that these permissions are profile specific)
* Manipulate registered services (remove, modify) without requiring to
  disconnect from D-Bus
* Callbacks for value/descriptor read/writes (so externally implemented
  profiles could react on these procedures)
* Update characteristic value
* Better name for the plugin and D-Bus interface (currently it is
  "gatt-profile" and GattProfile, respectively)

Comments and suggestions are welcome. I would also appreciate comments
regarding coding style, given that I based on the SDP "service.c" plugin which
is quite old.

Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

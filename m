Return-Path: <cyrus@holtmann.org>
From: armansito@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ 0/2] Initial D-Bus GATT client API implementation.
Date: Tue, 11 Mar 2014 21:03:58 -0700
Message-Id: <1394597040-4483-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Arman Uguray <armansito@chromium.org>

Hi everyone,

I'm working on the GATT client API and I have an initial implementation that
exposes basic GATT service and characteristic objects via D-Bus. Before I go
any further in the implementation, I wanted to get some feedback on whether or
not I've been taking the right approach so far. Also, since this is the first
time I'm contributing to BlueZ, there might be some general style/convention
issues that I would like to get corrected sooner than later :)

This set includes two patches that add support for GATT service and
characteristic objects. Characteristic descriptors, characteristic value
read/write requests, characteristic value notifications and indications,
characteristic properties (flags) and permissions, and included services are
not yet implemented. The main implementation choices that I've made that I would
especially like comments on are the following:

  1. A GATT service is represented by instances of btd_gatt_dbus_service. A
  btd_device directly creates and owns services. It might actually be better to
  keep track of services and the devices that created them in src/gatt-dbus.c,
  as the way I implemented it might make managing included services difficult.

  2. btd_gatt_dbus_service objects get created in
  src/device.c:register_all_services. This may not be the right place to create
  them, but every time register_all_services gets called, a btd_device removes
  all GATT services that it created and reconstructs them. I took this route
  to keep the initial implementation simple but there might be a smarter way to
  go about it.

  3. GATT service hierarchies are not cached and services are created only after
  we connect to a remote device.

  4. A btd_device creates a btd_gatt_dbus_service object for all GATT primary
  services that it has created. Each service then individually does
  characteristic discovery based on it's handle range.

  5. GAttrib is used for discovery. GATT services obtain the GAttrib instance
  from btd_device by using its attio callbacks. I did it this way solely based
  on profiles (profiles/gatt/gas.c and profiles/gatt/heartrate.c) and for all I
  know this might be an absolutely terrible way of managing the ATT connection
  to the remote device, so please tell me whether or not this is the right
  approach.

  6. The first patch introduces a change to the way device_browse_primary gets
  called in device.c:att_connect_cb; the existing code doesn't do primary
  service discovery unless (as far as I understand) the connect request came
  over D-Bus, so an auto-connect won't discover remote GATT services, for
  example. I made a change here, not because I intended to change that code
  path, but because I was curious why it was done the way it is.

Arman Uguray (2):
  gatt-dbus: Add remote GATT service objects.
  gatt-dbus: Add remote GATT characteristic objects.

 src/device.c    |  47 ++++++++++-
 src/gatt-dbus.c | 255 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/gatt-dbus.h |  25 ++++++
 3 files changed, 321 insertions(+), 6 deletions(-)

-- 
1.8.3.2


Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/4] High level GATT API for service registration
Date: Fri,  4 Nov 2011 10:29:59 -0400
Message-Id: <1320417003-23493-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Following a previously sent RFC, this series implement an internal API that
simplifies GATT service registration on server implementations. It is built on
top of current "low level" attribute API, and both can be used at the same time
without problem.

It is currently being used for Phone Alert Status and Time profile server
implementations which we are preparing to send upstream (we previously sent RFC
patches for both of them).

As an example, I converted a service from the GATT example profile (see patch
#4). Note the migration to this API is optional, and can be done incrementally.

Still not implemented (but can be added later):

* No support for aggregate format descriptors, included services (also we don't
  have any example services using them)
* No support for some GATT descriptors
* No support for "static" characteristic values. Any readable or writeable
  characteristic needs a corresponding read or write callback

Best Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil

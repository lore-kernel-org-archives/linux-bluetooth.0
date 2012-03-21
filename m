Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RFC: GATT Client support for Included services
Date: Wed, 21 Mar 2012 14:13:28 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B453531@DNCE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Introduction
-------------
Included services in GATT are additional services referenced by another service. To represent that, we would need to change the way our GATT Client behaves. Currently, our GATT Client does not support this feature, but it is needed for implementing the HOGP, so it's time to add this functionality.
This is a high level changes design for supporting this feature.

Adding support
---------------
At first, we need to add support for secondary services. Secondary services are services which are not discoverable by the "discover_primary_services" method, and only exist when another service includes them. 
We will need to add a discover_included_services internal method which will iterate each primary service and search for its included services, and add them to the list of available services, to be probed to allow plugin drivers to do their job correctly.

Representing the services list
------------------------------
There are two options for handling primaries/secondaries/included services:
1. Hold two lists of services - one for primaries and one for secondaries, and simply add the primary and secondary services to those lists as we discover them
2. Have a single list of services, adding a service type property to the service structure to identify it's type.

In addition to that, we will need to add a list of included services to each service, to point to any included services it may have. This list must point to an already existing service structure, and cleanup procedures must be updated to clear all lists referencing a service when needed.

Characteristic discovery
---------------------------
When discovering characteristic for a service, which also includes additional services, will provide a list of characteristics available for the specific service start/end range, and will not include a list of characteristics belonging to included services. This is why we keep the included services as a separate list, and a client can use the referenced included service to discover characteristics in that specific service as well, as required. Including the included service characteristic in the same list as the master service, will cause confusion, by adding unrelated characteristics to a service, and making it more complex to follow on each characteristic and it's origin. In addition, if a service includes the same service twice, we will have a range of characteristics, with no easy ability to distinguish which one belongs to which service.


D-BUS
------
In addition, the DBUS representation of the services will have to change as well:
For a device, executing the GetProperties will show the following list of services -

dict entry(
         string "Services"
         variant             array [
               object path "/org/bluez/288/hci0/dev_64_9C_8E_E5_A0_E9/service0001"
               object path "/org/bluez/288/hci0/dev_64_9C_8E_E5_A0_E9/service000c"
               object path "/org/bluez/288/hci0/dev_64_9C_8E_E5_A0_E9/service0017"
               object path "/org/bluez/288/hci0/dev_64_9C_8E_E5_A0_E9/service0031"
               object path "/org/bluez/288/hci0/dev_64_9C_8E_E5_A0_E9/service0042"
            ]
      )

This will include both primary service discovered by "discover_primary_services" or by discovering secondary services which were included inside other primary services. I believe that all services should reside at the same level, regardless of their primary/secondary/included status - it is not really important which type it is at this level.

In addition, each of the services will have two new properties, which are actually an array of object paths:

string "Includes"
       variant             array [
        object path "/org/bluez/288/hci0/dev_64_9C_8E_E5_A0_E9/included_service00031"
        object path "/org/bluez/288/hci0/dev_64_9C_8E_E5_A0_E9/included_service00042"
      ]

string "IncludedBy"
       variant             array [
        object path "/org/bluez/288/hci0/dev_64_9C_8E_E5_A0_E9/included_service000c"
      ]

The "Includes" will simply list references of object paths to services included inside this service. 
The "IncludedBy" In addition, a list of services including this service will also be provided for clarity.

Lizardo, Claudio - I'm waiting for your inputs before I start implementing this and adding this functionality as a set of patches to the ML.

Thanks,

Chen Ganir
Texas Instruments


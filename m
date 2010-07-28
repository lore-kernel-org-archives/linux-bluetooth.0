Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jul 2010 16:33:23 +0100
From: Tim Renouf <tpraplix.vger@botech.co.uk>
To: linux-bluetooth@vger.kernel.org
Subject: add dbus api to set class of device?
Message-ID: <20100728153323.GA9410@aplixcorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all

I am putting a JSR82 implementation on an Android device that uses
BlueZ, accessing BlueZ via the dbus api.

JSR82 has an API where you can set service class bits for a particular
service you have registered. So the JSR82 implementation needs to be
able to set the class of device in some way. I would like to add a dbus
method to do this, and I'd like to know the opinion of BlueZ developers
on this:

1. Is this a reasonable thing to do and submit a patch for ?

2. What would be a good approach, out of the following (or any other
possibility I have missed) ?

2a. Add a dbus method to set service class bits for a registered
service. This would set a new field in sdp_record_t. The existing
function update_adapter_svclass_list in sdpd-service.c would read this
new field in every service record when determining the service class
bits to set. The setting gets cleared automatically when the service is
removed. This seems like the cleanest solution.

2b. Add a dbus method to set service class bits, or all device class
bits, globally for the dbus connection. There would have to be a list of
dbus connections, each storing the connection's requested class.
manager_update_svc would scan that list. The setting gets cleared
automatically when the dbus connection is lost.

2c. Add a dbus method to set service class bits, or all device class
bits, globally. This can just call the BlueZ internal method directly.
The problems with this are (i) it doesn't work if multiple apps are
trying to use it; (ii) the setting gets lost next time a service gets
registered or removed, so the app needs to be aware of this and reapply
its setting, and (iii) the setting remains if the app exits or crashes
without removing it.

I note that Bluecove-on-BlueZ does not implement this, therefore it
fails the same conformance test that I am looking at.

Thanks.

-tpr

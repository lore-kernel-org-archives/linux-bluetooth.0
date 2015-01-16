Return-Path: <cyrus@holtmann.org>
From: Joseph McLaughlin <JMcLaughlin@cybexintl.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: BLE peripheral with GATT DBus API
Date: Fri, 16 Jan 2015 18:50:10 +0000
Message-ID: <D0DEC78F.16D94%jmclaughlin@cybexintl.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi:

I’m trying to use BlueZ to implement a GATT server (peripheral) that will host a couple of custom BLE services with a multitude of characteristics each.  I was hoping to use the GATT Dbus API with BlueZ, but  I see from this post: http://article.gmane.org/gmane.linux.bluez.kernel/54715 that as of a few months ago, the GATT Dbus API is not quite ready.  Is this still the case with the latest BlueZ (5.27 as of now)?  I’m assuming so since I don’t see the API documentation in the doc folder.

The recommendation from that post was to use the gatt_service_add() API.  If this is still the recommended approach until the Dbus API is ready, can you expand a little bit more on how I would do this?  For example, do I need to figure out how to add a plugin, or can I create an external application that simply calls gatt_service_add().  Can I use the BlueZ stack as is, or do I need to hack it up a bit?  There were some “online examples" referred to in the previous post.  Any idea where I can find those?

Thanks,

Joe McLaughlin

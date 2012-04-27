Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ RFC 0/5] gdbus: Add support for DBus.Properties interface
Date: Fri, 27 Apr 2012 18:25:17 -0300
Message-Id: <1335561922-3518-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

This series adds DBus.Properties interface to gdbus - it's still missing the
PropertiesChanged signal, but we'd like to share early this code to get feedback.

See http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-properties

The intention is to replace the GetProperties method per-interface and use this
interface per-object instead. It adds some nice things like getting properties
separately, too.

This is just the infrastructure needed in gdbus. Henrique (that's working with
me on this) will send soon his changes on some of the interfaces so you can take
a look how it will be after these patches. After that we can work on finishing the
conversion for the other interfaces.


If you are going to test this series, it is intended to be applied on top of my
previous series improving gdbus introspection.


Lucas De Marchi (5):
  gdbus: add skeleton of DBus.Properties interface
  gdbus: implement DBus.Properties.Get method
  gdbus: implement DBus.Properties.GetAll method
  gdbus: implement DBus.Properties.Set method
  gdbus: add properties into interface introspection

 gdbus/gdbus.h  |   21 +++++-
 gdbus/object.c |  224 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 243 insertions(+), 2 deletions(-)

-- 
1.7.10


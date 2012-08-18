Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v3 00/15] gdbus: DBus.Properties + ObjectManager
Date: Sat, 18 Aug 2012 03:50:47 -0300
Message-Id: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,
	
here is a third version of the changes planned to gdbus. In contrary to
previous versions, this patch set includes also the Object Manager, since the
PropertiesChanged signal was made on top of it.

The first two patches are cosmetics to the other ones and somehow independent.

The last two patches are examples on how we would use the API after the conversion.

DBus.Properties.Set() is async now. We pass the message on so user can use it
to create the reply or error message.

Lucas De Marchi (10):
  gdbus: Move typedefs up
  gdbus: Define macros to add annotations
  gdbus: Add skeleton of DBus.Properties interface
  gdbus: Implement DBus.Properties.Get method
  gdbus: Implement DBus.Properties.GetAll method
  gdbus: Implement DBus.Properties.Set method
  gdbus: Add properties into Introspectable interface
  gdbus: Implement PropertiesChanged signal
  control: Use DBus.Properties
  audio: device: Use DBus.Properties

Luiz Augusto von Dentz (5):
  gdbus: Add support for org.freedesktop.DBus.ObjectManager interface
  gdbus: Group interface changes to reduce the amount of signals
    emitted
  gdbus: Only export ObjectManager interface on root path
  gdbus: Integrates ObjectManager with Properties interface
  gdbus: Simplify code for appending properties

 audio/control.c |  56 ++--
 audio/device.c  |  48 ++--
 gdbus/gdbus.h   |  66 +++--
 gdbus/object.c  | 783 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 797 insertions(+), 156 deletions(-)

-- 
1.7.11.5


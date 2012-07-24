Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v2 0/5] DBus.Properties
Date: Tue, 24 Jul 2012 07:46:21 -0300
Message-Id: <1343126786-12628-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2:
	s/property_name/name/
	s/interface_name/interface/

Original text:

This is the first part of the patches for implementing the DBus.Properties as
demonstrated during last BlueZ meeting. I changed the Properties.Set
implementation a little bit from what was demonstrated - the goal here is to
facilitate the use of the new API.

Luiz will send the ObjectManager implementation on top of these ones.


Lucas De Marchi (5):
  gdbus: Add skeleton of DBus.Properties interface
  gdbus: Implement DBus.Properties.Get method
  gdbus: Implement DBus.Properties.GetAll method
  gdbus: Implement DBus.Properties.Set method
  gdbus: Add properties into Introspectable interface

 gdbus/gdbus.h  |  22 +++++-
 gdbus/object.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 266 insertions(+), 2 deletions(-)

-- 
1.7.11.2


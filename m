Return-Path: <cyrus@holtmann.org>
From: Bea Lam <blam@trolltech.com>
To: linux-bluetooth@vger.kernel.org
Subject: Adapter API - Devices property not updated if connection initiated by remote device
Date: Thu, 11 Dec 2008 13:57:58 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812111357.59004.blam@trolltech.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using the org.bluez.Adapter interface, if I initiate a connection to a 
remote device, then the adapter's Devices property is updated to include the 
remote device, as expected. However, if the remote device initiates the 
connection to my device instead, it isn't added to the Devices list. This 
would appear to be a bug.

This can be problematic if I am trying to identify whether any remote devices 
are currently connected to the local adapter; it is not possible to identify 
the connected devices if they have initiated the connection.

It would be much appreciated if someone could look into this. Perhaps the 
adapter->devices list could be updated when adapter_add_active_conn() is 
called, but I'm not sure if this is correct.

Return-Path: <cyrus@holtmann.org>
Message-ID: <87E59FD9271E47DBA9A1F241EAAAD63D@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Cc: "Marcel Holtmann" <marcel@holtmann.org>
Subject: MINOR: libgdbus embedded in bluez does not agree with libgdbus
Date: Mon, 20 Jul 2009 19:26:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
List-ID: <bluez-devel.lists.sourceforge.net>

Specifically, the function g_dbus_cleanup_connection is missing for the 
Bluez version.  Is this by design???

David Stockwell 

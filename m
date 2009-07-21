Return-Path: <cyrus@holtmann.org>
Message-ID: <0FE22482A7FF4B6684D16C72DB28CD7E@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: MINOR: libgdbus embedded in bluez does not agree with libgdbus
Date: Tue, 21 Jul 2009 08:20:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Specifically, the function g_dbus_cleanup_connection is missing for the 
version embedded in Bluez.  Is this by design???

David Stockwell


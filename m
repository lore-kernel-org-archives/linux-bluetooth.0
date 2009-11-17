Return-Path: <cyrus@holtmann.org>
From: Thilo =?iso-8859-1?q?Rie=DFner?= <thilo@riessner.de>
To: linux-bluetooth@vger.kernel.org
Subject: bluetooth dead after suspend
Date: Tue, 17 Nov 2009 13:33:47 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200911171333.47667.thilo@riessner.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, my bluetooth works fine after normal boot, bat after suspending and 
resuming, it is dead. With my old installation (openSuSE 11.1) it was the 
same, but the problem could be solved by restarting bluetooth (rcbluetooth 
restart). With the new openSuSE 11.2 the rcbluetooth script vanished. As far 
as I understood, bluetooth gets started via dbus. But even a rcdbus restart 
does not help. Any idea of a quirk or workaround?
Thanks in advance for any help.

Thilo

Return-Path: <cyrus@holtmann.org>
Message-ID: <503F3AE2.2040800@tu-ilmenau.de>
Date: Thu, 30 Aug 2012 12:05:22 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: gnome-obex-send problem
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

i have two Scientific Linux 5.8 computers and a bluetooth 3.0+HS dongle 
at each PC. The bluetooth devices are paired. I want to transmit data 
files via bluetooth (more precisely: via HS) but it does not work:
On both PC's I added:
     # sdptool add ftp
     # sdptool add opush
then I tried:
     # nautilus-sendto <data-file>
and choosed the remote device. But I got an error: "gnome-obex-send: the 
remote device doesn't support object receiving".
Funny: When I shut down the remote device then i get the same error -.-
On top of that, I tried to start an obex server at the remote PC:
     # gnome-obex-server
     ** (gnome-obex-server:18545): WARNING **: OBEX server register 
error: -1
     ** (gnome-obex-server:18545): WARNING **: Unable to initialize OBEX 
source
     ** (gnome-obex-server:18545): WARNING **: Couldn't initialise OBEX 
listener

Does anyone know what to do?

Regards,
Steffen

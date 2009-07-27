Return-Path: <cyrus@holtmann.org>
Message-ID: <4A6E3161.7010105@dtsp.co.nz>
Date: Tue, 28 Jul 2009 10:59:45 +1200
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Gnome applet failing with current BlueZ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Using BlueZ 4.46 and Gnome Bluetooth 2.27.8, the applet icon fails to 
appear.  If I pull the USB adapter out and in the icon appears, but with 
a little red cross, and it isn't very functional.

Running the applet with -d (debug) I see nothing.  Doing the USB adapter 
out-in as well, I see:

Agent registration failed: Rejected send message, 2 matched rules; 
type="method_call", sender=":1.12" (uid=1000 pid=1473 
comm="bluetooth-applet -d ") interface="org.bluez.Adapter" 
member="RegisterAgent" error name="(unset)" requested_reply=0 
destination="org.bluez" (uid=0 pid=1100 comm="bluetoothd "))

I'm not sure when this stopped working, having got suitably confused 
over whether to use bluez-gnome or gnome-bluetooth I've ended up using 
neither for some time :)  bluez-gnome doesn't work either though.

It looks dbus related, but that's a black art to me...

Cheers,

Dave


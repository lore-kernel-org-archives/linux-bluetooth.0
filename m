Return-Path: <cyrus@holtmann.org>
In-Reply-To: <ac8af0be0902170031l32c54051w19fdedf1a2aabf6d@mail.gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/4] HFP Gateway profile
MIME-Version: 1.0
Message-ID: <OF0CE87466.E448C300-ONC1257561.00364325-C1257561.0037F61E@aweurope.be>
From: Thierry Pierret <extern.Thierry.Pierret@awtce.be>
Date: Wed, 18 Feb 2009 11:11:13 +0100
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Many thanks for this.

But it did not work either (same behaviour).
I only performed a quick test since currently I don't get the time to.
Here is what I noticed that I did not notice before :
New messages appear :

        bluetoothd[1815]: headset_probe: path 
/org/bluez/1815/hci0/dev_00_0E_ED_01_DA_55
        bluetoothd[1815]: probe failed with driver input-headset for 
device /org/bluez/1815/hci0/dev_00_0E_ED_01_DA_55

And after a while (a few seconds after the test ends), other messages 
appear :

        bluetoothd[1815]: Agent replied with an error: 
org.freedesktop.DBus.Error.NoReply, Did not receive a reply. Possible 
causes include: the remote application did not send a reply, the message 
bus security policy blocked the reply, the reply timeout expired, or the 
network connection was broken.
        bluetoothd[1815]: Access denied: Did not receive a reply. Possible 
causes include: the remote application did not send a reply, the message 
bus security policy blocked the reply, the reply timeout expired, or the 
network connection was broken.
And a "Cancel" message has been received by the Agent. I don't know if 
this has an impact or if it is a consequence of the disconnection.

I will dive into this issue in a few days.
As I do not catch all the points in the way the HFP profile works, I'm 
quite sure that I'm doing something wrong.
Will keep you informed.

Regards.
Thierry



Return-Path: <cyrus@holtmann.org>
From: Marcus Redeker <marcus@openremote.org>
Content-Type: text/plain; charset=utf-8
Subject: Bluez with dbus and Java
Message-Id: <B8A1D36D-3BFE-428D-B879-AE7294B33EE4@openremote.org>
Date: Thu, 9 Apr 2015 12:20:41 +0200
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All,

I am currently trying to interface with bluez from Java. Since I don’t want to create a JNI/JNA native mapping I thought that dbus is the way to go.
I am testing with debian Jessie which has already bluez5 support since I do want to use the new dbus interfaces.

Can anybody point me to some how to’s or documentation? 

I am already looking at the doc folder and the python dbus tests.
My goal is to simulate a bluetooth keyboard so our openremote home automation controller could eg. control a firetv.

My understanding so far is that I need to use the adapter-api to make myself discoverable and set a name and alias eg. „OR Virtual Keyboard“.
But I cannot set my device class through this api, correct? I will need to set this in /etc/bluetooth/main.conf?
The keyword „disable-plugins“ is not supported in main.conf anymore. How can I tell bluez to not listen on the HID PSM’s anymore since I want to use them?

Once this is solved I should use the profile-api to register my HID service, correct?
How can I create an SDP record? Do  I need to create a XML of my SDP record and use  "void RegisterProfile(object profile, string uuid, dict options)“.

Which API do I have to use the actually send my key events?

Thanks a lot for any help which is really appreciated.

Regards,
-Marcus



Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 16:02:31 -0300
Message-ID: <5d223510907021202gb1f466amc697137d582a168a@mail.gmail.com>
Subject: Can't connect to cell phone using dbus api
From: Rafael Seste <rseste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm trying to connect to my cellphone (nokia 5310) using the Dbus api.

First of all I created the device (org.bluez.Adapter.CreateDevice) and
it worked but it didn't request the pin code. The simple-agent was
running.

Then I tried to connect using org.bluez.Audio.Connect but it returned
the following error:

Error org.bluez.Error.ConnectFailed: Headset connect failed

I tried to change the profile to HeadsetGateway
(org.bluez.HeadsetGateway.Connect) and got this output:

Error org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with
signature "" on interface "org.bluez.HeadsetGateway" doesn't exist

Isn't it possible to connect with my cellphone? it has HSP/HFP.
Am I doing something wrong???

Thanks

-- 
Rafael S. Seste

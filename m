Return-Path: <cyrus@holtmann.org>
From: Pradeep Vivekanandan <vivekanandanp@hcl.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth: Help need on RegisterPlayer in simpleagent python script
 on bluez 5.7
Date: Tue, 18 Feb 2014 06:10:14 +0000
Message-ID: <A4B1A1B79EB08444A5B867A4254F4B88409189D4@chn-hclt-mbs05.HCLT.CORP.HCL.IN>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

I am running the bluetoothd in bluez 5.7.

I have execute test folder scripts i python.

For getting metadata information i run simple-player python script.

But i got the below error could please help on that how to get metadata information.
error:
File "./simple-player", line 149, in <module>
    media.RegisterPlayer(dbus.ObjectPath(path), player.properties)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: Method "RegisterPlayer" with signature "oa{sv}" on interface "org.bluez.Media1" doesn't exist

Also I could not found  the method RegisterPlayer  in org.bluez.Media1 using d-feet.

Thanks and Regards,
Pradeep V
end


::DISCLAIMER::
----------------------------------------------------------------------------------------------------------------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and intended for the named recipient(s) only.
E-mail transmission is not guaranteed to be secure or error-free as information could be intercepted, corrupted,
lost, destroyed, arrive late or incomplete, or may contain viruses in transmission. The e mail and its contents
(with or without referred errors) shall therefore not attach any liability on the originator or HCL or its affiliates.
Views or opinions, if any, presented in this email are solely those of the author and may not necessarily reflect the
views or opinions of HCL or its affiliates. Any form of reproduction, dissemination, copying, disclosure, modification,
distribution and / or publication of this message without the prior written consent of authorized representative of
HCL is strictly prohibited. If you have received this email in error please delete it and notify the sender immediately.
Before opening any email and/or attachments, please check them for viruses and other defects.

----------------------------------------------------------------------------------------------------------------------------------------------------


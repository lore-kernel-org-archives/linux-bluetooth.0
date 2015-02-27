Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 27 Feb 2015 12:10:00 -0800
Message-ID: <CAGXr9JFCzqUQXU7cLwPi0Q3_rinBd+A+kT2F=LxDJ75pPOiO4w@mail.gmail.com>
Subject: HID fast reconnects broken on Linux 3.19 / BlueZ 5.28
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

We recently updated our platform to use Linux 3.19 and BlueZ 5.28.

I immediately noticed that HID remote control reconnects back to BlueZ
host got slower. It would often take 3-5 seconds for the host to see
the first keypress from HID remote.

Running "btmgmt info" reveals that hci0 is no longer "connectable" and
"fast-connectable".

hci0: addr XX:XX:XX:XX:XX:XX version 6 manufacturer 72 class 0x000100
supported settings: powered connectable fast-connectable discoverable
bondable link-security ssp br/edr hs le advertising secure-conn
debug-keys privacy configuration
current settings: powered bondable ssp br/edr le secure-conn
name ...
short name ...

Regardless of the above, a previously paired HID remote is still able
to reconnect, so somewhere in BlueZ code the page scan must be turned
on.

I think what is missing from the code is that wherever page scan is
turned on, the page scan interval should be configured as well, when
fast reconnects are desired.

In order to work around this issue, I had to use the following patch
in src/adapter.c to force "connectable" and "fast-connectable" on at
all times:

@@ -7142,6 +7143,11 @@ static void read_info_complete(uint8_t status,
uint16_t length,

        if (adapter->current_settings & MGMT_SETTING_POWERED)
                adapter_start(adapter);
+       else
+               set_mode(adapter, MGMT_OP_SET_POWERED, 0x01);
+
+       set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x01);
+       set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);

Can someone clarify how previously paired BT Classic devices reconnect
back to host when the hci interface is not connectable?

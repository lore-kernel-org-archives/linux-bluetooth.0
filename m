Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05071213476bbc0fa0@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net, cktakahasi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] bluetoothd specification
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 12 Jul 2005 17:47:38 -0300

Hi Marcel,

Periodic inquiry and adapter setup is extremely
necessary for me. Is it possible set a high priority
for these features?

Regarding the interfaces and objects path of the=20
bluetoothd my suggestion is:

>>>bluetoothd
DBus service :    org.bluez.hci
DBus interface:   org.bluez.hci
DBus object path: org/bluez/hci
    - setup link properties
    - setup inquiry mode
    - kill bluetoothd
    - show local adapters
    - ???
>>>SDP
DBus service :    org.bluez.sdp
DBus interface:   org.bluez.sdp
DBus object path: org/bluez/sdp
methods:
    - search
    - register/unregister
    - get local services
    - ???

>>>PAN
DBus service :    org.bluez.pan
DBus interface:   org.bluez.pan
DBus object path: org/bluez/pan
    - connect/disconnect
    - listen start/stop
    - connections


Open issues:
- How/Where handle multiple bluetooth adapters?
  solution1: the device id (hci0) can be part of object path
  eg: org.bluez.hci0.pan org.bluez.hci0.sdp
            =20
  solution2: pass the device id as parameter or define a method=20
             to set the active adapter.


I am not sure if it is better define a hierarchical objects or
register multiples objects. Dbus support two functions:
dbus_connection_register_object_path and=20
dbus_connection_register_fallback(for a given subsection of the=20
object hierarchy). But I think that it is not important now because
for both approachs the message handler functions are distinct.
I will investigate more which approach is the best.

Defining an hierarchical approach make easier define policy/rules
in the dbus configuration files.=20

Do you have a different design for it or suggestions?
There are a lot services that shall be inserted in the bluetoothd,
maybe should be better define multiple interfaces(adapter, link, ... )=20
for this daemon.


Regards,
Claudio.


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

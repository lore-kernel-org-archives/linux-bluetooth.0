Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Michael Schmidt <mike_schmidt@gmx.net>
Subject: Re: A2DP: simple-agent vs bluetoothctl
To: linux-bluetooth@vger.kernel.org
References: <79b36674-39ec-8d96-8515-4c0ef79e45ee@gmx.net>
 <CAHU4CU+PBowrTEqahB_BJWi=E0PuhFGscpD+e68ZUBakOFzCcQ@mail.gmail.com>
Message-ID: <92b0a647-10c7-1bdc-1d7b-93db8e082e61@gmx.net>
Date: Mon, 1 Jan 2018 13:42:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAHU4CU+PBowrTEqahB_BJWi=E0PuhFGscpD+e68ZUBakOFzCcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Ahmed,

Thanks a lot for your quick feedback!

I'm actually working on a Bluetooth audio receiver on a Raspberry Pi
based on an article in the German c't computer magazine from about a
year ago. There, they start a modified 'simple-agent' Python script from
within '.profile' of a regular (non-root) user ('pi'). The script is
attached. It basically starts a loop where it waits for pairing and
connection requests and confirms these without user interaction.

This setup used to work more or less flawlessly with Raspbian Jessie.
With Stretch, however, I'm seeing a variety of behaviors from "pairing
rejected" over "paired, but not trusted" to "working OK" (rare). This
inconsistent behavior lets me believe that the BT device is missing
initialization into a predictable state (pairable, discoverable, any
other?) before the script is called. I'm currently playing with explicit
initialization sequences using 'bluetoothctl', but I'm also wondering
how this used to work with Raspbian Jessie before.

The most common behavior is "paired, but not trusted", which yields the
following errors in syslog:
Jan  1 12:40:53 Raspi-2 bluetoothd[615]: Authentication attempt without
agent
Jan  1 12:40:53 Raspi-2 bluetoothd[615]: Hands-Free unit rejected
5C:51:88:89:40:C0: org.bluez.Error.Rejected
Jan  1 12:40:54 Raspi-2 bluetoothd[615]: Authentication attempt without
agent
Jan  1 12:40:54 Raspi-2 bluetoothd[615]: Access denied:
org.bluez.Error.Rejected

/var/lib/bluetooth/<host MAC addr>/<client MAC addr>/info contains
'Trusted=false' in this case.

I have also taken a look at your 'bluew' Python library. This seems to
be the most consistent approach for my problem, but would also mean
re-implementation of the entire script. I'm still reluctant to go this way

Thanks and cheers, Michael


Am 01.01.2018 um 02:41 schrieb Ahmed Alsharif:
> On Dec 31, 2017 11:44, <mortadelo@gmx-topmail.de> wrote:
>> Hi,
>>
>> I'm currently playing with A2DP in Raspbian Stretch (i.e. Bluez
>> 5.43-2+rpt2+deb9u2). I understand that there has been an architectural
>> rework in BT pairing, connetion acceptance etc. handling. Whereas in
>> earlier versions of BlueZ, the script 'simple-agent' was provided for a
>> scripted (possibly unattended) pairing and connection handling, this
>> script is no more available. 'bluetoothctl' is the actual replacement.
>>
>> ....
>>
>> What is the current philosophy behind pairing and connection management?
>> Is 'simple-agent' still supposed to work, and I'm using it wrong, or is
>> 'bluetoothctl' the way to go? If the latter, will it ever be scriptable?
>>
>>
>> Thanks and kind regards, Michael
> Hi,
>
> You can use bluetoothctl non-interactively in the following way:
>
> #  $ bluetoothctl << __EOL__
> #  > connect xx:xx:xx:xx:xx:xx
> #  > __EOL__
>
> connect and trust seem to work fine this way, but pair doesn't. If
> you're okay with using python, checkout this library:
> https://github.com/nullp0tr/bluew. I'm also planning to add a
> non-interactive bluetoothctl alternative to it, but you can easily
> write a 3 liner with it that does what you need (disclaimer: I wrote
> it).
>
>> My problem with 'bluetoothctl' is that, due to its interactive
>> character, it is hard to impossible to use in scripts. 'simple-agent'
>> (the previous version), however, seems to have become somewhat
>> unpredictable in current Bluez. I haven't managed to implement a
>> consistent and predictable flow of pairing -set trust - connect anymore
>> with 'simple-agent'. Typically (but not consistently), the pairing would
>> not be set to 'Trusted=true'.
> Overall simple-agent should still work. Examples/code snippets of your
> current 'flow', and the errors returned would help in finding the
> problem.
>
>
> Cheers,
> Ahmed Alsharif.

attached script:
#!/usr/bin/python

#Automatically authenticating bluez agent. Script modifications by
Merlin Schumacher <mls@ct.de> for c't Magazin (www.ct.de)

from __future__ import absolute_import, print_function, unicode_literals

from optparse import OptionParser
import sys
import dbus
import dbus.service
import dbus.mainloop.glib
try:
  from gi.repository import GObject
except ImportError:
  import gobject as GObject

SERVICE_NAME = "org.bluez"
ADAPTER_INTERFACE = SERVICE_NAME + ".Adapter1"
DEVICE_INTERFACE = SERVICE_NAME + ".Device1"

def get_managed_objects():
    bus = dbus.SystemBus()
    manager = dbus.Interface(bus.get_object("org.bluez", "/"),
                "org.freedesktop.DBus.ObjectManager")
    return manager.GetManagedObjects()

def find_adapter(pattern=None):
    return find_adapter_in_objects(get_managed_objects(), pattern)

def find_adapter_in_objects(objects, pattern=None):
    bus = dbus.SystemBus()
    for path, ifaces in objects.iteritems():
        adapter = ifaces.get(ADAPTER_INTERFACE)
        if adapter is None:
            continue
        if not pattern or pattern == adapter["Address"] or \
                            path.endswith(pattern):
            obj = bus.get_object(SERVICE_NAME, path)
            return dbus.Interface(obj, ADAPTER_INTERFACE)
    raise Exception("Bluetooth adapter not found")

def find_device(device_address, adapter_pattern=None):
    return find_device_in_objects(get_managed_objects(), device_address,
                                adapter_pattern)

def find_device_in_objects(objects, device_address, adapter_pattern=None):
    bus = dbus.SystemBus()
    path_prefix = ""
    if adapter_pattern:
        adapter = find_adapter_in_objects(objects, adapter_pattern)
        path_prefix = adapter.object_path
    for path, ifaces in objects.iteritems():
        device = ifaces.get(DEVICE_INTERFACE)
        if device is None:
            continue
        if (device["Address"] == device_address and
                        path.startswith(path_prefix)):
            obj = bus.get_object(SERVICE_NAME, path)
            return dbus.Interface(obj, DEVICE_INTERFACE)

    raise Exception("Bluetooth device not found")



BUS_NAME = 'org.bluez'
AGENT_INTERFACE = 'org.bluez.Agent1'
AGENT_PATH = "/test/agent"

bus = None
device_obj = None
dev_path = None

def ask(prompt):
    try:
        return raw_input(prompt)
    except:
        return input(prompt)

def set_trusted(path):
    props = dbus.Interface(bus.get_object("org.bluez", path),
                    "org.freedesktop.DBus.Properties")
    props.Set("org.bluez.Device1", "Trusted", True)

def dev_connect(path):
    dev = dbus.Interface(bus.get_object("org.bluez", path),
                            "org.bluez.Device1")
    dev.Connect()

class Rejected(dbus.DBusException):
    _dbus_error_name = "org.bluez.Error.Rejected"

class Agent(dbus.service.Object):
    exit_on_release = True

    def set_exit_on_release(self, exit_on_release):
        self.exit_on_release = exit_on_release

    @dbus.service.method(AGENT_INTERFACE,
                    in_signature="", out_signature="")
    def Release(self):
        print("Release")
        if self.exit_on_release:
            mainloop.quit()

    @dbus.service.method(AGENT_INTERFACE,
                    in_signature="os", out_signature="")
    def AuthorizeService(self, device, uuid):
        print("AuthorizeService (%s, %s)" % (device, uuid))
        set_trusted(device)
        return

    @dbus.service.method(AGENT_INTERFACE,
                    in_signature="o", out_signature="s")
    def RequestPinCode(self, device):
        print("RequestPinCode (%s)" % (device))
        set_trusted(device)
                return "1234"

    @dbus.service.method(AGENT_INTERFACE,
                    in_signature="o", out_signature="u")
    def RequestPasskey(self, device):
        print("RequestPasskey (%s)" % (device))
        set_trusted(device)
        passkey = ask("Enter passkey: ")
        return dbus.UInt32(passkey)

    @dbus.service.method(AGENT_INTERFACE,
                    in_signature="ouq", out_signature="")
    def DisplayPasskey(self, device, passkey, entered):
        print("DisplayPasskey (%s, %06u entered %u)" %
                        (device, passkey, entered))

    @dbus.service.method(AGENT_INTERFACE,
                    in_signature="os", out_signature="")
    def DisplayPinCode(self, device, pincode):
        print("DisplayPinCode (%s, %s)" % (device, pincode))

    @dbus.service.method(AGENT_INTERFACE,
                    in_signature="ou", out_signature="")
    def RequestConfirmation(self, device, passkey):
        print("RequestConfirmation (%s, %06d)" % (device, passkey))
        set_trusted(device)
        return

    @dbus.service.method(AGENT_INTERFACE,
                    in_signature="o", out_signature="")
    def RequestAuthorization(self, device):
        print("RequestAuthorization (%s)" % (device))
        set_trusted(device)
        return

    @dbus.service.method(AGENT_INTERFACE,
                    in_signature="", out_signature="")
    def Cancel(self):
        print("Cancel")

def pair_reply():
    print("Device paired")
    set_trusted(dev_path)
    dev_connect(dev_path)
    mainloop.quit()

def pair_error(error):
    err_name = error.get_dbus_name()
    if err_name == "org.freedesktop.DBus.Error.NoReply" and device_obj:
        print("Timed out. Cancelling pairing")
        device_obj.CancelPairing()
    else:
        print("Creating device failed: %s" % (error))


    mainloop.quit()

if __name__ == '__main__':
    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)

    bus = dbus.SystemBus()

    capability = "NoInputNoOutput"

    parser = OptionParser()
    parser.add_option("-i", "--adapter", action="store",
                    type="string",
                    dest="adapter_pattern",
                    default=None)
    parser.add_option("-c", "--capability", action="store",
                    type="string", dest="capability")
    parser.add_option("-t", "--timeout", action="store",
                    type="int", dest="timeout",
                    default=60000)
    (options, args) = parser.parse_args()
    if options.capability:
        capability  = options.capability

    path = "/test/agent"
    agent = Agent(bus, path)

    mainloop = GObject.MainLoop()

    obj = bus.get_object(BUS_NAME, "/org/bluez");
    manager = dbus.Interface(obj, "org.bluez.AgentManager1")
    manager.RegisterAgent(path, capability)

    print("Agent registered")

    if len(args) > 0 and args[0].startswith("hci"):
        options.adapter_pattern = args[0]
        del args[:1]

    if len(args) > 0:
        device = find_device(args[0],
                        options.adapter_pattern)
        dev_path = device.object_path
        agent.set_exit_on_release(False)
        device.Pair(reply_handler=pair_reply, error_handler=pair_error,
                                timeout=60000)
        device_obj = device
    else:
        manager.RequestDefaultAgent(path)

    mainloop.run()


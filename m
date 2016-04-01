Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 1 Apr 2016 16:21:59 -0400
From: Don Zickus <dzickus@redhat.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: example GATT code to talk with a sensortag
Message-ID: <20160401202159.GY159470@redhat.com>
References: <20160108222608.GU152924@redhat.com>
 <CABBYNZ+bpQQH6XhM20d62wy5Y-PWw_Vq7_jhriHFmmLvJVHtAg@mail.gmail.com>
 <20160111145735.GW152924@redhat.com>
 <1452537920.4584.16.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452537920.4584.16.camel@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 11, 2016 at 07:45:20PM +0100, Bastien Nocera wrote:
> > > bluetoothctl has some generic support for GATT attributes, in
> > > addition
> > > we have some examples in python under test/example-gatt-client and
> > > test/example-gatt-server.
> > 
> > Hi Luis,
> > 
> > Perfect, thanks!!
> 
> Let me know how far you manage to get. I have one such device from
> "Proximo" which I was hoping to be able to use.

Hi Bastien,

Sorry for the late reply.  We have had this script working for awhile now.
It is menu driven.  Just select 'find devices' and then select your
device to have it dump out a table.  It is very minimalistic but you can get
the point (I hope :-) ).

Cheers,
Don

================================
#!/usr/bin/python

import argparse
import dbus
import gobject
import sys
import pprint
import time
import traceback

from dbus.mainloop.glib import DBusGMainLoop

# defines
ADAPTER_IFACE =      'org.bluez.Adapter1'
BLUEZ_SERVICE_NAME = 'org.bluez'
DBUS_OM_IFACE =      'org.freedesktop.DBus.ObjectManager'
DBUS_PROP_IFACE =    'org.freedesktop.DBus.Properties'
DEVICE_IFACE =       'org.bluez.Device1'
GATT_SERVICE_IFACE = 'org.bluez.GattService1'
GATT_CHRC_IFACE =    'org.bluez.GattCharacteristic1'

# global
g_bus = None
g_mainloop = None

def init_global():
    global g_bus
    g_bus = dbus.SystemBus()
    global g_mainloop
    g_mainloop = gobject.MainLoop()

# bluez utility functions
def get_device_interface(object_path):
    proxy = g_bus.get_object(BLUEZ_SERVICE_NAME, object_path)
    dev_interface = dbus.Interface(proxy, DEVICE_IFACE)
    return dev_interface

def get_device_property(object_path, property):
    dbus_interface = get_dbus_prop_interface(object_path)
    prop = dbus_interface.Get(DEVICE_IFACE, property)
    return prop

def get_dbus_prop_interface(object_path):
    proxy = g_bus.get_object(BLUEZ_SERVICE_NAME, object_path)
    dbus_interface = dbus.Interface(proxy, DBUS_PROP_IFACE)
    return dbus_interface

def get_gatt_svc_interface(object_path):
    proxy = g_bus.get_object(BLUEZ_SERVICE_NAME, object_path)
    gatt_interface = dbus.Interface(proxy, GATT_CHRC_IFACE)
    return gatt_interface

def get_dbus_manager():
    manager = dbus.Interface(g_bus.get_object(BLUEZ_SERVICE_NAME, "/"),
			     DBUS_OM_IFACE)
    return manager

def get_managed_objects():
    manager = get_dbus_manager()
    objects = manager.GetManagedObjects()
    return objects
        
# generic callbacks

def generic_error_cb(error):
    print('D-Bus call failed: ' + str(error))
    g_mainloop.quit()

def interfaces_removed_cb(object_path, interfaces):
    print "interfaces_removed_cb: %s" % object_path


# Generic BT Device (hopefully)
class BTDevice:
    """manager of cc2260"""
    def __init__(self, service_path):
        print "path = %s" % service_path
        self.object_path = service_path
        s1 = service_path
        s2 = 'dev_'
        address = s1[s1.index(s2) + len(s2):]
        self.address = address.replace('_', ':')
        self.notify_count = 0
        self.gatt_service_retry = True

    def get_all(self):
        dbus_interface = get_dbus_prop_interface(self.object_path)
        try:
            self.service_props = dbus_interface.GetAll(DEVICE_IFACE)
            print "\nName: %s" % self.service_props['Name']
            print "Adapter: %s\n" % self.service_props['Adapter']
        except:
            self.service_props = None
            self.disconnect()

    def get_uuids(self):
        self.uuids = []
        if self.service_props:
            if 'UUIDs' in self.service_props:
                self.uuids = self.service_props['UUIDs']

        print "there are %d primary uuids:" % len(self.uuids)
        for u in self.uuids:
            print "     %s" % u

    def get_gatt_services(self):
        # GattServices are not always immediately present
        # perhaps we could drive the mainloop here and wait
        # for them to appear, but for now the hack solution
        # is to sleep for up to 10 seconds
        # BUG: sometimes the sensor requires a reset to resolve
        # this issue
        if 'GattServices' not in self.service_props:
            wait = 10
            print "\nwaiting %d seconds for gatt services to materialize" \
                % wait
            time.sleep(wait)
            self.get_all()
        if 'GattServices' in self.service_props:
            self.gatt_services = self.service_props['GattServices']
        else:
            self.gatt_services = []
        print "there are %d gatt_services" % len(self.gatt_services)
        if not self.gatt_services:
            if self.gatt_service_retry:
                # avoid infinite recursion
                self.gatt_service_retry = False
                print "timing failure -> retry"
                self.get_gatt_services()
            else:
                print "unable to locate gatt_services -> Failure"
                sys.exit(-1)
        else:
            for svc in self.gatt_services:
                print "     %s" % svc

    def exists(self):
        found = False
        objects = get_managed_objects()
        for path, ifaces in objects.iteritems():
            if path == self.object_path:
                found = True
                break

        return found

    def connected(self):
        _connected = get_device_property(self.object_path, 'Connected')
        return _connected

    def connect(self):
        if not self.connected():
            dev_interface = get_device_interface(self.object_path)
            print "\nattempting to connect to %s" % self.object_path
            try:
                dev_interface.Connect()
                print "connected"
            except:
                print(traceback.format_exc())
                raise Exception("unable to connect to device")

    def disconnect(self):
        if self.connected():
            dev_interface = get_device_interface(self.object_path)
            if dev_interface:
                print "\nattempting to disconnect..."
                try:
                    dev_interface.Disconnect()
                except:
                    print(traceback.format_exc())
                    raise Exception("unable to disconnect to device")
            else:
                # don't see how this can happen if connected returned
                # True -> perhaps a race condition
                raise Exception("device does not exist")
        print "disconnected!!!!!!\n"

    def sensor_cb(self, iface, changed_props, invalidated_props):
        if iface != DEVICE_IFACE:
            return

        # check to see if Connected property has changed
        connected = changed_props.get('Connected')
        if connected is None:
            return

        # it has -> probably means not connected
        print "Connected status is now %s" % connected
        if not connected:
            print "device is no longer connected"
            g_mainloop.quit()

class BTAdapter:
    def __init__(self):
        adapters = []

        self.om = dbus.Interface(g_bus.get_object(BLUEZ_SERVICE_NAME, '/'),
                                 DBUS_OM_IFACE)

        objects = self.om.GetManagedObjects()
        
        for path, interfaces in objects.iteritems():
            if ADAPTER_IFACE not in interfaces:
                continue
            #self.print_field('Adapter', path)
            adapters.append(path)

        if not adapters:
            raise Exception("No adapters located")
        if len(adapters) > 1:
            raise Exception("More than one adapter located")

        self.path = adapters[0]

        proxy = g_bus.get_object(BLUEZ_SERVICE_NAME, adapters[0])
        self.interface = dbus.Interface(proxy, ADAPTER_IFACE)
        self.target_path = None
        self.devices = {}
        self.disco_duration = 60
        self.disco_interval = 5
        return

    def print_field(self, field, value):
        print "%-10s: %s" % (field, value)

    def print_val(self, props, key, convert=False):
        if key in props:
            if convert:
                self.print_field(key, hex(int(props[key])))
            else:
                self.print_field(key, props[key])

    def get_devices(self):
        objects = self.om.GetManagedObjects()
        for path, interfaces in objects.iteritems():
            if DEVICE_IFACE not in interfaces:
                continue
            props = interfaces[DEVICE_IFACE]
            self.devices[path] = props
        return self.devices
            
    def list_devices_summary(self):
        print
        self.get_devices()
        idx = 1
        for device in self.devices:
            props = self.devices[device]
            print "%s: %-40s: %s" % (repr(idx), props['Name'], device)
            idx = idx + 1
        print

    def list_devices_details(self):
        self.get_devices()
        for device in self.devices:
            props = self.devices[device]
            self.print_field("Path", device)
            self.print_val(props, 'Name')
            self.print_val(props, 'Alias')
            self.print_val(props, 'Address')
            self.print_val(props, 'Class', True)
            self.print_val(props, 'Icon')
            self.print_val(props, 'Adapter')
            self.print_val(props, 'Connected')
            if 'UUIDs' in props:
                for uuid in props['UUIDs']:
                    self.print_field('UUID', uuid)
            print                

    def properties_cb(self, iface, changed_props, invalidated_props):
        print "properties_cb"
        print changed_props
        print invalidates_props

    def start_discovery_timeout_cb(self):
        sys.stdout.write('*')
        sys.stdout.flush()
        self.disco_count = self.disco_count + 1
        if self.disco_count * self.disco_interval >= self.disco_duration:
            # discovery is complete
            g_mainloop.quit()
            return False
        return True

    def interface_added(self, object_path, interfaces):
        if DEVICE_IFACE in interfaces:
            if object_path not in self.devices:
                self.discovered.append(object_path)

    def interface_removed(self, object_path, interfaces):
        if DEVICE_IFACE in interfaces:
            print "removed interface %s" % object_path

    def start_discovery(self):
        self.om.connect_to_signal('InterfacesAdded', self.interface_added)
        self.om.connect_to_signal('InterfacesRemoved', self.interface_removed)
        self.om.connect_to_signal("PropertiesChanged", self.properties_cb)
        # start a timer, this will run forever otherwise
        self.timer_id = gobject.timeout_add(self.disco_interval * 1000,
                                            self.start_discovery_timeout_cb)
        self.discovered = list()
        self.disco_count = 0
        print
        print "START DISCOVERY - this operation will take %s seconds to " \
            "complete" % self.disco_duration
        self.interface.StartDiscovery()
        try:
            g_mainloop.run()
        except:
            print(traceback.format_exc())
            sys.exit(-1)
        self.interface.StopDiscovery()
        print
        if not self.discovered:
            print "no devices were found during discovery"
        else:
            for d in self.discovered:
                print "discovered: %s" % d
        print "DISCOVERY COMPLETE"
        print
        return
        
    def find_device(self, object_path):
        self.om.connect_to_signal('InterfacesAdded', self.find_device_cb)
        self.target_path = object_path
        self.interface.StartDiscovery()
        print "attempting discovery for specific device"
        try:
            g_mainloop.run()
        except KeyboardInterrupt:
            print "\n"
        return

    def find_device_cb(self, object_path, interfaces):
        print "find_device_cb: %s" % object_path
        print "target_path = %s" % self.target_path
        if object_path == self.target_path:
            print "found device: %s" % object_path
            g_mainloop.quit()


def list_options(d):
    min_opt = 1
    optno = 0
    optlist = list()

    print
    print "please choose a device or option from the following menu:"
    print

    first = True
    for path in d:
        props = d[path]
        # if the device doesn't have a name - we don't care about it
        if 'Name' not in props:
            continue
        optno = optno + 1
        print "%s: %-40s: %s" % (repr(optno), props['Name'], path)
        optlist.append(path)

    optno = optno + 1
    print "%s: %s" % (repr(optno), "perform bluetooth discovery")

    optno = optno + 1
    print "%s: exit program" % repr(optno)

    print

    max_opt = optno
    return (min_opt, max_opt, optlist)

def get_answer(optinfo):
    
    minval = optinfo[0]
    maxval = optinfo[1]
    paths = optinfo[2]

    ans = 0
    while ans < minval or ans > maxval:
        ans = raw_input("please enter a value from %d to %d: " %
                        (minval, maxval))
        try:
            ans = int(ans)
        except:
            pass

    if ans == maxval:
        path = "EXIT"
    elif ans == (maxval - 1):
        path = "DISCO"
    else:
        path = paths[ans-1]
    return path

def main():
    # Set up the main loop.
    DBusGMainLoop(set_as_default=True)

    init_global()

    adapter = BTAdapter()

    done = False
    path = None

    # figure out what device the user wants to test with
    while not done:
        devices = adapter.get_devices()
        optinfo = list_options(devices)
        option = get_answer(optinfo)
        if option == "EXIT":
            done = True
        elif option == "DISCO":
            adapter.start_discovery()
        else:
            done = True
            path = option

    # has the user selected a device
    if path:
        print
        print "processing device %s" % path
        print
        device = BTDevice(path)
        device.connect()
        device.get_all()
        device.get_uuids()
        device.get_gatt_services()
        device.disconnect()
        
    return

if __name__ == '__main__':
    main()

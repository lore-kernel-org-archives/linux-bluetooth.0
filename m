Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426180319-16509-5-git-send-email-jamuraa@chromium.org>
References: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
	<1426180319-16509-5-git-send-email-jamuraa@chromium.org>
Date: Thu, 12 Mar 2015 13:00:02 -0700
Message-ID: <CAHrH25Rqks4KxqrLC5f0enZtQhFcC0kFe0h5zfMYSafu95qjiA@mail.gmail.com>
Subject: Re: [BlueZ 04/12] tools: Python script to test Advertisement API
From: Arman Uguray <armansito@chromium.org>
To: Michael Janssen <jamuraa@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> On Thu, Mar 12, 2015 at 10:11 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> This script provides an example of using the advertisement-data
> D-Bus API from python.
> ---
>  tools/advertisement-example | 160 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 tools/advertisement-example
>
> diff --git a/tools/advertisement-example b/tools/advertisement-example
> new file mode 100644
> index 0000000..dcd2ea2
> --- /dev/null
> +++ b/tools/advertisement-example
> @@ -0,0 +1,160 @@
> +#!/usr/bin/python
> +
> +import dbus
> +import dbus.exceptions
> +import dbus.mainloop.glib
> +import dbus.service
> +
> +import array
> +import gobject
> +
> +from random import randint
> +
> +mainloop = None
> +
> +BLUEZ_SERVICE_NAME = 'org.bluez'
> +LE_ADVERTISING_MANAGER_IFACE = 'org.bluez.LEAdvertisingManager1'
> +DBUS_OM_IFACE = 'org.freedesktop.DBus.ObjectManager'
> +DBUS_PROP_IFACE = 'org.freedesktop.DBus.Properties'
> +
> +LE_ADVERTISEMENT_IFACE = 'org.bluez.LEAdvertisement1'
> +
> +
> +class InvalidArgsException(dbus.exceptions.DBusException):
> +    _dbus_error_name = 'org.freedesktop.DBus.Error.InvalidArgs'
> +
> +
> +class NotSupportedException(dbus.exceptions.DBusException):
> +    _dbus_error_name = 'org.bluez.Error.NotSupported'
> +
> +
> +class NotPermittedException(dbus.exceptions.DBusException):
> +    _dbus_error_name = 'org.bluez.Error.NotPermitted'
> +
> +
> +class InvalidValueLengthException(dbus.exceptions.DBusException):
> +    _dbus_error_name = 'org.bluez.Error.InvalidValueLength'
> +
> +
> +class FailedException(dbus.exceptions.DBusException):
> +    _dbus_error_name = 'org.bluez.Error.Failed'
> +
> +
> +class Advertisement(dbus.service.Object):
> +    PATH_BASE = '/org/bluez/example/advertisement'
> +
> +    def __init__(self, bus, index, advertising_type):
> +        self.path = self.PATH_BASE + str(index)
> +        self.bus = bus
> +        self.ad_type = advertising_type
> +        self.service_uuids = None
> +        self.manufacturer_specific_data = None
> +        self.solicit_uuids = None
> +        self.service_data = None
> +        dbus.service.Object.__init__(self, bus, self.path)
> +
> +    def get_properties(self):
> +        properties = dict()
> +        properties['Type'] = self.ad_type
> +        if self.service_uuids is not None:
> +            properties['ServiceUUIDs'] = dbus.Array(self.service_uuids,
> +                                                    signature='s')
> +        if self.solicit_uuids is not None:
> +            properties['SolicitUUIDs'] = dbus.Array(self.solicit_uuids,
> +                                                    signature='s')
> +        if self.manufacturer_specific_data is not None:
> +            properties['ManufacturerSpecificData'] = dbus.Dictionary(
> +                self.manufacturer_specific_data, signature='qay')
> +        if self.service_data is not None:
> +            properties['ServiceData'] = dbus.Dictionary(self.service_data,
> +                                                        signature='say')
> +        return {LE_ADVERTISEMENT_IFACE: properties}
> +
> +    def get_path(self):
> +        return dbus.ObjectPath(self.path)
> +
> +    def add_service_uuid(self, uuid):
> +        if not self.service_uuids:
> +            self.service_uuids = []
> +        self.service_uuids.append(uuid)
> +
> +    def add_manufacturer_data(self, manuf_code, data):
> +        if not self.manufacturer_specific_data:
> +            self.manufacturer_specific_data = dict()
> +        self.manufacturer_specific_data[manuf_code] = data
> +
> +    @dbus.service.method(DBUS_PROP_IFACE,
> +                         in_signature='s',
> +                         out_signature='a{sv}')
> +    def GetAll(self, interface):
> +        print 'GetAll'
> +        if interface != LE_ADVERTISEMENT_IFACE:
> +            raise InvalidArgsException()
> +        print 'returning props'
> +        return self.get_properties[LE_ADVERTISEMENT_IFACE]
> +
> +    @dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
> +    def GetManagedObjects(self):

Nowhere in the documentation do we mention that ObjectManager is
required for this API and frankly I don't think it's necessary, since
you only register one LEAdvertisement1 object at a time (whose path
you provide to RegisterAdvertisement already). ObjectManager was
necessary for the GATT API, since we needed to atomically fetch the
object paths and properties of an entire
Service/Characteristic/Descriptor tree, but in the LEAdvertisement1
case it's much simpler.

> +        response = {}
> +        print 'GetManagedObjects'
> +
> +        print self.get_properties()
> +        response[self.get_path()] = self.get_properties()
> +        return response
> +
> +
> +class TestAdvertisement(Advertisement):
> +
> +    def __init__(self, bus, index):
> +        Advertisement.__init__(self, bus, index, 'broadcast')
> +        self.add_manufacturer_data(0x00ff, 'testing')
> +
> +
> +def register_ad_cb():
> +    print 'Advertisement registered'
> +
> +
> +def register_ad_error_cb(error):
> +    print 'Failed to register advertisement: ' + str(error)
> +    mainloop.quit()
> +
> +
> +def find_adapter(bus):
> +    remote_om = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, '/'),
> +                               DBUS_OM_IFACE)
> +    objects = remote_om.GetManagedObjects()
> +
> +    for o, props in objects.iteritems():
> +        if LE_ADVERTISING_MANAGER_IFACE in props:
> +            return o
> +
> +    return None
> +
> +
> +def main():
> +    global mainloop
> +
> +    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
> +
> +    bus = dbus.SystemBus()
> +
> +    adapter = find_adapter(bus)
> +    if not adapter:
> +        print 'LEAdvertisingManager1 interface not found'
> +        return
> +
> +    ad_manager = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, adapter),
> +                                LE_ADVERTISING_MANAGER_IFACE)
> +
> +    test_advertisement = TestAdvertisement(bus, 0)
> +
> +    mainloop = gobject.MainLoop()
> +
> +    ad_manager.RegisterAdvertisement(test_advertisement.get_path(), {},
> +                                     reply_handler=register_ad_cb,
> +                                     error_handler=register_ad_error_cb)
> +
> +    mainloop.run()
> +
> +if __name__ == '__main__':
> +    main()
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman

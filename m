Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: multipart/mixed; boundary="Apple-Mail=_C055D179-A66E-4B5A-8CB2-B1BA2578C938"
Subject: Seeking some bluez dbus enlightenment
Message-Id: <F0CC57E5-9193-483D-A2DF-33254216E6AD@gmail.com>
Date: Fri, 25 Mar 2016 15:21:53 -0700
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_C055D179-A66E-4B5A-8CB2-B1BA2578C938
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I have gotten a python3 (mostly) abstracted versions of the =
example-gatt-server and example-advertise working. Basically had to add =
the =E2=80=9CApplication=E2=80=9D thing from the previous 5.37 based =
versions. They are relatively small and attached. Hardest part was =
throwing darts at the difference between the python3 dbus interface and =
the python2 dbus interface. It works, but who knows how idiomatic it is.

I=E2=80=99m confused by many things (at least 6) though.

Right after startup, without running any of my own code:

~# mdbus2 --system org.bluez / =
org.freedesktop.DBus.ObjectManager.GetManagedObjects
({'/org/bluez': {'org.freedesktop.DBus.Introspectable': {}, =
'org.bluez.AgentManager1': {}, 'org.bluez.ProfileManager1': {}, =
'org.bluez.Alert1': {}, 'org.bluez.HealthManager1': {}}, =
'/org/bluez/hci0': {'org.freedesktop.DBus.Introspectable': {}, =
'org.bluez.Adapter1': {'Address': <'5C:F3:70:68:C1:F9'>, 'Name': =
<'nelson'>, 'Alias': <'PILOT-FF0021'>, 'Class': <uint32 0>, 'Powered': =
<true>, 'Discoverable': <false>, 'DiscoverableTimeout': <uint32 180>, =
'Pairable': <true>, 'PairableTimeout': <uint32 0>, 'Discovering': =
<false>, 'UUIDs': <['00001801-0000-1000-8000-00805f9b34fb', =
'0000110e-0000-1000-8000-00805f9b34fb', =
'00001200-0000-1000-8000-00805f9b34fb', =
'00001800-0000-1000-8000-00805f9b34fb', =
'0000110c-0000-1000-8000-00805f9b34fb']>, 'Modalias': =
<'usb:v1D6Bp0246d0526'>}, 'org.freedesktop.DBus.Properties': {}, =
'org.bluez.GattManager1': {}, 'org.bluez.Media1': {}, =
'org.bluez.CyclingSpeedManager1': {}, 'org.bluez.HeartRateManager1': {}, =
'org.bluez.ThermometerManager1': {}, 'org.bluez.LEAdvertisingManager1': =
{}}},)

1) A GattManager and a LEAdvertisingManager are things I expected. But a =
CycleSpeedManager? And a HeartRateManager? I don=E2=80=99t understand =
why these are there. Is it because I have the -E turned on. Are they =
just temporary during the development phase while that is experimental? =
I thought there was quite a few of these predefined services and =
characteristics, and here see a few, but far from all. I *think* those =
UUIDs match up with some of the manager things?

2) How does it know that my Alias is =E2=80=98PILOT-FF0021=E2=80=99 ? My =
code does set that, but this was after I had pulled the dongle out, =
shutdown the SBC, plugged it back in, and then started it up. Is that =
being written into the dongle=E2=80=99s non volatile memory somehow??



Now, I run some python code that turns on advertising, but register no =
services:

class PilotAdvertisement(ble_advertise.Advertisement):
        def __init__(self, bus):
                super().__init__(bus, 'peripheral')
                self.add_service_uuid(MainService.UUID)
                self.include_tx_power =3D True

Adapter =3D '/org/bluez/hci0'

def main():
        dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
        bus =3D dbus.SystemBus()
        advertisingManager =3D =
dbus.Interface(bus.get_object('org.bluez', Adapter), =
ble_advertise.LE_ADVERTISING_MANAGER_IFACE)
        advertisement =3D PilotAdvertisement(bus)
        =
advertisingManager.RegisterAdvertisement(advertisement.get_path(), {}, =
reply_handler=3DregisterAdvertisementSuccess, =
error_handler=3DregisterAdvertisementFail)
        mainloop =3D glib.MainLoop()
        try:
                mainloop.run()
        except KeyboardInterrupt:
                mainloop.quit()

And then connect to the device using the LightBlue iOS app...

3) Suddenly, I have all kinds of object paths in org.bluez that I =
can=E2=80=99t identify

# mdbus2 --system org.bluez
/
/org
/org/bluez
/org/bluez/hci0
/org/bluez/hci0/dev_5E_41_16_18_F6_37
/org/bluez/hci0/dev_5E_41_16_18_F6_37/service000a
/org/bluez/hci0/dev_5E_41_16_18_F6_37/service000a/char000b
/org/bluez/hci0/dev_5E_41_16_18_F6_37/service000a/char000b/desc000d
/org/bluez/hci0/dev_5E_41_16_18_F6_37/service000a/char000b/desc000e
   <snipped 10+ lines>
/org/bluez/hci0/dev_5E_41_16_18_F6_37/service0028/char0031
/org/bluez/hci0/dev_5E_41_16_18_F6_37/service0028/char0031/desc0033

Are these related to those various predefined services I was asking =
about? Or are they just generalized meta data that comes along with any =
connection? What confuses me is that LightBlue on my phone shoes no =
characteristics to play with. But I can see that the advertising data =
does indeed include the single service UUID that _I_ added to it. It =
doesn=E2=80=99t seem to advertise any of these other services.



Now I add my own service with two characteristics (one write, one =
notify) by registering an Application that has the single service.

    serviceManager =3D dbus.Interface(bus.get_object('org.bluez', =
Adapter), ble_gatt.GATT_MANAGER_IFACE)
    application =3D ble_gatt.Application(bus)
    application.add_service(MainService(bus, 0))
    serviceManager.RegisterApplication(application.get_path(), {}, =
reply_handler=3DregisterApplicationSuccess, =
error_handler=3DregisterApplicationFail)

And then connect. LightBlue now sees 2 characteristics correctly =
identified.

4) The query shown above doesn=E2=80=99t change. It still has the same =
output. This further leads me to believe those are meta =
services/characteristics independent of the example ones? Is there any =
way to know what they are?

5) On line 60 of the attached ble_gatt.py, I am setting PATH_BASE =3D =
'/com/nelson_irrigation/pilot/service=E2=80=99. This is being used to =
construct the paths for the service, characteristics, and descriptors. =
But I don=E2=80=99t see this path anywhere in mdbus2 queries. Where is =
it at?

6) I can change the `write` characteristic value from LightBlue, and my =
subclass override of WriteValue successfully print()=E2=80=99s the newly =
arrived value. But with `dbus-monitor =E2=80=94system` running, I see no =
traffic there. Do I need to run dbus-monitor in a more specific fashion?=20=


TIA



--Apple-Mail=_C055D179-A66E-4B5A-8CB2-B1BA2578C938
Content-Disposition: attachment;
	filename=ble_advertise.py
Content-Type: text/x-python-script;
	name="ble_advertise.py"
Content-Transfer-Encoding: 7bit

#!/usr/bin/env python3

import dbus
import dbus.exceptions
import dbus.mainloop.glib
import dbus.service

LE_ADVERTISING_MANAGER_IFACE = 'org.bluez.LEAdvertisingManager1'
LE_ADVERTISEMENT_IFACE = 'org.bluez.LEAdvertisement1'
DBUS_PROP_IFACE = 'org.freedesktop.DBus.Properties'

class InvalidArgsException(dbus.exceptions.DBusException):
	_dbus_error_name = 'org.freedesktop.DBus.Error.InvalidArgs'


class NotSupportedException(dbus.exceptions.DBusException):
	_dbus_error_name = 'org.bluez.Error.NotSupported'


class NotPermittedException(dbus.exceptions.DBusException):
	_dbus_error_name = 'org.bluez.Error.NotPermitted'


class InvalidValueLengthException(dbus.exceptions.DBusException):
	_dbus_error_name = 'org.bluez.Error.InvalidValueLength'


class FailedException(dbus.exceptions.DBusException):
	_dbus_error_name = 'org.bluez.Error.Failed'


class Advertisement(dbus.service.Object):
	PATH_BASE = '/nelson_irrigation/twig_pilot'

	def __init__(self, bus, advertising_type):
		self.path = self.PATH_BASE
		self.bus = bus
		self.ad_type = advertising_type
		self.service_uuids = None
		self.manufacturer_data = None
		self.solicit_uuids = None
		self.service_data = None
		self.include_tx_power = None
		dbus.service.Object.__init__(self, bus, self.path)

	def get_properties(self):
		properties = dict()
		properties['Type'] = self.ad_type
		if self.service_uuids is not None:
			properties['ServiceUUIDs'] = dbus.Array(self.service_uuids, signature='s')
		if self.solicit_uuids is not None:
			properties['SolicitUUIDs'] = dbus.Array(self.solicit_uuids, signature='s')
		if self.manufacturer_data is not None:
			properties['ManufacturerData'] = dbus.Dictionary(self.manufacturer_data, signature='qay')
		if self.service_data is not None:
			properties['ServiceData'] = dbus.Dictionary(self.service_data, signature='say')
		if self.include_tx_power is not None:
			properties['IncludeTxPower'] = dbus.Boolean(self.include_tx_power)
		return {LE_ADVERTISEMENT_IFACE: properties}

	def get_path(self):
		return dbus.ObjectPath(self.path)

	def add_service_uuid(self, uuid):
		if not self.service_uuids:
			self.service_uuids = []
		self.service_uuids.append(uuid)

	def add_solicit_uuid(self, uuid):
		if not self.solicit_uuids:
			self.solicit_uuids = []
		self.solicit_uuids.append(uuid)

	def add_manufacturer_data(self, manuf_code, data):
		if not self.manufacturer_data:
			self.manufacturer_data = dict()
		self.manufacturer_data[manuf_code] = data

	def add_service_data(self, uuid, data):
		if not self.service_data:
			self.service_data = dict()
		self.service_data[uuid] = data

	@dbus.service.method(DBUS_PROP_IFACE, in_signature='s', out_signature='a{sv}')
	def GetAll(self, interface):
		if interface != LE_ADVERTISEMENT_IFACE:
			raise InvalidArgsException()
		return self.get_properties()[LE_ADVERTISEMENT_IFACE]

	@dbus.service.method(LE_ADVERTISEMENT_IFACE, in_signature='', out_signature='')
	def Release(self):
		print('{}: Released!'.format(self.path))
--Apple-Mail=_C055D179-A66E-4B5A-8CB2-B1BA2578C938
Content-Disposition: attachment;
	filename=ble_gatt.py
Content-Type: text/x-python-script;
	name="ble_gatt.py"
Content-Transfer-Encoding: 7bit

#!/usr/bin/env python3

import dbus
import dbus.exceptions
import dbus.mainloop.glib
import dbus.service

GATT_MANAGER_IFACE = 'org.bluez.GattManager1'
DBUS_OM_IFACE =      'org.freedesktop.DBus.ObjectManager'
DBUS_PROP_IFACE =    'org.freedesktop.DBus.Properties'
GATT_SERVICE_IFACE = 'org.bluez.GattService1'
GATT_CHRC_IFACE =    'org.bluez.GattCharacteristic1'
GATT_DESC_IFACE =    'org.bluez.GattDescriptor1'

class InvalidArgsException(dbus.exceptions.DBusException):
	_dbus_error_name = 'org.freedesktop.DBus.Error.InvalidArgs'


class NotSupportedException(dbus.exceptions.DBusException):
	_dbus_error_name = 'org.bluez.Error.NotSupported'


class NotPermittedException(dbus.exceptions.DBusException):
	_dbus_error_name = 'org.bluez.Error.NotPermitted'


class InvalidValueLengthException(dbus.exceptions.DBusException):
	_dbus_error_name = 'org.bluez.Error.InvalidValueLength'


class FailedException(dbus.exceptions.DBusException):
	_dbus_error_name = 'org.bluez.Error.Failed'

class Application(dbus.service.Object):
	def __init__(self, bus):
		self.path = '/'
		self.services = []
		dbus.service.Object.__init__(self, bus, self.path)

	def get_path(self):
		return dbus.ObjectPath(self.path)

	def add_service(self, service):
		self.services.append(service)

	@dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
	def GetManagedObjects(self):
		response = {}
		for service in self.services:
			response[service.get_path()] = service.get_properties()
			chrcs = service.get_characteristics()
			for chrc in chrcs:
				response[chrc.get_path()] = chrc.get_properties()
				descs = chrc.get_descriptors()
				for desc in descs:
					response[desc.get_path()] = desc.get_properties()
		return response


class Service(dbus.service.Object):
	PATH_BASE = '/com/nelson_irrigation/pilot/service'

	def __init__(self, bus, index, uuid, primary):
		self.path = self.PATH_BASE + str(index)
		self.bus = bus
		self.uuid = uuid
		self.primary = primary
		self.characteristics = []
		dbus.service.Object.__init__(self, bus, self.path)

	def get_properties(self):
		return {
			GATT_SERVICE_IFACE: {
				'UUID': self.uuid,
				'Primary': self.primary,
				'Characteristics': dbus.Array(self.get_characteristic_paths(), signature='o')
			}
		}

	def get_path(self):
		return dbus.ObjectPath(self.path)

	def add_characteristic(self, characteristic):
		self.characteristics.append(characteristic)

	def get_characteristic_paths(self):
		result = []
		for characteristic in self.characteristics:
			result.append(characteristic.get_path())
		return result

	def get_characteristics(self):
		return self.characteristics

	@dbus.service.method(DBUS_PROP_IFACE, in_signature='s', out_signature='a{sv}')
	def GetAll(self, interface):
		if interface != GATT_SERVICE_IFACE:
			raise InvalidArgsException()
		return self.get_properties[GATT_SERVICE_IFACE]


class Characteristic(dbus.service.Object):
	def __init__(self, bus, index, uuid, flags, service):
		self.path = service.path + '/char' + str(index)
		self.bus = bus
		self.uuid = uuid
		self.service = service
		self.flags = flags
		self.descriptors = []
		dbus.service.Object.__init__(self, bus, self.path)

	def get_properties(self):
		return {
			GATT_CHRC_IFACE: {
				'Service': self.service.get_path(),
				'UUID': self.uuid,
				'Flags': self.flags,
				'Descriptors': dbus.Array(self.get_descriptor_paths(), signature='o')
			}
		}

	def get_path(self):
		return dbus.ObjectPath(self.path)

	def add_descriptor(self, descriptor):
		self.descriptors.append(descriptor)

	def get_descriptor_paths(self):
		result = []
		for descriptor in self.descriptors:
			result.append(descriptor.get_path())
		return result

	def get_descriptors(self):
		return self.descriptors

	@dbus.service.method(DBUS_PROP_IFACE, in_signature='s', out_signature='a{sv}')
	def GetAll(self, interface):
		if interface != GATT_CHRC_IFACE:
			raise InvalidArgsException()
		return self.get_properties[GATT_CHRC_IFACE]

	@dbus.service.method(GATT_CHRC_IFACE, out_signature='ay')
	def ReadValue(self):
		print('Default ReadValue called, returning error')
		raise NotSupportedException()

	@dbus.service.method(GATT_CHRC_IFACE, in_signature='ay')
	def WriteValue(self, value):
		print('Default WriteValue called, returning error')
		raise NotSupportedException()

	@dbus.service.method(GATT_CHRC_IFACE)
	def StartNotify(self):
		print('Default StartNotify called, returning error')
		raise NotSupportedException()

	@dbus.service.method(GATT_CHRC_IFACE)
	def StopNotify(self):
		print('Default StopNotify called, returning error')
		raise NotSupportedException()

	@dbus.service.signal(DBUS_PROP_IFACE, signature='sa{sv}as')
	def PropertiesChanged(self, interface, changed, invalidated):
		pass


class Descriptor(dbus.service.Object):
	def __init__(self, bus, index, uuid, flags, characteristic):
		self.path = characteristic.path + '/desc' + str(index)
		self.bus = bus
		self.uuid = uuid
		self.flags = flags
		self.chrc = characteristic
		dbus.service.Object.__init__(self, bus, self.path)

	def get_properties(self):
		return {
				GATT_DESC_IFACE: {
						'Characteristic': self.chrc.get_path(),
						'UUID': self.uuid,
						'Flags': self.flags,
				}
		}

	def get_path(self):
		return dbus.ObjectPath(self.path)

	@dbus.service.method(DBUS_PROP_IFACE, in_signature='s', out_signature='a{sv}')
	def GetAll(self, interface):
		if interface != GATT_DESC_IFACE:
			raise InvalidArgsException()
		return self.get_properties[GATT_CHRC_IFACE]

	@dbus.service.method(GATT_DESC_IFACE, out_signature='ay')
	def ReadValue(self):
		print ('Default ReadValue called, returning error')
		raise NotSupportedException()

	@dbus.service.method(GATT_DESC_IFACE, in_signature='ay')
	def WriteValue(self, value):
		print('Default WriteValue called, returning error')
		raise NotSupportedException()

--Apple-Mail=_C055D179-A66E-4B5A-8CB2-B1BA2578C938--

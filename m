Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1344496816-4641-14-git-send-email-rafal.garbat@tieto.com>
References: <1344496816-4641-1-git-send-email-rafal.garbat@tieto.com>
	<1344496816-4641-14-git-send-email-rafal.garbat@tieto.com>
Date: Thu, 9 Aug 2012 12:18:19 +0200
Message-ID: <CACLukzJATt449+j5ip9LVAn70oT12=x4+92zWhwBrDJGofGruQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] heartrate: Add Heart Rate test script
From: Santiago Carot <sancane@gmail.com>
To: Rafal Garbat <rafal.garbat@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafa

2012/8/9 Rafal Garbat <rafal.garbat@tieto.com>:
> ---
>  Makefile.tools      |    4 +--
>  test/test-heartrate |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 2 deletions(-)
>  create mode 100755 test/test-heartrate
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 5579b86..77b0a3f 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -222,7 +222,7 @@ EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro \
>                 test/test-network test/simple-agent test/simple-service \
>                 test/simple-endpoint test/test-audio test/test-input \
>                 test/test-sap-server test/test-oob test/test-attrib \
> -               test/test-proximity test/test-thermometer test/test-health \
> -               test/test-health-sink test/service-record.dtd \
> +               test/test-proximity test/test-thermometer test/test-heartrate \
> +               test/test-health test/test-health-sink test/service-record.dtd \
>                 test/service-did.xml test/service-spp.xml test/service-opp.xml \
>                 test/service-ftp.xml test/simple-player test/test-nap
> diff --git a/test/test-heartrate b/test/test-heartrate
> new file mode 100755
> index 0000000..35c97a8
> --- /dev/null
> +++ b/test/test-heartrate
> @@ -0,0 +1,78 @@
> +#!/usr/bin/python
> +
> +from __future__ import absolute_import, print_function, unicode_literals
> +
> +'''
> +Heart Rate Monitor test script
> +'''
> +
> +import gobject
> +
> +import sys
> +import dbus
> +import dbus.service
> +import dbus.mainloop.glib
> +from optparse import OptionParser, make_option
> +
> +class Watcher(dbus.service.Object):
> +       @dbus.service.method("org.bluez.HeartRateWatcher",
> +                                       in_signature="a{sv}", out_signature="")
> +       def MeasurementReceived(self, measure):
> +               print("Measurement received")
> +               print("Value", measure["Value"])
> +               print("Energy", measure["Energy"])
> +               print("Contact", measure["Contact"])
> +               print("Location", measure["Location"])
> +
> +               for i in measure["Interval"]:
> +                       print("Interval", i)
> +
> +if __name__ == "__main__":
> +       dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
> +
> +       bus = dbus.SystemBus()
> +
> +       manager = dbus.Interface(bus.get_object("org.bluez", "/"),
> +                                       "org.bluez.Manager")
> +
> +       option_list = [
> +               make_option("-i", "--adapter", action="store",
> +                       type="string", dest="adapter"),
> +               make_option("-b", "--device", action="store",
> +                       type="string", dest="address"),
> +               ]
> +
> +       parser = OptionParser(option_list=option_list)
> +
> +       (options, args) = parser.parse_args()
> +

This is just an idea, but it would be great to have an option here
which enables you to reset the device from command line, just for
testing. This option could be similar to EnableIntermediateMeasurement
in thermometer test script.

> +       if not options.address:
> +               print("Usage: %s [-i <adapter>] -b <bdaddr>" % (sys.argv[0]))
> +               sys.exit(1)
> +
> +       if options.adapter:
> +               adapter_path = manager.FindAdapter(options.adapter)
> +       else:
> +               adapter_path = manager.DefaultAdapter()
> +
> +       adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
> +                                                       "org.bluez.Adapter")
> +
> +       device_path = adapter.FindDevice(options.address)
> +
> +       device = dbus.Interface(bus.get_object("org.bluez", device_path),
> +                                                       "org.bluez.Device")
> +
> +       heartrate = dbus.Interface(bus.get_object("org.bluez",
> +                                       device_path), "org.bluez.HeartRate")
> +
> +       path = "/test/watcher"
> +       watcher = Watcher(bus, path)
> +
> +       heartrate.RegisterWatcher(path)
> +
> +       properties = heartrate.GetProperties()
> +       print("Reset Supported:", properties["ResetSupported"])
> +
> +       mainloop = gobject.MainLoop()
> +       mainloop.run()
> \ No newline at end of file
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

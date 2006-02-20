Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80602201328o26227a52i2f0ff01815d26e5d@mail.gmail.com>
From: "Eduardo Rocha" <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_21580_7166770.1140470885614"
Subject: [Bluez-devel] dbus-test
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
Date: Mon, 20 Feb 2006 18:28:05 -0300

------=_Part_21580_7166770.1140470885614
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel & Johan,

here is a first version of dbus-test based on the new interface. My
idea is to keep it simple as the interfaces are still changing.
Tomorrow I'll implement the method call based on the interface
document and send the hole patch. Any suggestion?

BR,
Eduardo.

--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

------=_Part_21580_7166770.1140470885614
Content-Type: application/octet-stream; name=dbus-test
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejxalciv
Content-Disposition: attachment; filename="dbus-test"

#!/usr/bin/env python

import dbus
import dbus.decorators
import dbus.glib
import gobject
import sys
import getopt
from signal import *

mgr_cmds = [ "ListDevices", "DefaultDevice" ]
dev_cmds = [ "GetAddress", "GetManufacturer", "GetVersion", "GetRevision",
             "GetCompany", "GetFeatures", "GetMode", "SetMode", "GetDiscoverableTimeout",
             "SetDiscoverableTimeout", "IsConnectable", "IsDiscoverable" , "GetName",
             "SetName", "GetClass", "SetClass", "GetAlias", "SetAlias", "RemoteName", 
             "RemoteAlias", "RemoteVersion", "LastSeen", "Discover", "DiscoverService", 
             "CreateBonding", "RemoveBonding", "HasBonding", "ListBonding", "PinCodeLength",
             "EncryptionKeySize" ]
mgr_signals = [ "DeviceAdded", "DeviceRemoved" ]
dev_signals = [ "ModeChanged", "NameChanged" , "AliasChanged", "RemoteName", "RemoteAlias" ]
dev_signals_filter = [ "/org/bluez/Device/hci0", "/org/bluez/Device/hci1",
                       "/org/bluez/Device/hci2", "/org/bluez/Device/hci3",
                       "/org/bluez/Device/hci4", "/org/bluez/Device/hci5",
                       "/org/bluez/Device/hci6", "/org/bluez/Device/hci7",
                       "/org/bluez/Device/hci8", "/org/bluez/Device/hci9" ]

class Tester:
    exit_events = []
    dev_path = None
    need_dev = False
    listen = False
    at_interrupt = None

    def __init__(self, argv):
        self.name = argv[0]

        self.parse_args(argv[1:])

        try:
            self.dbus_setup()
            self.dbus_mrg_setup()
            self.dbus_dev_setup()
        except dbus.DBusException, e:
            print 'Failed to do D-BUS setup: %s' % e
            sys.exit(1)

    def parse_args(self, argv):
        try:
            opts, args = getopt.getopt(argv, "hli:")
        except getopt.GetoptError:
            self.usage()
            sys.exit(1)

        for o, a in opts:
            if o == "-h":
                self.usage()
                sys.exit()
            elif o == "-l":
                self.need_dev = False
                self.listen = True
            elif o == "-i":
                if a[0] == '/':
                    self.dev_path = a
                else:
                    self.dev_path = '/org/bluez/Device/%s' % a

        if not (args or self.listen):
            self.usage()
            sys.exit(1)

        if args:
            self.cmd = args[0]
            self.cmd_args = args[1:]

            if not self.cmd in mgr_cmds:
                self.need_dev = True

    def dbus_dev_setup(self):
        if self.need_dev and not self.dev_path:
            try:
                self.dev_path = self.manager.DefaultDevice()
            except dbus.DBusException, e:
                print 'Failed to get default device: %s' % e
                sys.exit(1)
            try:
                obj = self.bus.get_object('org.bluez', self.dev_path)
                self.dev = dbus.Interface(obj, 'org.bluez.Device')
            except dbus.DBusException, e:
                print 'Failed to setup device path: %s' % e
                sys.exit(1)
        if self.listen:
            self.dbus_dev_sig_setup()

    def dbus_dev_sig_setup(self):
        try:
           for signal in dev_signals:
                for path in dev_signals_filter:
                    self.bus.add_signal_receiver(self.dev_signal_handler,
                                             signal,'org.bluez.Device',
                                             'org.bluez', path)
        except dbus.DBusException, e:
            print 'Failed to setup signal handler for device path: %s' % e
            sys.exit(1)

    def dbus_mgr_sig_setup(self):
        try:
            for signal in mgr_signals:
                self.bus.add_signal_receiver(self.mgr_signal_handler,
                                         signal,'org.bluez.Manager',
                                         'org.bluez', '/org/bluez/Manager')
        except dbus.DBusException, e:
            print 'Failed to setup signal handler for manager path: %s' % e
            sys.exit(1)

    def dbus_mrg_setup(self):
        manager_obj = self.bus.get_object('org.bluez', '/org/bluez/Manager')
        self.manager = dbus.Interface(manager_obj, 'org.bluez.Manager')
	if self.listen:
            self.dbus_mgr_sig_setup()

    def dbus_setup(self):
        self.bus = dbus.SystemBus()

    def usage(self):
        print 'Usage: %s [-i <dev>] [-l] [-h] <cmd> [arg1..]' % self.name
        print '  -i <dev>   Specify device (e.g. "hci0" or "/org/bluez/Device/hci0")'
        print '  -l         Listen for events (no command required)'
        print '  -h         Show this help'
        print 'Manager commands:'
        for cmd in mgr_cmds:
            print '\t%s' % cmd
        print 'Device commands:'
        for cmd in dev_cmds:
            print '\t%s' % cmd

    @dbus.decorators.explicitly_pass_message
    def dev_signal_handler(*args, **keywords):
        dbus_message = keywords["dbus_message"]
        member = dbus_message.get_member()
        sys.stdout.write(member) 
        sys.stdout.write(' - ') 
        sys.stdout.write(dbus_message.get_path())
        sys.stdout.write(': ')
        for arg in args[1:]:
            sys.stdout.write(arg)
            sys.stdout.write('   ')
        sys.stdout.write('\n')
        sys.stdout.flush()

    @dbus.decorators.explicitly_pass_message
    def mgr_signal_handler(*args, **keywords):
        dbus_message = keywords["dbus_message"]
        member = dbus_message.get_member()
        sys.stdout.write(member) 
        sys.stdout.write(': ')
        for arg in args[1:]:
            sys.stdout.write(arg)
            sys.stdout.write('   ')
        sys.stdout.write('\n')
        sys.stdout.flush()

    def signal_cb(self, sig, frame):
        print 'Caught signal, exiting'
        if self.at_interrupt:
            self.at_interrupt()
        self.main_loop.quit()

    def call_mgr_dbus_func(self, func, *param):
        print "To be implemented"

    def call_dev_dbus_func(self, func, *param):
        print "To be implemented"

    def run(self):
        # Manager methods
        if self.listen:
            print 'Listening for events...'
        elif self.cmd in mgr_cmds:
            self.call_mgr_dbus_func(self.cmd, *self.cmd_args)
        elif self.cmd in dev_cmds:
            self.call_dev_dbus_func(self.cmd, *self.cmd_args)
        else:
            print 'Unknown command: %s' % self.cmd
            sys.exit(1)

        if self.listen:
            signal(SIGINT, self.signal_cb)
            signal(SIGTERM, self.signal_cb)
            self.main_loop = gobject.MainLoop()
            self.main_loop.run()

if __name__ == '__main__':
    gobject.threads_init()
    dbus.glib.init_threads()

    tester = Tester(sys.argv)
    tester.run()

------=_Part_21580_7166770.1140470885614--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

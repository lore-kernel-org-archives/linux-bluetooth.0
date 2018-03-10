Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: John Klug <ski.brimson@gmail.com>
Date: Fri, 9 Mar 2018 21:46:16 -0600
Message-ID: <CADU0Vqw6qZ5gcsUCtJJxYewW2DUSm8Sj8JOotYYJFErxbyLyyA@mail.gmail.com>
Subject: How can I retrieve the remote device name?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am using 5.47 Bluez and python.

I am trying to use rfcomm with Profile1.


    @dbus.service.method('org.bluez.Profile1',
                         in_signature='oha{sv}',
                         out_signature='')
    def NewConnection(self, path, fd, properties):

I get a path like:
/org/bluez/hci0/dev_DC_74_A8_05_39_77

The file descriptor works great.

Properties is an empty dictionary.

What can I use to retrieve the name of the device that made the new connection?

Is the properties dictionary supposed to be empty?  The examples try
to retrieve a Version and Features, but I get nothing and a zero
length dictionary:


        # Following code shows noting (why?)
        lg.debug('Look for a key len(properties): %d',len(properties))
        for key in properties.keys():
            lg.debug('found a key!!!!!')
            lg.debug('  %s = %s' % (key, properties[key]))
            if key == 'Version' or key == 'Features':
                print('  %s = 0x%04x' % (key, properties[key]))
                lg.debug('  %s = 0x%04x' % (key, properties[key]))
            else:
                print('  %s = %s' % (key, properties[key]))
                lg.info('  %s = %s' % (key, properties[key]))
        lg.debug('Past keys')

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 28 Aug 2012 01:08:43 +0900
Message-ID: <CADwiJcZyD8TMOyr1PSoYY9KrAhTU4Twi8TE28OJvCoeFAEHwyA@mail.gmail.com>
Subject: Unable to run bluez "test-health-sink" sample
From: =?ISO-2022-JP?B?GyRCNUhFRD1jGyhC?= <fantajista1089@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear bluez list,

I want to develop an application which receives health data with the
latest blueZ libraries (4.101 version) available for download. First
thing was try to understand the logical process and routines involved
in the API through the test scripts shared with the blueZ project
(under "test" folder).
The problem is that my system is not able to run script related with
the health profile. "test-health-sink" script output is below.

===============
./test-health-sink
ERROR:dbus.connection:Unable to set arguments ({'DataType':
dbus.UInt16(4103), 'Role': 'sink'},) according to signature None:
<type 'exceptions.TypeError'>: an integer is required
Traceback (most recent call last):
  File "./test-health-sink", line 18, in <module>
    "Role": "sink"})
File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in __call__
    **keywords)
File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 620,
in call_blocking
    message.append(signature=signature, *args)
TypeError: an integer is required

I'm working with Angstrom OS (32 bits), dbus-python 1.1.1.

Best regards.

----
Jun

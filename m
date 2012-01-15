Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Islam Amer <pharon@gmail.com>
Date: Sun, 15 Jan 2012 21:17:32 +0200
Message-ID: <CALO1QdHwejgjOQdyN0Dx97Ziuf3sAsvJLaGJi10OZYSWw2Sn6w@mail.gmail.com>
Subject: obex-client fails with Connection refused (111) most of the time
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Using obex-client and the send-files test app on my thinkpad to send
a single file to two different Nokia phones I get this error 90% of the time:

Connection refused (111)

This problem has been manifesting for some time but this test is on Debian
unstable with linux-image-3.2.0-rc7-amd64, bluez 4.97 , and self
compiled obexd 0.44

I tried debugging the issue myself but haven't reached any results so far.

I have some of the debugging output of several failed trials, and then
a successful
operation. Usually a successful operation happens when it is started
very close after
a failed one.

Any pointers or help are greatly appreciated. Thanks in advance.
---

~/Workspace/Compile/obexd-0.44 $ ./test/send-files xx:xx:xx:xx:xx:xx /tmp/new
Traceback (most recent call last):
  File "./test/send-files", line 80, in <module>
    client.SendFiles({ "Destination": sys.argv[1] }, files, path)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
630, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.openobex.Error.Failed: Connection
refused (111)
~/Workspace/Compile/obexd-0.44 $ ./test/send-files xx:xx:xx:xx:xx:xx /tmp/new
Traceback (most recent call last):
  File "./test/send-files", line 80, in <module>
    client.SendFiles({ "Destination": sys.argv[1] }, files, path)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
630, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.openobex.Error.Failed: Connection
refused (111)
~/Workspace/Compile/obexd-0.44 $ ./test/send-files xx:xx:xx:xx:xx:xx /tmp/new
Traceback (most recent call last):
  File "./test/send-files", line 80, in <module>
    client.SendFiles({ "Destination": sys.argv[1] }, files, path)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
630, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.openobex.Error.Failed: Connection
refused (111)
~/Workspace/Compile/obexd-0.44 $ ./test/send-files xx:xx:xx:xx:xx:xx /tmp/new
Traceback (most recent call last):
  File "./test/send-files", line 80, in <module>
    client.SendFiles({ "Destination": sys.argv[1] }, files, path)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
630, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.openobex.Error.Failed: Connection
refused (111)
~/Workspace/Compile/obexd-0.44 $ ./test/send-files xx:xx:xx:xx:xx:xx /tmp/new
Traceback (most recent call last):
  File "./test/send-files", line 80, in <module>
    client.SendFiles({ "Destination": sys.argv[1] }, files, path)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
630, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.openobex.Error.Failed: Connection
refused (111)
~/Workspace/Compile/obexd-0.44 $ ./test/send-files xx:xx:xx:xx:xx:xx /tmp/new
Transfer Request
  Filename = /tmp/new
  Name = new
  Size = 2108
Transfer Started
Transfer progress (2108/2108 bytes) @ 3 kB/s
Transfer finished

---

./client/obex-client -d -s
obex-client[28987]: obex-client daemon 0.44
obex-client[28987]: client/opp.c:opp_init()
obex-client[28987]: client/driver.c:obc_driver_register() driver
0x6224c0 service OPP registered
obex-client[28987]: client/manager.c:manager_init() Target opp loaded
obex-client[28987]: client/ftp.c:ftp_init()
obex-client[28987]: client/driver.c:obc_driver_register() driver
0x6222c0 service FTP registered
obex-client[28987]: client/driver.c:obc_driver_register() driver
0x622300 service PCSUITE registered
obex-client[28987]: client/manager.c:manager_init() Target ftp loaded
obex-client[28987]: client/pbap.c:pbap_init()
obex-client[28987]: client/driver.c:obc_driver_register() driver
0x6220a0 service PBAP registered
obex-client[28987]: client/manager.c:manager_init() Target pbap loaded
obex-client[28987]: client/sync.c:sync_init()
obex-client[28987]: client/driver.c:obc_driver_register() driver
0x621fc0 service SYNC registered
obex-client[28987]: client/manager.c:manager_init() Target sync loaded
obex-client[28987]: client/map.c:map_init()
obex-client[28987]: client/driver.c:obc_driver_register() driver
0x622500 service MAP registered
obex-client[28987]: client/manager.c:manager_init() Target map loaded
obex-client[28987]: client/main.c:main() Entering main loop
obex-client[28987]: client/session.c:obc_session_create() driver OPP
obex-client[28987]: client/session.c:obc_session_ref() 0x17d27b0: ref=2
obex-client[28987]: client/session.c:manager_reply() adapter path
/org/bluez/28955/hci0
obex-client[28987]: client/session.c:rfcomm_connect()
obex-client[28987]: client/session.c:rfcomm_callback()
obex-client[28987]: Connection refused (111)
obex-client[28987]: client/session.c:obc_session_shutdown() 0x17d27b0
obex-client[28987]: client/session.c:obc_session_ref() 0x17d27b0: ref=3
obex-client[28987]: client/session.c:obc_session_unref() 0x17d27b0: ref=2
obex-client[28987]: client/session.c:obc_session_unref() 0x17d27b0: ref=1
obex-client[28987]: client/session.c:obc_session_unref() 0x17d27b0: ref=0
obex-client[28987]: client/session.c:session_free() 0x17d27b0
obex-client[28987]: client/session.c:obc_session_create() driver OPP
obex-client[28987]: client/session.c:obc_session_ref() 0x17cf5e0: ref=2
obex-client[28987]: client/session.c:manager_reply() adapter path
/org/bluez/28955/hci0
obex-client[28987]: client/session.c:rfcomm_connect()
obex-client[28987]: client/session.c:rfcomm_callback()
obex-client[28987]: Connection refused (111)
obex-client[28987]: client/session.c:obc_session_shutdown() 0x17cf5e0
obex-client[28987]: client/session.c:obc_session_ref() 0x17cf5e0: ref=3
obex-client[28987]: client/session.c:obc_session_unref() 0x17cf5e0: ref=2
obex-client[28987]: client/session.c:obc_session_unref() 0x17cf5e0: ref=1
obex-client[28987]: client/session.c:obc_session_unref() 0x17cf5e0: ref=0
obex-client[28987]: client/session.c:session_free() 0x17cf5e0
obex-client[28987]: client/session.c:obc_session_create() driver OPP
obex-client[28987]: client/session.c:obc_session_ref() 0x17d2b70: ref=2
obex-client[28987]: client/session.c:manager_reply() adapter path
/org/bluez/28955/hci0
obex-client[28987]: client/session.c:rfcomm_connect()
obex-client[28987]: client/session.c:rfcomm_callback()
obex-client[28987]: Connection refused (111)
obex-client[28987]: client/session.c:obc_session_shutdown() 0x17d2b70
obex-client[28987]: client/session.c:obc_session_ref() 0x17d2b70: ref=3
obex-client[28987]: client/session.c:obc_session_unref() 0x17d2b70: ref=2
obex-client[28987]: client/session.c:obc_session_unref() 0x17d2b70: ref=1
obex-client[28987]: client/session.c:obc_session_unref() 0x17d2b70: ref=0
obex-client[28987]: client/session.c:session_free() 0x17d2b70
obex-client[28987]: client/session.c:obc_session_create() driver OPP
obex-client[28987]: client/session.c:obc_session_ref() 0x17cf600: ref=2
obex-client[28987]: client/session.c:manager_reply() adapter path
/org/bluez/28955/hci0
obex-client[28987]: client/session.c:rfcomm_connect()
obex-client[28987]: client/session.c:rfcomm_callback()
obex-client[28987]: client/session.c:obc_session_ref() 0x17cf600: ref=3
obex-client[28987]: client/transfer.c:obc_transfer_register()
0x17d2750 registered /org/openobex/transfer0
obex-client[28987]: client/agent.c:obc_agent_request() /org/openobex/transfer0
obex-client[28987]: client/session.c:obc_session_unref() 0x17cf600: ref=2
obex-client[28987]: client/session.c:obc_session_unref() 0x17cf600: ref=1
obex-client[28987]: client/session.c:session_request_reply()
Agent.Request() reply:
obex-client[28987]: client/session.c:session_prepare_put()
Transfer(0x17d2750) started
obex-client[28987]: client/agent.c:obc_agent_notify_progress()
/org/openobex/transfer0
obex-client[28987]: client/session.c:session_notify_progress()
Transfer(0x17d2750) progress: 0 bytes
obex-client[28987]: client/agent.c:obc_agent_notify_progress()
/org/openobex/transfer0
obex-client[28987]: client/session.c:session_notify_progress()
Transfer(0x17d2750) progress: 2108 bytes
obex-client[28987]: client/agent.c:obc_agent_notify_complete()
/org/openobex/transfer0
obex-client[28987]: client/session.c:session_notify_complete()
Transfer(0x17d2750) complete
obex-client[28987]: client/session.c:obc_session_ref() 0x17cf600: ref=2
obex-client[28987]: client/transfer.c:obc_transfer_unregister()
0x17d2750 unregistered /org/openobex/transfer0
obex-client[28987]: client/transfer.c:obc_transfer_free() 0x17d2750
obex-client[28987]: client/session.c:obc_session_unref() 0x17cf600: ref=1
obex-client[28987]: client/session.c:obc_session_unref() 0x17cf600: ref=0
obex-client[28987]: client/session.c:session_free() 0x17cf600
obex-client[28987]: client/agent.c:obc_agent_release()

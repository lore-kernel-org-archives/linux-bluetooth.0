Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] test: Update simple-agent to new API
Date: Mon, 17 Dec 2012 19:48:20 -0300
Message-Id: <1355784500-28062-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The method org.bluez.Device.Pair() doesn't have arguments anymore. This
commit fixes the following error:

  $ test/simple-agent hci0 4C:B1:99:F1:BC:E9
  Agent registered
  ERROR:dbus.connection:Unable to set arguments (u'/test/agent', u'Keybo
  ardDisplay') according to signature '': <type 'exceptions.TypeError'>:
   Fewer items found in D-Bus signature than in Python arguments
  Traceback (most recent call last):
    File "/usr/lib/python2.7/site-packages/dbus/connection.py", line 586
  , in msg_reply_handler
      reply_handler(*message.get_args_list(**get_args_opts))
    File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 391, i
  n _introspect_reply_handler
      self._introspect_execute_queue()
    File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 378, i
  n _introspect_execute_queue
      proxy_method(*args, **keywords)
    File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 132, i
  n __call__
      **keywords)
    File "/usr/lib/python2.7/site-packages/dbus/connection.py", line 566
  , in call_async
      message.append(signature=signature, *args)
  TypeError: Fewer items found in D-Bus signature than in Python argumen
  ts
---
 test/simple-agent | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/test/simple-agent b/test/simple-agent
index deb6497..bb40eae 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -169,9 +169,7 @@ if __name__ == '__main__':
 						options.adapter_pattern)
 		dev_path = device.object_path
 		agent.set_exit_on_release(False)
-		device.Pair(path, capability, timeout=options.timeout,
-					reply_handler=pair_reply,
-					error_handler=pair_error)
+		device.Pair(reply_handler=pair_reply, error_handler=pair_error)
 		device_obj = device
 	else:
 		manager.RequestDefault()
-- 
1.7.11.7


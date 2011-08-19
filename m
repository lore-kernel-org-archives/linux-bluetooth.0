Return-Path: <cyrus@holtmann.org>
From: Bruno Dilly <bdilly@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Bruno Dilly <bdilly@profusion.mobi>
Subject: [PATCH 1/3] Add Serial Proxy and Serial Proxy Manager doc
Date: Fri, 19 Aug 2011 19:10:40 -0300
Message-Id: <1313791842-32558-1-git-send-email-bdilly@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/serial-proxy-api.txt |  108 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100644 doc/serial-proxy-api.txt

diff --git a/doc/serial-proxy-api.txt b/doc/serial-proxy-api.txt
new file mode 100644
index 0000000..fa08bcb
--- /dev/null
+++ b/doc/serial-proxy-api.txt
@@ -0,0 +1,108 @@
+BlueZ D-Bus Serial API description
+**********************************
+
+Serial Proxy Manager hierarchy
+=================
+
+Service		org.bluez
+Interface	org.bluez.SerialProxyManager
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		array{string} ListProxies()
+
+			Returns an array of the object path strings of
+			all the proxies created for the adapter.
+
+		string CreateProxy(string pattern, string address)
+
+			Possible patterns: UUID 128 bit as string
+					   Profile short names, e.g: spp, dun
+					   RFCOMM channel as string, 1-30
+
+			Address is the path to the TTY or Unix socket to be used.
+			Only one proxy per address (TTY or Unix socket)
+			is allowed.
+
+			The object path of created proxy is returned.
+			On success this will emit a ProxyCreated signal.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+					 org.bluez.Error.Failed
+
+		void RemoveProxy(string path)
+
+			This removes the proxy object at the given path.
+			On success this will emit a ProxyRemoved signal.
+
+			Possible Errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.NotAuthorized
+
+Signals		ProxyCreated(string path)
+
+			This signal indicates a proxy was created.
+			Parameter is object path of created proxy.
+
+		ProxyRemoved(string path)
+
+			This signal indicates a proxy was removed.
+			Parameter is object path of removed proxy.
+
+Serial Proxy hierarchy
+================
+
+Service		org.bluez
+Interface	org.bluez.SerialProxy
+Object path	[variable prefix]/{hci0,hci1,...}/{proxy0,proxy1,...}
+
+Methods		void Enable()
+
+			Starts to listen to the TTY or Unix socket, allocates
+			a RFCOMM channel and add record to the server.
+
+			Possible errors: org.bluez.Error.Failed
+
+		void Disable()
+
+			Stops to listen to the TTY or Unix socket, shutdown
+			the RFCOMM channel allocated for the proxy, and remove
+			record from the server.
+
+			Possible errors: org.bluez.Error.Failed
+
+		dict GetInfo()
+
+			Returns all properties for the proxy. See the
+			properties section for available properties.
+
+		void SetSerialParameters(string rate, uint8 data, uint8 stop,
+			string parity)
+
+			Configures serial communication setting baud rate,
+			data bits, stop bits and parity.
+
+			Doesn't allow change TTY settings if it is open.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotAuthorized
+
+Properties	string uuid [readonly]
+
+			128-bit UUID that represents the available remote service.
+
+		string address [readonly]
+
+			Address is the path to the TTY or Unix socket name used,
+			set when the proxy was created.
+
+		uint8 channel [readonly]
+
+			RFCOMM channel.
+
+		boolean enabled [readonly]
+
+			Indicates if the proxy is currently enabled.
+
+		boolean connected [readonly]
+
+			Indicates if the proxy is currently connected.
-- 
1.7.4.1


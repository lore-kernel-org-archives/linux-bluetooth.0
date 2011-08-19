Return-Path: <cyrus@holtmann.org>
From: Bruno Dilly <bdilly@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Bruno Dilly <bdilly@profusion.mobi>
Subject: [PATCH 2/3] Include interface descriptions following DTD for D-Bus
Date: Fri, 19 Aug 2011 19:10:41 -0300
Message-Id: <1313791842-32558-2-git-send-email-bdilly@profusion.mobi>
In-Reply-To: <1313791842-32558-1-git-send-email-bdilly@profusion.mobi>
References: <1313791842-32558-1-git-send-email-bdilly@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Document type definition at
http://standards.freedesktop.org/dbus/1.0/introspect.dtd

Very useful for use with tools that parse them to generate code
for proxy class or adaptor skeleton.

Some annotations may be required for variant types.
---
 xml/adapter.xml              |   64 ++++++++++++++++++++++++++++++++++++++++++
 xml/agent.xml                |   32 +++++++++++++++++++++
 xml/audio.xml                |   15 ++++++++++
 xml/audiosink.xml            |   22 ++++++++++++++
 xml/control.xml              |   20 +++++++++++++
 xml/device.xml               |   25 ++++++++++++++++
 xml/headset.xml              |   53 ++++++++++++++++++++++++++++++++++
 xml/health.xml               |   13 ++++++++
 xml/input.xml                |   15 ++++++++++
 xml/manager.xml              |   33 +++++++++++++++++++++
 xml/network_server.xml       |   13 ++++++++
 xml/serial.xml               |   13 ++++++++
 xml/serial_proxy.xml         |   18 ++++++++++++
 xml/serial_proxy_manager.xml |   23 +++++++++++++++
 xml/service.xml              |   22 ++++++++++++++
 15 files changed, 381 insertions(+), 0 deletions(-)
 create mode 100644 xml/adapter.xml
 create mode 100644 xml/agent.xml
 create mode 100644 xml/audio.xml
 create mode 100644 xml/audiosink.xml
 create mode 100644 xml/control.xml
 create mode 100644 xml/device.xml
 create mode 100644 xml/headset.xml
 create mode 100644 xml/health.xml
 create mode 100644 xml/input.xml
 create mode 100644 xml/manager.xml
 create mode 100644 xml/network_server.xml
 create mode 100644 xml/serial.xml
 create mode 100644 xml/serial_proxy.xml
 create mode 100644 xml/serial_proxy_manager.xml
 create mode 100644 xml/service.xml

diff --git a/xml/adapter.xml b/xml/adapter.xml
new file mode 100644
index 0000000..ece2cf7
--- /dev/null
+++ b/xml/adapter.xml
@@ -0,0 +1,64 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.Adapter">
+		<method name="GetProperties">
+			<arg type="a{sv}" direction="out"/>
+		</method>
+		<method name="SetProperty">
+			<arg type="s" direction="in"/>
+			<arg type="v" direction="in"/>
+		</method>
+		<method name="RequestSession"/>
+		<method name="ReleaseSession"/>
+		<method name="StartDiscovery"/>
+		<method name="StopDiscovery"/>
+		<method name="ListDevices">
+			<arg type="ao" direction="out"/>
+		</method>
+		<method name="CreateDevice">
+			<arg type="s" direction="in"/>
+			<arg type="o" direction="out"/>
+		</method>
+		<method name="CreatePairedDevice">
+			<arg type="s" direction="in"/>
+			<arg type="o" direction="in"/>
+			<arg type="s" direction="in"/>
+			<arg type="o" direction="out"/>
+		</method>
+		<method name="CancelDeviceCreation">
+			<arg type="s" direction="in"/>
+		</method>
+		<method name="RemoveDevice">
+			<arg type="o" direction="in"/>
+		</method>
+		<method name="FindDevice">
+			<arg type="s" direction="in"/>
+			<arg type="o" direction="out"/>
+		</method>
+		<method name="RegisterAgent">
+			<arg type="o" direction="in"/>
+			<arg type="s" direction="in"/>
+		</method>
+		<method name="UnregisterAgent">
+			<arg type="o" direction="in"/>
+		</method>
+		<signal name="PropertyChanged">
+			<arg type="s"/>
+			<arg type="v"/>
+		</signal>
+		<signal name="DeviceCreated">
+			<arg type="o"/>
+		</signal>
+		<signal name="DeviceRemoved">
+			<arg type="o"/>
+		</signal>
+		<signal name="DeviceFound">
+			<arg type="s"/>
+			<arg type="a{sv}"/>
+		</signal>
+		<signal name="DeviceDisappeared">
+			<arg type="s"/>
+		</signal>
+	</interface>
+</node>
diff --git a/xml/agent.xml b/xml/agent.xml
new file mode 100644
index 0000000..0442bf8
--- /dev/null
+++ b/xml/agent.xml
@@ -0,0 +1,32 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.Agent">
+		<method name="Release"/>
+		<method name="RequestPinCode">
+			<arg type="o" direction="in"/>
+			<arg type="s" direction="out"/>
+		</method>
+		<method name="RequestPasskey">
+			<arg type="o" direction="in"/>
+			<arg type="u" direction="out"/>
+		</method>
+		<method name="DisplayPasskey">
+			<arg type="o" direction="in"/>
+			<arg type="u" direction="in"/>
+			<arg type="y" direction="in"/>
+		</method>
+		<method name="RequestConfirmation">
+			<arg type="o" direction="in"/>
+			<arg type="u" direction="in"/>
+		</method>
+		<method name="Authorize">
+			<arg type="o" direction="in"/>
+			<arg type="s" direction="in"/>
+		</method>
+		<method name="ConfirmModeChange">
+			<arg type="s" direction="in"/>
+		</method>
+		<method name="Cancel"/>
+	</interface>
+</node>
diff --git a/xml/audio.xml b/xml/audio.xml
new file mode 100644
index 0000000..5b760de
--- /dev/null
+++ b/xml/audio.xml
@@ -0,0 +1,15 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.Audio">
+		<method name="Connect"/>
+		<method name="Disconnect"/>
+		<method name="GetProperties">
+			<arg type="a{sv}" direction="out"/>
+		</method>
+		<signal name="PropertyChanged">
+			<arg type="s"/>
+			<arg type="v"/>
+		</signal>
+	</interface>
+</node>
diff --git a/xml/audiosink.xml b/xml/audiosink.xml
new file mode 100644
index 0000000..798dc74
--- /dev/null
+++ b/xml/audiosink.xml
@@ -0,0 +1,22 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.AudioSink">
+		<method name="Connect"/>
+		<method name="Disconnect"/>
+		<method name="IsConnected">
+			<arg type="b" direction="out"/>
+		</method>
+		<method name="GetProperties">
+			<arg type="a{sv}" direction="out"/>
+		</method>
+		<signal name="Connected"/>
+		<signal name="Disconnected"/>
+		<signal name="Playing"/>
+		<signal name="Stopped"/>
+		<signal name="PropertyChanged">
+			<arg type="s"/>
+			<arg type="v"/>
+		</signal>
+	</interface>
+</node>
diff --git a/xml/control.xml b/xml/control.xml
new file mode 100644
index 0000000..b913d7a
--- /dev/null
+++ b/xml/control.xml
@@ -0,0 +1,20 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.Control">
+		<method name="IsConnected">
+			<arg type="b" direction="out"/>
+		</method>
+		<method name="GetProperties">
+			<arg type="a{sv}" direction="out"/>
+		</method>
+		<method name="VolumeUp"/>
+		<method name="VolumeDown"/>
+		<signal name="Connected"/>
+		<signal name="Disconnected"/>
+		<signal name="PropertyChanged">
+			<arg type="s"/>
+			<arg type="v"/>
+		</signal>
+	</interface>
+</node>
diff --git a/xml/device.xml b/xml/device.xml
new file mode 100644
index 0000000..471695d
--- /dev/null
+++ b/xml/device.xml
@@ -0,0 +1,25 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.Device">
+		<method name="GetProperties">
+			<arg type="a{sv}" direction="out"/>
+		</method>
+		<method name="SetProperty">
+			<arg type="s" direction="in"/>
+			<arg type="v" direction="in"/>
+		</method>
+		<method name="DiscoverServices">
+			<arg type="s" direction="in"/>
+			<arg type="a{us}" direction="out"/>
+		</method>
+		<method name="CancelDiscovery"/>
+		<method name="Disconnect"/>
+		<signal name="PropertyChanged">
+			<arg type="s"/>
+			<arg type="v"/>
+		</signal>
+		<signal name="DisconnectRequested"/>
+	</interface>
+</node>
+
diff --git a/xml/headset.xml b/xml/headset.xml
new file mode 100644
index 0000000..b647bc2
--- /dev/null
+++ b/xml/headset.xml
@@ -0,0 +1,53 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.Headset">
+		<method name="Connect"/>
+		<method name="Disconnect"/>
+		<method name="IsConnected">
+			<arg type="b" direction="out"/>
+		</method>
+		<method name="IndicateCall"/>
+		<method name="CancelCall"/>
+		<method name="Play"/>
+		<method name="Stop"/>
+		<method name="IsPlaying">
+			<arg type="b" direction="out"/>
+		</method>
+		<method name="GetSpeakerGain">
+			<arg type="q" direction="out"/>
+		</method>
+		<method name="GetMicrophoneGain">
+			<arg type="q" direction="out"/>
+		</method>
+		<method name="SetSpeakerGain">
+			<arg type="q" direction="in"/>
+		</method>
+		<method name="SetMicrophoneGain">
+			<arg type="q" direction="in"/>
+		</method>
+		<method name="GetProperties">
+			<arg type="a{sv}" direction="out"/>
+		</method>
+		<method name="SetProperty">
+			<arg type="s" direction="in"/>
+			<arg type="v" direction="in"/>
+		</method>
+		<signal name="Connected"/>
+		<signal name="Disconnected"/>
+		<signal name="AnswerRequested"/>
+		<signal name="Stopped"/>
+		<signal name="Playing"/>
+		<signal name="SpeakerGainChanged">
+			<arg type="q"/>
+		</signal>
+		<signal name="MicrophoneGainChanged">
+			<arg type="q"/>
+		</signal>
+		<signal name="CallTerminated"/>
+		<signal name="PropertyChanged">
+			<arg type="s"/>
+			<arg type="v"/>
+		</signal>
+	</interface>
+</node>
diff --git a/xml/health.xml b/xml/health.xml
new file mode 100644
index 0000000..2222b02
--- /dev/null
+++ b/xml/health.xml
@@ -0,0 +1,13 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.HealthManager">
+		<method name="CreateApplication">
+			<arg type="a{sv}" direction="in"/>
+			<arg type="o" direction="out"/>
+		</method>
+		<method name="DestroyApplication">
+			<arg type="o" direction="in"/>
+		</method>
+	</interface>
+</node>
diff --git a/xml/input.xml b/xml/input.xml
new file mode 100644
index 0000000..d21d81a
--- /dev/null
+++ b/xml/input.xml
@@ -0,0 +1,15 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.Input">
+		<method name="Connect"/>
+		<method name="Disconnect"/>
+		<method name="GetProperties">
+			<arg type="a{sv}" direction="out"/>
+		</method>
+		<signal name="PropertyChanged">
+			<arg type="s"/>
+			<arg type="v"/>
+		</signal>
+	</interface>
+</node>
diff --git a/xml/manager.xml b/xml/manager.xml
new file mode 100644
index 0000000..46b3b1f
--- /dev/null
+++ b/xml/manager.xml
@@ -0,0 +1,33 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.Manager">
+		<method name="GetProperties">
+			<arg type="a{sv}" direction="out"/>
+		</method>
+		<method name="DefaultAdapter">
+			<arg type="o" direction="out"/>
+		</method>
+		<method name="FindAdapter">
+			<arg type="s" direction="in"/>
+			<arg type="o" direction="out"/>
+		</method>
+		<method name="ListAdapters">
+			<arg type="ao" direction="out"/>
+		</method>
+		<signal name="PropertyChanged">
+			<arg type="s"/>
+			<arg type="v"/>
+		</signal>
+		<signal name="AdapterAdded">
+			<arg type="o"/>
+		</signal>
+		<signal name="AdapterRemoved">
+			<arg type="o"/>
+		</signal>
+		<signal name="DefaultAdapterChanged">
+			<arg type="o"/>
+		</signal>
+	</interface>
+</node>
+
diff --git a/xml/network_server.xml b/xml/network_server.xml
new file mode 100644
index 0000000..97c72b9
--- /dev/null
+++ b/xml/network_server.xml
@@ -0,0 +1,13 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.NetworkServer">
+		<method name="Register">
+			<arg type="s" direction="in"/>
+			<arg type="s" direction="in"/>
+		</method>
+		<method name="Unregister">
+			<arg type="s" direction="in"/>
+		</method>
+	</interface>
+</node>
diff --git a/xml/serial.xml b/xml/serial.xml
new file mode 100644
index 0000000..001ba53
--- /dev/null
+++ b/xml/serial.xml
@@ -0,0 +1,13 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.Serial">
+		<method name="Connect">
+			<arg type="s" direction="in"/>
+			<arg type="s" direction="out"/>
+		</method>
+		<method name="Disconnect">
+			<arg type="s" direction="in"/>
+		</method>
+	</interface>
+</node>
diff --git a/xml/serial_proxy.xml b/xml/serial_proxy.xml
new file mode 100644
index 0000000..1d6da6b
--- /dev/null
+++ b/xml/serial_proxy.xml
@@ -0,0 +1,18 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.SerialProxy">
+		<method name="Enable"/>
+		<method name="Disable"/>
+		<method name="GetInfo">
+			<arg type="a{sv}" direction="out"/>
+		</method>
+		<method name="SetSerialParameters">
+			<arg type="s" direction="in"/>
+			<arg type="y" direction="in"/>
+			<arg type="y" direction="in"/>
+			<arg type="s" direction="in"/>
+		</method>
+	</interface>
+</node>
+
diff --git a/xml/serial_proxy_manager.xml b/xml/serial_proxy_manager.xml
new file mode 100644
index 0000000..621619f
--- /dev/null
+++ b/xml/serial_proxy_manager.xml
@@ -0,0 +1,23 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.SerialProxyManager">
+		<method name="CreateProxy">
+			<arg type="s" direction="in"/>
+			<arg type="s" direction="in"/>
+			<arg type="s" direction="out"/>
+		</method>
+		<method name="ListProxies">
+			<arg type="as" direction="out"/>
+		</method>
+		<method name="RemoveProxy">
+			<arg type="s" direction="in"/>
+		</method>
+		<signal name="ProxyCreated">
+			<arg type="s"/>
+		</signal>
+		<signal name="ProxyRemoved">
+			<arg type="s"/>
+		</signal>
+	</interface>
+</node>
diff --git a/xml/service.xml b/xml/service.xml
new file mode 100644
index 0000000..95cd436
--- /dev/null
+++ b/xml/service.xml
@@ -0,0 +1,22 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
+"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+	<interface name="org.bluez.Service">
+		<method name="AddRecord">
+			<arg type="s" direction="in"/>
+			<arg type="u" direction="out"/>
+		</method>
+		<method name="UpdateRecord">
+			<arg type="u" direction="in"/>
+			<arg type="s" direction="in"/>
+		</method>
+		<method name="RemoveRecord">
+			<arg type="u" direction="in"/>
+		</method>
+		<method name="RequestAuthorization">
+			<arg type="s" direction="in"/>
+			<arg type="u" direction="in"/>
+		</method>
+		<method name="CancelAuthorization"/>
+	</interface>
+</node>
-- 
1.7.4.1


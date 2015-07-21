Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v1 14/15] peripheral: Add a README for the Soletta support
Date: Tue, 21 Jul 2015 20:16:47 -0300
Message-Id: <1437520608-22444-15-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
References: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This gives an overview about what is Soletta, what is gained by having
this support in the BlueZ tree and how to build and use it.
---
 peripheral/soletta/README | 140 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 peripheral/soletta/README

diff --git a/peripheral/soletta/README b/peripheral/soletta/README
new file mode 100644
index 0000000..a11df63
--- /dev/null
+++ b/peripheral/soletta/README
@@ -0,0 +1,140 @@
+Bluetooth node types for Soletta
+********************************
+
+Soletta
+=======
+
+From the Soletta project github[1] repository:
+
+"Soletta Project is a framework for making IoT devices. With Soletta
+Project's libraries developers can easily write software for devices
+that control actuators/sensors and communicate using standard
+technologies. It enables adding smartness even on the smallest edge
+devices."
+
+Soletta support in BlueZ will provide node types for common Bluetooth
+profiles, so applications written for Soletta may target devices
+running BlueZ.
+
+
+Build requirements
+------------------
+
+- GLib
+
+- python-jsonschema (Used for validating JSON files, for code
+  generation and providing meta-data about node types)
+
+- chrpath
+
+
+Building Soletta
+----------------
+
+Soletta uses kconfig as build system, the default config is enough for
+the purposes of building an external module. From the soletta project
+root directory:
+
+$ make alldefconfig
+
+(It will complain if the required dependencies aren't found)
+
+If you run:
+
+$ make menuconfig
+
+Then the configuration can be tweaked for different objectives, for
+example, changing 'Core library -> Target platform' to linux-micro and
+'Core library -> Mainloop' to posix, would make the resulting soletta
+library more adequate for building self contained applications.
+
+After Soletta is configured, the usual incantations for building and
+installing:
+
+$ make
+
+$ make install
+
+
+Bluetooth LE peripheral support for Soletta
+===========================================
+
+LE peripheral use cases mainly target low power devices, potentially
+coin cell operated, so running Linux on these devices is not usually
+adequate for production devices. But when developing applications,
+having all the development/debug tools available for Linux on hand is
+valuable.
+
+What is possible is to develop the application using Soletta node
+nodes on Linux (or linux-micro), and when the application is feature
+complete, target the final device.
+
+
+Building
+--------
+
+Soletta support is activated by the '--enable-soletta' option
+(protected by the --enable-experimental flag) to the configure step
+when building BlueZ. For buildind an static version of the library,
+pass '--enable-static'. For example, from BlueZ root directory:
+
+$ ./bootstrap
+
+$ ./configure --prefix=/usr --enable-experimental --enable-soletta --enable-static
+
+('--enable-static' enables building static version of the libraries as
+well, this makes it easier building a standalone binary, see the last
+section.)
+
+$ make
+
+$ make install
+
+The install step is necessary so the node types (and its associated
+meta-data) are installed where the soletta tools can find them.
+
+
+Running
+-------
+
+After building and installing BlueZ, go to the 'peripheral/soletta'
+directory and do:
+
+$ sol-fbp-runner heartrate.fbp
+
+You may need super user privileges to properly register the Heartrate service.
+
+The content of the 'heartrate.fbp' file should be similar to this:
+
+"""
+Timer(timer:interval=1000) OUT -> IN Heartrate(heartrate)
+"""
+
+It should read like this, create a node of type 'timer' with the
+'interval' option set to '1000' and name it 'Timer', then connect
+'Timer' 'OUT' port to the 'IN' port of the node named 'Heartrate' of
+type 'heartrate'.
+
+
+Standalone binary
+-----------------
+
+Also in the 'peripheral/soletta' there is a sample 'Makefile'
+demonstrating how you would build an executable using the soletta
+tools.
+
+Building an completely static binary is easier accomplished when using
+the musl[2] libc, and it is left as an exercise.
+
+
+Supported Profiles
+==================
+
+Profile name				node type name
+------------------------------------------------------
+Heartrate Sensor			heartrate
+
+
+[1] https://github.com/solettaproject/soletta
+
+[2] http://www.musl-libc.org/
\ No newline at end of file
-- 
2.4.6


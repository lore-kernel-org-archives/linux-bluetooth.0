Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/2] hostname: Fix "BlueZ 5.XX" adapter name on startup
Date: Wed, 20 Sep 2017 14:54:45 +0200
Message-Id: <20170920125445.24792-2-hadess@hadess.net>
In-Reply-To: <20170920125445.24792-1-hadess@hadess.net>
References: <20170920125445.24792-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hostname plugin listens to property changes from systemd-hostnamed
but doesn't fetch initial values. This means that unless the
PrettyHostname or StaticHostname changes, the default adapter will be
called "BlueZ 5.XX" matching the version number.

This is the case since the hostname plugin replaced the adaptername
plugin in 2012.

Fetch the initial values for PrettyHostname, StaticHostname and
Chassis when the plugin is initiated, so as to make the values
available for adapter setup.
---
 plugins/hostname.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/hostname.c b/plugins/hostname.c
index f876d0afb..db9187378 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -307,6 +307,10 @@ static int hostname_init(void)
 		hostname_proxy = NULL;
 		g_dbus_client_unref(hostname_client);
 		hostname_client = NULL;
+	} else {
+		g_dbus_proxy_refresh_property(hostname_proxy, "PrettyHostname");
+		g_dbus_proxy_refresh_property(hostname_proxy, "StaticHostname");
+		g_dbus_proxy_refresh_property(hostname_proxy, "Chassis");
 	}
 
 	return err;
-- 
2.14.1


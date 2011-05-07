Return-Path: <cyrus@holtmann.org>
Subject: Re: RFC: First pass at pretty hostname support
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Sat, 07 May 2011 07:56:23 +0100
In-Reply-To: <1304701117.16101.40.camel@novo.hadess.net>
References: <1304701117.16101.40.camel@novo.hadess.net>
Content-Type: multipart/mixed; boundary="=-dFSrTdBTd6hZ6CztuDPP"
Message-ID: <1304751384.2427.5.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-dFSrTdBTd6hZ6CztuDPP
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Fri, 2011-05-06 at 17:58 +0100, Bastien Nocera wrote:
> Most of the details are in the patch.
> 
> I just wanted to mention that:
> "Bastien's desktop": good
> "novo-0": bad
> 
> Ideas on how to implement the TODO items would be appreciated. I'm
> currently thinking that a plugin to monitor the pretty hostname would be
> the cleaner way. It would even allow us to change the adapter name on
> the fly if the hostname (rather than the pretty hostname) changed.
> 
> Cheers

And with the correct patch...

--=-dFSrTdBTd6hZ6CztuDPP
Content-Disposition: attachment; filename="0001-Use-Pretty-hostname-for-the-adapter-name.patch"
Content-Type: text/x-patch; name="0001-Use-Pretty-hostname-for-the-adapter-name.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 76eef22b0cc2e99724fbac05d6d4cb054337b795 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 6 May 2011 17:48:56 +0100
Subject: [PATCH] Use "Pretty hostname" for the adapter name

systemd exports a "pretty hostname" through /etc/machine-info[1],
as well as through a D-Bus service[2]. This pretty hostname should be
used to name the adapter in a way that's more dynamic and user-friendly
than the current "static hostname" use.

[1]: http://0pointer.de/public/systemd-man/machine-info.html
[2]: http://www.freedesktop.org/wiki/Software/systemd/hostnamed

TODO:
- Add option not to write the adapter name, so it can be changed
  automatically
- Make the default adapter (and not hci0) have the shorter pretty name
  (eg. through plug/unplug, "My laptop 1" could be the name for the
   default adapter, we don't want that)
- Monitor /etc/machine-info, or listen to the hostname service signals
  for changes
---
 src/adapter.c |   20 ++++++++++++++++++++
 src/hcid.h    |    1 +
 src/main.c    |   32 ++++++++++++++++++++++++++++++++
 src/main.conf |    8 +++++---
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 76fc01b..1ef6e36 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -183,7 +183,10 @@ static void dev_info_free(struct remote_dev_info *dev)
 
 /*
  * Device name expansion
+ *   %h - hostname
  *   %d - device id
+ *   %p - pretty hostname
+ *   %i - device id if different from 0, empty otherwise
  */
 static char *expand_name(char *dst, int size, char *str, int dev_id)
 {
@@ -209,6 +212,19 @@ static char *expand_name(char *dst, int size, char *str, int dev_id)
 				opt = main_opts.host_name;
 				break;
 
+			case 'p':
+				opt = main_opts.pretty_host_name;
+				if (!opt)
+					opt = main_opts.host_name;
+				break;
+
+			case 'i':
+				if (dev_id > 0) {
+					sprintf(buf, "%d", dev_id);
+					opt = buf;
+				}
+				break;
+
 			case '%':
 				dst[np++] = str[sp++];
 				/* fall through */
@@ -236,6 +252,10 @@ static char *expand_name(char *dst, int size, char *str, int dev_id)
 		}
 	}
 	dst[np] = '\0';
+
+	/* Remove leading and trailing whitespaces */
+	g_strstrip(dst);
+
 	return dst;
 }
 
diff --git a/src/hcid.h b/src/hcid.h
index 856723b..b2a3b0a 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -25,6 +25,7 @@
 
 struct main_opts {
 	char		host_name[40];
+	char           *pretty_host_name;
 	unsigned long	flags;
 	char		*name;
 	uint32_t	class;
diff --git a/src/main.c b/src/main.c
index c454327..4a336ba 100644
--- a/src/main.c
+++ b/src/main.c
@@ -234,6 +234,35 @@ static void parse_config(GKeyFile *config)
 						HCI_LP_HOLD | HCI_LP_PARK;
 }
 
+static char *read_pretty_host_name (void)
+{
+	char *contents, *ret;
+	char **lines;
+	guint i;
+
+	ret = NULL;
+
+	if (g_file_get_contents("/etc/machine-info",
+			&contents, NULL, NULL) == FALSE) {
+		return NULL;
+	}
+	lines = g_strsplit_set(contents, "\r\n", 0);
+	g_free(contents);
+
+	if (lines == NULL)
+		return NULL;
+
+	for (i = 0; lines[i] != NULL; i++) {
+		if (g_str_has_prefix(lines[i], "PRETTY_HOSTNAME=")) {
+			ret = g_strdup(lines[i] + strlen("PRETTY_HOSTNAME="));
+			break;
+		}
+	}
+
+	g_strfreev(lines);
+	return ret;
+}
+
 static void init_defaults(void)
 {
 	/* Default HCId settings */
@@ -248,6 +277,7 @@ static void init_defaults(void)
 
 	if (gethostname(main_opts.host_name, sizeof(main_opts.host_name) - 1) < 0)
 		strcpy(main_opts.host_name, "noname");
+	main_opts.pretty_host_name = read_pretty_host_name();
 }
 
 static GMainLoop *event_loop;
@@ -501,6 +531,8 @@ int main(int argc, char *argv[])
 	if (config)
 		g_key_file_free(config);
 
+	g_free (main_opts.pretty_host_name);
+
 	info("Exit");
 
 	__btd_log_cleanup();
diff --git a/src/main.conf b/src/main.conf
index 8cd132f..bedd5c7 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -4,9 +4,11 @@
 #DisablePlugins = network,input
 
 # Default adaper name
-# %h - substituted for hostname
-# %d - substituted for adapter id
-Name = %h-%d
+# %h - hostname
+# %d - adapter id
+# %p - pretty hostname (if available, hostname otherwise)
+# %i - device id if different from 0, empty otherwise
+Name = %p %i
 
 # Default device class. Only the major and minor device class bits are
 # considered.
-- 
1.7.5


--=-dFSrTdBTd6hZ6CztuDPP--


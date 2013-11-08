Return-Path: <cyrus@holtmann.org>
Message-ID: <1383938500.3880.23.camel@nuvo>
Subject: obexd broken for absolute paths
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 08 Nov 2013 20:21:40 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

I was trying to test gnome-user-share's Bluetooth support for BlueZ 5,
and was quite surprised it didn't work one bit, with transfers failing
as soon as they were created.

I made this simple change to test/simple-obex-agent so you could
replicate the failure. Obviously, change the download path to exist on
your system:
-               return properties['Name']
+               return ("%s/%s" % ("/home/hadess/Downloads/", properties['Name']))

This will see OBEX Push transfers fail as soon as accepted.

I must also mention the dreadful code in agent_reply() in obexd/src/manager.c:
                const char *slash = strrchr(name, '/');
                DBG("Agent replied with %s", name);
                if (!slash) {
                        agent->new_name = g_strdup(name);
                        agent->new_folder = NULL;
                } else {
                        agent->new_name = g_strdup(slash + 1); 
                        agent->new_folder = g_strndup(name, slash - name);
                }

Please use g_path_get_basename() and g_path_get_dirname(). This is even
a security issue because I could pass relative paths and expect some
system file to get overwritten.

Cheers


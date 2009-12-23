Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Dec 2009 14:51:19 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Jeremy Jackson <jerj@coplanar.net>,
 linux-bluetooth@vger.kernel.org
Subject: Re: btusb regression on commands unsupported by adapter
Message-ID: <20091223145119.3ef1651b@strolchi.home.s3e.de>
In-Reply-To: <1261173206.4041.89.camel@localhost.localdomain>
References: <1261158272.4932.184.camel@ragnarok>
	<1261173206.4041.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, 18 Dec 2009 13:53:26 -0800
Marcel Holtmann <marcel@holtmann.org> wrote:
> > The question for kernel side is, regression, or corrected behaviour?
> 
> this is basically a bluetoothd issue. We should be reading the list of
> supported commands and then either issue or not issue this command. Feel
> free to write a patch for that.

This sounded like fun, and because I had nothing better to do, I wanted
to take a shot at that.

The result looks something like that (not to be applied,
whitespace-damaged!):

diff --git a/src/adapter.c b/src/adapter.c
index 2e43662..2690227 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2121,6 +2121,7 @@ int adapter_start(struct btd_adapter *adapter)
        struct hci_dev_info di;
        struct hci_version ver;
        uint8_t features[8];
+       uint8_t cmds[64];
        int dd, err;
        char mode[14], address[18];

@@ -2203,8 +2204,16 @@ int adapter_start(struct btd_adapter *adapter)
        }

 setup:
-       hci_send_cmd(dd, OGF_LINK_POLICY, OCF_READ_DEFAULT_LINK_POLICY,
-                                                               0, NULL);
+       if (hci_read_local_commands(dd, cmds, 1000) < 0) {
+               error("Can't read supported commands on %s: %s (%d)\n",
+                                       adapter->path, strerror(errno), errno);
+       }
+
+       /* bit 43 is "Read Default Link Policy Settings" command support */
+       if (cmds[5] & (1 << 3))
+               hci_send_cmd(dd, OGF_LINK_POLICY,
+                                       OCF_READ_DEFAULT_LINK_POLICY, 0, NULL);
+
        hci_close_dev(dd);

        adapter->current_cod = 0;


One question I faced was, if we should error out if
hci_read_local_commands fails? I'm generally against it since it might
introduce an 

But then I noticed that we are not even reading the answer to this
command (or is there no answer? would seem strange for a "read"
command), so I concluded that the best way to fix the problem would
probably be to just revert commit 8563b779 which added this command.

Is my conclusion correct or did I overlook something?

Have fun,

	seife
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."

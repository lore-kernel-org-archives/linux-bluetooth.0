Return-Path: <cyrus@holtmann.org>
Message-ID: <51890AC9.7010501@asianux.com>
Date: Tue, 07 May 2013 22:08:09 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>, gustavo@padovan.org,
 johan.hedberg@gmail.com
CC: David Miller <davem@davemloft.net>, dh.herrmann@gmail.com,
 Jiri Kosina <jkosina@suse.cz>,
 andrei.emeltchenko@intel.com, linux-bluetooth@vger.kernel.org,
 netdev <netdev@vger.kernel.org>
Subject: [Suggestion] Bluetooth: hidp: redundant initialization or issue for
 function hidp_copy_session
References: <518906A8.7060708@asianux.com>
In-Reply-To: <518906A8.7060708@asianux.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Maintainers:

In net/bluetooth/hidp/core.c, for hidp_copy_session(), the
'session->input' and 'session->hid' are conflict with each other.

And excuse me, I do not quit know the details, but I think we have 2
choices for fixing it:

  one is ''if (session->input) { } else if (session->hid) { };''
  the other is ''if (seesion->hid) { } else if (session->input) { };''

The first choice assumes the original code has a logical issue; the
second choice assumes the original code has redundant initialization.

Please help check.

Thanks.

  71 static void hidp_copy_session(struct hidp_session *session, struct hidp_conninfo *ci)
  72 {
  73         memset(ci, 0, sizeof(*ci));
  74         bacpy(&ci->bdaddr, &session->bdaddr);
  75 
  76         ci->flags = session->flags;
  77         ci->state = BT_CONNECTED;
  78 
  79         ci->vendor  = 0x0000;
  80         ci->product = 0x0000;
  81         ci->version = 0x0000;
  82 
  83         if (session->input) {
  84                 ci->vendor  = session->input->id.vendor;
  85                 ci->product = session->input->id.product;
  86                 ci->version = session->input->id.version;
  87                 if (session->input->name)
  88                         strncpy(ci->name, session->input->name, 128);
  89                 else
  90                         strncpy(ci->name, "HID Boot Device", 128);
  91         }
  92 
  93         if (session->hid) {
  94                 ci->vendor  = session->hid->vendor;
  95                 ci->product = session->hid->product;
  96                 ci->version = session->hid->version;
  97                 strncpy(ci->name, session->hid->name, 128);
  98         }
  99 }

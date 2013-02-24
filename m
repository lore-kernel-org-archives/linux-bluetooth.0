Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH BlueZ 0/2] Some more prerequisites for the playstation-peripheral plugin
Date: Sun, 24 Feb 2013 10:54:43 +0100
Message-Id: <1361699686-12341-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

if you recall some older discussions we decided to have the
playstation-peripheral plugin as an _external_ plugin, because it will be
used by only a few people and allowing to make its installation optional
makes a lot of sense.

But external plugins can only use a subset of the BlueZ API, the one
marked as "global" in src/bluetooth.ver

Hence some more btd_* APIs are needed for the playstation-peripheral
plugin.

Here I propose the last missing pieces of the jigsaw before I can submit
the actual plugin.

Please comment, in the hope that at most one more review round will be
enough to have these functionalities merged.

Patch 1 is needed because the playstation-peripheral plugin will send
the adapter bdaddr to the peripheral via USB, to have it set as the
"master bdaddr". I can very well avoid a new API in this case but then
I'd need to make some symbols global, let me know if that's what you
prefer instead.

Patch 2 is to create the device in the BlueZ database, any comment on
this one is appreciated: the name can be improved, the implementation
can be changed, but the point is that in one way or another we need some
mechanism to add new devices programmatically before they show up via
Bluetooth. An alternative proposal by someone else would also be very
welcome :)

Patches are against BlueZ 5.3.

I can submit the plugin as well, if you really want to see the code using
these APIs, I didn't just yet in order to keep the discussion more focused.

Thanks,
   Antonio

Antonio Ospite (2):
  adapter: add a btd_adapter_get_default_address() call
  adapter: add a btd_create_stored_device() call

 src/adapter.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |   12 ++++++++++
 2 files changed, 81 insertions(+)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

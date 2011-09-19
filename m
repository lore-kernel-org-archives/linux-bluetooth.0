Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: [RFC PATCH BlueZ 0/3] Add new btd_* calls for external plugins
Date: Mon, 19 Sep 2011 19:42:02 +0200
Message-Id: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

following up from a previous conversation[1] and some clarifications via
IRC with Vinicius Costa Gomes, I am proposing these three new btd_*
calls which I need in order to keep the playstation-peripheral plugin
(ex sixaxis plugin) external.

The first two should be functionally OK, but maybe the implementation
can be improved.

The third one needs some more care, I added some XXX notes to the pieces
I have still some doubts on.

I used an interface based on "char *" to avoid using bluez types in an
external plugin and avoid adding calls like ba2str() and str2ba() to
src/bluetooth.ver

I checked the patches with checkpatch.pl from linux and there are a
couple of WARNING: braces {} are not necessary for single statement
blocks I can fix these in another iteration if this is required by bluez
coding guidelines too.

Thanks,
   Antonio

[1] http://article.gmane.org/gmane.linux.bluez.kernel/16032

Antonio Ospite (3):
  Add a btd_manager_get_default_adapter_str() call
  Add a btd_store_record_string() call
  Add a btd_device_set_trusted() call

 src/device.h  |    6 +++++
 src/manager.h |    1 +
 src/storage.h |    1 +
 src/device.c  |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/manager.c |   16 +++++++++++++
 src/storage.c |   17 +++++++++++++
 6 files changed, 111 insertions(+), 0 deletions(-)

--
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

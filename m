Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Bastien Nocera <hadess@hadess.net>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20BlueZ=200/3=5D=20Prerequisites=20for=20playstation-peripheral=20=5Fexternal=5F=20plugin?=
Date: Mon, 13 Feb 2012 15:42:45 +0100
Message-Id: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I proposed these changes back in September[1] but they didn't receive
a lot of comments, I know they are not very interesting to most of you,
but let me repeat the rationale behind them.

  1. It was decided to have the playstation-peripheral as an external
     plugin because it is going to be used by few people and it is not
     worth to keep it in the bluetoothd binary. Distributors could
     choose to put external plugins in their own packages so to provide
     a install-time choice instead of a compile-time choice to use the
     plugin services.

  2. external plugins can only access symbols exported as global in
     src/bluetooth.ver, like btd_* and very few others.

  3. It was suggested to add some helper functions to the bluez code
     instead of adding new global symbols to bluetooth.ver

Some notes about the implementation: I choose to pass only strings in
function signatures so that external plugins doesn't have to care about
bluez data structures too much and we can avoid exporting str2ba() and
other similar functions as global symbols in bluetooth.ver.

I hope you could comment on the patches and give me directions of how
you want me to do them if they are not OK as they are.

Once these —or equivalent— are merged then getting in the
playstation-peripheral plugin will take a very short time.

Thanks a lot,
   Antonio

[1] http://article.gmane.org/gmane.linux.bluez.kernel/16540

Changes since the RFC:
  - fixed a memory leak in btd_manager_get_default_adapter_str(), thanks to
    Daninele Forsi for looking at the code.
  - Removed unnecessary steps in btd_device_set_trusted()
  - Allow passing vendor_id_source in btd_device_set_trusted()

Antonio Ospite (3):
  manager: add a btd_manager_get_default_adapter_str() call
  storage: add a btd_store_record_string() call
  device: add a btd_device_set_trusted() call

 src/device.c  |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |    8 +++++++
 src/manager.c |   21 +++++++++++++++++++
 src/manager.h |    1 +
 src/storage.c |   17 +++++++++++++++
 src/storage.h |    1 +
 6 files changed, 110 insertions(+), 0 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

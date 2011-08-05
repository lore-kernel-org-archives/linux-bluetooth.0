Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>,
	Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>,
	Simon Wood <simon@mungewell.org>,
	Arc Riley <arcriley@gmail.com>
Subject: [PATCH BlueZ 4/4] plugins/sixaxis: Wait for the PS button before setting the LEDs
Date: Fri,  5 Aug 2011 16:09:18 +0200
Message-Id: <1312553358-26280-5-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Wait for actual input events, that is PS button has been pressed, before
setting the LEDs to indicate the controller number.
This makes setting LEDs look more like on the PS3.
---
 plugins/sixaxis.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 2b0616a..d64ad6d 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -511,8 +511,14 @@ static void handle_device_plug(struct udev_device *udevice)
 		sixpair(fd, adapter);
 	}
 
-	if (js_num > 0)
+	if (js_num > 0) {
+		char c;
+
+		/* wait for events before setting leds */
+		if (read(fd, &c, 1) != 1)
+			perror("read error");
 		set_controller_number(fd, js_num);
+	}
 
 	close(fd);
 }
-- 
1.7.5.4


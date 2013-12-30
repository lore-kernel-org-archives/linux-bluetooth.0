Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Dec 2013 23:19:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>, trivial@kernel.org
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	=?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <ville.tervo@nokia.com>,
	Sebastian Reichel <sre@ring0.de>
Subject: [PATCH] wilink: mention name of module in help text
Message-ID: <20131230221903.GB32561@amd.pavel.ucw.cz>
References: <1379703710-5757-1-git-send-email-pali.rohar@gmail.com>
 <1727897.LBX8128hIo@izba>
 <C8D1F470-7964-4EAC-82E0-D53CF54DE086@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C8D1F470-7964-4EAC-82E0-D53CF54DE086@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Mention module name in Kconfig.
    
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 9d46f23..a53e8c7 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -241,7 +241,7 @@ config BT_WILINK
 	  core driver to communicate with the BT core of the combo chip.
 
 	  Say Y here to compile support for Texas Instrument's WiLink7 driver
-	  into the kernel or say M to compile it as module.
+	  into the kernel or say M to compile it as module (btwilink).
 
 config BT_NOKIA_H4P
 	tristate "HCI driver with H4 Nokia extensions"


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

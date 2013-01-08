Return-Path: <cyrus@holtmann.org>
From: Lubomir Rintel <lkundrak@v3.sk>
To: David Woodhouse <dwmw2@infradead.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	libertas-dev@lists.infradead.org,
	linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org,
	lkundrak@v3.sk
Subject: [PATCH] Move sd8688*.bin images away from libertas tree
Date: Wed,  9 Jan 2013 00:57:15 +0100
Message-Id: <1357689435-8089-1-git-send-email-lkundrak@v3.sk>
In-Reply-To: <1357689361-7969-1-git-send-email-lkundrak@v3.sk>
References: <1357689361-7969-1-git-send-email-lkundrak@v3.sk>
List-ID: <linux-bluetooth.vger.kernel.org>

They are (unlike rest of sd8xxx images from libertas/ and mrvl/) not Libertas
WiFi specific and are used for the bluetooth controller (btmrvl) which does not
look for them in libertas/.

This is fine for the WiFi driver that utilizes those, since it has always been
looking in this place as well.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 libertas/sd8688.bin => sd8688.bin               |  Bin 259172 -> 259172 bytes
 libertas/sd8688_helper.bin => sd8688_helper.bin |  Bin 2616 -> 2616 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename libertas/sd8688.bin => sd8688.bin (100%)
 rename libertas/sd8688_helper.bin => sd8688_helper.bin (100%)

-- 
1.7.1

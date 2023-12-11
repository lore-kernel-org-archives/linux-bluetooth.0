Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A432CB4;
	Mon, 11 Dec 2023 08:40:27 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A4E18208A9;
	Mon, 11 Dec 2023 17:40:25 +0100 (CET)
From: Francesco Dolcini <francesco@dolcini.it>
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 1/3] Bluetooth: btnxpuart: fix recv_buf() return value
Date: Mon, 11 Dec 2023 17:40:18 +0100
Message-Id: <20231211164020.173253-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211164020.173253-1-francesco@dolcini.it>
References: <20231211164020.173253-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Serdev recv_buf() callback is supposed to return the amount of bytes
consumed, therefore an int in between 0 and count.

Do not return a negative number in case of issue, just print an error
and return count. Before this change, in case of error, the returned
negative number was internally converted to 0 in ttyport_receive_buf,
now when the receive buffer is corrupted we return the size of the whole
received data (`count`). This should allow for better recovery in case
receiver/transmitter get out of sync if some data is lost.

This fixes a WARN in ttyport_receive_buf().

  Bluetooth: hci0: Frame reassembly failed (-84)
  ------------[ cut here ]------------
  serial serial0: receive_buf returns -84 (count = 6)
  WARNING: CPU: 0 PID: 37 at drivers/tty/serdev/serdev-ttyport.c:37 ttyport_receive_buf+0xd8/0xf8
  Modules linked in: mwifiex_sdio(+) ...
  CPU: 0 PID: 37 Comm: kworker/u4:2 Not tainted 6.7.0-rc2-00147-gf1a09972a45a #1
  Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
  Workqueue: events_unbound flush_to_ldisc
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : ttyport_receive_buf+0xd8/0xf8
  lr : ttyport_receive_buf+0xd8/0xf8
...
  Call trace:
   ttyport_receive_buf+0xd8/0xf8
   flush_to_ldisc+0xbc/0x1a4
   process_scheduled_works+0x16c/0x28c

Closes: https://lore.kernel.org/all/ZWEIhcUXfutb5SY6@francesco-nb.int.toradex.com/
Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2:
 - improve commit message
---
 drivers/bluetooth/btnxpuart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b7e66b7ac570..951fe3014a3f 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1276,11 +1276,10 @@ static int btnxpuart_receive_buf(struct serdev_device *serdev, const u8 *data,
 	if (IS_ERR(nxpdev->rx_skb)) {
 		int err = PTR_ERR(nxpdev->rx_skb);
 		/* Safe to ignore out-of-sync bootloader signatures */
-		if (is_fw_downloading(nxpdev))
-			return count;
-		bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
+		if (!is_fw_downloading(nxpdev))
+			bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
 		nxpdev->rx_skb = NULL;
-		return err;
+		return count;
 	}
 	if (!is_fw_downloading(nxpdev))
 		nxpdev->hdev->stat.byte_rx += count;
-- 
2.25.1


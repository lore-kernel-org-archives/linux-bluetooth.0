Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Date: Thu, 14 Jan 2010 15:42:12 -0800
Message-ID: <43e72e891001141542j4a6c1cdfr715ff092b01bb03e@mail.gmail.com>
Subject: ath3k driver for older kernels
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Vikram Kandukuri <vikram.kandukuri@atheros.com>, Alicke Xu <sxu@atheros.com>,
	Marcel Holtmann <marcel@holtmann.org>, Bala Shanmugam <sbalashanmugam@atheros.com>,
	"Luis R. Rodriguez" <lrodriguez@atheros.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

The ath3k bluetooth driver is now merged on bluetooth-testing and
linux-next trees. The firmware is also now merged onto the
linux-firmware git tree. However if you're on older kernels you won't
have it available. If you're stuck on older kernels you can use this
git tree which just has the ath3k driver alone along with the
firmware:

git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/ath3k.git

Marcel, you OK with us pushing ath3k into for the 2.6.33-rc5? Its a
relatively small and simple driver.

  Luis

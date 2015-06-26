Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 26 Jun 2015 11:27:41 +0200
Message-ID: <CADDKRnA4-h61=Tp90Cgj7GsAOZhBX6Dr0ka_CncrCrHDbWLcvw@mail.gmail.com>
Subject: [4.1.0-07254-gc13c810] Regression: Bluetooth not working.
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	inux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth is inoperable in current Linus tree and the
first bad commit is:

835a6a2f8603237a3e6cded5a6765090ecb06ea5 is the first bad commit
commit 835a6a2f8603237a3e6cded5a6765090ecb06ea5
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Wed Jun 10 20:28:33 2015 +0300

    Bluetooth: Stop sabotaging list poisoning

    list_del() poisons pointers with special values, no need to overwrite t=
hem.

    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

My BT adapter is an intel 8087:07da
I reverted that commit and this fixed the problem for me.

Thanks, J=C3=B6rg

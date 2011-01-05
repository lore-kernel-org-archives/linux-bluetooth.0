Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Jan 2011 16:34:35 +0300
From: Ilya Basin <basinilya@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Message-ID: <74438513.20110105163435@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re[2]: listening socket not notified when bluetoothd stops, but becomes unusable
In-Reply-To: <AANLkTi=mncb6yoZECV8Rc3sXVvMcKkT=gGGyLN0nu+8k@mail.gmail.com>
References: <1769727890.20110105144834@gmail.com> <AANLkTi=mncb6yoZECV8Rc3sXVvMcKkT=gGGyLN0nu+8k@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.
LAvD> If you are using BDADDR_ANY than that is probably ok, now for specific
LAvD> adapter this could be a bug
I just copied the code from someone else's project:
sdpSession = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, SDP_RETRY_IF_BUSY);

I understand now, why select() doesn't return, but I still can't
connect.

LAvD> adapter is powered off after bluetoothd restart than you won't be able
LAvD> to accept connections.
If I restart my program after restarting bluetoothd, it accepts
connections.



Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: sudeepta bhuyan <sudeepta.bhuyan@gmail.com>
Date: Mon, 12 Jun 2017 18:50:26 +0530
Message-ID: <CA+TC0NonXdmqVxW+iz_eNos11Bd2+1Dd-M05JxtDAg164d0T6g@mail.gmail.com>
Subject: undefined reference errors with --disable-avrcp option (bluez 5.45)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I tried to disable AVRCP using the configure option --disable-avrcp in
bluez 5.45.

./configure --disable-avrcp

However building the code results in undefined reference errors like
the following:

bluez-5.45/profiles/audio/media.c:982: undefined reference to
`avrcp_unregister_player'
bluez-5.45/profiles/audio/media.c:1361: undefined reference to
`avrcp_player_event'
bluez-5.45/profiles/audio/media.c:1783: undefined reference to
`avrcp_register_player'

Am I doing something wrong here?

Thanks,
Sudeepta

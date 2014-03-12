Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: rctest -c "Can't connect: Device or resource busy (16)"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHZ1yCnx_fbd_O5VLZ6TWpBbyT3vsx_1JB-qOR5NBYuGMwnA_g@mail.gmail.com>
Date: Tue, 11 Mar 2014 19:14:18 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <15A2D205-97BC-4790-A998-52AD8941DB3F@holtmann.org>
References: <CAHZ1yC=+XNxEx5ivA+ebGi_Cjui2Mcrx+q83b-eUPvt2J0XLPw@mail.gmail.com> <7C822ED2-E0F6-4CC7-AF1D-D909AD7C0B1F@holtmann.org> <CAHZ1yCnx_fbd_O5VLZ6TWpBbyT3vsx_1JB-qOR5NBYuGMwnA_g@mail.gmail.com>
To: Scott James Remnant <keybuk@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> 3.10 with bluetooth-next applied - btmon of both sides attached

I am seeing the same with bluetooth-next on a 3.13 kernel. It even has a weird pattern for me.

rctest[52844]: Connected [handle 11, class 0x000000, priority 0]
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Device or resource busy (16)
rctest[52844]: Can't connect: Connection refused (111)
rctest[52844]: Can't connect: Connection reset by peer (104)
rctest[52844]: Can't connect: Connection reset by peer (104)
rctest[52844]: Connected [handle 11, class 0x000000, priority 0]

Unfortunately I currently have no idea on why this happens. When using SO_LINGER of 60 seconds with rctest -L 60 -c <bdaddr> I am getting some really odd tracing behavior.

> ACL Data RX: Handle 11 flags 0x02 dlen 14
      L2CAP: Command Reject (0x01) ident 7 len 6
        Reason: Invalid CID in request (0x0002)
        Destination CID: 64
        Source CID: 0

This should never happen and makes me wonder if something is even screwed up one down in L2CAP. Do you happen to have time to bisect this and figure out which patch introduced this behavior.

Regards

Marcel


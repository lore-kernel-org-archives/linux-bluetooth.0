Return-Path: <cyrus@holtmann.org>
Subject: Re: How could bluez start A2DP stream directly without other
 commands  while PTS.
From: Marcel Holtmann <marcel@holtmann.org>
To: =?UTF-8?Q?=EB=B0=95=EC=B0=AC=EC=97=B4?= <chanyeol.park@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <434c4b6e0906062053na041ddj6ae690c5f08f750@mail.gmail.com>
References: <434c4b6e0906062053na041ddj6ae690c5f08f750@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 07 Jun 2009 10:39:46 +0200
Message-Id: <1244363986.23850.79.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

> If possible, could you explain how to start a2dp stream directly
> without other commands such as Get_capability, Set_configuration..
> because it is necessary when a2dp stream connection was already made
> by peer(sink).
> 
> In case of PTS test(TP/SET/BV-06-I), I couldn't pass the test case.
> There is no action after bluez receive DISCOVER cmd from PTS....
> 
> I uses PTS 3.2.16
> 
> If you need futher information, please let me know it.

just start audio playback as you would always do. PTS should be able to
handle that properly and BlueZ does for sure. Otherwise that is a bug,
but I have never encountered any problems running A2DP PTS against
BlueZ.

Regards

Marcel



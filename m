Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Sep 2010 16:21:08 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Sergej Pupykin <ml@sergej.pp.ru>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Another "hci0 command tx timeout"
Message-ID: <20100927192108.GA5489@vigoh>
References: <4CA0E800.4000000@sergej.pp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CA0E800.4000000@sergej.pp.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sergej,

* Sergej Pupykin <ml@sergej.pp.ru> [2010-09-27 22:52:48 +0400]:

>   Hello, All.
> 
> How can I help to debug this issue? BT works without userspace, but does 
> not work if I enable it in udev rules (ACTION=="add", 
> SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev") or do 
> "/etc/rc.d/bluetooth start".

What do you mean by "works without userspace"?

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

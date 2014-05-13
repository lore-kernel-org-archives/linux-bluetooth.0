Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: BLE connection failing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <7E32DBFD-3A61-4126-8B8F-71E1E3D395EB@latencyzero.com>
Date: Mon, 12 May 2014 19:22:26 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7BB1715C-A0F8-4F74-B0D4-D4CD353962BA@holtmann.org>
References: <B473A0F2-765A-47EC-950F-69FAF659504B@latencyzero.com> <9ED33F2C-C3EF-41D7-8559-C04F1E6CE21D@holtmann.org> <7E32DBFD-3A61-4126-8B8F-71E1E3D395EB@latencyzero.com>
To: Rick Mann <rmann@latencyzero.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rick,

>> kernel 3.13 and later have support for Set Advertising mgmt command. That is what you should be using. Just issue “btmgmt advertising on”.
> 
> Unfortunately, I can't. We're stuck with the 3.10 kernel. I turn on advertising with hciconfig hci0 leadv. Advertising is not the problem though, as you can see.

the kernel does way more than just sending the HCI command. It does tracking of the connections and also re-enabling of advertising when needed. If you are stuck with 3.10 kernel, then do not bother with LE peripheral role. It makes no sense.

Regards

Marcel


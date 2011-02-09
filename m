Return-Path: <cyrus@holtmann.org>
Subject: Obexd client question
From: =?euc-kr?B?udrC+b+t?= <chanyeol.park@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <51E531A4-C9E5-4291-8078-FFD4C0656CD3@gmail.com>
Date: Wed, 9 Feb 2011 10:38:23 +0900
Cc: "luiz.dentz-von@nokia.com" <luiz.dentz-von@nokia.com>
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (iPhone Mail 8C148a)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Hello Bluetooth developer!

I try to use obexd client(the latest version). 
I have a few question while using ftp client.

1. Listfolder
After I dbus call it("ListFolder"), "ChangeFolder" dbus method call doesn't work well. I think because session_transfer() is just returned transfer_unregister() is not called and they block another dbus call. If you find mistake in my usage, please tell me.

2. Agen Cancel
If we call Agent Cancel While transfer is going on, connection is removed unexpectfully. Is this original concept? I think it could only stop transfer. 

Finally could you tell me who use obexd server, obexd client respectively?
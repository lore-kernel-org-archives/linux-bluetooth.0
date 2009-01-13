Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: passkey agent in bluez4.X
Date: Tue, 13 Jan 2009 21:27:30 +0800
Message-ID: <9F2B2656C8747B498D56A7B30FF5EB9FE7675A@CNMAIL13.cn.utstarcom.com>
In-Reply-To: <2d5a2c100901130508s7c083c8dh21d4ac56e3b72b3a@mail.gmail.com>
From: "Yao Ye" <yeyao@utstar.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


My platform didn't support python, so I need a C version
agent.c/passkey-agent.c for bluez4.

I have tried http://thread.gmane.org/gmane.linux.bluez.kernel/813,
but it can't work.

I am a new user of bluez.
May I ask some help at this point ?
Regards.

-----Original Message-----
Hi,

test/agent.c seems to be outdated, but you can use test/simple-agent if
your platform supports python.



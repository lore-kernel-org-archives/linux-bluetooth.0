Return-Path: <cyrus@holtmann.org>
Message-Id: <2C0A35D3-4DD9-4089-8061-F596A8A5A4B8@tiscali.it>
From: Michele Noberasco <michele.noberasco@tiscali.it>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: [PATCH] BlueZ support for audio gateway role (HFP/HSP)
Date: Thu, 22 Jan 2009 17:43:00 +0100
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello list,

some time ago my company tasked me to develop this feature, but  
unfortunately they changed their mind before I could complete  
development. I sought to finish it on my own, but my spare time is  
dwindling lately.

So I thought that someone might be interested to pick development up  
where I left it off.

If anyone is interested, I'm willing to provide the source code of my  
own work. I implemented it for HSP up to the actual creation of audio  
channels (excluded). Mostly implemented and working is rfcomm  
connection and event passing ("RING", ...).

My modifications are made against bluez-3.36 (latest version of the  
3.x branch), but I think it should be trivial to forward port them to  
bluez 4 (if you have a look at audio/gateway.c you will notice there  
is nothing in there), so I would provide a patch that applies against  
that codebase.

Best regards,
Michele Noberasco


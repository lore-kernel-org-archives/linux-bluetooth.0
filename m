Return-Path: <cyrus@holtmann.org>
Message-Id: <77F88439-8777-40C9-BECA-CFF500EE7DEA@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <792645.64581.qm@web52903.mail.re2.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Cannot pair A2DP speakers with Belkin Bluetooth adapter
Date: Mon, 4 Aug 2008 11:47:11 +0300
References: <792645.64581.qm@web52903.mail.re2.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Aug 4, 2008, at 2:39, Chris Rankin wrote:
> and I cannot pair it with a set of bluetooth A2DP speakers. These  
> same speakers work fine with my laptop, which has an internal  
> bluetooth device 0x0a5c:0x2110. But whenever I try to pair the  
> Belkin device using the commands
>
> $ hcitool cc <bdaddr>
> $ hcitool auth <bdaddr>
>
> then the connection drops after only a few seconds and the pairing  
> fails.

For those two low-level test commands the behavior you describe is  
perfectly normal and expected. However, they certainly aren't a proper  
way to initiate pairing. Where did you get the idea that this is the  
right way to do pairing? If it was in some BlueZ documentation we  
should fix it ASAP. You might want to check the bluez wiki for some  
ways to perform pairing (hint: search for "CreateBonding"):
http://wiki.bluez.org/wiki/HOWTO/Bonding

> Can anyone suggest anything to try in order to keep the BT  
> connection up, please? I have already tried adding the flags  
> HCI_RESET | HCI_WRONG_SCO_MTU without any effect.

This is not specific in any way to your adapter. You would have gotten  
the same behavior with any other adapter as well.

Johan

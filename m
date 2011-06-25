Return-Path: <cyrus@holtmann.org>
Message-ID: <1309027604.47829.YahooMailClassic@web26504.mail.ukl.yahoo.com>
Date: Sat, 25 Jun 2011 19:46:44 +0100 (BST)
From: Mark Hobley <markhobley@yahoo.co.uk>
Reply-To: markhobley@yahoo.co.uk
Subject: Re: How do I make the computer visible to the mobile phone?
To: Takeshi Hamasaki <hmatrjp@users.sourceforge.jp>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <BANLkTinUuOLEUQHLKj=DayiCM9JtMGbCZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--- On Sat, 25/6/11, Takeshi Hamasaki <hmatrjp@users.sourceforge.jp> wrote:

> I assume you've already installed bluez package.
> 
> $ bluez-test-adapter discoverable
> 
> this command returns 1 or 0.
> 
> If 1 was returned, your computer, in fact your bluetooth
> adapter, is set to discoverable from other bluetooth device, in your case, mobile phone.

Ok, this returns 1

> You can switch the status:
> $ bluez-test-adapter discoverable [on/off]

I have tried toggling this to both on and off, but the mobile phone still cannot see the computer.

My mobile phone is a Samsung J700, if that matters.


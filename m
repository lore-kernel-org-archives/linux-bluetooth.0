Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Bluetooth LE localizer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAPd6Mmhxoh+W8L+d_Jxp-J-yvBOBSgFFjyi6moYuX+xSsCc7=w@mail.gmail.com>
Date: Wed, 26 Nov 2014 23:10:35 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <15E0E105-CF63-45BC-91B4-2814FF97E3ED@holtmann.org>
References: <CAPd6Mmhxoh+W8L+d_Jxp-J-yvBOBSgFFjyi6moYuX+xSsCc7=w@mail.gmail.com>
To: Krutskikh Ivan <stein.hak@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ivan,

> I had this idea for some time right now but never managed to make it
> work. Let's say I have a typical office, a bunch of bluetooth le
> dongles (ones that are used to find missing car keys and such) and a
> small linux servers with bluetooth capabilities in every room. Can I
> passively (without having to push anything on le dongles) detect the
> location of every dongle in the office? What would the precision of
> such an approach? I would be happy with it narrowing to one room, but
> higher is better of course.

if the LE devices are advertising and including TX power level, then you can calculate the pathloss and be pretty precise on where the devices are.

Regards

Marcel


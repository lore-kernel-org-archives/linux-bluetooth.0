Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: mgmt-api callback not firing properly
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACjvaw==Z9Mbgd6tBdHsNs1W+o7UbSudDUaGuwTLeY=LWkyW2A@mail.gmail.com>
Date: Thu, 10 Sep 2015 15:21:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3A3A3A19-AE6E-493A-AA1F-3C0A8451B775@holtmann.org>
References: <CACjvaw==Z9Mbgd6tBdHsNs1W+o7UbSudDUaGuwTLeY=LWkyW2A@mail.gmail.com>
To: Nazmul Alam <fadedreamz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nazmul,

> I am using mgmt-api to send command to the bluetooth kernel driver.
> 
> The problem is that sometimes the callback of the mgmt_send() command
> is not fired even though the return value of the mgmt_send() is
> indicating a success.
> 
> is there any special case which may cause this kind of issue?
> 
> using bluez 5.31 and 4.1+ kernel.

are you utilizing src/shared/mgmt.c for your code. That one has proper handling for queuing the commands. It however means that the next command is only send when the previous one completed? Which command do you have problems with. There are a few special ones that require mgmt_reply to be used.

Regards

Marcel


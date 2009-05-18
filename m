Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Emit device_found when RSSI changes.
From: Marcel Holtmann <marcel@holtmann.org>
To: Manuel Naranjo <manuel@aircable.net>
Cc: Jaikumar Ganesh <jaikumar@google.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <4A10D66E.2040604@aircable.net>
References: <1241505159-12795-1-git-send-email-jaikumar@google.com>
	 <4A10C797.4080803@aircable.net>
	 <e8892a6a0905172014h798119c4m3b36e7e6efed8bb4@mail.gmail.com>
	 <4A10D66E.2040604@aircable.net>
Content-Type: text/plain
Date: Mon, 18 May 2009 14:20:31 -0700
Message-Id: <1242681631.17495.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manuel,

> >   This fix got implemented as part of bunch of changed made by Luiz in 
> > the DeviceFound code namely,
> >
> > http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=66ef7864f7820f41d7331942bcb6256ff68d7614
> >
> > Thanks
> > Jaikumar
> Oops sorry I missed it. So it will send a result each time there's an 
> inquriry result no matter if RSSI changes or not. That's why I missed it.

is this still an issue with the latest code from the GIT repository?

Regards

Marcel



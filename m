Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH BlueZ] android/AVDTP: Duplicate fd passed to avdtp_new
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKcsaSSEXLV+gQuxXMzu8ePCyiyU5cJcNQ8rTjzsP-PUg@mail.gmail.com>
Date: Fri, 20 Dec 2013 05:52:03 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <68A01E8B-5BF3-41AD-AF79-0DF619566069@holtmann.org>
References: <1387533387-6724-1-git-send-email-luiz.dentz@gmail.com> <6E8A8CD1-5CB6-4D65-9BD7-DF4CF23F274C@holtmann.org> <CABBYNZKcsaSSEXLV+gQuxXMzu8ePCyiyU5cJcNQ8rTjzsP-PUg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>> This use dup to create a new fd to be used by AVDTP session leaving the
>>> caller free to close the original fd. Note that even if the caller
>>> decides to keep the original fd it will still be notified when
>>> avdtp_shutdown is called since it uses shutdown.
>> 
>> I would be more curious on why this is needed.
> 
> It is basically to make the caller able to release any resources, such
> as GIOChannel managed by btio, without causing a disconnect.

you do not have to set close_on_unref with the GIOChannel. You can just unset that one. Then GIOChannel will not touch it and will not call close on it.

Regards

Marcel


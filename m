Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6E8A8CD1-5CB6-4D65-9BD7-DF4CF23F274C@holtmann.org>
References: <1387533387-6724-1-git-send-email-luiz.dentz@gmail.com>
	<6E8A8CD1-5CB6-4D65-9BD7-DF4CF23F274C@holtmann.org>
Date: Fri, 20 Dec 2013 15:44:17 +0200
Message-ID: <CABBYNZKcsaSSEXLV+gQuxXMzu8ePCyiyU5cJcNQ8rTjzsP-PUg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] android/AVDTP: Duplicate fd passed to avdtp_new
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 20, 2013 at 3:16 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> This use dup to create a new fd to be used by AVDTP session leaving the
>> caller free to close the original fd. Note that even if the caller
>> decides to keep the original fd it will still be notified when
>> avdtp_shutdown is called since it uses shutdown.
>
> I would be more curious on why this is needed.

It is basically to make the caller able to release any resources, such
as GIOChannel managed by btio, without causing a disconnect.


-- 
Luiz Augusto von Dentz

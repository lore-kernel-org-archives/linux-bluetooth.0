Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYONE6a2PWtOEY4Kgg9TQkX3pCwhW9UJLk5KGVtpL5eVaw@mail.gmail.com>
References: <CACUGKYONE6a2PWtOEY4Kgg9TQkX3pCwhW9UJLk5KGVtpL5eVaw@mail.gmail.com>
Date: Mon, 10 Sep 2012 14:39:11 -0700
Message-ID: <CACUGKYPHy2XyFK_LBHmMh4E1ZdN71SUbdJH9Ye8SJ-ijPmfxKQ@mail.gmail.com>
Subject: Re: Dropping connection (bit off-topic)
From: John Tobias <john.tobias.ph@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Addition to that, if iPhone to iPhone bluetooth le connection, it
won't drop the connectivity.

Regards,

John

On Mon, Sep 10, 2012 at 2:35 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hello Guys,
>
> I am using pandaboard with USB BLE dongle and an apps in iPhone that
> do the advertising. I was able to connect to the said device from my
> pandaboard using the following commands:
>
> gatttool -i hci1 -m 27 -I -b 74:xx:xx:xx:xx:xx
> connect
>
> But, I've noticed that after 30 secs, the iPhone dropped off the
> connection. I am just wondering if anyone here have tried playing with
> the iPhone using the ble connection?.
>
> Regards,
>
> John

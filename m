Return-Path: <cyrus@holtmann.org>
Message-id: <502C49F4.9060007@samsung.com>
Date: Thu, 16 Aug 2012 10:16:36 +0900
From: Chan-yeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez 4.101
References: <CACUGKYMjKcZZJsYi-SXCd1C=guWtKP3k=SBVPVe=+MR0R=pwHg@mail.gmail.com>
In-reply-to: <CACUGKYMjKcZZJsYi-SXCd1C=guWtKP3k=SBVPVe=+MR0R=pwHg@mail.gmail.com>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John

On 08/16/2012 09:26 AM, John Tobias wrote:
> Hi All,
>
> I downloaded the latest Bluez 4.101, compiled and installed on my
> machine. After executing the command (/usr/sbin/bluetoothd -n -d), it
> returned "bluetoothd[15067]: mgmt setup failed: Invalid argument."
> I am just wondering what are the missing key on my build?.
It looks like that your kernel doesn't support mgmt interface.
Which version of kernel do you use?

Regards
chanyeol

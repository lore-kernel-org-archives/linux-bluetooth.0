Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5B92EB78-6761-4617-9186-CC5040532A91@gmail.com>
References: <5B92EB78-6761-4617-9186-CC5040532A91@gmail.com>
Date: Sun, 17 Jan 2016 14:54:49 +0200
Message-ID: <CABBYNZJd+fdjLnUTfoeFK515shuG=ncPncRo9joYSoY910hktw@mail.gmail.com>
Subject: Re: Could example-gatt-server and example-advertisement be folded
 into one?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Travis Griggs <travisgriggs@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

On Sat, Jan 16, 2016 at 3:10 AM, Travis Griggs <travisgriggs@gmail.com> wrote:
> Subject mostly asks it all. I’m not asking whether the bluez distributed examples could be folded into one.
>
> I have been able able to build a working BLE interface to my Linux SBC using python to operate as a peripheral. I worked from these two files. Is there any reason I couldn’t weld the two files together into one? Or do they need to be run as two separate processes with two separate mainloops?
>
> I’m really hoping to get any answer, my last few questions went unanswered (which happens), but I’ve begun to wonder if my emails are getting through.

I guess they were done separately just exercise their interfaces, note
that you may not want to advertise in the beginning or actually stop
advertise if something else happen, e.g. sensor is no longer active,
that is why the interfaces are separated. Also note these are just
examples, we don't expect anyone using this code in production.

-- 
Luiz Augusto von Dentz

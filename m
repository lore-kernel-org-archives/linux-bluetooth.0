Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAG9fbzbpJZgUO7VkEu-AJj72p9o_JZtydQ08dhyyfosDDehr9Q@mail.gmail.com>
References: <CAG9fbzbpJZgUO7VkEu-AJj72p9o_JZtydQ08dhyyfosDDehr9Q@mail.gmail.com>
Date: Wed, 3 Aug 2011 12:39:28 +0300
Message-ID: <CABBYNZL0iqzady5v=EiNjTm-u95VnFywj_w+YY5qSFjUX=_GhA@mail.gmail.com>
Subject: Re: bluetooth and OPP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: ranjith kumar <ranjithproxy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 3, 2011 at 11:11 AM, ranjith kumar <ranjithproxy@gmail.com> wrote:
> Hi,
> I am new to bluetooth and bluez.
> I installed bluez on my linux PC.
> Please let me  know weather bluez contains OPP(Object Push Profile)
> implementation or not.
> Where can I find an application which calls bluez API for OPP profile?
> Also I am searching for OPP  full description. I could not found it.
> Please let me know if there are any links.


OPP, FTP and other OBEX related profiles are implemented in obexd:

http://git.kernel.org/?p=bluetooth/obexd.git;a=summary

-- 
Luiz Augusto von Dentz

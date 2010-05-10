Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE875C8.8050202@gmail.com>
Date: Mon, 10 May 2010 14:08:24 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: magicmouse: claimed by neither input, hiddev nor hidraw
References: <j2idd18b0c31005101341o43b652c1zf8729f5f9a60e0d3@mail.gmail.com>
In-Reply-To: <j2idd18b0c31005101341o43b652c1zf8729f5f9a60e0d3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/10/2010 01:41 PM, Justin Mattock wrote:
> is it me, or is there something wrong
> with the magicmouse connecting
> i.g. I've had my system setup to use the
> magicmouse with 2.6.33* with no issues
> now coming back after sometime
> seems everything is connecting,but then no movement:
> (and some thing in dmesg):
> [  116.267993] magicmouse 0005:05AC:030D.0007: claimed by neither
> input, hiddev nor hidraw
> [  116.268053] magicmouse 0005:05AC:030D.0007: magicmouse hw start failed
>
> using osx  magicmouse connects fine.
> Using standard mightymouse everything connects.
>   are there any reports of such things?
>
>

nevermind.. my bad, ended up not
having hiddraw enabled in the kernel.

everything looks good, suspend etc..

Justin P. Mattock

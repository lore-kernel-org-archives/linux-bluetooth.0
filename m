Return-Path: <tetsu@s-direct.com>
Message-Id: <4.3.2-J.20040714175104.05b9c430@emi.s-direct.com>
Date: Wed, 14 Jul 2004 18:12:55 +0900
To: Marcel Holtmann <marcel@holtmann.org>
From: Tetsuo Shiraishi <tetsu@s-direct.com>
Subject: Re: [Bluez-devel] rfcomm bind : Address already in use
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1089656770.4644.69.camel@pegasus>
References: <4.3.2-J.20040713015123.0463e378@emi.s-direct.com>
 <4.3.2-J.20040710152845.0669b538@emi.s-direct.com>
 <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
 <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
 <4.3.2-J.20040710152845.0669b538@emi.s-direct.com>
 <4.3.2-J.20040713015123.0463e378@emi.s-direct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

At 04/07/12 20:26 +0200, Marcel Holtmann wrote:
>
>sorry to say that, but that is not the solution. Implementing some kind
>of garbage collection is not ok. This is the Linux kernel, if you think
>that this is a bug, find it and fix it. And don't work around it.
>
>Btw you forgot the locking while iteration along the socket list.
>

Thank you much for reviewing my patch.

I will reconsider the solution of this problem.
And I need to study the Linux kernel and the BlueZ more...

Thanks,

Tetsuo

//
//   Tetsuo Shiraishi tetsu@s-direct.com
//                    tshiro@arion.ocn.ne.jp
//

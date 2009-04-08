Return-Path: <cyrus@holtmann.org>
From: Nicola Ranaldo <ranaldo@unina.it>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Status of serial proxy
Date: Wed, 8 Apr 2009 09:46:31 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <20090405130856.w9g2f6pa804kg84g@webmail.unina.it> <2d5a2c100904060738n1e1e450bnf63aab1b52960c15@mail.gmail.com>
In-Reply-To: <2d5a2c100904060738n1e1e450bnf63aab1b52960c15@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904080946.32235.ranaldo@unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 06 April 2009 16:38:41 Luiz Augusto von Dentz wrote:
> Hi Nicola,
>
> I've fixed the problem of channel 0 some time ago, so either wait for
> 4.35 release or use the current HEAD.

Hi Luiz,
using HEAD I was able to share the internal GPS of my openmoko freerunner to 
other devices, thanks!

As I suppose no applications are currently using Serial Proxies interfaces 
with bluez api 4.* (unless some older version of bluez did not had the channel 
0 issue), it may not impact doing other few modifications, some parameters 
used in dbus functions are string and stringlist while I guess they should be 
object and object arrays. And last, I'd like to see a signal on the 
SerialProxy interface or ProxyManager interface to trap when a serial proxy is 
Enabled, to have may GUI apps be notified when a proxy is enabled by other 
applications.

Regards

    Nicola


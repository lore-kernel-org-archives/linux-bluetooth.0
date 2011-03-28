Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Mar 2011 17:33:47 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/6] Move Attrib client (including: should we disconnect
 or not?)
Message-ID: <20110328203346.GA2664@piper>
References: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 21:01 Fri 25 Mar, Vinicius Costa Gomes wrote:
> Hi,
> 
> The move itself is pretty simple, but when implementing it, I took a decision
> and I would like to hear your opinion about it.

There were problems with some useless includes. I will send another version
soon. But the question below remains.

> 
> With this patch series, the behaviour is that we never disconnect from
> a LE device unless we are told so, i.e. org.bluez.Device.Disconnect(),
> is that what is expected from us?
> 
> 
> Cheers,
> --
> 
> Vinicius Costa Gomes (6):
>   Move Attrib client to the core
>   Register Attrib interface when loading device from storage
>   Register Attrib interface after Primary Service discovery
>   Remove _init and _exit methods from Attrib client
>   Add support for re-using the attrib channel
>   Fix disconnecting when primary service discovery is done
> 
>  Makefile.am      |    4 ++--
>  attrib/client.c  |   49 ++++++++++++++++++-------------------------------
>  attrib/client.h  |    6 +++---
>  attrib/manager.c |   47 -----------------------------------------------
>  src/adapter.c    |    5 +++++
>  src/device.c     |   20 +++++++++++++-------
>  6 files changed, 41 insertions(+), 90 deletions(-)
> 
> --
> 1.7.4.1
> 

Cheers,
-- 
Vinicius

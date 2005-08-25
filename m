Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Picky about coding style
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <430E2002.2060309@hasborg.com>
References: <ef9938ec0508251208621847fd@mail.gmail.com>
	 <1124997684.8019.76.camel@pegasus>  <430E2002.2060309@hasborg.com>
Content-Type: text/plain
Message-Id: <1124999599.8019.77.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 25 Aug 2005 21:53:19 +0200

Hi Josh,

> While reading up on the Linux kernel coding style to satisfy patch
> requirements, I came the kernel scripts/Lindent script:
> 
> mercury:/usr/src/linux/scripts $ cat Lindent
> #!/bin/sh
> indent -kr -i8 -ts8 -sob -l80 -ss -ncs "$@"
> mercury:/usr/src/linux/scripts $
> 
> Is it safe to use this script to satisfy formatting requirements for
> patch submissions for BlueZ?

if you do it once, then yes, but in general you should use the correct
coding style from the start. Check Greg's OLS talk for details.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

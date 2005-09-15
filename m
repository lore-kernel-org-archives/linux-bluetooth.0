Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] detection phones with bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050915113222.89004.qmail@web50613.mail.yahoo.com>
References: <20050915113222.89004.qmail@web50613.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1126784734.31715.4.camel@station6.example.com>
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
Date: Thu, 15 Sep 2005 13:45:34 +0200

Hi Christian,

>    My issue manifests when in the same room there are
> many bluetooth phones ( > 15 ). My application has a
> bluetooth detection engine using a bluetooth dongle
> device. I'm sending a OCF_INQUIRY command with
> hci_send_cmd, with inquiry_cp.length = 10 (~13 sec I
> guess) and when loop with poll function. My phone
> detection engine doesn't detect all the phone. In the
> first loop it detects some of them, then in the next
> loop other phones and so on. 
>    Is there a way to detect all the phone without
> increasing the interval for scanning ? What is the
> recommended interval for this? 

the easy answer is no. Increase the interval as needed.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

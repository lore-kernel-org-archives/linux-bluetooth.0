Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM TTY data loss
From: Marcel Holtmann <marcel@holtmann.org>
To: Aaron Klish <aklish1@urbana.css.mot.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: 
	<Pine.GSO.4.20.0310141004130.13019-100000@wombat.urbana.css.mot.com>
References: 
	<Pine.GSO.4.20.0310141004130.13019-100000@wombat.urbana.css.mot.com>
Content-Type: text/plain
Message-Id: <1066738150.1005.119.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 21 Oct 2003 14:09:05 +0200

Hi Aaron,

> There seems to be a problem between the Rfcomm tty driver code 
> and the generic n_tty line discipline where data can be lost.  

please tell us which kernel version you have tested. Have you used any
additional patches that we should know of? We included a TTY buffer
management patch from David Woodhouse some time ago.

Do you have a test program with that we can reproduce this behaviour?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

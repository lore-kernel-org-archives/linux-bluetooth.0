Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] textfile.c find_key
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <CBBBD909D2D6D211B4700090273F9E6E04C49B66@polaris.hhn.com>
References: <CBBBD909D2D6D211B4700090273F9E6E04C49B66@polaris.hhn.com>
Content-Type: text/plain
Message-Id: <1131488023.5544.9.camel@blade>
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
Date: Tue, 08 Nov 2005 23:13:43 +0100

Hi Robert,

> Normally I would agree with you but I tried it and there came a NULL
> -- to my great surprise.  I could have a bug in the kernel I'm using
> or something else.  If you aren't sure you can always try it out
> yourself and if I'm wrong there you go.  If you could let me know the
> results you get I would appreciate it.
> 
> I ran textfile_get on a file that is size 0.  This should replicate
> the bug for you.  I used test_textfile to test both the problem and
> the 'fix' -- sadly, being that the mmap documentation says that 0
> cannot be returned, I would say that the fix is a farce and mmap
> should be fixed instead.

I can't reproduce this problem. On a file with size 0 the textfile_get()
returns NULL as it should be. No segmentation fault or any other problem
so far. Maybe the kernel or your glibc is broken. What do you use?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

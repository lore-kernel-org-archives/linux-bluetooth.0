Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] automatic bnep0 configuration
Cc: "Christoph Torens" <c.torens@web.de>
References: <opseq1blhheocfdv@debian>
In-Reply-To: <opseq1blhheocfdv@debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200409230038.29082.pavouk@pavouk.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 23 Sep 2004 00:38:29 +0200

Hello,

> I tried to configure this with /etc/network/interfaces
> but that didn't help. I also tried to set 'auto bnep0'
> but this only works at boot time, when the device is
> not there yet.
> What's the trick?

This is done automatically by hotplug feature in kernel. I was problems, that
hotplug scripts was for kernel 2.4 and they doesn't correctly work with 2.6
kernel.

I have enabled "DEBUG=yes export DEBUG"
in /etc/hotplug.d/default/default.hotplug in Mandrake10.0 distribution.

Look at mailing list archive, because this was here discussed before
few months.

Best regards,

Pavel Ruzicka


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

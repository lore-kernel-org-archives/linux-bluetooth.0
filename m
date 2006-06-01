Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <447EA02C.3070703@palmsource.com>
References: <447C7ADD.1040503@palmsource.com>
	<447E951C.6040400@xmission.com>  <447EA02C.3070703@palmsource.com>
Date: Thu, 01 Jun 2006 10:27:30 +0200
Message-Id: <1149150450.28511.6.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] First try
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frederic,

> >could you resend as a 'diff -u' output?
> 
> this is the command line I use is that correct?
> 
> cvs diff -u pcm_a2dp.c > pcm_a2dp.c.diff-u

you should have a .cvsrc file in $HOME that looks like this:

cvs -z3
diff -u
update -dP
checkout -P

> Now the output has +- instead of ><

It is called unified diff and it is the preferred format around any open
source project. I don't know of anybody who ever has reviewed a context
diff.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

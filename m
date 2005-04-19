Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4264E2F8.8020307@kernelconcepts.de>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PC to PC file transfer
References: <20050419050546.7885.qmail@web52410.mail.yahoo.com> <1113907452.16233.169.camel@pegasus>
In-Reply-To: <1113907452.16233.169.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-15
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
Date: Tue, 19 Apr 2005 12:52:40 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
> Hi Jose,
Hi!

>>i have two PCs with linux, with bluetooth capability
>>on both(using BlueZ).
>>i want to transfer a file (any file)between them.
>>Could be command-line transfer or any other way.
> the easiest way is to create a PAN with pand between your two machines
> and then use tools like ftp or scp.

But in general I think it would be nice to have a some more ad-hoc file
transfer tool. Would maybe OBEX be suitable for that?

We have for example that situation quite often that you sit together
with some people and their notebooks or other prtable devices but you do
not have a common network or simply do not want that (imagine a business
meeting). But you want to share some docs, files, etc.. Mostly small
stuff, not whole movies ;)
Last time I was in a meeting guess what happened: They tucked out a
floppy disk!

For those purposes something like
	bt-receive-file (waiting)
	bt-send-file <BD-ADDR> <file>
would be nice.

> Regards
> Marcel
CU
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCZOL4JXeIURG1qHgRAiHeAKCXQSJKSmnPugMw++QaIx2VLBUGOwCg8Trq
hXuiZBBG4vtCvq4TavtBXWs=
=WMLZ
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

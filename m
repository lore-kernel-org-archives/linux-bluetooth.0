Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PC to PC file transfer
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4264E2F8.8020307@kernelconcepts.de>
References: <20050419050546.7885.qmail@web52410.mail.yahoo.com>
	 <1113907452.16233.169.camel@pegasus>  <4264E2F8.8020307@kernelconcepts.de>
Content-Type: text/plain
Message-Id: <1113915617.16233.182.camel@pegasus>
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
Date: Tue, 19 Apr 2005 15:00:17 +0200

Hi Nils,

> >>i have two PCs with linux, with bluetooth capability
> >>on both(using BlueZ).
> >>i want to transfer a file (any file)between them.
> >>Could be command-line transfer or any other way.
> > the easiest way is to create a PAN with pand between your two machines
> > and then use tools like ftp or scp.
> 
> But in general I think it would be nice to have a some more ad-hoc file
> transfer tool. Would maybe OBEX be suitable for that?
> 
> We have for example that situation quite often that you sit together
> with some people and their notebooks or other prtable devices but you do
> not have a common network or simply do not want that (imagine a business
> meeting). But you want to share some docs, files, etc.. Mostly small
> stuff, not whole movies ;)
> Last time I was in a meeting guess what happened: They tucked out a
> floppy disk!
> 
> For those purposes something like
> 	bt-receive-file (waiting)
> 	bt-send-file <BD-ADDR> <file>
> would be nice.

there are some programs for that job, but actually I like an obextool
merged into bluez-utils that is capable of doing things like this, but I
never finally finished it. Feel free to send me patches to add such a
tool.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

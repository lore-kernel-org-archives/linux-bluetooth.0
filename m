Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <447B6A07.2070301@porthome.nl>
References: <447B4F98.8020501@free.fr>
	<1148934839.31689.116.camel@localhost> <447B6A07.2070301@porthome.nl>
Date: Tue, 30 May 2006 00:21:35 +0200
Message-Id: <1148941295.31689.127.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] SCO flow control
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

Hi Pieter,

> > And for the core part, please be brief with any additional comments. My
> > rule for comments is to put them where the code is not clear by itself.
> > What you have done is actually over-commenting and that makes the code
> > harder to read and understand.
> >   
> I've read the code and for me the comments are very welcome. As well as 
> your enthousiasm & code, Fabian.

the right amount of comments and the coding style has always been
something people disagree on. However the kernel follows the policy to
have clean and easy code. You should understand the code and there
should be no need for comments. The comments are used to explain parts
that are not easy to guess.

Example for these are the reasons why to put a memory barrier here or
why not using some kind of locking or the reason why this isn't a race
conditions even if it looks like one etc.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

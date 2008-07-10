Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <bd5b16740807092236k22c63049vad40852d61147c3f@mail.gmail.com>
References: <00695C9C8F8B4448856F48142B4AA2012032A21E@dnce02.ent.ti.com>
	<1215662827.24462.2.camel@californication>
	<bd5b16740807092236k22c63049vad40852d61147c3f@mail.gmail.com>
Date: Thu, 10 Jul 2008 14:33:23 +0200
Message-Id: <1215693203.9744.0.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Add support for Texas Instruments' chips
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Ohad,

> > please put all the TI code into hciattach_ti.c and then I gonna apply
> > this patch.
> 
> I'm gonna have to put some common definitions in hciattach.h then
> (mainly struct uart_t).
> 
> Is that ok ?

no. Do the same as I did for hciattach_st.c

Regards

Marcel



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

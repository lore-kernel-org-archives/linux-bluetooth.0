Return-Path: <sitelist-bounces@lists.sourceforge.net>
Subject: Bluez-devel post from bunk@stusta.de requires approval
From: bluez-devel-owner@lists.sourceforge.net
To: bluez-devel-owner@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1605953541=="
Message-ID: <mailman.387610.1168321864.8777.bluez-devel@lists.sourceforge.net>
Date: Mon, 08 Jan 2007 21:51:04 -0800
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
Sender: sitelist-bounces@lists.sourceforge.net
Errors-To: sitelist-bounces@lists.sourceforge.net

--===============1605953541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

As list administrator, your authorization is requested for the
following mailing list posting:

    List:    Bluez-devel@lists.sourceforge.net
    From:    bunk@stusta.de
    Subject: 2.6.20-rc4: known regressions with patches (v2)
    Reason:  Too many recipients to the message

At your convenience, visit:

    https://lists.sourceforge.net/lists/admindb/bluez-devel
        
to approve or deny the request.

--===============1605953541==
Content-Type: message/rfc822
MIME-Version: 1.0

Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list2-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H49t0-0008BO-SR
	for bluez-devel@lists.sourceforge.net; Mon, 08 Jan 2007 21:51:03 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H49t0-0006yt-Vq
	for bluez-devel@lists.sourceforge.net; Mon, 08 Jan 2007 21:51:04 -0800
Received: (qmail 7256 invoked from network); 9 Jan 2007 05:50:56 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
	by mailout.stusta.mhn.de with SMTP; 9 Jan 2007 05:50:56 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id E113411426C; Tue,  9 Jan 2007 06:51:01 +0100 (CET)
Date: Tue, 9 Jan 2007 06:51:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sami Farin <7atbggg02@sneakemail.com>, David Chinner <dgc@sgi.com>,
	xfs-masters@oss.sgi.com, Pavel Machek <pavel@ucw.cz>,
	Marcel Holtmann <marcel@holtmann.org>, bluez-devel@lists.sf.net,
	netdev@vger.kernel.org, Komuro <komurojun-mbn@nifty.com>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	Craig Schlenter <craig@codefountain.com>,
	Peter Osterlund <petero2@telia.com>, Patrick McHardy <kaber@trash.net>,
	netfilter-devel@lists.netfilter.org, Michael Reske <micha@gmx.com>,
	Ayaz Abdulla <aabdulla@nvidia.com>, jgarzik@pobox.com,
	Brice Goglin <brice@myri.com>, Robert Hancock <hancockr@shaw.ca>,
	gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: 2.6.20-rc4: known regressions with patches (v2)
Message-ID: <20070109055101.GH25007@stusta.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001

This email lists some known regressions in 2.6.20-rc4 compared to 2.6.19
with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
References : http://lkml.org/lkml/2007/1/5/308
Submitter  : Sami Farin <7atbggg02@sneakemail.com>
Handled-By : David Chinner <dgc@sgi.com>
Patch      : http://lkml.org/lkml/2007/1/7/201
Status     : patch available


Subject    : bluetooth oopses because of multiple kobject_add()
References : http://lkml.org/lkml/2007/1/2/101
Submitter  : Pavel Machek <pavel@ucw.cz>
Handled-By : Marcel Holtmann <marcel@holtmann.org>
Patch      : http://lkml.org/lkml/2007/1/2/147
Status     : patch available


Subject    : ftp: get or put stops during file-transfer
References : http://lkml.org/lkml/2006/12/16/174
Submitter  : Komuro <komurojun-mbn@nifty.com>
Caused-By  : YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
             commit cfb6eeb4c860592edd123fdea908d23c6ad1c7dc
Handled-By : Craig Schlenter <craig@codefountain.com>
             YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Patch      : http://lkml.org/lkml/2007/1/9/5
Status     : patch available


Subject    : nf_conntrack_netbios_ns.c causes Oops
References : http://lkml.org/lkml/2007/1/7/188
Submitter  : Peter Osterlund <petero2@telia.com>
Caused-By  : Patrick McHardy <kaber@trash.net>
             commit 92703eee4ccde3c55ee067a89c373e8a51a8adf9
Handled-By : Patrick McHardy <kaber@trash.net>
Patch      : http://lkml.org/lkml/2007/1/8/290
Status     : patch available


Subject    : forcedeth.c 0.59: problem with sideband managment
References : http://bugzilla.kernel.org/show_bug.cgi?id=7684
Submitter  : Michael Reske <micha@gmx.com>
Handled-By : Ayaz Abdulla <aabdulla@nvidia.com>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7684
Status     : patch available


Subject    : nVidia CK804 chipset: not detecting HT MSI capabilities
References : http://lkml.org/lkml/2007/1/5/215
Submitter  : Brice Goglin <brice@myri.com>
             Robert Hancock <hancockr@shaw.ca>
Handled-By : Brice Goglin <brice@myri.com>
Patch      : http://lkml.org/lkml/2007/1/5/215
Status     : patch available


--===============1605953541==
Content-Type: message/rfc822
MIME-Version: 1.0

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: confirm 1d53e204d52cbb1248538a216b317600b6a51638
Sender: bluez-devel-request@lists.sourceforge.net
From: bluez-devel-request@lists.sourceforge.net

If you reply to this message, keeping the Subject: header intact,
Mailman will discard the held message.  Do this if the message is
spam.  If you reply to this message and include an Approved: header
with the list password in it, the message will be approved for posting
to the list.  The Approved: header can also appear in the first line
of the body of the reply.
--===============1605953541==--

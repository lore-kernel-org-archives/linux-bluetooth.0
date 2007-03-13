Return-Path: <sitelist-bounces@lists.sourceforge.net>
Subject: Bluez-devel post from cornelia.huck@de.ibm.com requires approval
From: bluez-devel-owner@lists.sourceforge.net
To: bluez-devel-owner@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1997588271=="
Message-ID: <mailman.197717.1173792569.20110.bluez-devel@lists.sourceforge.net>
Date: Tue, 13 Mar 2007 06:29:29 -0700
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
Sender: sitelist-bounces@lists.sourceforge.net
Errors-To: sitelist-bounces@lists.sourceforge.net

--===============1997588271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

As list administrator, your authorization is requested for the
following mailing list posting:

    List:    Bluez-devel@lists.sourceforge.net
    From:    cornelia.huck@de.ibm.com
    Subject: Re: [2/6] 2.6.21-rc3: known regressions
    Reason:  Too many recipients to the message

At your convenience, visit:

    https://lists.sourceforge.net/lists/admindb/bluez-devel
        
to approve or deny the request.

--===============1997588271==
Content-Type: message/rfc822
MIME-Version: 1.0

Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list2-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HR73r-0005rU-BZ
	for bluez-devel@lists.sourceforge.net; Tue, 13 Mar 2007 06:29:07 -0700
Received: from mtagate4.de.ibm.com ([195.212.29.153])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HR73r-0005jd-W5
	for bluez-devel@lists.sourceforge.net; Tue, 13 Mar 2007 06:29:09 -0700
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l2DDSwAM102906
	for <bluez-devel@lists.sf.net>; Tue, 13 Mar 2007 13:28:58 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l2DDSv7a1999064
	for <bluez-devel@lists.sf.net>; Tue, 13 Mar 2007 14:28:57 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l2DDSv7u018592
	for <bluez-devel@lists.sf.net>; Tue, 13 Mar 2007 14:28:57 +0100
Received: from gondolin.boeblingen.de.ibm.com (gondolin.boeblingen.de.ibm.com
	[9.152.198.14])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id l2DDSuRV018581; Tue, 13 Mar 2007 14:28:56 +0100
Date: Tue, 13 Mar 2007 14:30:34 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
	<akpm@linux-foundation.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Marcel
	Holtmann <marcel@holtmann.org>,
	maxk@qualcomm.com, bluez-devel@lists.sf.net, Mark Lord <lkml@rtr.ca>
Subject: Re: [2/6] 2.6.21-rc3: known regressions
Message-ID: <20070313143034.77425af4@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20070313125003.GS18731@stusta.de>
References: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
	<20070313125003.GS18731@stusta.de>
Organization: IBM Deutschland Entwicklung GmbH
X-Mailer: Claws Mail 2.8.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Legal: IBM Deutschland Entwicklung GmbH Vorsitzender des Aufsichtsrats:
	Johann Weihen =?ISO-8859-15?Q?Gesch=E4ftsf=FChrung:?= Herbert Kircher
	Sitz der Gesellschaft: =?ISO-8859-15?Q?B=F6blingen?= Registergericht:
	Amtsgericht Stuttgart, HRB 243294
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001

On Tue, 13 Mar 2007 13:50:03 +0100,
Adrian Bunk <bunk@stusta.de> wrote:

> Subject    : ThinkPad X60: bluetooth hardlocks
> References : http://lkml.org/lkml/2007/3/2/85
> Submitter  : Pavel Machek <pavel@ucw.cz>
> Handled-By : Marcel Holtmann <marcel@holtmann.org>
> Status     : unknown

Does this still happen with -rc3? I'd have thought Mark's patch in
0de1517e23c2e28d58a6344b97a120596ea200bb fixed that...


--===============1997588271==
Content-Type: message/rfc822
MIME-Version: 1.0

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: confirm 2792222b2b3c780ee69b050e2765181946e85f69
Sender: bluez-devel-request@lists.sourceforge.net
From: bluez-devel-request@lists.sourceforge.net

If you reply to this message, keeping the Subject: header intact,
Mailman will discard the held message.  Do this if the message is
spam.  If you reply to this message and include an Approved: header
with the list password in it, the message will be approved for posting
to the list.  The Approved: header can also appear in the first line
of the body of the reply.
--===============1997588271==--

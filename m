Return-Path: <sitelist-bounces@lists.sourceforge.net>
Subject: Bluez-devel post from bunk@stusta.de requires approval
From: bluez-devel-owner@lists.sourceforge.net
To: bluez-devel-owner@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0191728629=="
Message-ID: <mailman.197539.1173790214.20110.bluez-devel@lists.sourceforge.net>
Date: Tue, 13 Mar 2007 05:50:14 -0700
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
Sender: sitelist-bounces@lists.sourceforge.net
Errors-To: sitelist-bounces@lists.sourceforge.net

--===============0191728629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

As list administrator, your authorization is requested for the
following mailing list posting:

    List:    Bluez-devel@lists.sourceforge.net
    From:    bunk@stusta.de
    Subject: [2/6] 2.6.21-rc3: known regressions
    Reason:  Too many recipients to the message

At your convenience, visit:

    https://lists.sourceforge.net/lists/admindb/bluez-devel
        
to approve or deny the request.

--===============0191728629==
Content-Type: message/rfc822
MIME-Version: 1.0

Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list2-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HR6S8-0001ga-14
	for bluez-devel@lists.sourceforge.net; Tue, 13 Mar 2007 05:50:08 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailhub.stusta.mhn.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HR6S9-0007cd-QU
	for bluez-devel@lists.sourceforge.net; Tue, 13 Mar 2007 05:50:10 -0700
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de
	[10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 7E08F181C0E;
	Tue, 13 Mar 2007 13:53:33 +0100 (CET)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 3700D1148D1; Tue, 13 Mar 2007 13:50:03 +0100 (CET)
Date: Tue, 13 Mar 2007 13:50:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, davem@davemloft.net,
	kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, jmorris@namei.org,
	yoshfuji@linux-ipv6.org, kaber@coreworks.de, netdev@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
	maxk@qualcomm.com, bluez-devel@lists.sf.net,
	Albert Hopkins <kernel@marduk.letterboxes.org>,
	Ayaz Abdulla <aabdulla@nvidia.com>, jgarzik@pobox.com
Subject: [2/6] 2.6.21-rc3: known regressions
Message-ID: <20070313125003.GS18731@stusta.de>
References: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001

This email lists some known regressions in Linus' tree compared to 2.6.20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : ipv6 crash
References : http://lkml.org/lkml/2007/3/10/2
Submitter  : Len Brown <lenb@kernel.org>
Status     : unknown


Subject    : ThinkPad X60: bluetooth hardlocks
References : http://lkml.org/lkml/2007/3/2/85
Submitter  : Pavel Machek <pavel@ucw.cz>
Handled-By : Marcel Holtmann <marcel@holtmann.org>
Status     : unknown


Subject    : forcedeth: skb_over_panic
References : http://bugzilla.kernel.org/show_bug.cgi?id=8058
Submitter  : Albert Hopkins <kernel@marduk.letterboxes.org>
Handled-By : Ayaz Abdulla <aabdulla@nvidia.com>
Status     : problem is being debugged




--===============0191728629==
Content-Type: message/rfc822
MIME-Version: 1.0

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: confirm 8304fa7a3a71c5e87ad5b5253f1388fa2673619f
Sender: bluez-devel-request@lists.sourceforge.net
From: bluez-devel-request@lists.sourceforge.net

If you reply to this message, keeping the Subject: header intact,
Mailman will discard the held message.  Do this if the message is
spam.  If you reply to this message and include an Approved: header
with the list password in it, the message will be approved for posting
to the list.  The Approved: header can also appear in the first line
of the body of the reply.
--===============0191728629==--

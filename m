Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030513165931.0d377d88@unixmail.qualcomm.com>
Date: Tue, 13 May 2003 17:05:42 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: Daryl Van Vorst <daryl@wideray.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052867997.4608.23.camel@pegasus.local>
References: <5.1.0.14.2.20030513153902.0d3016d8@unixmail.qualcomm.com>
	<5.1.0.14.2.20030513095851.0d257510@unixmail.qualcomm.com>
	<000201c31771$70577930$6400a8c0@baked>
	<5.1.0.14.2.20030513095851.0d257510@unixmail.qualcomm.com>
	<5.1.0.14.2.20030513153902.0d3016d8@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 04:19 PM 5/13/2003, Marcel Holtmann wrote:
>so if we detect a failure in an ACL packet, we notify all L2CAP
>connections on the ACL link that have this option set. This sounds a
>little bit better to me. I understand you wrong at the first time and
>now I think we should have such extra stuff.
>
>But I don't like the name and your meaning of this options. It sounds
>like something that it is not and will never be. For the description of
>this option I think it should be something like
>
>        "Notify me when you detect an error in the ACL payload"
ACL is a lower lever. If baseband detects error in ACL payload it retransmits 
a packet :).

>And the option name can be L2CAP_CHECKACL. This is not very good, I
>know, so any other proposals?
L2CAP_LM_RELIABLE

Implementation is very very very simple and code for 2.4 is already in BK :).
http://linux-bt.bkbits.net:8080/bt-2.4/patch@1.1163?nav=index.html|ChangeSet@-1h|cset@1.1163

We didn't even need a new socket option. Just another LM (link mode) flag. And common case 
is not affected at all.
Now we just need to add support for it in l2test.

Max

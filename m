Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <459D3B83.5050701@xmission.com>
Date: Thu, 04 Jan 2007 10:38:11 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <459D10F6.8090509@uni-ulm.de> <459D26CF.5030709@palmsource.com>
	<459D3730.6080504@gmx.de>
In-Reply-To: <459D3730.6080504@gmx.de>
Subject: Re: [Bluez-devel] SBC codec, joint stereo mode
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

Siegbert

> Yep, now it makes sense.
> BTW, is this the right list to ask SBC-specific questions? I have some 
> more general questions, e.g. I don't quite understand the rationale 
> behind the codec definition: If you choose joint mode for encoding, it 
> happens that the encoder does not use joint mode for all subbands. But 
> why? Saving bits? If anybody has a pointer to some documentation for 
> SBC, which explains the design decisions I would be really happy.

yes this is the right place.

I haven't worked on it in a while so your question doesn't ring a
bell... I do need to get back into it to re-roll the encoder and
eliminate the inner loop memory move.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

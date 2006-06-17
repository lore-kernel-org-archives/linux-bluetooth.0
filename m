Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <435B3A56-B448-4E26-8BEB-E0879356ACBB@wideray.com>
References: <435B3A56-B448-4E26-8BEB-E0879356ACBB@wideray.com>
Date: Sat, 17 Jun 2006 12:07:56 +0200
Message-Id: <1150538876.17539.0.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bug: infinite loop in extract_seq()
	when	sdp_extract_seqtype() fails
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

Hi Jason,

> I'm new to this list.  Please let me know if there is a more  
> appropriate place to report this.

this mailing list is the correct place to report such problems.

> It appears that extract_seq() in sdp.c (bluez-libs) can enter an  
> infinite loop if sdp_extract_seqtype() fails when extract_seq() has  
> called itself recursively.  Here's how:

Do you have a patch for it or can you send a small reproducer program?

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

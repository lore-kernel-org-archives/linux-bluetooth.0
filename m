Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 14 May 2008 09:40:24 -0700
Message-ID: <F60A3CE9E807BE49B5F56BD80B894D20016883B2@sc-exch03.marvell.com>
References: <F60A3CE9E807BE49B5F56BD80B894D20016883A4@sc-exch03.marvell.com>
	<F60A3CE9E807BE49B5F56BD80B894D20016883A5@sc-exch03.marvell.com>
From: "Angus Ainslie" <aainslie@marvell.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] A2dpsink with bluez 3.31
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

It seems the a2dpsink for 3.31 has different audio format requirements.

Adding audioconvert to the pipeline fixed my problem.


> 
> Looking closer it's the filter child that transitions 
> properly. The fakesink and a2dpsink always stay READY.
> 
> Angus
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

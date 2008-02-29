Return-Path: <cyrus@holtmann.org>
Message-Id: <A7BA29A9-413A-4A4D-BEFB-E2DEE7A4988F@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47C7D90A.9020306@access-company.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 29 Feb 2008 19:27:05 +0100
References: <47C7D90A.9020306@access-company.com>
Subject: Re: [Bluez-devel] [patch] alignment trap in hcid
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

Hi Frederic,

> I recently met an alignment trap in hcid.
> Some device sent me an sdp request and the answer had to be  
> fragmented because the device reception buffer was very small.
> After that i saw alignment trap.
> The last trace I saw was : Continuation state size: 8
> The trace is located at sdpd/request.c : static sdp_cont_state_t  
> *sdp_cstate_get(uint8_t *buffer)
> This function returns an unaligned pointer.

this is so funny since I know it was there, but the new qualification  
tests don't find it anymore :)

Please fix the coding style. You are missing some spaces after the "if".

Johan, please have second look at the patch. It looks good to me.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

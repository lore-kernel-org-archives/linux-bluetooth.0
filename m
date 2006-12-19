Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4587C1EA.5000607@nokia.com>
Date: Tue, 19 Dec 2006 12:41:46 +0200
From: Luciano Coelho <luciano.coelho@nokia.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200612191103.20942.thsuut@utu.fi>	<1166521154.29972.4.camel@violet>
	<200612191147.39325.thsuut@utu.fi>
	<1166524299.29972.24.camel@violet>
In-Reply-To: <1166524299.29972.24.camel@violet>
Subject: Re: [Bluez-devel] rfcomm_sock_sendmsg with len==0 (in Linux 2.6.18)
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

ext Marcel Holtmann wrote:
> that is really strange. A recent compiler should detect that err can be
> used uninitialized.

Yes, it *should* ;-) But I have noticed at least one case in which GCC 
(version 3.4.4) doesn't recognize the use of uninitialized values... :-( 
It happened when compiling an ugly piece of code with gotos and stuff 
like that, but still...

Cheers,
Luca

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

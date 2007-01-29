Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45BDD594.9040000@st.com>
Date: Mon, 29 Jan 2007 16:38:04 +0530
From: Mayank BATRA <mayank.batra@st.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <D8CE9CFA707C894180BAC8CDD154F8460B033014@msiexch01.marvell.com>	<45B5AD79.8020104@st.com>
	<1169573111.5861.12.camel@violet>	<45BDCE90.5070906@st.com>
	<1170068129.15389.122.camel@violet>
In-Reply-To: <1170068129.15389.122.camel@violet>
Subject: Re: [Bluez-devel] hcidump EDR packet type
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

Hi Marcel,

> that must be a bug in their firmware. They should be the same with the
> only exception of DM1.
> 
> My assumption is that change connection packet type is treating this
> command as enable 3-DH5 only. However that is not what that command
> means. It means enable DM1 and all 2-* and 3-* packets except 3-DH5.

You are right. Its the job of the firmware and not the host to toggle
the EDR packet type bits (in contrast to what I said in a previous post).

Best Regards,

Mayank

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

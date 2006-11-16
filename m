Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002601c70966$bc1d4ee0$9d0cc70a@dlh.st.com>
References: <002601c70966$bc1d4ee0$9d0cc70a@dlh.st.com>
Date: Thu, 16 Nov 2006 11:23:30 +0100
Message-Id: <1163672610.5169.18.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Can I create an eSCO connection using BlueZ?
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

Hi Mayank,

> Is there any method with which I can create an eSCO connection using the BlueZ stack?
> I mean, if I create a socket in the following manner:
> int s;
> s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
> 
> then the command sent will be "Add Sco Connection".
> 
> But the problem is that my device (BT2.0)does not support this command as it has been deprecated since v1.2.
> My device supports only "Setup Synchronous Command".
> 
> (eSCO connections can be created using only Setup Synchronous Command.)
> 
> In other words, my question is does BlueZ Stack send Setup Synchronous Command to establish Synchronous connections?

no it doesn't support eSCO setups. The reason for that is that nobody
actually sent a kernel patch to add this support and I never needed it.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Thu, 16 Nov 2006 15:35:23 +0530
Message-ID: <002601c70966$bc1d4ee0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
Subject: [Bluez-devel] Can I create an eSCO connection using BlueZ?
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

Hi,

Is there any method with which I can create an eSCO connection using the BlueZ stack?
I mean, if I create a socket in the following manner:
int s;
s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);

then the command sent will be "Add Sco Connection".

But the problem is that my device (BT2.0)does not support this command as it has been deprecated since v1.2.
My device supports only "Setup Synchronous Command".

(eSCO connections can be created using only Setup Synchronous Command.)

In other words, my question is does BlueZ Stack send Setup Synchronous Command to establish Synchronous connections?

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

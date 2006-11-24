Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Fri, 24 Nov 2006 12:45:48 +0530
Message-ID: <018a01c70f98$5e21d670$8935c70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1164348861.28284.4.camel@localhost>
Subject: Re: [Bluez-users] L2CAP disconnect problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel

The patch worked. But after the L2CAP disconnection, the ACL channel doesn't disconnect. Is there some other patch also at HCI Level? Please send it also.

Regards,
Sumeet 


-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net [mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel Holtmann
Sent: Friday, November 24, 2006 11:44 AM
To: BlueZ users
Subject: Re: [Bluez-users] L2CAP disconnect problem

Hi Sumeet,

> I investigated the RFCOMM disconnect problem in more detail and found out
> that when the device is a listener, it expects the initiator of RFCOMM
> connection to disconnect dlci 0. But all devices don't send RFCOMM DISC for
> dlci 0. For ex PTS doesn't disconnect dlci 0 in case of HS profile testing 
> Test Case: 
> -> IUT (BlueZ) is HS Gateway, PTS is HS
> -> PTS initiates connection and then disconnect
> -> RFCOMM data channel is disconnected by BlueZ but it waits for PTS to
> disconnect RFCOMM control channel which doesn't happen.
> -> As a result test case fails
> 
> The HS Spec says HS Gateway is responsible for disconnecting the connection.
> In that case I think there is a misbehaviour here.
> 
> If there is something I am missing in understanding the RFCOMM
> implementation and this problem, please correct me.
> Otherwise do you have a patch to solve this problem, wherein the listener
> disconnects dlci 0?

I told you that this was a known bug and we fixed it. You should have
tested a recent 2.6 kernel and this basically means 2.6.18 or even
later. Not an ancient RHEL4 kernel. Anyway, this is the patch that went
in upstream to fix this problem.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Fri, 24 Nov 2006 11:29:10 +0530
Message-ID: <017801c70f8d$a9d62ea0$8935c70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1164176602.23477.14.camel@localhost>
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

I investigated the RFCOMM disconnect problem in more detail and found out
that when the device is a listener, it expects the initiator of RFCOMM
connection to disconnect dlci 0. But all devices don't send RFCOMM DISC for
dlci 0. For ex PTS doesn't disconnect dlci 0 in case of HS profile testing 
Test Case: 
-> IUT (BlueZ) is HS Gateway, PTS is HS
-> PTS initiates connection and then disconnect
-> RFCOMM data channel is disconnected by BlueZ but it waits for PTS to
disconnect RFCOMM control channel which doesn't happen.
-> As a result test case fails

The HS Spec says HS Gateway is responsible for disconnecting the connection.
In that case I think there is a misbehaviour here.

If there is something I am missing in understanding the RFCOMM
implementation and this problem, please correct me.
Otherwise do you have a patch to solve this problem, wherein the listener
disconnects dlci 0?

Thanks and Regards,


Sumeet 


-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Wednesday, November 22, 2006 11:53 AM
To: BlueZ users
Subject: Re: [Bluez-users] L2CAP disconnect problem

Hi Sumeet,

> So you mean if I use 2.6 kernel this problem will not occur. I tried 
> 2.6.9-34.EL kernel but the same problem occurs. No RFCOMM disconnect 
> :(

I was talking about a recent 2.6 kernel. Not some ancient RHEL4 kernel.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT Join SourceForge.net's
Techsay panel and you'll get the chance to share your opinions on IT &
business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

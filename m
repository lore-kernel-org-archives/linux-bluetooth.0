Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <00b501c70c99$65404970$8935c70a@dlh.st.com>
References: <00b501c70c99$65404970$8935c70a@dlh.st.com>
Date: Mon, 20 Nov 2006 13:40:59 +0100
Message-Id: <1164026459.28397.33.camel@localhost>
Mime-Version: 1.0
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

Hi Summeet,

> I am testing a HS-Gateway application. I have a listening thread which waits for incoming HS connection. I am using 
> 
>         sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
> 		then bind and then waiting on accept()
> 
> Now connection is successful but when I disconnect I see the RFCOMM channel disconnecting but then L2CAP doesn't disconnect. After a UA is received there is no L2CAP disc which I am expecting. Anybody faced this problem before? 
> 
> Listening thread code is referenced from scotest.c but it doesn't work..:(

actually the RFCOMM control is not disconnected and unless this one
disconnects, the L2CAP will not close that PSM.

What kernel version do you use?

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

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0704020210y469544fbx640b0ee6c88c9b2e@mail.gmail.com>
References: <57c68ddc0704020210y469544fbx640b0ee6c88c9b2e@mail.gmail.com>
Date: Mon, 02 Apr 2007 12:35:39 +0200
Message-Id: <1175510139.5815.313.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] getting RFComm channel of the device.
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

Hi Siddhant,

>      I would like to know how can one know the rfcomm channel number
> of any particular device.
> 
> Right now method that i am following is first getting making and sdp
> querry and then traversing over the result to get the channel number. 
> 
> Can anyone tell me whether the method i have mentioned is the right
> way or there is another faster or more appropriate method as time
> required for making sdp querry is quite large.

the SDP query is the only way to get the RFCOMM channel number.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

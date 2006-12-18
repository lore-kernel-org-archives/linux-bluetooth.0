Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <mailman.247983.1166465173.8777.bluez-users@lists.sourceforge.net>
References: <mailman.247983.1166465173.8777.bluez-users@lists.sourceforge.net>
Message-Id: <08C55293-7564-45BD-B18C-571EBC240FEC@gothpunk.com>
From: "Steve \" 'dillo \" Okay (Roadknight Labs)" <armadilo@gothpunk.com>
Date: Mon, 18 Dec 2006 11:35:58 -0800
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] why does one need bluez-firmware ?
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


On Dec 18, 2006, at 10:06 , bluez-users-request@lists.sourceforge.net  
wrote:

> On Sun, Dec 17, 2006 at 01:15:30PM +0100, Marcel Holtmann wrote:
>> Hi,
>>
>>> I read on some web pages that one need bluez-firmware to be able to
>>> operate the BroadCom 203x series bluetooth dongle correctly on a 2.4
>>> kernel. So I am wondering what is the purpose of bluez-firmware? And
>>> how does it work?
>>
>> that is a misunderstanding. For the 2.6 kernel you use a kernel  
>> module
>> to load the firmware. For 2.4 an extra USB application was needed.  
>> Both
>> however need the firmware files.
>
> And what is the purpose of bluez-firmware? How does it work?

The USB dongles themselves are stupid and don't have operational  
firmware in them.

It's a cost-saving measure. By using uploadable firmware, the  
manufacturer (Dlink, Linksys, whoever)
doesn't have to make a Windows version and a Mac version and a Linux  
version.
They just make one type of device and then ship the appropriate  
firmware blob on the drivers CD.

So the real reason you need the BlueZ firmware is that the driver has  
to upload the right firmware(in this case, for Linux) into the
bluetooth module itself, otherwise it won't work.

HTH,
-----Steve

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 29 Nov 2006 20:45:16 +0800
From: amateur <ztl.post@gmail.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061129124516.GD3364@163.com>
References: <20061128171141.74443.qmail@web39810.mail.mud.yahoo.com>
MIME-Version: 1.0
In-Reply-To: <20061128171141.74443.qmail@web39810.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] Compile Problem
Reply-To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

On Tue, Nov 28, 2006 at 05:11:41PM +0000, Fabio PC wrote:
> Hi everybody! 
>    
>   I always compiled the avetana library without errors. Today I formated a machine and intall the OS (Debian) and bluez packages again. When I tried to compile the avetana, I get an error. I don't know if it is a change insome bluez library or something like that, but I don't know how to solve this problem. The error that I'm getting is: 
>   BlueZ.cpp:2492: error: invalid conversion from 'u_int8_t*' to 'char*'

Seems like there is a typo. u_int8_t could be uint8_t, just a guess.
You can try it though.

-- 
You will be singled out for promotion in your work.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

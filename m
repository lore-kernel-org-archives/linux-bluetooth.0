Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <462BE48E.8000000@gmail.com>
Date: Sun, 22 Apr 2007 19:41:18 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <12a679470704221147v13b00925vf41dead8dc98ed24@mail.gmail.com>	<c49421c50704221228x4fdd2ea1uda37debc07f6bc3e@mail.gmail.com>	<462BDFE9.7010001@gmail.com>
	<c49421c50704221536g1e696aeaj8d97c10a84e3f98a@mail.gmail.com>
In-Reply-To: <c49421c50704221536g1e696aeaj8d97c10a84e3f98a@mail.gmail.com>
Subject: Re: [Bluez-users] Max number of RFCOMM connections?
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

Yes you are right, the question is quite tricky.
Cheers
> I totally agree with you, but I thought the question was about the 
> maximum number of RFCOMM connections.
> When I said 30 I considered scenarios where there could be more than 
> one RFCOMM connection between the same two ACL-connected devices...
>
> Actually, I have never implemented such scenario. I agree I am wrong 
> if bluetooth doesn't allow to establish such a set of simultaneous 
> connections...
>
> Loreno
>
>     bluetooth dongle, according to the specs of the BT SIG. And RFCOMM is
>     implemented over ACL, so you have a maximum of 7 simultaneous rfcomm
>     connections.
>     > I believe the maximum number of allowed connections relates to the
>     > number of ports available to connect to using rfcomm.
>     > Thus, my guess is 30.
>     >
>     >
>     http://people.csail.mit.edu/albert/bluez-intro/x92.html#rfcomm-and-tcp
>     >
>     > Regards,
>     >
>     > Loreno
>     >
>     >
>     >     Hi all, can someone please enlight me on the following?
>     >
>     >     What is the maximum number of RFCOMM connections for each
>     >     bluetooth dongle with BlueZ?
>     >
>     >     Thanks in advance
>     >
>
>
>     -------------------------------------------------------------------------
>     This SF.net email is sponsored by DB2 Express
>     Download DB2 Express C - the FREE version of DB2 express and take
>     control of your XML. No limits. Just data. Click to get it now.
>     http://sourceforge.net/powerbar/db2/
>     <http://sourceforge.net/powerbar/db2/>
>     _______________________________________________
>     Bluez-users mailing list
>     Bluez-users@lists.sourceforge.net
>     <mailto:Bluez-users@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> I'm sorry, that's not right. There's a maximum of 7 ACL connections per
>
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

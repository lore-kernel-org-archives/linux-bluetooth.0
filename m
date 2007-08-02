Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46B22DB0.60906@gmail.com>
Date: Thu, 02 Aug 2007 16:17:04 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <d9a09df00708021125n3abd1281l51d7f313e913da27@mail.gmail.com>	<46B224A6.8040501@gmail.com>	<d9a09df00708021140k58b2fc16gd7f5a868899017d9@mail.gmail.com>	<46B228EF.80800@gmail.com>
	<d9a09df00708021200r1df93be6leab6acc3680cc0da@mail.gmail.com>
In-Reply-To: <d9a09df00708021200r1df93be6leab6acc3680cc0da@mail.gmail.com>
Subject: Re: [Bluez-devel] OBEX OPP/FTP implementation in Bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Udayan Singh escribi=F3:
> Hi Manuel,
>
>
>   =

>>> as well as roadmap:
>>> http://wiki.bluez.org/wiki/Roadmap
>>>
>>>       =

>> I don't know if I can update this one, maybe in the feature BlueZ team
>> want to add obex support directly in the stack.
>>     =

>
> So presently Bluez does not have obex support directly in the stack.
> If I want to work on the same, ne pointers to how can I go about doing
> the same ?
You can use openobex and obexftp (both are in the same place, openobex =

is a lib obexftp is an user app), it's the defacto obex implementation =

for linux and it works perfectly over bluetooth with bluez. It's just =

that you don't get this when you download blueZ.
What I'm not sure is that if the BlueZ guys are planning to reimplement =

Obex and add this to they're source base.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

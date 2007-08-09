Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46BB1D8E.6050506@gmail.com>
Date: Thu, 09 Aug 2007 10:58:38 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <EJENLMBEOLKAMCJFBFMDMEEECAAA.leiyu@kcoe.cn>
In-Reply-To: <EJENLMBEOLKAMCJFBFMDMEEECAAA.leiyu@kcoe.cn>
Subject: Re: [Bluez-users] How to become a bluetooth obex server
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1845100090=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1845100090==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

Leiyu,
The package obexftp has an app called obexftpd that's an obexftp server
daemon. You just do obexftpd -b and then you need to register OPUSH with
sdptool, first check that obexftpd has registered a new service with
sdptool records local, get the channel for FTP and then do sdptool add
OPUSH --channel=<NUMBER> usually obexftpd uses channel 10 unleash you
tell it to use another one
Cheers,
Manuel
> Dear All,
>
>
> I am doing a project , it is a bluetooth obex server and other bluetooth device can send file to it 
> I install openobex-1.3 . after below procedure , I can send file to SE  K900c  
>
> #obex_test -b 00:19:63:A7:59:3B 6
> Using Bluetooth RFCOMM transport
> OBEX Interactive test client/server.
>   
>> c
>>     
> .....
>   
> but  after below procedure ,SE K900c can not send file to me
> #obex_test -b 00:19:63:A7:59:3B 6
> Using Bluetooth RFCOMM transport
> OBEX Interactive test client/server.
>   
>> s
>>     
> ..... 
>
> Above failture is not important, as running obex_test command  need know the bluetooth address and RFCOMM channel of OPUSH, It is very not convenient. 
> I want to reach this target , I do not need to know other device's information  , RFCOMM channel  and so on.
> just like this , run a command "obex_server ", then other bluetooth device that has opp profile can send file to me  
> it is not need GUI too, because it run in embedded device finally.
> Could you help to suggest me that which package I need? 
> Thanks in advance!
>
> Best regards,
> Leiyu 
>
>   
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   



--===============1845100090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1845100090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1845100090==--

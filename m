Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46C05A50.10004@gmail.com>
Date: Mon, 13 Aug 2007 10:19:12 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <EJENLMBEOLKAMCJFBFMDAEEHCAAA.leiyu@kcoe.cn>
In-Reply-To: <EJENLMBEOLKAMCJFBFMDAEEHCAAA.leiyu@kcoe.cn>
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
Content-Type: multipart/mixed; boundary="===============1654714639=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1654714639==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

Exactly, it will handle any connection that wants to use Channel 10
> Dear  Manuel,
>
> Thank you very much ,I succeed with your help.
> I register the OPUSH service in RFCOMM channel 10 with the command "sdptool add --channel=10 OPUSH"
> obexftpd -b will listen all the services that have been registered in channel 10, not only FTP, but also OPUSH ,
> Am my opinion right?
>
> Best regards,
> Leiyu
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



--===============1654714639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1654714639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1654714639==--

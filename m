Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <db972f430709052323m7d7df2dfn78fd802aeb4b780d@mail.gmail.com>
Date: Thu, 6 Sep 2007 14:23:08 +0800
From: "Ricky Soh" <rickysoh@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] bccmd compilation fails (help needed)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0531025533=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0531025533==
Content-Type: multipart/alternative;
	boundary="----=_Part_58447_4072332.1189059788723"

------=_Part_58447_4072332.1189059788723
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I did ./configure, make and make install.

I scanned the Make execution, realise bccmd was not compiled.

Inside the tool folders, only has those executed during the Make command.
There is no executable bccmd.

Please help. Thanks alot.

>Hi,

>> during normal bluez-util-3.18 installation, bccmd in the "tools"
> >folder was not compiled.
>>
>> i tried the following compilation but have the following error.
>>
> >[root@localhost tools]# gcc -lusb -lbluetooth csr.c csr_3wire.c

>have the build system build it for you. That works fine.

>Regards

>Marcel

------=_Part_58447_4072332.1189059788723
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I did ./configure, make and make install.<br><br>I scanned the Make execution, realise bccmd was not compiled.<br><br>Inside the tool folders, only has those executed during the Make command. There is no executable bccmd.
<br><br>Please help. Thanks alot.<br><br>&gt;Hi,<br><br>&gt;&gt; during normal bluez-util-3.18 installation, bccmd in the &quot;tools&quot;<br>&gt; &gt;folder was not compiled.<br>&gt;&gt;<br>&gt;&gt; i tried the following compilation but have the following error.
<br>&gt;&gt;<br>&gt; &gt;[root@localhost tools]# gcc -lusb -lbluetooth csr.c csr_3wire.c<br><br>&gt;have the build system build it for you. That works fine.<br><br>&gt;Regards<br><br>&gt;Marcel

------=_Part_58447_4072332.1189059788723--


--===============0531025533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0531025533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0531025533==--

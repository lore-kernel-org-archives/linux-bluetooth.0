Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1025.200.207.51.132.1090605410.squirrel@webmail.ic.unicamp.br>
From: ra002890@ic.unicamp.br
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] RFCOMM error message
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 23 Jul 2004 14:56:50 -0300 (BRT)

Hello everybody;

 I'm back again...
 Now I'm trying to put bluez to work with my embedded linux aplication in
a ppc cpu. I have already recompiled it and tested it with l2ping and
l2test, but when I try to use rfcomm I receive this message:

/mnt/flash/validador/aplicativo # rfcomm connect rfcomm1 00:01:24:00:30:de
1 &
/mnt/flash/validador/aplicativo # bcsp_timed_event: Timeout,
retransmitting 1 pkts
Can't create RFCOMM TTY: Operation not supported

Does anybody knows why it sends me this error?
And why I'm receiving a bcsp_timed_event warning?
My bluez version are:
utils 2.4
libs  2.5

I tryed to xcompile the 2.8 version but I couldn't do it, it does not
work. I had problems in the compilation. Have anyone had this problem?
Could you help me?

                                Thanks in advance by Daniel Moraes from   
                                  Brasil.



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46A9A4F1.8090009@yandex.ru>
Date: Fri, 27 Jul 2007 11:55:29 +0400
From: Irakli Tsagareli <itsagareli@yandex.ru>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] simultaneous read/write on SCO channel
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0197369768=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0197369768==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi all,
<br>
<br>
I asked this question in bluez-users list, but did not get an answer.
may be bluez-devel is wrong place to ask such things, but I stuck on
problem that looks VERY simple, but I can't find a way to correct&nbsp; it.
it's terrible to know, that 99.99%-percent-done application does not
work because of only one send() function....<br>
<br>
I'm writing a small code to test HandsFree capabilities between my
phone and PC. everything works fine for audio playback (on the PC, I
can hear sound file played on the phone and in case of incoming call, I
can hear a voice of remote subscriber) but when I try at the same time
to send some audio data to the handset via same socket, send() function
returns "Invalid argument" error. I tried to create new socket for
writing (same way I created listening socket). creation succeeds, but
connect fails with "Device or resource busy". can anybody be so kind
and explain, how can I read and write data through SCO channel
simultaneously ?
<br>
<br>
thank you and best regards,
<br>
kern.<br>
<br>
P.S. here is code snippet, that do actual SCO link setup and data
transfer:<br>
<br>
&nbsp;&nbsp;&nbsp; int scosock, cli_scosock, snd_fd, nbytes;<br>
&nbsp;&nbsp;&nbsp; socklen_t addrlen;<br>
&nbsp;&nbsp;&nbsp; struct sockaddr_sco addr;<br>
<br>
&nbsp;&nbsp;&nbsp; unsigned char buffer[1024];<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; snd_fd = init_sound();<br>
&nbsp;&nbsp;&nbsp; while(1)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if((scosock = socket(PF_BLUETOOTH, SOCK_SEQPACKET,
BTPROTO_SCO)) &lt; 0)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; perror("could not create SCO channel socket");<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(struct sockaddr_sco));<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; addr.sco_family = AF_BLUETOOTH;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bacpy(&amp;addr.sco_bdaddr, BDADDR_ANY);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if(bind(scosock, (struct sockaddr *)&amp;addr, sizeof(struct
sockaddr)) &lt; 0)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; perror("could not bind SCO channel to local address");<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; close(scosock);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; listen(scosock, 20);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; memset(&amp;addr, 0, sizeof(struct sockaddr_sco));<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; addrlen = sizeof(struct sockaddr);<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("waiting for SCO connection\n");<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if(wait4data(scosock) &lt; 0 || (cli_scosock = accept(scosock,
(struct sockaddr *)&amp;addr, &amp;addrlen)) &lt; 0)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("could not accept SCO link, socket error,
reconnecting\n");<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(scosock);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("accepted voice channel from MT\n"); <br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while(1)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; memset(buffer, 0, 1024);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if(wait4data(cli_scosock) &lt; 0 || (nbytes =
read(cli_scosock, buffer, 1024)) &lt; 0) <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("could not read from SCO link, socket error,
reconnecting\n");<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(cli_scosock);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; close(scosock);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; write(snd_fd, buffer, nbytes);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; memset(buffer, 0, 1024);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; read(snd_fd, buffer, 48);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if(send(cli_scosock, buffer, 48, 0) &lt; 0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font
 color="#ff0000">&lt;&lt; --- send() fails here with "Invalid argument"</font><br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; perror("send failed");<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; } <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; }<br>
}<br>
<br>
</body>
</html>


--===============0197369768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0197369768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0197369768==--

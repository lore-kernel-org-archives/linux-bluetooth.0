Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46AD9C4A.6020003@yandex.ru>
Date: Mon, 30 Jul 2007 12:07:38 +0400
From: Irakli Tsagareli <itsagareli@yandex.ru>
MIME-Version: 1.0
To: Andreas Kemnade <andreas@kemnade.info>
References: <46A9A4F1.8090009@yandex.ru> <20070727191022.521811b7@localhost>
In-Reply-To: <20070727191022.521811b7@localhost>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] simultaneous read/write on SCO channel
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1638078954=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1638078954==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Andreas, <br>
<br>
thank you for answer. you are right about my mistake - getsockopt says
MTU is 16 bytes, so no "Invalid argument" any more. but I still have a
problem with transmission - send() sends only 437 MTU blocks and then
stops with "Resource temporarily unavailable". I tried to wait with
"select()" for proper time slot, but it never arrives after first 437
blocks. have no idea how to solve it... <br>
<br>
Best Regards,<br>
kern.<br>
<br>
<br>
Andreas Kemnade wrote:
<blockquote cite="mid:20070727191022.521811b7@localhost" type="cite">
  <pre wrap="">On Fri, 27 Jul 2007 11:55:29 +0400
Irakli Tsagareli <a class="moz-txt-link-rfc2396E" href="mailto:itsagareli@yandex.ru">&lt;itsagareli@yandex.ru&gt;</a> wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi all,
 
I'm writing a small code to test HandsFree capabilities between my phone and PC. everything works fine for audio playback (on the PC, I can hear sound file played on the phone and in case of incoming call, I can hear a voice of remote subscriber) but when I try at the same time to send some audio data to the handset via same socket, send() function returns "Invalid argument" error. I tried to create new socket for writing (same way I created listening socket). creation succeeds, but connect fails with "Device or resource busy". can anybody be so kind and explain, how can I read and write data through SCO channel simultaneously ?
    </pre>
  </blockquote>
  <pre wrap=""><!----> 
[...]
  </pre>
  <blockquote type="cite">
    <pre wrap="">            read(snd_fd, buffer, 48);
            if(send(cli_scosock, buffer, 48, 0) &lt; 0)             &lt;&lt; --- send() fails here with "Invalid argument"
            {
                perror("send failed");
            }
    </pre>
  </blockquote>
  <pre wrap=""><!---->I remember having trouble with sco and hardcoded packet sizes (try 64). sometimes it's 64
and sometimes 48 if I remember correctly.

yout should do 
  struct sco_options opts;
  int size=sizeof(opts);
  getsockopt(cli_scosock,SOL_SCO,SCO_OPTIONS,&amp;opts,&amp;size);
once somewhere and then use opts.mtu

Greetings
Andreas Kemnade

  </pre>
</blockquote>
<br>
</body>
</html>


--===============1638078954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1638078954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1638078954==--

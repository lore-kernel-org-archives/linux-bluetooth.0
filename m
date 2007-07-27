Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 27 Jul 2007 19:10:22 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070727191022.521811b7@localhost>
In-Reply-To: <46A9A4F1.8090009@yandex.ru>
References: <46A9A4F1.8090009@yandex.ru>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Fri, 27 Jul 2007 11:55:29 +0400
Irakli Tsagareli <itsagareli@yandex.ru> wrote:

> Hi all,
>  
> I'm writing a small code to test HandsFree capabilities between my phone and PC. everything works fine for audio playback (on the PC, I can hear sound file played on the phone and in case of incoming call, I can hear a voice of remote subscriber) but when I try at the same time to send some audio data to the handset via same socket, send() function returns "Invalid argument" error. I tried to create new socket for writing (same way I created listening socket). creation succeeds, but connect fails with "Device or resource busy". can anybody be so kind and explain, how can I read and write data through SCO channel simultaneously ?
 
[...]
>             read(snd_fd, buffer, 48);
>             if(send(cli_scosock, buffer, 48, 0) < 0)             << --- send() fails here with "Invalid argument"
>             {
>                 perror("send failed");
>             }
I remember having trouble with sco and hardcoded packet sizes (try 64). sometimes it's 64
and sometimes 48 if I remember correctly.

yout should do 
  struct sco_options opts;
  int size=sizeof(opts);
  getsockopt(cli_scosock,SOL_SCO,SCO_OPTIONS,&opts,&size);
once somewhere and then use opts.mtu

Greetings
Andreas Kemnade

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

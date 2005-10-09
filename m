Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] ttyS0 problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <001901c5ccef$f35b63b0$f7c4fea9@cmsrytxkk3p90i>
References: <001901c5ccef$f35b63b0$f7c4fea9@cmsrytxkk3p90i>
Content-Type: text/plain
Message-Id: <1128876303.5536.2.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 09 Oct 2005 18:45:03 +0200

Hi David,

> I want to write some commands to the uart(ttyS0), but it fails.
> The steps are as follows:
>  
> 1. hciattach ttyS0 texas
> 2. Open ttyS0 device again and get a fd, init ttyS0 with speed,
> flow_ctl and so on,then write a command(0x30) to the fd but return
> 0; That is nothing is written to ttyS0.
>  
> If I write the same command  in the  function texas(int fd, struct
> uart_t *u, struct termios *ti), it succeeds.
> From bluez-utiles I see the following code which maybe
> the reason why I can't write the command to ttyS0 after running
> hciattach ttyS0 texas.
>  
> /* Set TTY to N_HCI line discipline */
>  i = N_HCI;
>  if (ioctl(fd, TIOCSETD, &i) < 0) {
>   perror("Can't set line discipline");
>   return -1;
>  }
>  
> It seems the codes is very important ,because if I delete these
> codes, the following codes can't run any more.
>  
> Is there any method that I can write the command to the ttyS0
> successfully after step 1?

after step 1, you  must use the HCI raw socket to send commands. What
commands do you wanna send?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

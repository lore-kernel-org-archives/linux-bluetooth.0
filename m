Return-Path: <cyrus@holtmann.org>
Subject: Re: Setting TIOCM_CD and TIOCM_RI in rfcomm (i.e. acting like a
 DCE)
From: Marcel Holtmann <marcel@holtmann.org>
To: Adam Bliss <abliss@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <ee007d8e0901071335kc57db3dyd95f4277d345ba13@mail.gmail.com>
References: <ee007d8e0901071335kc57db3dyd95f4277d345ba13@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 16:33:08 +0100
Message-Id: <1232292788.5095.29.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

> I apologize if I am mailing the wrong list; I saw the address posted
> on bluez.org.
> 
> I would like to set the CD (Carrier Detect) and RI (Ring Indicator)
> signals on an rfcomm line.  I understand that these are typically DCE
> -> DTE signals, but in rfcomm there doesn't seem to be much meaning to
> this distinction.  My use case is a linux box with a bluetooth
> adapter, talking to a BGB203.
> 
> Now I see in the rfcomm driver that that tiocmset() should be able to
> handle these signals:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=net/bluetooth/rfcomm/tty.c;hb=09c7d8293a2d1317d16ef4ddb9f6dd2553d0694e
> 1019 static int rfcomm_tty_tiocmset(struct tty_struct *tty, struct
> file *filp, unsigned int set, unsigned int clear)
>    ...
> 1033         if (set & TIOCM_RI)
> 1034                 v24_sig |= RFCOMM_V24_IC;
> 1035         if (set & TIOCM_CD)
> 1036                 v24_sig |= RFCOMM_V24_DV;
>    ...
> 
> So I tried to write code like this:
> 
> fd = open("/dev/rfcomm1", O_RDWR | O_NDELAY);
> ri = TIOCM_RI;
> ioctl(fd, TIOCMSET, &ri);
> 
> But it doesn't work.  (I'm fully able to connect the rfcomm link and
> pass characters over it.  Moreover, I can control the DTR signal in
> this manner.  But not RI or CD.)
> 
> I recompiled the net/bluetooth/rfcomm.ko driver with BT_DBG turned on,
> tried setting ri to 0xffff, and saw this:
> 
> rfcomm_tty_tiocmset: tty d25bc800 dev c34369c0 set 0xe006 clear 0x00
> 
> This mask is conspicuously missing the RI and CD bits (0x40 and 0x80).
>  This behavior seems to come from the tty driver:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/char/tty_io.c;h=d33e5ab061779a67e63b305b30b29d01f6fe38ca;hb=HEAD
>    ...
> 2452 static int tty_tiocmset(struct tty_struct *tty, struct file
> *file, unsigned int cmd,
> 2453              unsigned __user *p)
>    ...
> 2477         set &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2|TIOCM_LOOP;
> 2478         clear &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2|TIOCM_LOOP;
> 2479         return tty->ops->tiocmset(tty, file, set, clear);
> 
> (The mask on line 2477 comes out to 0xe006.)
> 
> I don't know the purpose of these lines, but they seem to imply that
> it is impossible to set the RI and CD signals using tiocmset() an
> rfcomm device.  To test my theory, I tried out this patch against my
> 2.6.22 kernel:
> 
> --- net/bluetooth/rfcomm/tty.c  2009-01-07 10:06:50.000000000 +0000
> +++ net/bluetooth/rfcomm/tty.c~ 2009-01-07 10:05:40.000000000 +0000
> @@ -1030,18 +1006,18 @@
>                 v24_sig |= RFCOMM_V24_RTC;
>         if (set & TIOCM_RTS || set & TIOCM_CTS)
>                 v24_sig |= RFCOMM_V24_RTR;
> -       if (set & TIOCM_RI)
> +       if (set & TIOCM_OUT1)
>                 v24_sig |= RFCOMM_V24_IC;
> -       if (set & TIOCM_CD)
> +       if (set & TIOCM_OUT2)
>                 v24_sig |= RFCOMM_V24_DV;
> 
> 
> I then changed my code snippet to use TIOCM_OUT1 instead of TIOCM_RI.
> It worked perfectly, setting the Ring Indicator signal on the rfcomm
> link, which was reflected on my BGB203.
> 
> Is there any way to set RI and CD using the stock rfcomm driver?  If
> not, should something be changed either in net/bluetooth/rfcomm/tty.c
> or in drivers/char/tty_io.c ?  I don't know the purpose of TIOCM_OUT1
> / TIOCM_OUT2, but they do not seem to be used elsewhere in rfcomm, so
> perhaps this remapping won't hurt anything.  (If anyone has a
> suggestion for a simple fix, I would be happy to try to submit a
> patch, but it would be my first.)

I honestly don't know why TIOCM_OUT1 etc. are working and others are
not. Since this comes from the TTY subsystem, please mail LKML about it
and include Alan Cox. He should know.

Regards

Marcel



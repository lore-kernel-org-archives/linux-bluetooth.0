Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 7 May 2012 15:10:41 -0300
Message-ID: <CALF0-+U0YwO+1BtXC4rz0hGNR7AjEjwUnF+MAnAX+SiOTSujDQ@mail.gmail.com>
Subject: [Q] Crappy bluetooth usb adapter is timing out
From: Ezequiel Garcia <elezegarcia@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have some generic (chinese) bluetooth usb adapter
that I want to use on linux 2.6.23.17 box, I'm using
bluez 4.95 stack.

(I now the kernel is very old, but I just need some
generic clue ;)

When I run this code:

  for i in 1 2 3 4 5 6 7 8 9 10
  do
      hciconfig hci0 reset
  done

I get this message:
"Can't init device hci0: Connection timed out (110)"

I've tracked this down to hciconfig.c, when it calls
HCIDEVUP ioctl.

I just wanted to know if I'm doing anything wrong, and
if I can raise any timer value, so I don't get the timeout error.

I guess I just could retry the operation, but it's a nice oportunity
to dive into interesting code.

Thanks in advance,
Ezequiel.

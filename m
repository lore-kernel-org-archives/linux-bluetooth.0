Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 22 Sep 2011 13:00:51 +0530
Message-ID: <CAMxgYMM5LxoD=RC44ARObUh9jV=d9LXyd6Gegi0MS95v7bW7GA@mail.gmail.com>
Subject: Dynamicall control the maximum or default transmit power
From: Vaishali Dhakate <justdoit.wg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ed Tsang <netdesign_98@...>
Subject: Dynamicall control the maximum or default transmit power
Newsgroups: gmane.linux.bluez.kernel
Date: 2009-02-18 20:12:08 GMT (2 years, 30 weeks, 4 days, 23 hours and
16 minutes ago)

Hi, I am looking at possibility of dynamically control the maximum or
default transmit power.
   Basically I would like to change the transmit power level during
inquiry. So I could kind of dynamically
control the physical range of devices that I see. In CSR's Bluecore
chip, I think there are pskey that

stored the maximum and default transmit power. And there seem to be
bccmd psget 0x0017 to get the value.
  Now my problem is I am using a class 1 dongle using Broadcom
chipset. Is there a way to dynamically control the

default or maximum transmit power e.g.
   hcitool cmd 0x.. 0x.. ..... ?

   During the inquiry paging, does anyone know if they use default or
maximum transmit power?

Thanks,
Edwin



Regarding this.
I also have the same question I am trying to find answer to ? Want to
know if you found the answer. I see three ways of doing this.
1)In the bcm4329 code
2)using bccmd
3)using hcitool cmd 0x0 0x0..

Going through the code can be time consuming And I ll have to go to
the theory before I start, Already scimmed through it to see if there
is any power control or anything like utility for hw control in the
driver , in the drivers/net/wireless/bcm4329 ..

I compiled bccmd , But this doesnot support some chips like mine
bcm4329 , the bccmd is for CSR chips ,Plz correct me , Mine is not
working on the phone. Maybe I ll have to take a clue from the bccmd
tool to write my own or check in the code where these pskeys will be.
So far I can surmise they are soemwhere in the eeprom. Also this phy.c
has some reference to power tables. Need to look carefully.

Next hcitool is the option. hcitool I ll look into the ogf and ocf
commands in the LMP specifications that I can send, havent tried this.
Tell me how did you do it.

Just thought I ll send you a mail,if you could plz share your
experience regarding this.

Regards
Vaishali

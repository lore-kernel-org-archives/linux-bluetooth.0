Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Oct 2008 04:42:22 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: <linux-bluetooth@vger.kernel.org>
Message-ID: <648988494.849661224198742466.JavaMail.root@mbv7.indiatimes.com>
Subject: one More PAIRING Issue.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a ubuntu desktop having BlueZ 3.26, When I connect and want to pair with the Desktop from a Remote device [say a phone], the Desktop pops up a message telling me, that A device is trying to connect.

But when I try to do that same from another Linux machine, from the command line with no I/O support to enter in the passkey, then it doesn't pop up the message.


Link Mode on Ubuntu when trying from Phone is accept.

Link Mode on Ubuntu when trying from the other lInux machine with no UI, has to be MASTER, If I try to connect as hcitool cc --role=m <..BD_ADDR...>

If the LINK mode is either "none" or "accept", then the hcitool cc --role=s , should always be slave.

Can someone explain this ?


--
Hyundai to launch the i20 in India. Catch the exclusive preview on ZigWheels.com
http://www.zigwheels.com/b2cam/newsDetails.action?name=Emb11_20080731&path=/INDT/News/Emb11_20080731&page=1&pagecount=2&utm_source=indmail&utm_medium=footer&utm_content=tracking&utm_campaign=Nletter_07oct2008_ZW

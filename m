Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 22 Dec 2009 15:51:51 +0530
Message-ID: <f63322490912220221w2dbf7db0m1681d68c11aa19c6@mail.gmail.com>
Subject: HFP Implementation Issue
From: Bhaskar <abc.bhaskar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Team,

The goal is to implement Hands Free Profile in the Bluetooth stack
developed by the third party.

After studying the HFP spec, I started with sending phone book
retrieval AT commands to the mobile and able to retrieve the missed
call, dialed call entries.

Everything works as expected with mobiles like Nokia 3110 series.  But
when I test the same with Apple Iphone, it issues disconnection
request before going into the sleep mode.

Please kindly guide me in the correct direction.  What might be the
reason for disconnection request and wheather it should be handled at
stack level or profile level.

Regards.

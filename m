Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Reply-To: mvogt1@gmail.com
Date: Wed, 10 Sep 2014 10:57:33 +0200
Message-ID: <CAOE8yMDRkmpuHP8LHgoCoD0SXqyHT48cneQ7BTnxvcz3arqwKQ@mail.gmail.com>
Subject: BCM20702A0 troubles on linux
From: Martin Vogt <mvogt1@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have found out that the Asus BT-400 is not working
very well on linux.

http://marc.info/?l=linux-bluetooth&m=140732083213294&w=2

this was for the older bluetooth 2 protocol "rfcomm"
Then I used the BT-400 stick for tests with the sensortag:

http://mike.saunby.net/2013/04/raspberry-pi-and-ti-cc2541-sensortag.html

here it turned out that the stick does not work too.
(lescan aborts, always disconnects, cannot read sensor info)

Then I bough a belkin stick, which has the BCM20702A0 too.
Same result: unusable, like BT-400

So, I would say the BCM20702A0 is not very well supported on linux?
Anyone have success with this chip?

A Stick which seem to work:

I bought a sitecom stick, which announce itsself in dmesg as:
CSR8510 A10 this does work with the sensortag!

regards,

Martin

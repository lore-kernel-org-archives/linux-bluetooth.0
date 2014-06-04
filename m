Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 4 Jun 2014 16:36:12 +0530
Message-ID: <CAP3RZojvGqDT9Bj5ErXwNVmmT9qeLDzJbT8NiD=+AvieB9jLvQ@mail.gmail.com>
Subject: file transfer through bluetooth in linux
From: jags gediya <jags.gediya@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In my imx6 based board, i want to integrate bluetooth through TI
wl1273 module. but the problem is it's having only 16 MB memory. i am
able to scan and pair to the devices through command line. now i want
to transfer files between my board and mobiles through command line.
ii have searched through the net and found that i need to use obexd
with bt-obex. or i can use obexftp and obexpushd also. i dont know
which of the above is better. i need to use whichever will occupy the
less space in file-system. Is there any other method through which i
can transfer data from command line between my board and mobiles. How
data transfer happens between two linux systems?

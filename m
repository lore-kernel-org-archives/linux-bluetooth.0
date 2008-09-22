Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Sep 2008 17:28:55 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: linux-bluetooth@vger.kernel.org
Message-ID: <1799979551.320401222084735025.JavaMail.root@mbv7.indiatimes.com>
Subject: OpenOBEX ObexFTPd problem on BlueZ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,


I have the BlueZ utilities cross-compiled to a particular Arm- target, and cannot get the openobex working.

I start of the server, 
$ hcid -s 
$ hciattach -- with relevant parameters
$ hciconfig -a -- doesnt show any Service classes
$ obexftpd -c ./ -b -- throws up a msg waiting for connection
$ hciconfig -a -- now shows the Capturing, Object transfer as service classes


But If I start an windows application, to connect to this device, it shows services not found.

Any other hints as to properly starting off obexftpd and using obexftp client?


--
Will the all new Indica Vista zip ahead of the Suzuki Swift? Read the expert review on Zigwheels.com
http://zigwheels.com/b2cam/reviewsDetails.action?name=Ro11_20080829&path=/INDT/Reviews/Ro11_20080829&page=1&pagecount=9

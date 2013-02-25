Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: Bluez Mailing List <linux-bluetooth@vger.kernel.org>
Subject: fd argument in NewConnection() Method (profile-api.txt)
Date: Mon, 25 Feb 2013 00:13:17 -0500
Message-ID: <874nh1t1qq.fsf@randy.site>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

How can the bluez stack, which runs in its own process, generate a file
descriptor and hand that fd over to another process (the bluetooth
profile server process)? I was under the impression that fds can not be
passed across processes.

bluez 5.2
-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com

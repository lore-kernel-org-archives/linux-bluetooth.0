Return-Path: <cyrus@holtmann.org>
Message-ID: <1330692190.20578.15.camel@novo.hadess.net>
Subject: obexd 0.45 compilation problem
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 02 Mar 2012 12:43:10 +0000
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

Trying to compile obexd 0.45 with bluez-4.98, I get:
btio/btio.c: In function 'get_key_size':
btio/btio.c:522:14: error: 'struct bt_security' has no member named 'key_size'

Do you need to either up the bluez dependency, or is obexd lagging?

Install log:
http://koji.fedoraproject.org/koji/getfile?taskID=3846402&name=root.log
Compile log:
http://koji.fedoraproject.org/koji/getfile?taskID=3846402&name=build.log

Cheers


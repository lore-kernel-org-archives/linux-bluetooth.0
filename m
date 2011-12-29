Return-Path: <cyrus@holtmann.org>
From: mindentropy <mindentropy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Regarding bluez connection problems.
Date: Fri, 30 Dec 2011 03:05:04 +0530
Message-ID: <2225979.B3tFglpjRu@terranet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

  I have developed a very simple bluez server application. It works in kernel 
2.6.xx(ubuntu lucid) but when I run on kernel 3.0 I am not able to connect at 
all. Pairing is successful. The application listens on channel 1 but my client 
app on my mobile phone is not able to connect to it. Initially there was DUN 
on channel 1 which I removed using sdptool del <classid> but still did not 
make any difference. What am I doing wrong?

Thanks.

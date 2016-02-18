Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?Q?J=c3=bcrgen_Benjamin_Ronshausen?= <b.r@rie.eu>
Subject: =?UTF-8?Q?Documentation_f=c3=bcr_bluetooth_low_energy?=
Message-ID: <56C5938F.6070504@rie.eu>
Date: Thu, 18 Feb 2016 10:49:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

i am working with Bluez 4.96, kernel 3.2 on embedded ARM and i try to 
figure bluetooth low energy out.

I looked at the code behind hcitool lescan. I wonder is there a 
documentation for the low energy commands?

I want to know when beacons are around.

My understandig is open bluetooth socket, specify scan parameters, 
enable scan, set filter for socket and then poll the socket.

And if i want the signal quality i have to connect to the beacon first.

Can someone point me to the docs, so i can educate myself please.

Thanks

Regards

Benjamin

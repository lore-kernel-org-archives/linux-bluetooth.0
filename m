Return-Path: <cyrus@holtmann.org>
Message-ID: <4AB086D3.9070706@Atheros.com>
Date: Wed, 16 Sep 2009 12:03:55 +0530
From: Sasikiran Maddula <Madula.Sasikiran@Atheros.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Is there any limit on the bluetooth share folder in linux either
 in bluez stack or in obex ftp?
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I tried to send a file of more than 2 GB using bluetooth in linux. It 
says "Error while copying. There is not enough space on the destination. 
Try to remove files to make space". When I look for more details it says 
"There is 2.0GB available, but 2.8GB required", but the file size I am 
trying to send is 2.8 GB, also in the other end it has more space than 
the file size. I am trying to copy the file from laptop1 to laptop2 with 
a share folder as "x" in laptop2. I used several vendor dongles. All of 
them behave the same way. When I check for the properties of folder x in 
laptop1 it shows as 2.0 GB used and 2.0 GB free. But actually the share 
folder is not filled by 2.0GB, but it is more. I used linux 2.6.28 and 
2.6.31 kernel versions with bluez 4.32. I even verified with 2.6.31 with 
4.32 bluez and 2.6.28 with 4.53 bluez. All of them behave the same way. 
Could some body suggest me where is the issue and how to rectify the issue.

Thanks,
Sasikiran.

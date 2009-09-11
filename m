Return-Path: <cyrus@holtmann.org>
Message-ID: <4AAA55D0.1050505@Atheros.com>
Date: Fri, 11 Sep 2009 19:21:12 +0530
From: Sasikiran Maddula <Madula.Sasikiran@Atheros.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Bluez stack issue with sco after headset profile disconnect
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I verified with different dongles in linux. The behavior is same in all 
the cases. Firstly we will connect the headset using headset profile. We 
will start skype call / some other sco connection. We will disconnect 
the headset service from the headset profile. hcitool con says sco 
connection is still available after disconnection successful. So, some 
body suggest me how to stop the sco connection when we disconnect the 
service.

Thanks,
Sasikiran.

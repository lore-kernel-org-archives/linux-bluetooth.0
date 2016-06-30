Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: <linux-bluetooth@vger.kernel.org>
From: Tom Harada <tomharada@lnihealth.com>
Subject: Ignore connection parameter update?
Message-ID: <7ae38149-8bf9-d748-7311-daa703154593@lnihealth.com>
Date: Thu, 30 Jun 2016 12:12:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I have a BLE device that requests a connection parameter update after 
pairing. The requested parameters significantly slow down the transfer 
of data from the device, which is problematic because the device doesn't 
stay connected for very long. With the default parameters, I can 
sometimes perform service discovery and enable indications on the 
necessary characteristics before the device disconnects. With the 
updated parameters it's impossible.

I'd like to try working around this problem by preventing BlueZ from 
using the updated connection parameters. I can see that BlueZ saves them 
to use the next time it connects. Is there a way to suppress this 
behavior so BlueZ always connects with the default parameters? 
Alternatively, is it feasible to use the Load Connection Parameters 
management command to override the saved parameters? Is there a better 
solution that I'm missing?

Thanks in advance,
Tom

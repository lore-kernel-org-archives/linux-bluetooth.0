Return-Path: <cyrus@holtmann.org>
Subject: Re: Problem in Pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: Kartikey Parmar <kartikey2781@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6887eb5d0902092123p2aa3f31chbd00bfc713b313dc@mail.gmail.com>
References: <6887eb5d0902092123p2aa3f31chbd00bfc713b313dc@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 10 Feb 2009 16:39:50 +0100
Message-Id: <1234280390.12847.32.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kartikey,

> I m using Bluez-4.27 to implement my bluetooth module which will
> detect nearby bluetooth enabled device & connects with its Audio
> Gateway.
> 
> Now when I attempt to connect Audio Gateway channel through my test
> module it prompts me to Pair with "Bluez" on the remote device.
> 
> When I accept the same it prompts me to enter "Pass Code" to pair.
> 
> I did not ask for such passcodes in my test application...even in my
> mobile phone I have not such type of setup to request for passcode.
> 
> This problem arise when I attempt to connect on the rfcomm socket
> which is bind to local bluetooth adapter.
> 
> if somebody has also faced this type of problem, kindly reply me how
> to solve this issue.

send in output of "hcidump -X -V". Otherwise we can't tell what is going
on.

Regards

Marcel



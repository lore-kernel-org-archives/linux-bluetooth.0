Return-Path: <cyrus@holtmann.org>
Message-ID: <4CA0F1FE.8040006@sergej.pp.ru>
Date: Mon, 27 Sep 2010 23:35:26 +0400
From: Sergej Pupykin <ml@sergej.pp.ru>
MIME-Version: 1.0
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Another "hci0 command tx timeout"
References: <4CA0E800.4000000@sergej.pp.ru> <20100927192108.GA5489@vigoh>
In-Reply-To: <20100927192108.GA5489@vigoh>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  On 27.09.2010 23:21, Gustavo F. Padovan wrote:
>
> What do you mean by "works without userspace"
I try to do following:

1. ensure that userspace does not work (stop bluetoothd and comment udev 
bluetooth rule)
2. modprobe btusb
3. hciconfig hci0 up
4. hcitool inq

then remove btusb, uncomment udev rules, start bluetoothd and do 2-4 again.

With userspace I got

$ hcitool inq
Inquiring ...
Inquiry failed.: Connection timed out

and subj error in dmesg.

Also I see that hcidump with userspace does not catch inquiry command.

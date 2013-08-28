Return-Path: <cyrus@holtmann.org>
Message-ID: <521DCF49.5020807@richardneill.org>
Date: Wed, 28 Aug 2013 11:22:01 +0100
From: Richard Neill <rn214@richardneill.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: How to test/debug bluetooth advertising [with hciconfig]?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear All,

I'm trying to get "hello world" working from the shell between 2 
Bluetooth 4 dongles, in LE advertising mode. I wonder whether I could 
ask for some pointers?

As I understand it, Bluetooth low-energy supports up to 31 bytes of 
arbitrary text in the advertising packet. So it should be possible to 
set one dongle up in LE-advertising mode, and a second in LE-scan mode, 
and to transfer the "hello world" message from one to the other.

I'm rather stuck at the moment. I've discovered that there is an "LE Set 
Advertising Data" command, 0xcf (from "hciconfig hci0 commands_list"), 
and that "hcitool -i hci0 cmd 0xcf XXX YYY ZZZ" is how to send it. But I 
can't find any more documentation for the command set used by hcitool.

Can anyone help, with the commands I need, or by pointing me to the 
appropriate documentation/tutorial?

Thanks for your help,

Richard

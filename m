Return-Path: <cyrus@holtmann.org>
From: Gary Mort <gary@mort.net>
Subject: 3dsp sample app and Bluez v5
To: linux-bluetooth@vger.kernel.org
Message-ID: <556CC928.60503@mort.net>
Date: Mon, 1 Jun 2015 17:05:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to convert a pair of 3D bluetooth glasses into 'Joo Janta 
200 Super-Chromatic Peril Sensitive Sunglasses'  and so it seemed a 
small modification to 3dsp to play with different frequencies would fit 
the bill.

Following the command line help, I kept getting the message
  ' Failed to open HCI user channel' and since it was an extremely tiny 
c file, I tracked that down to a failure at line 642    hci_dev = 
bt_hci_new_user_channel(index);

I noticed that there was a different method of opening a socket right 
above it,    hci_dev = bt_hci_new_raw_device(index); and it was 
controlled via a command line arguement.

So adding -r to my command line, my server now seems to execute. 
However, when I try to run 3dsp in client mode from a second terminal 
window it does not connect[as well as my actual glasses not connecting]

I figured before spending too much time on this, I'd check to see if the 
code is supposed to work at this point - in which case it is my 
system..or if the bluez api has changed sufficiently that I need to 
modify the code to use some new api?
Konsole outFailed to open HCI user channel

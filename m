Return-Path: <cyrus@holtmann.org>
From: Mailing List SVR <lists@svrinformatica.it>
Reply-To: lists@svrinformatica.it
To: linux-bluetooth@vger.kernel.org
Subject: Re: pc as headset: some progress but still no audio
Date: Mon, 11 Jan 2010 10:51:27 +0100
References: <201001091142.00568.lists@svrinformatica.it>
In-Reply-To: <201001091142.00568.lists@svrinformatica.it>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201001111051.27627.lists@svrinformatica.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After further investigation I got this error:

bluetoothd[2094]: State changed /org/bluez/2094/hci0/dev_00_1C_D4_2A_4B_54: 
HEADSET_STATE_CONNECTING -> HEADSET_STATE_CONNECTED
bluetoothd[2094]: Refusing non-HFP SCO connect attempt from 00:1C:D4:2A:4B:54
bluetoothd[2094]: No matching connection found for handle 1

so seems that bluez doesn't support the use of pc as headset,

Nicola

In data sabato 9 gennaio 2010 11:42:00, Mailing List SVR ha scritto:
: > Hi,
> 
> I made some progress:
> 
> 1) my phone can now recognize my pc as an headset
> 2) I'm able to pair the two device
> 3) I advertise the hsp service with the attacched pybluez script
> 4) the phone can connect to the pc and the output of the script is:
> 
> Waiting for connection on RFCOMM 1
> Accepted connection  ('00:1E:96:00:07:D2', 1)
> received
> OK
> 
> so the connection is successfull and the phone answer ok to AT+CKPD
> 5) I run bluetoothd -n -d and I see some errors like this:
> 
> bluetoothd[5938]: No matching connection found for handle 1
> 
> 6) with hcidump I see sco data:
> > SCO data: handle 1 flags 0x00 dlen 48
> 
> and I think this sco data cause the error "No matching connection found for
> handle 1"
> 
> so I think there is something wrong in the sco link estabilishment, can you
> please give my some hints?
> 
> Is there a way to use a pc as an headset using bluez?
> 
> thanks
> Nicola
> 

Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: Bluetooth certification with bluez stack
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACUGKYNrsWu6k4q193FsLmCc-fMJ955j6TRdnx=LfqFqcQfrmg@mail.gmail.com>
Date: Mon, 8 Sep 2014 11:39:19 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <15262F73-F609-40F5-9294-9B35F5CB7C8C@holtmann.org>
References: <CACUGKYNrsWu6k4q193FsLmCc-fMJ955j6TRdnx=LfqFqcQfrmg@mail.gmail.com>
To: John Tobias <john.tobias.ph@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> We are planning to apply for bluetooth certification and we are using
> bluez stack. I am gathering more information regarding with the cost.
> 
> According to my contact, since we are using an opensource bluetooth
> stack, they need to test all the layers for:
> 
> 1. Classic BlueZ stack testing:
>    -> L2CAP, GAP, SDP, SPP, RFCOMM
>    -> AVCTP and AVDTP
> 
> 2. LE BlueZ stack:
>    -> ATT, GATT, SM
> 
> I would like to know if anyone have done the bluetooth certification
> using bluez stack and what did you do to lower the cost?.

many companies have qualified BlueZ in different form and shapes. You can find an incomplete list here:

http://www.bluez.org/qualification/

The list is incomplete, because there are many more BlueZ based products out there that we do not know enough details about to list them here.

When it comes to qualification, there is no simple answer, however it is safe to say that you need to qualify all used protocols and profiles one way or another. That means either you qualify them all by yourself or you can reference an existing qualification record. However most companies have opted for doing the whole qualification by themselves so they are in control of the qualification record.

My advise is that whatever you can test with PTS tool from the Bluetooth SIG, you test with it. That lowers your cost a lot since you do not need to go to a test house. If you use the self-listing process with the TPG, you can also avoid test house costs. Or you do it the other way around and just contract the whole thing out to a test house.

If you would be qualifying BlueZ for Android (a version of BlueZ running on Android devices), then we have full documentation for every single protocol and profile. Look at android/{pics,pixit,pts}-*.txt files in the source code. Most of these information will also apply to a generic BlueZ. However we have not had time to unify this kind of qualification documentation.

I bet these information will get you pretty far when it comes to qualification. They are pretty extensive.

Regards

Marcel


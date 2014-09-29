Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHF=Y4pkXTvcN6YQTH6DPboeav7BCa8T0HUSfOHfag+W9GJ8fQ@mail.gmail.com>
Date: Mon, 29 Sep 2014 16:54:01 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C99B4465-75E0-4170-B51D-94898D65010C@holtmann.org>
References: <1411746855-9936-1-git-send-email-fons@spotify.com> <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org> <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com> <BCEE5DFC-08DA-43A7-AED8-BEFD837B07ED@holtmann.org> <CAHF=Y4p-st7N4+kUezYWjy7L58zcH-1t0AO0ME6axZ76ZK+oKQ@mail.gmail.com> <1D7AEE8B-51DB-4A6D-8EBA-3EC81760224E@holtmann.org> <CAHF=Y4pkXTvcN6YQTH6DPboeav7BCa8T0HUSfOHfag+W9GJ8fQ@mail.gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

>> if it can not store its LTK, then why doesn't it use a key hierarchy (as defined in the Bluetooth specification) so that it can restore its keys after reboot. If it remembers its Bluetooth address, then it could clearly remember a single master key.
>> 
>> But seriously, if you can remember your BD_ADDR, then you might want to remember your LTK as well. Just a hint here.
> 
> 
> Thanks for the hint, I wasn't familiar with "key hierarchies".

you should really only use them if your device has no persistent storage. If you have a choice, get a device that has persistent storage. Since generating a random LTK for each device (instead of deriving it from a key hierarchy) is of course more secure.

Regards

Marcel


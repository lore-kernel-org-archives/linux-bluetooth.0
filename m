Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ] core: Reduce RSSI delta threshold for RSSI property updates on Device1.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25TT+jSUKy_r4Pmfo5EHqQBi1hB1Hu7Qq2DQm32Y99z_FA@mail.gmail.com>
Date: Tue, 30 Sep 2014 19:26:05 +0200
Cc: Szymon Janc <szymon.janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <3E482A6F-C48C-4297-A203-6D3E26AFFDA7@holtmann.org>
References: <1412028964-5298-1-git-send-email-armansito@chromium.org> <12072518.xz8sZz3RZr@uw000953> <CAHrH25SU4CMDJGukOpAzP7ZSgV3qLWBWx7+3+e7wHzX=EoL=ZA@mail.gmail.com> <E68A0F43-AD5C-4ED5-8724-3E43D064F5BA@holtmann.org> <CAHrH25TT+jSUKy_r4Pmfo5EHqQBi1hB1Hu7Qq2DQm32Y99z_FA@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> the reason why this threshold exists in the first place is that when you show the pairing list in your basic UI that the entries not keep jumping around like crazy. When we added this code 8 dBm made sense for that. That allows that you select an entry in the devices list successfully by touch or mouse. Since sorting close by devices at the top makes more sense than doing things alphabetical.
>> 
> 
> Looks like we order them according to the order in which they were
> discovered in Chrome OS :P Aside from that though, isn't it a bit
> strange to set this threshold based on UI a use case? If I'm building
> a UI around this and entries are jumping around like crazy, then this
> seems like a UI problem and not a bluetooth daemon problem and I can
> go and set a new threshold myself in the UI code.

the D-Bus API have all been designed with user interaction in mind. So it makes sense to impose this kind of extra thresholds. That is why you can map D-Bus things 1:1 to your UI and it will all nicely work.

Regards

Marcel


Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Apr 2013 12:21:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: yousif saeed <yufi_saeed@hotmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Listening for notifications/indications
Message-ID: <20130402092115.GA9284@x220>
References: <BAY175-W240DF9C80BE34DD37FB78DE5D20@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY175-W240DF9C80BE34DD37FB78DE5D20@phx.gbl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Youssif,

On Thu, Mar 28, 2013, yousif saeed wrote:
> I'm trying to communicate with a BLE module through a Linux machine
> (the module is running a heart rate profile). So far, I've been able
> to do everything I need except listening for Notifications and
> indications. I've searched through the web, forums, and even tried
> walking through the source code and still could not find the answer. 
> 
> I'm using kernel version 3.5 and bluez-5.3.
> 
> Any help is greatly appreciated as this is part of my final year project.
> 
> Thanks
> Youssif
> 
> Succcessful commands used so far:
> hcitool lescan
> hcitool lecc
> gatttool -b <Mac Address> --primary
> gatttool -b <MAC Address> --characteristics
> gatttool -b <MAC Address> --char-read
> gatttool -b <MAC Address> --char-des
> gatttool -b <MAC Address> --interactive
> 
> Failed commands:
> gatttool -b <MAC Address> --listen

You shouldn't need to use hcitool nor gatttool for the heartrate
profile. Instead, it should be enough to register a Heartrate Watcher
through the HeartrateManager D-Bus interface (see doc/heartrate-api.txt).
There's also a python script that will do all this for you in
test/test-heartrate. I've been able to use the script successfully with
my own LE heartrate device.

Johan

Return-Path: <cyrus@holtmann.org>
Message-Id: <C2133416-B233-4FFF-B29B-0BCF3B3402E1@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <492BB3F2.3050005@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: HBH-PV270 headset get locked
Date: Tue, 25 Nov 2008 11:15:59 +0200
References: <492B7A98.90603@gmail.com> <492BB3F2.3050005@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Thanks for taking the time to investigate this.

On Nov 25, 2008, at 10:14, Sam Lin wrote:
> I traced code and found in some case headset is not unlocked well.
> for example when something goes wrong in headset_resume_complete(),
> client->dev = NULL
>
> so client_cb() will skip headset_unlock()
>
> then headset will be locked forever until restart bluetoothd.
>
> I have no idea what's the lock idea behind, BTW still unclear how the
> problem happens to cause this.

The lock part is used for making sure that only one unix socket client  
can have read or write access to a remote device at a time. The part  
that's setting client->dev to NULL seems definitely wrong to me but  
I'll let Luiz comment on it before making any changes (since according  
to git blame he was the last one to touch this part of the code). The  
A2DP resume function has similar logic so it probably needs fixing too.

Johan

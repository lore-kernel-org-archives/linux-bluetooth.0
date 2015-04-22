Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: android/hid
Date: Wed, 22 Apr 2015 17:21:52 +0200
Message-ID: <6165450.GeaFHTnZGY@leonov>
In-Reply-To: <CAKafyqqB5JKGt6iXKXwBrz1za6f64CJZA-d9oUjXD6vbbjU2=g@mail.gmail.com>
References: <CAKafyqqB5JKGt6iXKXwBrz1za6f64CJZA-d9oUjXD6vbbjU2=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

On Wednesday 22 of April 2015 16:09:57 Prabhu Chawandi wrote:
> Hi,
> 
> I got a BT HID device which has support for GAMEPAD and MOUSE, this is
> not LE device.  When i try to bond, its failing?
> 
> Can you give me pointers to debug, further ?

Please provide full debug logs from logcat. Check 'Enabling BlueZ debugs' in 
android/README for details how to enable those.

Also please provide HCI traces.

-- 
BR
Szymon Janc

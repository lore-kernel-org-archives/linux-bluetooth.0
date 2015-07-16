Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jul 2015 16:10:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: dogan yazar <doganyazar@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Advertising API, possible to set LE only?
Message-ID: <20150716131004.GA28916@t440s.P-661HNU-F1>
References: <CANzaTi6_OF9C6DjPeRqaoUBKqdJZSQ+0k0cJLodWS3o5LzTsbw@mail.gmail.com>
 <20150716105937.GA18341@t440s.lan>
 <CANzaTi5gK457ZJP5V_ty6ufSzm2LmX6wsfVracqR0MwDZS6jyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANzaTi5gK457ZJP5V_ty6ufSzm2LmX6wsfVracqR0MwDZS6jyg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi dogan,

On Thu, Jul 16, 2015, dogan yazar wrote:
> Thanks a lot for the answer. That is exactly what I need.  However
> putting in the main.conf did not really make any reference and trying
> the btmgmt returns "Rejected"
> [mgmt]# bredr off
> Set BR/EDR for hci0 failed with status 0x0b (Rejected)
> 
> Any idea why? Is it controller related?

First of all, please don't top-post on this list. I think you need to
power off the adapter before you can disable BR/EDR, i.e. "btmgmt power
off".

Johan

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL2sZR7LssB-ptmvhHx2HfMwgODO6S=MW9RVGD5W1Hqr2OPGtA@mail.gmail.com>
References: <CAL2sZR6evPuMOd1PDvrffQt9tkcR5jEBCJuHjJecKxaj++4_Qg@mail.gmail.com>
 <CAL2sZR7LssB-ptmvhHx2HfMwgODO6S=MW9RVGD5W1Hqr2OPGtA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Jun 2016 13:06:57 +0300
Message-ID: <CABBYNZKxg0uBZFOQjCY52EO320Z8VJ35tc7aN-Y0XB_OmVdAEA@mail.gmail.com>
Subject: Re: Problem with l2pinging an iphone
To: Arnold Maderthaner <arnold@maderthaner.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnold,

On Tue, May 31, 2016 at 10:11 AM, Arnold Maderthaner
<arnold@maderthaner.me> wrote:
> Hi !
>
> I want to use bluetooth for presence detection in my home utilizing my
> iphone bluetooth.
> I have 2 systems at the moment: 1x Intel NUC with onboard bluetooth
> and a Raspberry Pi 3.
>
> My problem is that on my NUC I always get a "Permission Denied" error
> which I don't understand vs. on my RP3 with the same iphone it just
> works.
>
> Attached I have 2 hcidumps. Could someone look at those and tell me
> what might be wrong ?

Looks like the NUC is triggering paring while RPI 3 doesn't, perhaps
at some point you had the NUC paired but you remove the link-key
locally (by removing the device) but iOS still has the link-key which
makes it trigger authentication which fails with the following error:

Reason: Remote Device Terminated Connection due to Low Resources

It could be that the iOS device is running out of slots to store the
new link-key, anyway try removing the NUC from the iPhone and see if
that helps.


-- 
Luiz Augusto von Dentz

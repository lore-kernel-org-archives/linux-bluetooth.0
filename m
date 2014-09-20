Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8zXV-b0D6dxY2ifAx-FCa9K0SP0jwr2Bq292gbHAmHWaA@mail.gmail.com>
Date: Sat, 20 Sep 2014 03:43:57 +0200
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Scott James Remnant <keybuk@google.com>
Message-Id: <16A82570-2E42-400C-8E9F-EAF0D869F46C@holtmann.org>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com> <735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org> <CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com> <20140917051457.GA4671@t440s.P-661HNU-F1> <CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com> <20140917065252.GA5554@t440s.lan> <CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com> <8868B74C-0DDD-43C1-BCBF-2578A700EF72@holtmann.org> <CAD0=r8xQzhizXo4umQ_mG_WMH7Akp4bji-9PNRGzqj-7HWnyNA@mail.gmail.com> <0EA633E6-A0F5-4F67-B421-9857466C1175@holtmann.org> <CAD0=r8w035mLnWTKtEfxZ7agzwTFRO9dsv+6qdafcBG7RYzYDQ@mail.gmail.com> <CAD0=r8zXV-b0D6dxY2ifAx-FCa9K0SP0jwr2Bq292gbHAmHWaA@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

so you really need to follow the mailing list guidelines and disable HTML emails ;)

> I will be very happy with mgmt api method that will filter by serice
> uuid and RSSI value, and that's enough for me. From my use case it
> looks like the user is going to be in this scan state for short time -
> few seconds, maximum minute.

that is then something different. That is more like "scan for this UUID within this RSSI range for x amount of seconds, if any results, report them, and otherwise go back to idle".

We can talk about this one-shot kind of API. I would need to think about it a little bit more. However one thing that you might want to consider is using pathloss instead of RSSI. Especially if the advertisement contains the TX power. That way you get a way better idea of how close or far the device is.

> If it would be possible to also add general le scan method that would
> return all advertisements, marked as "only for development", and "not
> for use in production", and "behaves differently for different
> controllers" and maybe somehow disabled by default and you need to set
> some special flag to enable it on your developer machine then it would
> be awsome for developers that want to play with it, but it's not my
> requirement.

The mgmt API will never contain any development methods. It is an official API and we are committed to stable API promise here. Any kind of testing API has to go via debugfs.

Regards

Marcel


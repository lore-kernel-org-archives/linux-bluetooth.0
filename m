Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8wKVvcWTVarU3ik_j2F53f9LWjemA1SD4outm_O8atOOQ@mail.gmail.com>
Date: Mon, 20 Oct 2014 20:22:02 +0200
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Scott James Remnant <keybuk@google.com>
Message-Id: <A03DCD0E-70CF-4509-AC41-6238E74DA5F9@holtmann.org>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com> <735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org> <CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com> <20140917051457.GA4671@t440s.P-661HNU-F1> <CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com> <20140917065252.GA5554@t440s.lan> <CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com> <8868B74C-0DDD-43C1-BCBF-2578A700EF72@holtmann.org> <CAD0=r8xQzhizXo4umQ_mG_WMH7Akp4bji-9PNRGzqj-7HWnyNA@mail.gmail.com> <0EA633E6-A0F5-4F67-B421-9857466C1175@holtmann.org> <CAD0=r8w035mLnWTKtEfxZ7agzwTFRO9dsv+6qdafcBG7RYzYDQ@mail.gmail.com> <F673E928-258E-47F7-B71A-F32410974538@holtmann.org> <CAD0=r8xMcGP-Hjt8uCSY9Qx9VJLov5scSwRTvFr3PAaOXXbyzQ@mail.gmail.com> <CAD0=r8zcPCWKyTQLQeG68uA21_sEv+5wDKNB-GJzgS1+BcD+bQ@mail.gmail.com> <372D8399-BFC6-413F-924F-44CE79030516@holtmann.org> <CAD0=r8x2bub9E+ohicwfxK0AAykRTUSrrTjAD-tFv-aj7xGoww@mail.gmail.com> <375944C8-4378-4589-A
 883-786F531EA291@holtmann.org> <CAD0=r8xDHvVq9QyCwo7_di_QRhbqEYdGJCKevQoEQ8WZRwA4dA@mail.gmail.com> <93AC6768-49F3-43CC-8014-83DD3C0EA3D3@holtmann.org> <8A0217F1-C062-466F-8C04-38E324BDD55D@holtmann.org> <CAD0=r8wuVAB0H1sRghzsmm0Ak9+r2_f13541_dP6QCV1ZeogNw@mail.gmail.com> <CAD0=r8wKVvcWTVarU3ik_j2F53f9LWjemA1SD4outm_O8atOOQ@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

you really should not top-post on this mailing list. It breaks the flow for everybody else.

> I started implementing service scanning and I have a questions:
> 
> We initially agreed on version that uses le deduplication that needs
> to be restarted after each device found.
> When I started looking into that it's going to be much more restarting:
> - need to restart after each packet from device that advertise service
> we're interested that's not in RSSI range. That's because controller
> that I use doesn't send advertisement again when RSSI changes.
> - need to restart every 0.5 or 1 second in case when some device added
> service I'm interested at to it's advertisement

I think first we might need to have a HCI_QUIRK that we can set on hci_dev->quirks that tells us what kind of behavior the controller has. We can argue what is the expected default since the specification is pretty much unclear.

Since for all known devices, we are using the whitelist, I am happy to accept that Broadcom controllers just need a quirk to restart scanning. We have to find a nice sweat spot on when to do it. So this would need some testing. So just go and play with it.

My initial take would be that when you see a device with the matching filter, then you start a timeout. And after that timeout restart. Postpone the timeout if you find more devices that match your filter up to x seconds. That should get your there.

> Can we conseider implementation using le scan without deduplication,
> and do packet de-duplication in kernel in hci_le_adv_report_evt ?
> I've started implementing it this way and it works really nice. The
> issue here might be that it might consume more energy.

If you get a really bad controller, then this will go ballistic. Trust me, we had this and some controllers will report every single advertising packet up to the host. You can not process this quickly enough. It gets worse if you have a peripheral that advertises with a high duty cycle. Then you will consume extra power.

You need to test this in a real scenario where you actually have tons and tons peripherals around. It can get really bad. I mean it all depends on what you are actually want to do and how much precision you need. My first instinct is to just restart scanning to get new results.

Regards

Marcel


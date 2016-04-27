Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: DS4 issues
From: Frank Praznik <frank.praznik@gmail.com>
In-Reply-To: <877ffrq6ox.fsf@gotu.dk>
Date: Tue, 26 Apr 2016 21:22:06 -0400
Cc: Antonio Ospite <ao2@ao2.it>, linux-bluetooth@vger.kernel.org
Message-Id: <41D0958C-321B-46A4-A29F-27D83AC3404B@gmail.com>
References: <20151221144607.GA18773@mkjlap.gotu.dk> <20151228101822.03253569407ac9dfe4ea15be@ao2.it> <0F6173F5-CF72-47E8-BB6B-44200F75EB6E@gmail.com> <20151228164042.GA20182@mkjlap.gotu.dk> <20151230110944.GA11559@mkjlap.gotu.dk> <7A34E2B1-A42C-4162-80FC-F2C9E8796F67@gmail.com> <87k2m7602c.fsf@gotu.dk> <877ffrq6ox.fsf@gotu.dk>
To: =?utf-8?Q?Martin_Kj=C3=A6r_J=C3=B8rgensen?= <mkj@gotu.dk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Apr 21, 2016, at 12:15, Martin Kjær Jørgensen <mkj@gotu.dk> wrote:
> 
> 
> I've now upgraded my Debian Testing machine to kernel 4.5.1. It seems to
> have fixed my first issue. The controller now binds, gets recognized
> and I can test it with jstest and use it in programs :-)
> 
> However, it's not recognized as a DS4 controller, so programs that
> would automatically map keys and buttons according to controller now
> requires manual mapping.
> 
> Upon turning my DS4 controller on, dmesg produces this:
> 
> [ 4469.637467] sony 0005:054C:05C4.0009: Using modified Dualshock 4 Bluetooth report descriptor
> [ 4469.638626] input: Wireless Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:256/0005:054C:05C4.0009/input/input27
> [ 4469.639080] sony 0005:054C:05C4.0009: input,hidraw5: BLUETOOTH HID v1.00 Gamepad [Wireless Controller] on 28:b2:bd:94:0c:4f
> 
> ... which is different from when using USB cabel. Again, when using
> cabel the controller works perfectly.
> 
> Any suggestions to this?

The bus type and version parameters of the input_id struct retrieved with EVIOCGID are different when using bluetooth vs USB.  That’s just how it is and software has to accommodate both values to work correctly.  For instance, the SDL game controller mapping database has two separate entries for both the wired and wireless modes to deal with this.
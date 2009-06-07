Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Jun 2009 20:34:18 +0100 (BST)
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Apple Bluetooth devices: Battery level?
In-Reply-To: <1244389933.23850.104.camel@localhost.localdomain>
References: <1244384236.30768.5690.camel@cookie.hadess.net> <1244389933.23850.104.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1244403258.783597.685.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 7 Jun 2009, Marcel Holtmann wrote:

> Hi Bastien,
>
> > I just got an Apple Bluetooth Mighty Mouse, and was wondering whether
> > anyone had information on how to get the battery level from the device
> > (the keyboard apparently also allows that):
> > http://support.apple.com/kb/TA27118?viewlocale=en_US
> >
> > Anyone with an idea? An unparsed HID event? Does it need "poking"?
>
> I think that Apple ones used an actually HID HUT conform descriptor for
> that. I did reverser engineered that a long time ago, but then never got
> around to do anything with it. Can't find my notes right now. Just run
> hcidump and eventually you will see the report.

I have a mighty mouse and while I don't use BlueZ or Linux I would be
interested in the details of this.. On my (NetBSD) system, the HID
descriptor parses as:

Collection page=Generic_Desktop usage=Mouse
  Input id=2 size=1 count=1 page=Button usage=Button_1 Variable, logical range 0..1
  Input id=2 size=1 count=1 page=Button usage=Button_2 Variable, logical range 0..1
  Input id=2 size=1 count=1 page=Button usage=Button_3 Variable, logical range 0..1
  Input id=2 size=1 count=1 page=Button usage=Button_4 Variable, logical range 0..1
  Input id=2 size=4 count=1 page=0x0000 usage=0x0000 Const Variable, logical range 0..1
Collection page=Generic_Desktop usage=Pointer
  Input id=2 size=8 count=1 page=Generic_Desktop usage=X Variable Relative, logical range -127..127
  Input id=2 size=8 count=1 page=Generic_Desktop usage=Y Variable Relative, logical range -127..127
  Input id=2 size=8 count=1 page=Consumer usage=AC_Pan Variable Relative, logical range -127..127
  Input id=2 size=8 count=1 page=Generic_Desktop usage=Wheel Variable Relative, logical range -127..127
End collection
  Input id=2 size=8 count=1 page=0x00ff usage=0x00c0 Variable, logical range -127..127
Feature id=71 size=8 count=1 page=Device_Controls usage=Battery_Strength Variable NoPref Volatile, logical range 0..100
End collection

But I'm not really sure what the Device_Controls feature is supposed to
be. Is it sent from the device, or sent to the device?  I've never had one
sent from the device in any case that I know of, and I'm not sure what the
Vendor_Defined (page 0x00ff) value (usage 0x00c0) is for either, it seems
to be zero.

What I know does happen is that a report with id=48 containing a single
byte with value=0x01 is sent two or three times just before the battery
gives out. That also happens with an older Apple keyboard except that the
descriptor does not contain any Vendor or Feature items. I did capture the
report once but I don't have it now. (I think it was an input report)

iain

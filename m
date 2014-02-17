Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Feb 2014 21:21:33 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
    David Herrmann <dh.herrmann@gmail.com>,
    "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
    "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: hidp: make sure input buffers are big
 enough
In-Reply-To: <37F7D8DE-5861-4452-B2F7-00D5E5F952B0@holtmann.org>
Message-ID: <alpine.LNX.2.00.1402172121220.1192@pobox.suse.cz>
References: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com> <3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org> <CANq1E4TOHvb3--H6SoRhB09sUwuYkrvSAXCNN2Y0PaVSOEte=w@mail.gmail.com> <alpine.LNX.2.00.1401071308020.4962@pobox.suse.cz>
 <CANq1E4SxrDnbOCsohZXYoYL-HQjEc-xcOnXfAm=npHG2QfMS9A@mail.gmail.com> <alpine.LNX.2.00.1401071811530.4962@pobox.suse.cz> <alpine.LNX.2.00.1401282152140.22492@pobox.suse.cz> <CANq1E4TW+GU=oaW0tXb=Tun9HMtr26u-PC3H6BsLot560ANgog@mail.gmail.com>
 <alpine.LNX.2.00.1402031107310.14066@pobox.suse.cz> <CANq1E4S++uqMzQue_0jC3N=Lm8Os5V-48Hw5M4vWvM+2Vx91yA@mail.gmail.com> <alpine.LNX.2.00.1402041446130.14066@pobox.suse.cz> <20573666-E2A0-4D6B-986A-09DAFC0FB64B@holtmann.org> <alpine.LNX.2.00.1402051648470.8614@pobox.suse.cz>
 <alpine.LNX.2.00.1402171506450.1192@pobox.suse.cz> <37F7D8DE-5861-4452-B2F7-00D5E5F952B0@holtmann.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 17 Feb 2014, Marcel Holtmann wrote:

> >> Gustavo, what is your take on this please? I can take it through hid.git 
> >> in case you don't have anything else queued for -rc2.
> > 
> > ... ping?
> > 
> > In case this doesn't get reacted upon by the end of the week, I am 
> > inclined to take it through hid.git.
> 
> take it through hid.git please.

Now applied, thanks.

-- 
Jiri Kosina
SUSE Labs

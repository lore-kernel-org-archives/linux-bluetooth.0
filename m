Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Sep 2010 16:46:50 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Sergej Pupykin <ml@sergej.pp.ru>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Another "hci0 command tx timeout"
Message-ID: <20100927194650.GB5489@vigoh>
References: <4CA0E800.4000000@sergej.pp.ru>
 <20100927192108.GA5489@vigoh>
 <4CA0F1FE.8040006@sergej.pp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CA0F1FE.8040006@sergej.pp.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Sergej Pupykin <ml@sergej.pp.ru> [2010-09-27 23:35:26 +0400]:

>   On 27.09.2010 23:21, Gustavo F. Padovan wrote:
> >
> > What do you mean by "works without userspace"
> I try to do following:
> 
> 1. ensure that userspace does not work (stop bluetoothd and comment udev 
> bluetooth rule)
> 2. modprobe btusb
> 3. hciconfig hci0 up
> 4. hcitool inq
> 
> then remove btusb, uncomment udev rules, start bluetoothd and do 2-4 again.

So that is the problem, you are removing btusb.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

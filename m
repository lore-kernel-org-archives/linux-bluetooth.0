Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8CC70E3BCE@irsmsx501.ger.corp.intel.com>
References: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8CC70E3BCE@irsmsx501.ger.corp.intel.com>
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Fri, 1 Apr 2011 22:36:20 +0530
Message-ID: <AANLkTim3NBH2dB=EF2pZDEoj+77Gv+k3JKvqSwc=6sFk@mail.gmail.com>
Subject: Re: Question about supported profiles
To: "Ferraton, Jean RegisX" <jean.regisx.ferraton@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jean,

> I have a question about supported profiles under linux-bluez.
> Where and how are defined the default supported profiles? Is it a conf file?
> In our case, by default we support HFP, A2DP, OPP, AVRCP...
> But if we want to use FTP or DUN, we have to enter "sdptool add DUN" or " sdptool add FTP"
> Can anyone tell me how to change the default params?

First of all its not clear what exactly are you looking for? in case
you need to know which all profiles are supported in bluez,
./configure --help should help! Most of the profiles are implemented
as plugins to either bluetoothd or obexd.
Few of the profiles are also supported via daemons. All data profiles,
such as FTP/OPP/PBAP they are supported as obex plugins.
hope this helps.

thanks,
Arun

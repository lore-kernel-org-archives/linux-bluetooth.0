Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Nov 2013 10:15:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Binderman <dcb314@hotmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez-5.10/monitor/packet.c:4335: possible missing break ?
Message-ID: <20131106081523.GE15573@x220.p-661hnu-f1>
References: <DUB118-W372AC521B8229C59C076809CF10@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <DUB118-W372AC521B8229C59C076809CF10@phx.gbl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, Nov 05, 2013, David Binderman wrote:
> Hello there,
> 
> I just ran the static analysis checker "cppcheck" over the source code of bluez-5.10
> 
> It said
> 
> [monitor/packet.c:4335] -> [monitor/packet.c:4338]: (warning) Variable 'str' is reassigned a value
>  before the old one has been used. 'break;' missing?
> 
> Source code is
> 
>     case 0x03:
>         str = "Allow Scan Request from White List Only, "
>             "Allow Connect Request from White List Only";
>     default:
>         str = "Reserved";
>         break;
> 
> Suggest add a break statement to the 0x03 case.

Yes, that looks like a bug. Do you want to send a proper patch for it?

Johan

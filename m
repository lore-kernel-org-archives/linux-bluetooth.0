Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: rohan16garg@gmail.com
In-Reply-To: <20120205142958.GA13091@x61.home>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
 <1326705845.6454.274.camel@aeonflux> <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
 <1328439363.32199.20.camel@pohly-mobl1.fritz.box> <20120205142958.GA13091@x61.home>
From: Rohan Garg <rohangarg@ubuntu.com>
Date: Sun, 5 Feb 2012 20:20:54 +0530
Message-ID: <CAEb1ZdhEjEgF4D3+agCpMhYGqShLUKNKfd2HcDF1vG9EzMY6qA@mail.gmail.com>
Subject: Re: bluez 4.97: build failure when used in C++ apps
To: Tino Keitel <tino.keitel@tikei.de>, Patrick Ohly <patrick.ohly@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Milan Crha <mcrha@redhat.com>, ying.an.deng@intel.com, ulf.hofemeier@intel.com,
	ning.w.wang@intel.com, Rohan Garg <rohan16garg@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Ah, seems you are correct. Thanks for pointing that out, I'll contact
the person who last uploaded the package in ubuntu to merge it from
debian.

Regards
Rohan Garg



On Sun, Feb 5, 2012 at 7:59 PM, Tino Keitel <tino.keitel@tikei.de> wrote:
> On Sun, Feb 05, 2012 at 11:56:03 +0100, Patrick Ohly wrote:
>
> [...]
>
>> How do we move forward with this? More and more distros are picking up
>> the broken header file.
>>
>> In MeeGo and Tizen we applied the patch that I had suggested.
>
> FYI, Debian also applied a patch and syncevolution builds fine.
>
> Regards,
> Tino

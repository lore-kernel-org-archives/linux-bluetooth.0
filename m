Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: rohan16garg@gmail.com
In-Reply-To: <CAEb1ZdjiDFTngKg+zTMHgDQ7hNd6h+VAgbjeNJXQUyF+=d6a9Q@mail.gmail.com>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
 <1326705845.6454.274.camel@aeonflux> <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
 <1328439363.32199.20.camel@pohly-mobl1.fritz.box> <CAEb1ZdjiDFTngKg+zTMHgDQ7hNd6h+VAgbjeNJXQUyF+=d6a9Q@mail.gmail.com>
From: Rohan Garg <rohangarg@ubuntu.com>
Date: Sun, 5 Feb 2012 17:32:39 +0530
Message-ID: <CAEb1Zdit58azC=q02rW=ySK1VZPn8=WWiAucqYu_5B8ABuwuXQ@mail.gmail.com>
Subject: Re: bluez 4.97: build failure when used in C++ apps
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Milan Crha <mcrha@redhat.com>, ying.an.deng@intel.com, ulf.hofemeier@intel.com,
	ning.w.wang@intel.com, Tino Keitel <tino.keitel+syncevolution@tikei.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Bug filed in Launchpad :
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/927097

Regards
Rohan Garg



On Sun, Feb 5, 2012 at 4:29 PM, Rohan Garg <rohangarg@ubuntu.com> wrote:
> I can file a bug for tracking purposes and get the patched package in
> the archives, as long as upstream is willing to accept the patch ( or
> a modified version of the patch ) in the near future. I don't speak
> for the rest of the Ubuntu developers, but I consider the best
> approach to getting issues fixed in distros.
>
> Best
> Rohan Garg
>
> On Sun, Feb 5, 2012 at 4:26 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
>> On Mon, 2012-01-16 at 11:09 +0100, Patrick Ohly wrote:
>>> On Mo, 2012-01-16 at 10:24 +0100, Marcel Holtmann wrote:
>>> > Also this topic
>>> > has been raised before and I need confirmation for a GCC guru to confirm
>>> > that this does exactly the same all all platforms.
>>>
>>> Now that you mentioned it I found the previous patch:
>>> http://article.gmane.org/gmane.linux.bluez.kernel/20276/match=invalid
>>> +conversion+void+bt_get_le64+anonymous+struct
>>>
>>> Note that my patch is different. It keeps the "struct
>>> __attribute__((packed))" magic and merely changes the (void *) typecast
>>> to something that works in C++ and C.
>>
>> How do we move forward with this? More and more distros are picking up
>> the broken header file.
>>
>> In MeeGo and Tizen we applied the patch that I had suggested.
>>
>> Milan, do you know what Fedora is doing? Tino, what about Debian? Roran,
>> you had it in Ubuntu Precise Pangolin. Care to file a bug there, if
>> there isn't one already?
>>
>> Would it be more acceptable for upstream to put the modified macros into
>> an ifdef so that they are really only used in C++, keeping the code for
>> C as it is now?
>>
>> I'll send such a patch immediately.
>>
>> --
>> Best Regards, Patrick Ohly
>>
>> The content of this message is my personal opinion only and although
>> I am an employee of Intel, the statements I make here in no way
>> represent Intel's position on the issue, nor am I authorized to speak
>> on behalf of Intel on this matter.
>>
>>

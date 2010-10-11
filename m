Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTik8k84qwMM3nHc4z2gVWm6Vo0HaLME2PEcwMyeg@mail.gmail.com>
References: <AANLkTi=Ogzb3kUX7O4fz-w9gNpU9PCyTFo0GnhfePjC6@mail.gmail.com>
 <20101011213154.GA12131@jh-x301> <AANLkTik8k84qwMM3nHc4z2gVWm6Vo0HaLME2PEcwMyeg@mail.gmail.com>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Tue, 12 Oct 2010 01:23:07 +0200
Message-ID: <AANLkTimFgj6sYyyK8Q16P2T5PcqC+Pjg9=O8NLZbRoX2@mail.gmail.com>
Subject: Re: Pull request git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git for_upstream
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2010/10/12 Jose Antonio Santos Cadenas <santoscadenas@gmail.com>:
> Hi,
>
> 2010/10/11 Johan Hedberg <johan.hedberg@gmail.com>:
>> Hi,
>>
>> On Mon, Oct 11, 2010, Jose Antonio Santos Cadenas wrote:
>>> The following changes since commit 646f0c7e6b557c5413825ce7b04bee52bf0129e8:
>>>
>>>   Move remote name and version requests to hciops (2010-10-10 22:44:25 +0100)
>>>
>>> are available in the git repository at:
>>>   git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git for_upstream
>>>
>>> José Antonio Santos Cadenas (6):
>>>       Remove mdl_conn from struct hdp_channel
>>>       Remove app paramter from hdp_establish_mcl, it is not needed
>>>       Imcoming connection in control channel should be ERTM
>>>       Fix multiple emission of main channel property signal.
>>>       Return MCAP_MDL_BUSY when health channel can't be created
>>>       Implement callback for responding echo petitions
>>>
>>> Santiago Carot-Nemesio (6):
>>>       Add a new function to create channels
>>>       Process request of of echo channels creation
>>>       Correctly notify the deletion of the reliable data channel
>>>       Add extra checks for avoid notifiying incoming echo channels
>>>       Delete all channels DBus interface when the instance is removed
>>>       Check first reliable configuration during channel creation
>>>
>>>  health/hdp.c       |  249 +++++++++++++++++++++++++++++++++++----------------
>>>  health/hdp_types.h |    3 +-
>>>  health/hdp_util.c  |    3 -
>>>  health/hdp_util.h  |    1 -
>>>  health/mcap.c      |    1 +
>>>  5 files changed, 174 insertions(+), 83 deletions(-)
>>
>> Could you try to ping me on IRC when possible so we can solve a few
>> issues with these patches. It seems e.g. that you're doing GIOChannel
>> reference counting incorrectly in one place. There are also some english
>> language errors in the commit messages that would be good to fix (let's
>> see if you can spot them yourselves, otherwise I'll point them out when
>> we go over the other issues ;)
>
> I'm sorry but I can't connect to the IRC rigth now. Nevertheless, I
> think that I've found the issues:
>
> - The iochannel should be unrefereed when the watcher is explicitly removed
> - The commit message s/paramter/parameter
>
> Are there any more?
>
> I will solve them in half an hour.

I've rebased the branch with the changes that I described before. I've
also fixed an other issue related with the mdep checks, now a macro is
used to make the code more readable and easy to mantain.

Regards.

Jose.
